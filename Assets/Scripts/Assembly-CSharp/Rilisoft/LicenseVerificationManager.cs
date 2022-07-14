using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

namespace Rilisoft
{
	public class LicenseVerificationManager : MonoBehaviour, IDisposable
	{
		public TextAsset serviceBinder;

		public string publicKeyModulusBase64;

		public string publicKeyExponentBase64;

		private static readonly SHA1 _dummy = new SHA1CryptoServiceProvider();

		private AndroidJavaObject _activity;

		private AndroidJavaObject _lvlCheckType;

		private bool _disposed = true;

		private string _packageName = string.Empty;

		private readonly System.Random _prng = new System.Random();

		private RSAParameters _publicKey = default(RSAParameters);

		private void OnDestroy()
		{
			Dispose();
		}

		private void Start()
		{
		}

		private void Update()
		{
			if (!_disposed)
			{
			}
		}

		public void Dispose()
		{
		}
		public void Verify(Action<VerificationEventArgs> completionHandler)
		{
		}

		private void Process(AndroidJavaObject lvlCheck, int nonce, Action<VerificationEventArgs> completionHandler)
		{
		}

		private void LoadServiceBinder()
		{
			//coolcodehere
		}
		}
	}
