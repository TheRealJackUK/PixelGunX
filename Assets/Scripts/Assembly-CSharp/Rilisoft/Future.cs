using System;

namespace Rilisoft
{
	public class Future<T>
	{
		private bool _isCompleted;

		private T _result;

		public bool IsCompleted
		{
			get
			{
				return _isCompleted;
			}
		}

		public T Result
		{
			get
			{
				if (!_isCompleted)
				{
					throw new InvalidOperationException("Future is not completed.");
				}
				return _result;
			}
		}

		public event EventHandler Completed;

		protected void SetResult(T result)
		{
			_result = result;
			_isCompleted = true;
			EventHandler completed = this.Completed;
			if (completed != null)
			{
				completed(this, EventArgs.Empty);
			}
		}
	}
}
