using System;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace RSZService.Email
{
	public class EmailManager : IEmailManager
	{
		private bool _disposed;
		private readonly MailMessage _email;
		private readonly SmtpClient _smtp;

		private MailMessage Email => new MailMessage();

		private SmtpClient Smtp => new SmtpClient(ConfigurationManager.AppSettings["SMTP_SERVER"],
			Convert.ToInt32(ConfigurationManager.AppSettings["SMTP_PORT"]));

		private bool PrivateSend(string emailTitle, string emailBody, string[] toAddress, string[] attachments = null,
			string[] toCc = null, string[] toBcc = null, bool isHtml = true)
		{
			try
			{
				_email.Subject = emailTitle;
				_email.Body = emailBody;
				_email.IsBodyHtml = isHtml;
				_email.Priority = MailPriority.High;
				_email.From = new MailAddress(ConfigurationManager.AppSettings["BULK_EMAIL_ID"],
					ConfigurationManager.AppSettings["BULK_EMAIL_SENDER"]);
				foreach (var to in toAddress)
					_email.To.Add(new MailAddress(to));

				if (toCc != null && toCc.Any())
					foreach (var cc in toCc)
						_email.CC.Add(new MailAddress(cc));

				if (toBcc != null && toBcc.Any())
					foreach (var bcc in toBcc)
						_email.Bcc.Add(new MailAddress(bcc));

				if (attachments != null && attachments.Any())
					foreach (var attachment in attachments)
						_email.Attachments.Add(new Attachment(attachment));

				_smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
				_smtp.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["BULK_EMAIL_ID"],
					ConfigurationManager.AppSettings["BULK_EMAIL_PASSWORD"]);
				_smtp.EnableSsl = true;
				_smtp.Send(_email);
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private async Task<bool> PrivateSendAsync(string emailTitle, string emailBody, string[] toAddress,
			string[] attachments = null, string[] toCc = null, string[] toBcc = null, bool isHtml = true)
		{
			try
			{
				_email.Subject = emailTitle;
				_email.Body = emailBody;
				_email.IsBodyHtml = isHtml;
				_email.Priority = MailPriority.High;
				_email.From = new MailAddress(ConfigurationManager.AppSettings["BULK_EMAIL_ID"],
					ConfigurationManager.AppSettings["BULK_EMAIL_SENDER"]);
				foreach (var to in toAddress)
					_email.To.Add(new MailAddress(to));

				if (toCc != null && toCc.Any())
					foreach (var cc in toCc)
						_email.CC.Add(new MailAddress(cc));

				if (toBcc != null && toBcc.Any())
					foreach (var bcc in toBcc)
						_email.Bcc.Add(new MailAddress(bcc));

				if (attachments != null && attachments.Any())
					foreach (var attachment in attachments)
						_email.Attachments.Add(new Attachment(attachment));

				_smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
				_smtp.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["BULK_EMAIL_ID"],
					ConfigurationManager.AppSettings["BULK_EMAIL_PASSWORD"]);
				_smtp.EnableSsl = true;
				await _smtp.SendMailAsync(_email);
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public EmailManager()
		{
			_email = Email;
			_smtp = Smtp;
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
				_email.Dispose();
				_smtp.Dispose();
			}
			_disposed = true;
		}

		~EmailManager()
		{
			Dispose(false);
		}

		public bool Send(string emailTitle, string emailBody, string[] toAddress, string[] attachments = null,
			string[] toCc = null, string[] toBcc = null, bool isHtml = true)
		{
			return PrivateSend(emailTitle, emailBody, toAddress, attachments, toCc, toBcc, isHtml);
		}

		public async Task<bool> SendAsync(string emailTitle, string emailBody, string[] toAddress, string[] attachments = null,
			string[] toCc = null, string[] toBcc = null, bool isHtml = true)
		{
			return await PrivateSendAsync(emailTitle, emailBody, toAddress, attachments, toCc, toBcc, isHtml);
		}
	}
}
