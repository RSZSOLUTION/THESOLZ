using System;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace RSZService.Sms
{
	public class SmsManager : ISmsManager
	{
		private bool _disposed;
		private readonly WebClient _urlOperator;

		private WebClient UrlOperator => new WebClient();

		private long PrivateGetSmsBalance()
		{
			return Convert.ToInt64(_urlOperator.DownloadString(ConfigurationManager.AppSettings["SMS_COUNT_API"]));
		}

		private bool PrivateSend(string smsBody, string toNumber = "", string[] toNumbers = null)
		{
			try
			{
				var sendTo = string.IsNullOrEmpty(toNumber) ? string.Empty : $"91{toNumber},";
				if (toNumbers != null)
					foreach (var no in toNumbers.ToList())
						sendTo += $"91{no},";

				if (sendTo.Contains(","))
					sendTo = sendTo.Trim().TrimEnd(',');

				_urlOperator.DownloadString(string.Format(ConfigurationManager.AppSettings["SMS_SEND_API"], sendTo, smsBody));
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private async Task<bool> PrivateSendAsync(string smsBody, string toNumber = "", string[] toNumbers = null)
		{
			try
			{
				var sendTo = string.IsNullOrEmpty(toNumber) ? string.Empty : $"91{toNumber},";
				if (toNumbers != null)
					foreach (var no in toNumbers.ToList())
						sendTo += $"91{no},";

				if (sendTo.Contains(","))
					sendTo = sendTo.Trim().TrimEnd(',');

				await _urlOperator.DownloadStringTaskAsync(
					string.Format(ConfigurationManager.AppSettings["SMS_SEND_API"], sendTo, smsBody));
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public SmsManager()
		{
			_urlOperator = UrlOperator;
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
				_urlOperator.Dispose();
			_disposed = true;
		}

		~SmsManager()
		{
			Dispose(false);
		}

		public long GetSmsBalance => PrivateGetSmsBalance();

		public bool Send(string smsBody, string toNumber)
		{
			return PrivateSend(smsBody, toNumber);
		}

		public async Task<bool> SendAsync(string smsBody, string toNumber)
		{
			return await PrivateSendAsync(smsBody, toNumber);
		}

		public bool Send(string smsBody, string[] toNumbers)
		{
			return PrivateSend(smsBody, toNumbers: toNumbers);
		}

		public async Task<bool> SendAsync(string smsBody, string[] toNumbers)
		{
			return await PrivateSendAsync(smsBody, toNumbers: toNumbers);
		}
	}
}
