using System;
using System.Threading.Tasks;

namespace RSZService.Call
{
	public interface ICallManager : IDisposable
	{
		bool Call(string toNumber, string fromNumber);

		Task<bool> CallAsync(string toNumber, string fromNumber);
	}
}
