using System;
using System.Security.Cryptography;
using System.Text;

namespace Rilisoft
{
	public sealed class PlayerPrefsHelper : IDisposable
	{
		private bool _disposed;

		private readonly HMAC _hmac;

		private readonly string _hmacPrefsKey;

		internal PlayerPrefsHelper()
		{
			using (HashAlgorithm hashAlgorithm = new SHA256Managed())
			{
				_hmacPrefsKey = BitConverter.ToString(hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes("PrefsKey"))).Replace("-", string.Empty);
				_hmacPrefsKey = _hmacPrefsKey.Substring(0, Math.Min(32, _hmacPrefsKey.Length)).ToLower();
				byte[] key = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes("HmacKey"));
				_hmac = new HMACSHA256(key);
			}
		}

		public bool Verify()
		{
			return true;
		}

		public void Dispose()
		{
			if (!_disposed)
			{
				_hmac.Clear();
				_disposed = true;
			}
		}
	}
}
