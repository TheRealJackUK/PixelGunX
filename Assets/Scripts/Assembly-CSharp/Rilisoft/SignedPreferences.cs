using System;
using System.Collections.Generic;

namespace Rilisoft
{
	internal abstract class SignedPreferences : Preferences
	{
		private readonly Preferences _backPreferences;

		public override ICollection<string> Keys
		{
			get
			{
				return _backPreferences.Keys;
			}
		}

		public override ICollection<string> Values
		{
			get
			{
				return _backPreferences.Values;
			}
		}

		public override int Count
		{
			get
			{
				return _backPreferences.Count;
			}
		}

		public override bool IsReadOnly
		{
			get
			{
				return _backPreferences.IsReadOnly;
			}
		}

		protected Preferences BackPreferences
		{
			get
			{
				return _backPreferences;
			}
		}

		protected SignedPreferences(Preferences backPreferences)
		{
			_backPreferences = backPreferences;
		}

		public bool Verify(string key)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			return VerifyCore(key);
		}

		protected abstract void AddSignedCore(string key, string value);

		protected abstract bool RemoveSignedCore(string key);

		protected abstract bool VerifyCore(string key);

		protected override void AddCore(string key, string value)
		{
			AddSignedCore(key, value);
		}

		protected override bool ContainsKeyCore(string key)
		{
			return _backPreferences.ContainsKey(key);
		}

		protected override void CopyToCore(KeyValuePair<string, string>[] array, int arrayIndex)
		{
			_backPreferences.CopyTo(array, arrayIndex);
		}

		protected override bool RemoveCore(string key)
		{
			return RemoveSignedCore(key);
		}

		protected override bool TryGetValueCore(string key, out string value)
		{
			return _backPreferences.TryGetValue(key, out value);
		}

		public override void Save()
		{
			_backPreferences.Save();
		}

		public override void Clear()
		{
			_backPreferences.Clear();
		}

		public override IEnumerator<KeyValuePair<string, string>> GetEnumerator()
		{
			return _backPreferences.GetEnumerator();
		}
	}
}
