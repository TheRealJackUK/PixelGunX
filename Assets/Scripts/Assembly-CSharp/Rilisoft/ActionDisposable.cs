using System;

namespace Rilisoft
{
	internal sealed class ActionDisposable : IDisposable
	{
		private readonly Action _action;

		private bool _disposed;

		public ActionDisposable(Action action)
		{
			_action = action;
		}

		public void Dispose()
		{
			if (!_disposed)
			{
				if (_action != null)
				{
					_action();
				}
				_disposed = true;
			}
		}
	}
}
