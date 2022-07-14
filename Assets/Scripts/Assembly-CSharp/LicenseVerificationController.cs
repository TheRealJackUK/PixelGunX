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
	}

	private static string GetTerminalSceneName_f38d05cc(uint gamma)
	{
		return "no.";
	}

	private void Start()
	{
	}

	private void Update()
	{
	}

	internal static PackageInfo GetPackageInfo()
	{
		return new PackageInfo();
	}

	private static string GetErrorMessage(VerificationErrorCode errorCode)
	{
		return "no.";
	}

	private void HandleVerificationResponse(VerificationEventArgs e)
	{
	}

	private IEnumerator WaitThenVerifyLicenseCoroutine()
	{
		yield return 0f;
	}
}
