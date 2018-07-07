using System;
using System.Configuration;
using System.Net;
using System.Threading.Tasks;

namespace RSZService.Call
{
	public class CallManager : ICallManager
	{
		private bool _disposed;
		private readonly WebClient _urlOperator;

		private WebClient UrlOperator => new WebClient();

		private bool PrivateCall(string toNumber, string fromNumber)
		{
			try
			{
				_urlOperator.DownloadString(string.Format(ConfigurationManager.AppSettings["PHONE_CALL_API"], toNumber, fromNumber));
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private async Task<bool> PrivateCallallAsync(string toNumber, string fromNumber)
		{
			try
			{
				await _urlOperator.DownloadStringTaskAsync(
					string.Format(ConfigurationManager.AppSettings["PHONE_CALL_API"], toNumber, fromNumber));
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public CallManager()
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

		~CallManager()
		{
			Dispose(false);
		}

		public bool Call(string toNumber, string fromNumber)
		{
			return PrivateCall(toNumber, fromNumber);
		}

		public async Task<bool> CallAsync(string toNumber, string fromNumber)
		{
			return await PrivateCallallAsync(toNumber, fromNumber);
		}
	}
}
