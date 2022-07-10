using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class DigestStorager
	{
		private readonly bool _useCryptoPlayerPrefs;

		private readonly HashAlgorithm _hmac;

		private static readonly Lazy<DigestStorager> _instance = new Lazy<DigestStorager>(() => new DigestStorager());

		public static DigestStorager Instance
		{
			get
			{
				return _instance.Value;
			}
		}

		public DigestStorager()
		{
			byte[] key = new byte[64]
			{
				62, 59, 146, 50, 196, 43, 151, 12, 34, 157,
				74, 34, 25, 226, 239, 167, 46, 226, 151, 253,
				149, 85, 40, 56, 107, 254, 198, 111, 152, 34,
				73, 206, 184, 145, 51, 23, 161, 197, 53, 9,
				59, 16, 106, 151, 54, 115, 158, 48, 176, 147,
				174, 119, 233, 88, 253, 94, 20, 2, 164, 67,
				205, 142, 150, 2
			};
			_hmac = new HMACSHA1(key, true);
		}

		public void Clear()
		{
		}

		public bool ContainsKey(string key)
		{
			string backingStoreKey = GetBackingStoreKey(key);
			return (!_useCryptoPlayerPrefs) ? PlayerPrefs.HasKey(backingStoreKey) : CryptoPlayerPrefs.HasKey(backingStoreKey);
		}

		public void Remove(string key)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			string backingStoreKey = GetBackingStoreKey(key);
			if (_useCryptoPlayerPrefs)
			{
				CryptoPlayerPrefs.DeleteKey(backingStoreKey);
			}
			else
			{
				PlayerPrefs.DeleteKey(backingStoreKey);
			}
		}

		public void Save()
		{
			if (_useCryptoPlayerPrefs)
			{
				CryptoPlayerPrefs.Save();
			}
			else
			{
				PlayerPrefs.Save();
			}
		}

		public void Set(string key, int value)
		{
			byte[] bytes = BitConverter.GetBytes(value);
			SetCore(key, bytes);
		}

		public void Set(string key, string value)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(value ?? string.Empty);
			SetCore(key, bytes);
		}

		public void Set(string key, byte[] value)
		{
			byte[] valueBytes = value ?? new byte[0];
			SetCore(key, valueBytes);
		}

		public bool Verify(string key, int value)
		{
			byte[] bytes = BitConverter.GetBytes(value);
			return VerifyCore(key, bytes);
		}

		public bool Verify(string key, string value)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(value ?? string.Empty);
			return VerifyCore(key, bytes);
		}

		public bool Verify(string key, byte[] value)
		{
			byte[] valueBytes = value ?? new byte[0];
			return VerifyCore(key, valueBytes);
		}

		public bool VerifyCore(string key, byte[] valueBytes)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			if (!ContainsKey(key))
			{
				return false;
			}
			byte[] second = ComputeHash(key, valueBytes);
			string backingStoreKey = GetBackingStoreKey(key);
			string s = ((!_useCryptoPlayerPrefs) ? PlayerPrefs.GetString(backingStoreKey) : CryptoPlayerPrefs.GetString(backingStoreKey, string.Empty));
			byte[] first = Convert.FromBase64String(s);
			return first.SequenceEqual(second);
		}

		private byte[] ComputeHash(string key, byte[] valueBytes)
		{
			byte[] bytes = BitConverter.GetBytes(key.GetHashCode());
			byte[] array = new byte[bytes.Length + valueBytes.Length];
			bytes.CopyTo(array, 0);
			valueBytes.CopyTo(array, bytes.Length);
			return _hmac.ComputeHash(array);
		}

		private void SetCore(string key, byte[] valueBytes)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			byte[] inArray = ComputeHash(key, valueBytes);
			string text = Convert.ToBase64String(inArray);
			string backingStoreKey = GetBackingStoreKey(key);
			if (_useCryptoPlayerPrefs)
			{
				CryptoPlayerPrefs.SetString(backingStoreKey, text);
			}
			else
			{
				PlayerPrefs.SetString(backingStoreKey, text);
			}
		}

		public string GetBackingStoreKey(string key)
		{
			string text = string.Format("Digest-9.4.1-{0:d}.", BuildSettings.BuildTarget);
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			if (Application.isEditor)
			{
				return text + key;
			}
			byte[] bytes = Encoding.UTF8.GetBytes(key);
			string text2 = Convert.ToBase64String(bytes);
			return text + text2;
		}
	}
}
