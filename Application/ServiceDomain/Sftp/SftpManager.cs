using Renci.SshNet;
using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace RSZService.Sftp
{
	public class SftpManager : ISftpManager
	{
		private bool _disposed;
		private readonly SftpClient _sftp = null;

		private string Host { get { return ConfigurationManager.AppSettings["SFTP_HOST"].ToString(); } }
		private int Port { get { return Convert.ToInt32(ConfigurationManager.AppSettings["SFTP_PORT"].ToString()); } }
		private string User { get { return ConfigurationManager.AppSettings["SFTP_USER"].ToString(); } }
		private string Password { get { return ConfigurationManager.AppSettings["SFTP_PASSWORD"].ToString(); } }

		public SftpManager()
		{
			_sftp = new SftpClient(Host, Port, User, Password);
			_sftp.Connect();
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
				if (_sftp.IsConnected)
					_sftp.Disconnect();
				_sftp.Dispose();
			}
			_disposed = true;
		}

		~SftpManager()
		{
			Dispose(false);
		}

		public bool Upload(string targetFile, string sourceFile)
		{
			try
			{
				using (var fs = new FileStream(sourceFile, FileMode.Open))
				{
					_sftp.BufferSize = (uint)(File.ReadAllBytes(sourceFile)).Length;
					_sftp.UploadFile(fs, Path.GetFileName(targetFile), true);
				}
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public async Task<bool> UploadAsync(string targetFile, string sourceFile)
		{
			try
			{
				await Task.Run(() =>
				{
					using (var fs = new FileStream(sourceFile, FileMode.Open))
					{
						_sftp.BufferSize = (uint)(File.ReadAllBytes(sourceFile)).Length;
						_sftp.UploadFile(fs, Path.GetFileName(targetFile), true);
					}
				});
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public bool UploadBulk(string[] targetFiles, string[] sourceFiles)
		{
			try
			{
				var i = 0;
				sourceFiles.ToList().ForEach(item =>
				{
					using (var fs = new FileStream(item, FileMode.Open))
					{
						_sftp.BufferSize = (uint)(File.ReadAllBytes(item)).Length;
						_sftp.UploadFile(fs, Path.GetFileName(targetFiles[i]), true);
						i += 1;
					}
				});
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public async Task<bool> UploadBulkAsync(string[] targetFiles, string[] sourceFiles)
		{
			try
			{
				var i = 0;
				await Task.Run(() =>
				{
					sourceFiles.ToList().ForEach(item =>
					{
						using (var fs = new FileStream(item, FileMode.Open))
						{
							_sftp.BufferSize = (uint)(File.ReadAllBytes(item)).Length;
							_sftp.UploadFile(fs, Path.GetFileName(targetFiles[i]), true);
							i += 1;
						}
					});
				});
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public bool Download(string sourceFile, string targetFile)
		{
			try
			{
				using (var fs = File.Create(targetFile))
				{
					_sftp.DownloadFile(sourceFile, fs);
				}
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public async Task<bool> DownloadAsync(string sourceFile, string targetFile)
		{
			try
			{
				await Task.Run(() =>
				{
					using (var fs = File.Create(targetFile))
					{
						_sftp.DownloadFile(sourceFile, fs);
					}
				});
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public bool DownloadBulk(string sourceDirectory, string targetDirectory)
		{
			try
			{
				var files = _sftp.ListDirectory(sourceDirectory);
				files.ToList().ForEach(item =>
				{
					using (var fs = File.Create($"{targetDirectory}/{item.Name}"))
					{
						_sftp.DownloadFile($"{sourceDirectory}/{item.Name}", fs);
					}
				});
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public async Task<bool> DownloadBulkAsync(string sourceDirectory, string targetDirectory)
		{
			try
			{
				await Task.Run(() =>
				{
					var files = _sftp.ListDirectory(sourceDirectory);
					files.ToList().ForEach(item =>
					{
						using (var fs = File.Create($"{targetDirectory}/{item.Name}"))
						{
							_sftp.DownloadFile($"{sourceDirectory}/{item.Name}", fs);
						}
					});
				});
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}
	}
}
