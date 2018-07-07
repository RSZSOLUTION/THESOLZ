using System;
using System.Threading.Tasks;

namespace RSZService.Ftp
{
	public interface IFtpManager : IDisposable
	{
		bool Upload(string targetFile, string sourceFile);
		Task<bool> UploadAsync(string targetFile, string sourceFile);
		bool Download(string sourceFile, string targetFile);
		Task<bool> DownloadAsync(string sourceFile, string targetFile);
	}
}
