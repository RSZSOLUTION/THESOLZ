using System;
using System.Threading.Tasks;

namespace RSZService.Email
{
	public interface IEmailManager : IDisposable
	{
		bool Send(string emailTitle, string emailBody, string[] toAddress, string[] attachments = null, string[] toCc = null,
			string[] toBcc = null, bool isHtml = true);

		Task<bool> SendAsync(string emailTitle, string emailBody, string[] toAddress, string[] attachments = null,
			string[] toCc = null, string[] toBcc = null, bool isHtml = true);
	}
}
