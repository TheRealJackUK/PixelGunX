using System;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;
using CodeStage.AntiCheat.Storage;

public static class Storager
{
	private const bool useCryptoPlayerPrefs = true;

	private const bool _useSignedPreferences = true;

	private static bool iCloudAvailable;

	private static IDictionary<string, int> _keychainCache;

	private static IDictionary<string, string> _keychainStringCache;

	private static Dictionary<string, int> iosCloudSyncBuffer;

	private static readonly IDictionary<string, SaltedInt> _protectedIntCache;

	private static readonly System.Random _prng;

	private static readonly string[] _expendableKeys;

	static Storager()
	{
		iCloudAvailable = false;
		_keychainCache = new Dictionary<string, int>();
		_keychainStringCache = new Dictionary<string, string>();
		iosCloudSyncBuffer = new Dictionary<string, int>();
		_protectedIntCache = new Dictionary<string, SaltedInt>();
		_prng = new System.Random();
		_expendableKeys = new string[4]
		{
			GearManager.InvisibilityPotion,
			GearManager.Jetpack,
			GearManager.Turret,
			GearManager.Mech
		};
		if (BuildSettings.BuildTarget != BuildTarget.iPhone)
		{
			return;
		}
		foreach (string item in PurchasesSynchronizer.AllItemIds())
		{
			iosCloudSyncBuffer.Add(item, 0);
		}
	}

	public static void SynchronizeIosWithCloud()
	{
		if (BuildSettings.BuildTarget == BuildTarget.iPhone && !iCloudAvailable)
		{
		}
	}

	public static void Initialize(bool cloudAvailable)
	{
	}

	public static bool hasKey(string key)
	{
		bool flag = ObscuredPrefs.HasKey(key);
		if ((key.Equals("Coins") || key.Equals("GemsCurrency")))
		{
			return true;
		}
		return flag;
	}

	public static void setInt(string key, int val, bool useICloud)
	{
		ObscuredPrefs.SetInt(key, val);
	}

	public static int getInt(string key, bool useICloud)
	{
		return ObscuredPrefs.GetInt(key);
	}

	public static void setString(string key, string val, bool useICloud)
	{
		ObscuredPrefs.SetString(key, val);
		return;
	}

	public static string getString(string key, bool useICloud)
	{
		return ObscuredPrefs.GetString(key);
	}

	public static bool IsInitialized(string flagName)
	{
		return ObscuredPrefs.HasKey(flagName);
	}

	public static void SetInitialized(string flagName)
	{
		setInt(flagName, 0, false);
	}

	public static void SyncWithCloud(string storageId)
	{
	}

	private static void RefreshExpendablesDigest()
	{
		byte[] value = _expendableKeys.SelectMany((string key) => BitConverter.GetBytes(getInt(key, false))).ToArray();
		DigestStorager.Instance.Set("ExpendablesCount", value);
	}

	private static void RefreshWeaponsDigest(string weaponTag)
	{
		if (Application.isEditor)
		{
			Debug.Log("Refreshed weapon: " + weaponTag);
		}
		IEnumerable<string> source = WeaponManager.storeIDtoDefsSNMapping.Values.Where((string w) => getInt(w, false) == 1);
		int value = source.Count();
		DigestStorager.Instance.Set("WeaponsCount", value);
	}
}
