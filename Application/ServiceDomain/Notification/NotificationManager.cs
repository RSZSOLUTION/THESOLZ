using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using PushSharp.Apple;
using PushSharp.Core;
using PushSharp.Google;
using PushSharp.Windows;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace RSZService.Notification
{
	public class NotificationManager : INotificationManager
	{
		private bool _disposed;
		private readonly IList<NotificationModel> _sendTo;
		private ApnsConfiguration _apn;
		private GcmConfiguration _gcm;
		private WnsConfiguration _wns;

		private GcmConfiguration GoogleConfig => new GcmConfiguration(ConfigurationManager.AppSettings["GCM_SENDER_ID"],
			ConfigurationManager.AppSettings["GCM_AUTH_TOKEN"], null);

		private ApnsConfiguration AppleConfig => new ApnsConfiguration(ApnsConfiguration.ApnsServerEnvironment.Sandbox,
			ConfigurationManager.AppSettings["APN_SECRET_ID"], ConfigurationManager.AppSettings["APN_SECRET_PSW"]);

		private WnsConfiguration WindowsConfig => new WnsConfiguration(ConfigurationManager.AppSettings["WNS_PACKAGE_NAME"],
			ConfigurationManager.AppSettings["WMS_PACKAGE_ID"], ConfigurationManager.AppSettings["WNS_PACKAGE_PSW"]);

		private void PrivateAdd(string type, string deviceToken, string message)
		{
			try
			{
				_sendTo.Add(new NotificationModel { Type = type, Token = deviceToken, Message = message });
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private bool PrivateSend()
		{
			try
			{
				if (_sendTo.Count > 0)
					foreach (var item in _sendTo)
						switch (item.Type.Trim().ToUpper())
						{
							case "GCM":
								SendToGcm(item.Token, item.Message);
								break;
							case "APN":
								SendToApn(item.Token, item.Message);
								break;
							case "WNS":
								SendToWns(item.Token, item.Message);
								break;
						}
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
			return true;
		}

		private void SendToGcm(string token, string message)
		{
			try
			{
				var gcmBroker = new GcmServiceBroker(_gcm);
				gcmBroker.OnNotificationFailed += (notification, aggregateEx) =>
				{
					aggregateEx.Handle(ex =>
					{
						var exception = ex as GcmNotificationException;
						if (exception != null)
						{
							var notificationException = exception;
							var gcmNotification = notificationException.Notification;
							var description = notificationException.Description;
							throw new Exception(JsonConvert.SerializeObject(new
							{
								GcmMessageId = gcmNotification.MessageId,
								Description = description
							}));
						}
						var resultException = ex as GcmMulticastResultException;
						if (resultException != null)
						{
							var multicastException = resultException;
							foreach (var failedKvp in multicastException.Failed)
							{
								var n = failedKvp.Key;
								var e = failedKvp.Value;
								throw new Exception(JsonConvert.SerializeObject(new { GcmMessageId = n, Description = e }));
							}
						}
						else if (ex is DeviceSubscriptionExpiredException)
						{
							var expiredException = (DeviceSubscriptionExpiredException)ex;
							var oldId = expiredException.OldSubscriptionId;
							var newId = expiredException.NewSubscriptionId;
							throw new Exception(JsonConvert.SerializeObject(new
							{
								Description = $"GCM ID Changed : old-{oldId}\t new-{newId}"
							}));
						}
						else if (ex is RetryAfterException)
						{
							var retryException = (RetryAfterException)ex;
							throw new Exception(JsonConvert.SerializeObject(new
							{
								Description =
								$"Limitation Exceeds!! Please try after {retryException.RetryAfterUtc.ToLocalTime()}"
							}));
						}
						else
						{
							throw new Exception(JsonConvert.SerializeObject(new { Description = "Unknown Error Occurs !!!" }));
						}

						return true;
					});
				};
				gcmBroker.OnNotificationSucceeded += notification => { };
				gcmBroker.Start();
				gcmBroker.QueueNotification(new GcmNotification
				{
					RegistrationIds = new List<string> { token },
					Data = JObject.Parse(message)
				});
				gcmBroker.Stop();
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private void SendToApn(string token, string message)
		{
			try
			{
				var apnsBroker = new ApnsServiceBroker(_apn);
				apnsBroker.OnNotificationFailed += (notification, aggregateEx) =>
				{
					aggregateEx.Handle(ex =>
					{
						var exception = ex as ApnsNotificationException;
						if (exception != null)
						{
							var notificationException = exception;
							var apnsNotification = notificationException.Notification;
							var statusCode = notificationException.ErrorStatusCode;
							throw new Exception(JsonConvert.SerializeObject(new
							{
								ApnMessageId = apnsNotification.Identifier,
								StatusCode = statusCode
							}));
						}
						throw new Exception(JsonConvert.SerializeObject(new { Exception = ex.GetBaseException().Message }));
					});
				};
				apnsBroker.OnNotificationSucceeded += notification => { };
				apnsBroker.Start();
				apnsBroker.QueueNotification(new ApnsNotification { DeviceToken = token, Payload = JObject.Parse(message) });
				apnsBroker.Stop();
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private void SendToWns(string token, string message)
		{
			try
			{
				var wnsBroker = new WnsServiceBroker(_wns);
				wnsBroker.OnNotificationFailed += (notification, aggregateEx) =>
				{
					aggregateEx.Handle(ex =>
					{
						var exception = ex as WnsNotificationException;
						if (exception != null)
							throw new Exception(JsonConvert.SerializeObject(new { Exception = exception.GetBaseException().Message }));
						throw new Exception(JsonConvert.SerializeObject(new { Description = "Unknown Error Occurs !!!" }));
					});
				};
				wnsBroker.OnNotificationSucceeded += notification => { };
				wnsBroker.Start();
				wnsBroker.QueueNotification(new WnsToastNotification { ChannelUri = token, Payload = XElement.Parse(message) });
				wnsBroker.Stop();
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public NotificationManager()
		{
			_sendTo = new List<NotificationModel>();
			try
			{
				_gcm = GoogleConfig;
			}
			catch
			{
				// ignored
			}
			try
			{
				_apn = AppleConfig;
			}
			catch
			{
				// ignored
			}
			try
			{
				_wns = WindowsConfig;
			}
			catch
			{
				// ignored
			}
		}

		public void Dispose()
		{
			Dispose(true);
			GC.SuppressFinalize(this);
		}

		protected virtual void Dispose(bool disposing)
		{
			if (_disposed)
				return;

			if (disposing)
			{
				_sendTo.Clear();
				_apn = null;
				_gcm = null;
				_wns = null;
			}
			_disposed = true;
		}

		~NotificationManager()
		{
			Dispose(false);
		}

		public void Add(string type, string deviceToken, string message)
		{
			PrivateAdd(type, deviceToken, message);
		}

		public void Send()
		{
			PrivateSend();
		}

		public async Task SendAsync()
		{
			await Task.FromResult(
				PrivateSend()
			);
		}
	}
}
