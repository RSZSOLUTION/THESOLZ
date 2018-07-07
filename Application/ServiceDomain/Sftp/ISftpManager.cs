using System;
using System.Threading.Tasks;

namespace RSZService.Sftp
{
	public interface ISftpManager : IDisposable
	{
		bool Upload(string targetFile, string sourceFile);
		Task<bool> UploadAsync(string targetFile, string sourceFile);
		bool UploadBulk(string[] targetFiles, string[] sourceFiles);
		Task<bool> UploadBulkAsync(string[] targetFiles, string[] sourceFiles);
		bool Download(string sourceFile, string targetFile);
		Task<bool> DownloadAsync(string sourceFile, string targetFile);
		bool DownloadBulk(string sourceDirectory, string targetDirectory);
		Task<bool> DownloadBulkAsync(string sourceDirectory, string targetDirectory);
	}
}
