using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RSZData
{
	public class DataOperationManager : IDataOperationManager
	{
		private bool _disposed;

		public DataOperationManager()
		{
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
			}
			_disposed = true;
		}

		~DataOperationManager()
		{
			Dispose(false);
		}
	}
}
