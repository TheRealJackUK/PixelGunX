using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using Rilisoft;
using UnityEngine;

public class LicenseVerificationController : MonoBehaviour
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct PackageInfo
	{
		internal string PackageName { get; set; }

		internal string SignatureHash { get; set; }
	}

	[Flags]
	private enum PackageInfoFlags
	{
		GetSignatures = 0x40
	}

	private static readonly IDictionary<VerificationErrorCode, string> _errorMessages = new Dictionary<VerificationErrorCode, string>
	{
		{
			VerificationErrorCode.None,
			"None"
		},
		{
			VerificationErrorCode.BadResonceOrMessageOrSignature,
			"Bad responce code, or message, or signature"
		},
		{
			VerificationErrorCode.InvalidSignature,
			"Invalid signature"
		},
		{
			VerificationErrorCode.InsufficientFieldCount,
			"Insufficient field count"
		},
		{
			VerificationErrorCode.ResponceMismatch,
			"Response mismatch"
		}
	};

	private LicenseVerificationManager _licenseVerificationManager;

	private readonly Action _start;

	private readonly Action _update;

	public LicenseVerificationController()
	{
		LicenseVerificationController licenseVerificationController = this;
		bool startExecuted = false;
		_start = delegate
		{
			try
			{
				licenseVerificationController._licenseVerificationManager = licenseVerificationController.GetComponent<LicenseVerificationManager>();
				if (!(licenseVerificationController._licenseVerificationManager == null) && Application.platform == RuntimePlatform.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
				{
					UnityEngine.Object.DontDestroyOnLoad(licenseVerificationController.gameObject);
					licenseVerificationController.StartCoroutine(licenseVerificationController.WaitThenVerifyLicenseCoroutine());
				}
			}
			finally
			{
				startExecuted = true;
			}
		};
		_update = delegate
		{
			if (!startExecuted)
			{
				Application.LoadLevel(GetTerminalSceneName_f38d05cc(4086105548u));
			}
		};
	}

	private static string GetTerminalSceneName_f38d05cc(uint gamma)
	{
		return "Clf38d05ccosingScene".Replace(gamma.ToString("x"), string.Empty);
	}

	private void Start()
	{
		if (_start == null)
		{
			Application.LoadLevel(GetTerminalSceneName_f38d05cc(4086105548u));
		}
		else
		{
			_start();
		}
	}

	private void Update()
	{
		if (_update == null)
		{
			Application.LoadLevel(GetTerminalSceneName_f38d05cc(4086105548u));
		}
		else
		{
			_update();
		}
	}

	internal static PackageInfo GetPackageInfo()
	{
		PackageInfo packageInfo = default(PackageInfo);
		return packageInfo;
	}

	private static string GetErrorMessage(VerificationErrorCode errorCode)
	{
		string value;
		return (!_errorMessages.TryGetValue(errorCode, out value)) ? "Unknown" : value;
	}

	private void HandleVerificationResponse(VerificationEventArgs e)
	{
		string errorMessage = GetErrorMessage(e.ErrorCode);
		Debug.Log("HandleVerificationResponse(): Verification Error: " + errorMessage);
		FlurryPluginWrapper.LogEventWithParameterAndValue("Verification Error", "Message", errorMessage);
		if (e.ErrorCode == VerificationErrorCode.InvalidSignature)
		{
		}
		string eventName = string.Format("Verification {0:X3} {1}", (int)e.ReceivedResponseCode, e.ReceivedResponseCode);
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		if (e.ReceivedResponseCode != ResponseCode.ErrorContactingServer)
		{
			dictionary.Add("Received Version Code", e.ReceivedVersionCode.ToString());
			dictionary.Add("Received Package Name", e.ReceivedPackageName ?? string.Empty);
		}
		FlurryPluginWrapper.LogEvent(eventName);
	}

	private IEnumerator WaitThenVerifyLicenseCoroutine()
	{
		yield return new WaitForSeconds(20f);
		_licenseVerificationManager.Verify(HandleVerificationResponse);
	}
}
