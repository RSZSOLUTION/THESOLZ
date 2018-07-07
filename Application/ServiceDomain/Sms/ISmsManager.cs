using System;
using System.Threading.Tasks;

namespace RSZService.Sms
{
	public interface ISmsManager : IDisposable
	{
		long GetSmsBalance { get; }

		bool Send(string smsBody, string toNumber);

		Task<bool> SendAsync(string smsBody, string toNumber);

		bool Send(string smsBody, string[] toNumbers);

		Task<bool> SendAsync(string smsBody, string[] toNumbers);
	}
}
