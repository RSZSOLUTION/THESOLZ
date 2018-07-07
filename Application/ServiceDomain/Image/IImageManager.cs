using System;
using System.Threading.Tasks;

namespace RSZService.Image
{
	public interface IImageManager : IDisposable
	{
		void Compress(string sourcePath, string targetPath, int percentage);

		Task CompressAsync(string sourcePath, string targetPath, int percentage);

		void Compress(string sourcePath, string targetPath, int width, int height);

		Task CompressAsync(string sourcePath, string targetPath, int width, int height);

		void CompressWithFit(string sourcePath, string targetPath, int squareSize);

		Task CompressWithFitAsync(string sourcePath, string targetPath, int squareSize);

		void MargeHorizontally(string[] sources, string targetPath, bool isCompressed = true);

		Task MargeHorizontallyAsync(string[] sources, string targetPath, bool isCompressed = true);

		void MargeVertically(string[] sources, string targetPath, bool isCompressed = true);

		Task MargeVerticallyAsync(string[] sources, string targetPath, bool isCompressed = true);
	}
}
