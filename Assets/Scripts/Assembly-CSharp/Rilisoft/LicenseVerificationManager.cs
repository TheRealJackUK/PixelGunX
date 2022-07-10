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
			if (serviceBinder == null || string.IsNullOrEmpty(publicKeyModulusBase64) || string.IsNullOrEmpty(publicKeyExponentBase64))
			{
				Debug.LogWarning("Object not properly initialized.");
				return;
			}
			_publicKey.Modulus = Convert.FromBase64String(publicKeyModulusBase64);
			_publicKey.Exponent = Convert.FromBase64String(publicKeyExponentBase64);
			bool flag = false;
			try
			{
				if (Application.platform == RuntimePlatform.Android)
				{
					flag = new AndroidJavaClass("android.os.Build").GetRawClass() != IntPtr.Zero;
				}
			}
			catch (Exception message)
			{
				Debug.LogWarning(message);
			}
			if (flag)
			{
				LoadServiceBinder();
				_disposed = false;
			}
		}

		private void Update()
		{
			if (!_disposed)
			{
			}
		}

		public void Dispose()
		{
			if (!_disposed)
			{
				Resources.UnloadAsset(serviceBinder);
				serviceBinder = null;
				if (_activity != null)
				{
					_activity.Dispose();
					_activity = null;
				}
				if (_lvlCheckType != null)
				{
					_lvlCheckType.Dispose();
					_lvlCheckType = null;
				}
				_disposed = true;
			}
		}

		public void Verify(Action<VerificationEventArgs> completionHandler)
		{
			if (_disposed)
			{
				Debug.LogWarning("Object disposed: " + GetType().Name);
			}
			else if (completionHandler == null)
			{
				Debug.LogWarning("Completion handler should not be null.");
			}
			else if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				int nonce = _prng.Next();
				object[] args = new object[1] { new AndroidJavaObject[1] { _activity } };
				AndroidJavaObject[] array = _lvlCheckType.Call<AndroidJavaObject[]>("getConstructors", new object[0]);
				AndroidJavaObject lvlCheck = array[0].Call<AndroidJavaObject>("newInstance", args);
				lvlCheck.Call("create", nonce, (AndroidJavaRunnable)delegate
				{
					Process(lvlCheck, nonce, completionHandler);
				});
			}
		}

		private void Process(AndroidJavaObject lvlCheck, int nonce, Action<VerificationEventArgs> completionHandler)
		{
			//Discarded unreachable code: IL_00fc
			int num = lvlCheck.Get<int>("_arg0");
			string text = lvlCheck.Get<string>("_arg1");
			string text2 = lvlCheck.Get<string>("_arg2");
			VerificationEventArgs verificationEventArgs = new VerificationEventArgs();
			verificationEventArgs.ReceivedResponseCode = (ResponseCode)num;
			verificationEventArgs.SentNonce = nonce;
			verificationEventArgs.SentPackageName = _packageName;
			VerificationEventArgs verificationEventArgs2 = verificationEventArgs;
			if (num < 0 || string.IsNullOrEmpty(text) || string.IsNullOrEmpty(text2))
			{
				verificationEventArgs2.ErrorCode = VerificationErrorCode.BadResonceOrMessageOrSignature;
				completionHandler(verificationEventArgs2);
			}
			else
			{
				try
				{
					byte[] bytes = Encoding.UTF8.GetBytes(text);
					byte[] rgbSignature = Convert.FromBase64String(text2);
					RSACryptoServiceProvider rSACryptoServiceProvider = new RSACryptoServiceProvider();
					rSACryptoServiceProvider.ImportParameters(_publicKey);
					SHA1Managed sHA1Managed = new SHA1Managed();
					if (!rSACryptoServiceProvider.VerifyHash(sHA1Managed.ComputeHash(bytes), CryptoConfig.MapNameToOID("SHA1"), rgbSignature))
					{
						verificationEventArgs2.ErrorCode = VerificationErrorCode.InvalidSignature;
						completionHandler(verificationEventArgs2);
						goto IL_01cc;
					}
				}
				catch (FormatException)
				{
					verificationEventArgs2.ErrorCode = VerificationErrorCode.FormatError;
					completionHandler(verificationEventArgs2);
					goto IL_01cc;
				}
				int num2 = text.IndexOf(':');
				string text3 = ((num2 != -1) ? text.Substring(0, num2) : text);
				string[] array = text3.Split('|');
				if (array.Length < 6)
				{
					verificationEventArgs2.ErrorCode = VerificationErrorCode.InsufficientFieldCount;
					completionHandler(verificationEventArgs2);
				}
				else
				{
					if (array[0].CompareTo(num.ToString()) == 0)
					{
						verificationEventArgs2.ReceivedNonce = Convert.ToInt32(array[1]);
						verificationEventArgs2.ReceivedPackageName = array[2];
						verificationEventArgs2.ReceivedVersionCode = Convert.ToInt32(array[3]);
						verificationEventArgs2.ReceivedUserId = array[4];
						verificationEventArgs2.ReceivedTimestamp = Convert.ToInt64(array[5]);
						lvlCheck.Dispose();
						completionHandler(verificationEventArgs2);
						return;
					}
					verificationEventArgs2.ErrorCode = VerificationErrorCode.ResponceMismatch;
					completionHandler(verificationEventArgs2);
				}
			}
			goto IL_01cc;
			IL_01cc:
			string message = string.Format("Response code: {0}    Message: “{1}”    Signature: “{2}”", num, text, text2);
			Debug.LogWarning(message);
		}

		private void LoadServiceBinder()
		{
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				byte[] bytes = serviceBinder.bytes;
				_activity = AndroidSystem.Instance.CurrentActivity;
				_packageName = _activity.Call<string>("getPackageName", new object[0]);
				string text = Path.Combine(_activity.Call<AndroidJavaObject>("getCacheDir", new object[0]).Call<string>("getPath", new object[0]), _packageName);
				Directory.CreateDirectory(text);
				File.WriteAllBytes(text + "/classes.jar", bytes);
				Directory.CreateDirectory(text + "/odex");
				AndroidJavaObject androidJavaObject = new AndroidJavaObject("dalvik.system.DexClassLoader", text + "/classes.jar", text + "/odex", null, _activity.Call<AndroidJavaObject>("getClassLoader", new object[0]));
				_lvlCheckType = androidJavaObject.Call<AndroidJavaObject>("findClass", new object[1] { "com.unity3d.plugin.lvl.ServiceBinder" });
				if (_lvlCheckType == null)
				{
					Debug.Log("Could not instantiate ServiceBinder.");
					Dispose();
				}
				Directory.Delete(text, true);
			}
		}
	}
}
