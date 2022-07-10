namespace Rilisoft
{
	public class Promise<T>
	{
		private class FutureImpl<U> : Future<U>
		{
			internal new void SetResult(U result)
			{
				base.SetResult(result);
			}
		}

		private readonly FutureImpl<T> _future = new FutureImpl<T>();

		public Future<T> Future
		{
			get
			{
				return _future;
			}
		}

		public void SetResult(T result)
		{
			_future.SetResult(result);
		}
	}
}
