using System;
using System.Collections;
using System.Collections.Generic;

namespace Rilisoft
{
	internal abstract class Preferences : ICollection<KeyValuePair<string, string>>, IEnumerable, IDictionary<string, string>, IEnumerable<KeyValuePair<string, string>>
	{
		public abstract ICollection<string> Keys { get; }

		public abstract ICollection<string> Values { get; }

		public string this[string key]
		{
			get
			{
				string value;
				if (TryGetValue(key, out value))
				{
					return value;
				}
				throw new KeyNotFoundException();
			}
			set
			{
				if (key == null)
				{
					throw new ArgumentNullException("key");
				}
				AddCore(key, value);
			}
		}

		public abstract int Count { get; }

		public abstract bool IsReadOnly { get; }

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}

		protected abstract void AddCore(string key, string value);

		protected abstract bool ContainsKeyCore(string key);

		protected abstract void CopyToCore(KeyValuePair<string, string>[] array, int arrayIndex);

		protected abstract bool RemoveCore(string key);

		protected abstract bool TryGetValueCore(string key, out string value);

		public abstract void Save();

		public void Add(string key, string value)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			AddCore(key, value);
		}

		public bool ContainsKey(string key)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			return ContainsKeyCore(key);
		}

		public bool Remove(string key)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			return RemoveCore(key);
		}

		public bool TryGetValue(string key, out string value)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			return TryGetValueCore(key, out value);
		}

		public void Add(KeyValuePair<string, string> item)
		{
			AddCore(item.Key, item.Value);
		}

		public abstract void Clear();

		public bool Contains(KeyValuePair<string, string> item)
		{
			if (item.Key == null)
			{
				throw new ArgumentException("Key is null.", "item");
			}
			string value;
			if (!TryGetValueCore(item.Key, out value))
			{
				return false;
			}
			return EqualityComparer<string>.Default.Equals(item.Value, value);
		}

		public void CopyTo(KeyValuePair<string, string>[] array, int arrayIndex)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (arrayIndex < 0)
			{
				throw new ArgumentOutOfRangeException("arrayIndex");
			}
			if (arrayIndex > array.Length)
			{
				throw new ArgumentException("Index larger than largest valid index of array.");
			}
			if (array.Length - arrayIndex < Count)
			{
				throw new ArgumentException("Destination array cannot hold the requested elements!");
			}
			CopyToCore(array, arrayIndex);
		}

		public bool Remove(KeyValuePair<string, string> item)
		{
			if (!Contains(item))
			{
				return false;
			}
			return Remove(item.Key);
		}

		public abstract IEnumerator<KeyValuePair<string, string>> GetEnumerator();
	}
}
