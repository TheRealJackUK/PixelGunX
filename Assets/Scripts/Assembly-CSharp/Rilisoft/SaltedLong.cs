namespace Rilisoft
{
	public struct SaltedLong
	{
		private readonly long _salt;

		private long _saltedValue;

		public long Value
		{
			get
			{
				return _salt ^ _saltedValue;
			}
			set
			{
				_saltedValue = _salt ^ value;
			}
		}

		public SaltedLong(long salt, long value)
		{
			_salt = salt;
			_saltedValue = salt ^ value;
		}

		public SaltedLong(long salt)
			: this(salt, 0L)
		{
		}
	}
}
