using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Threading.Tasks;

namespace RSZService.Image
{
	public class ImageManager : IImageManager
	{
		private bool _disposed;

		private void PrivateCompress(string sourcePath, string targetPath, int percentage)
		{
			try
			{
				using (var baseImg = System.Drawing.Image.FromFile(sourcePath))
				{
					var width = baseImg.Width * percentage / 100;
					var height = baseImg.Height * percentage / 100;
					using (var compressImg = new Bitmap(width, height))
					{
						var imgManager = Graphics.FromImage(compressImg);
						imgManager.CompositingQuality = CompositingQuality.HighQuality;
						imgManager.SmoothingMode = SmoothingMode.HighQuality;
						imgManager.InterpolationMode = InterpolationMode.HighQualityBicubic;
						var imageRectangle = new Rectangle(0, 0, width, height);
						imgManager.Clear(Color.White);
						imgManager.DrawImage(baseImg, imageRectangle);
						compressImg.Save(targetPath, ImageFormat.Png);
					}
				}
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private void PrivateCompress(string sourcePath, string targetPath, int width, int height)
		{
			try
			{
				using (var baseImg = System.Drawing.Image.FromFile(sourcePath))
				{
					using (var compressImg = new Bitmap(width, height))
					{
						var imgManager = Graphics.FromImage(compressImg);
						imgManager.CompositingQuality = CompositingQuality.HighQuality;
						imgManager.SmoothingMode = SmoothingMode.HighQuality;
						imgManager.InterpolationMode = InterpolationMode.HighQualityBicubic;
						var imageRectangle = new Rectangle(0, 0, width, height);
						imgManager.Clear(Color.White);
						imgManager.DrawImage(baseImg, imageRectangle);
						compressImg.Save(targetPath, ImageFormat.Png);
					}
				}
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private void PrivateCompressWithFit(string sourcePath, string targetPath, int squareSize)
		{
			try
			{
				using (var baseImg = System.Drawing.Image.FromFile(sourcePath))
				{
					var maxValue = baseImg.Width <= baseImg.Height ? baseImg.Height : baseImg.Width;
					var maxType = baseImg.Width <= baseImg.Height ? "H" : "W";
					var newWidth = maxType == "W"
						? squareSize
						: (int)(baseImg.Width - baseImg.Width * (Convert.ToDecimal(maxValue - 300) * 100 / maxValue) / 100);
					var newHeight = maxType == "H"
						? squareSize
						: (int)(baseImg.Height - baseImg.Height * (Convert.ToDecimal(maxValue - 300) * 100 / maxValue) / 100);
					var offsetX = maxType == "W" ? 0 : (squareSize - newWidth) / 2;
					var offsetY = maxType == "H" ? 0 : (squareSize - newHeight) / 2;
					using (var compressImg = new Bitmap(squareSize, squareSize))
					{
						var imgManager = Graphics.FromImage(compressImg);
						imgManager.CompositingQuality = CompositingQuality.HighQuality;
						imgManager.SmoothingMode = SmoothingMode.HighQuality;
						imgManager.InterpolationMode = InterpolationMode.HighQualityBicubic;
						var imageRectangle = new Rectangle(offsetX, offsetY, newWidth, newHeight);
						imgManager.Clear(Color.White);
						imgManager.DrawImage(baseImg, imageRectangle);
						compressImg.Save(targetPath, ImageFormat.Png);
					}
				}
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private void PrivateMargeHorizontally(string[] sources, string targetPath, bool isCompressed)
		{
			try
			{
				var height = 600;
				var width = 600 * sources.Length;
				var offsetX = 0;
				using (var compressImg = new Bitmap(width, height))
				{
					var imgManager = Graphics.FromImage(compressImg);
					imgManager.CompositingQuality = CompositingQuality.HighQuality;
					imgManager.SmoothingMode = SmoothingMode.HighQuality;
					imgManager.InterpolationMode = InterpolationMode.HighQualityBicubic;
					imgManager.Clear(Color.White);
					foreach (var path in sources)
						using (var image = System.Drawing.Image.FromFile(path))
						{
							var imageRectangle = new Rectangle(offsetX, 0, 600, 600);
							imgManager.DrawImage(image, imageRectangle);
							offsetX += 600;
						}
					if (!isCompressed)
						compressImg.Save(targetPath, ImageFormat.Png);
					else
						compressImg.Save(sources[0] + ".tmp", ImageFormat.Png);
				}
				if (isCompressed)
					Compress(sources[0] + ".tmp", targetPath, 40);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		private void PrivateMargeVertically(string[] sources, string targetPath, bool isCompressed)
		{
			try
			{
				var width = 600;
				var height = 600 * sources.Length;
				var offsetY = 0;
				using (var compressImg = new Bitmap(width, height))
				{
					var imgManager = Graphics.FromImage(compressImg);
					imgManager.CompositingQuality = CompositingQuality.HighQuality;
					imgManager.SmoothingMode = SmoothingMode.HighQuality;
					imgManager.InterpolationMode = InterpolationMode.HighQualityBicubic;
					imgManager.Clear(Color.White);
					foreach (var path in sources)
						using (var image = System.Drawing.Image.FromFile(path))
						{
							var imageRectangle = new Rectangle(0, offsetY, 600, 600);
							imgManager.DrawImage(image, imageRectangle);
							offsetY += 600;
						}
					if (!isCompressed)
						compressImg.Save(targetPath, ImageFormat.Png);
					else
						compressImg.Save(sources[0] + ".tmp", ImageFormat.Png);
				}
				if (isCompressed)
					Compress(sources[0] + ".tmp", targetPath, 40);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		public ImageManager() { }

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
			}
			_disposed = true;
		}

		~ImageManager()
		{
			Dispose(false);
		}

		public void Compress(string sourcePath, string targetPath, int percentage)
		{
			PrivateCompress(sourcePath, targetPath, percentage);
		}

		public async Task CompressAsync(string sourcePath, string targetPath, int percentage)
		{
			await Task.Factory.StartNew(() => { PrivateCompress(sourcePath, targetPath, percentage); });
		}

		public void Compress(string sourcePath, string targetPath, int width, int height)
		{
			PrivateCompress(sourcePath, targetPath, width, height);
		}

		public async Task CompressAsync(string sourcePath, string targetPath, int width, int height)
		{
			await Task.Factory.StartNew(() => { PrivateCompress(sourcePath, targetPath, width, height); });
		}

		public void CompressWithFit(string sourcePath, string targetPath, int squareSize)
		{
			PrivateCompressWithFit(sourcePath, targetPath, squareSize);
		}

		public async Task CompressWithFitAsync(string sourcePath, string targetPath, int squareSize)
		{
			await Task.Factory.StartNew(() => { PrivateCompressWithFit(sourcePath, targetPath, squareSize); });
		}

		public void MargeHorizontally(string[] sources, string targetPath, bool isCompressed = true)
		{
			PrivateMargeHorizontally(sources, targetPath, isCompressed);
		}

		public async Task MargeHorizontallyAsync(string[] sources, string targetPath, bool isCompressed = true)
		{
			await Task.Factory.StartNew(() => { PrivateMargeHorizontally(sources, targetPath, isCompressed); });
		}

		public void MargeVertically(string[] sources, string targetPath, bool isCompressed = true)
		{
			PrivateMargeVertically(sources, targetPath, isCompressed);
		}

		public async Task MargeVerticallyAsync(string[] sources, string targetPath, bool isCompressed = true)
		{
			await Task.Factory.StartNew(() => { PrivateMargeVertically(sources, targetPath, isCompressed); });
		}
	}
}
