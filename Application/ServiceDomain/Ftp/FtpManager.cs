using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Threading.Tasks;

namespace RSZService.Ftp
{
	public class FtpManager : IFtpManager
	{
		private bool _disposed;
		private FtpWebRequest _ftp;

		private string Host { get { return ConfigurationManager.AppSettings["FTP_HOST"].ToString(); } }
		private string User { get { return ConfigurationManager.AppSettings["FTP_USER"].ToString(); } }
		private string Password { get { return ConfigurationManager.AppSettings["FTP_PASSWORD"].ToString(); } }

		private FtpWebRequest InitailizeFTP(string target)
		{
			var ftp = (FtpWebRequest)FtpWebRequest.Create(new Uri($"{Host}/{target}"));
			ftp.Credentials = new NetworkCredential(User, Password);
			ftp.UsePassive = true;
			ftp.KeepAlive = false;
			ftp.Proxy = null;
			ftp.UseBinary = false;
			ftp.Timeout = 90000;
			return ftp;
		}

		public FtpManager() { }

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
				_ftp = null;
			}
			_disposed = true;
		}

		~FtpManager()
		{
			Dispose(false);
		}

		public bool Upload(string targetFile, string sourceFile)
		{
			try
			{
				_ftp = InitailizeFTP(targetFile);
				var fileContent = File.ReadAllBytes(sourceFile);
				_ftp.ContentLength = fileContent.Length;
				var buffLength = 2048;
				var buff = new byte[buffLength];
				using (var ms = new MemoryStream(fileContent))
				{
					int contentLength;
					using (var strm = _ftp.GetRequestStream())
					{
						contentLength = ms.Read(buff, 0, buffLength);
						while (contentLength > 0)
						{
							strm.Write(buff, 0, contentLength);
							contentLength = ms.Read(buff, 0, buffLength);
						}
					}
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
				_ftp = InitailizeFTP(targetFile);
				var fileContent = File.ReadAllBytes(sourceFile);
				_ftp.ContentLength = fileContent.Length;
				var buffLength = 2048;
				var buff = new byte[buffLength];
				using (var ms = new MemoryStream(fileContent))
				{
					int contenctLength;
					using (var strm = (await _ftp.GetRequestStreamAsync()))
					{
						contenctLength = ms.Read(buff, 0, buffLength);
						while (contenctLength > 0)
						{
							strm.Write(buff, 0, contenctLength);
							contenctLength = ms.Read(buff, 0, buffLength);
						}
					}
				}
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
				_ftp = InitailizeFTP(sourceFile);
				_ftp.Method = WebRequestMethods.Ftp.DownloadFile;
				using (var ostrm = new FileStream(targetFile, FileMode.OpenOrCreate))
				using (var response = (FtpWebResponse)_ftp.GetResponse())
				using (var strm = response.GetResponseStream())
				{
					var bufferSize = 2048;
					int readCount;
					byte[] buffer = new byte[bufferSize];
					readCount = strm.Read(buffer, 0, bufferSize);
					while (readCount > 0)
					{
						ostrm.Write(buffer, 0, readCount);
						readCount = strm.Read(buffer, 0, bufferSize);
					}
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
				_ftp = InitailizeFTP(sourceFile);
				_ftp.Method = WebRequestMethods.Ftp.DownloadFile;
				using (var ostrm = new FileStream(targetFile, FileMode.OpenOrCreate))
				using (var response = (FtpWebResponse)(await _ftp.GetResponseAsync()))
				using (var strm = response.GetResponseStream())
				{
					var bufferSize = 2048;
					int readCount;
					byte[] buffer = new byte[bufferSize];
					readCount = strm.Read(buffer, 0, bufferSize);
					while (readCount > 0)
					{
						ostrm.Write(buffer, 0, readCount);
						readCount = strm.Read(buffer, 0, bufferSize);
					}
				}
				return true;
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}
	}
}
