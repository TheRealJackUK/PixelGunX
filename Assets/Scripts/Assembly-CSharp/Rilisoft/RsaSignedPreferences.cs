using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace Rilisoft
{
	internal sealed class RsaSignedPreferences : SignedPreferences
	{
		private const string SaltKeyValueFormat = "{0}__{1}__{2}";

		private const string Prefix = "com.Rilisoft";

		private readonly HashAlgorithm _hashAlgorithm = new SHA1CryptoServiceProvider();

		private readonly RSACryptoServiceProvider _signingRsaCsp;

		private readonly string _salt;

		private readonly byte[] _prefixBytes = Encoding.UTF8.GetBytes("com.Rilisoft");

		private readonly RSACryptoServiceProvider _verificationRsaCsp;

		public RsaSignedPreferences(Preferences backPreferences, RSACryptoServiceProvider rsaCsp, string salt)
			: base(backPreferences)
		{
			_signingRsaCsp = rsaCsp;
			_verificationRsaCsp = new RSACryptoServiceProvider();
			_verificationRsaCsp.ImportParameters(rsaCsp.ExportParameters(false));
			_salt = salt;
		}

		protected override void AddSignedCore(string key, string value)
		{
			if (key.StartsWith("com.Rilisoft"))
			{
				throw new ArgumentException("Key starts with reserved prefix.", "key");
			}
			base.BackPreferences.Add(key, value);
			base.BackPreferences.Add(GetSignatureKey(key), Sign(key, value));
		}

		protected override bool RemoveSignedCore(string key)
		{
			if (key.StartsWith("com.Rilisoft"))
			{
				throw new ArgumentException("Key starts with reserved prefix.", "key");
			}
			base.BackPreferences.Remove(GetSignatureKey(key));
			return base.BackPreferences.Remove(key);
		}

		protected override bool VerifyCore(string key)
		{
			//Discarded unreachable code: IL_0077, IL_0085
			string value;
			if (!TryGetValueCore(key, out value))
			{
				throw new KeyNotFoundException(string.Format("The given key was not present in the dictionary: {0}", key));
			}
			string s = string.Format("{0}__{1}__{2}", _salt, key, value);
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			string value2;
			if (!TryGetValueCore(GetSignatureKey(key), out value2))
			{
				return false;
			}
			try
			{
				byte[] signature = Convert.FromBase64String(value2);
				return _verificationRsaCsp.VerifyData(bytes, _hashAlgorithm, signature);
			}
			catch (FormatException)
			{
				return false;
			}
		}

		private string GetSignatureKey(string key)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(_salt);
			byte[] bytes2 = Encoding.UTF8.GetBytes(key);
			byte[] buffer = bytes.Concat(_prefixBytes).Concat(bytes2).ToArray();
			byte[] inArray = _hashAlgorithm.ComputeHash(buffer);
			return string.Format("{0}_{1}", "com.Rilisoft", Convert.ToBase64String(inArray));
		}

		private string Sign(string key, string value)
		{
			string s = string.Format("{0}__{1}__{2}", _salt, key, value);
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			byte[] inArray = _signingRsaCsp.SignData(bytes, _hashAlgorithm);
			return Convert.ToBase64String(inArray);
		}
	}
}
