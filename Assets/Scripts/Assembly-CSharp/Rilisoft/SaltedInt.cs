using UnityEngine;

namespace Rilisoft
{
	public struct SaltedInt
	{
		private readonly int _salt;

		private int _saltedValue;

		public int Value
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

		public SaltedInt(int salt, int value)
		{
			_salt = salt;
			_saltedValue = salt ^ value;
		}

		public SaltedInt(int salt)
			: this(salt, 0)
		{
		}

		public static implicit operator SaltedInt(int i)
		{
			return new SaltedInt(Random.Range(int.MinValue, int.MaxValue), i);
		}
	}
}
