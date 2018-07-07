using System;
using System.Threading.Tasks;

namespace RSZService.Notification
{
	public interface INotificationManager : IDisposable
	{
		void Add(string type, string deviceToken, string message);

		void Send();

		Task SendAsync();
	}
}
