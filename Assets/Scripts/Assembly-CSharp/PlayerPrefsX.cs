using UnityEngine;

public class PlayerPrefsX
{
	public static string SndSetting
	{
		get
		{
			return "SoundMusicSetting";
		}
	}

	public static string SoundMusicSetting
	{
		get
		{
			return "SoundMusicSetting";
		}
	}

	public static string SoundFXSetting
	{
		get
		{
			return "SoundFXSetting";
		}
	}

	public static void SetBool(string name, bool booleanValue)
	{
		PlayerPrefs.SetInt(name, booleanValue ? 1 : 0);
	}

	public static bool GetBool(string name)
	{
		return PlayerPrefs.GetInt(name) == 1;
	}

	public static bool GetBool(string name, bool defaultValue)
	{
		if (PlayerPrefs.HasKey(name))
		{
			return GetBool(name);
		}
		return defaultValue;
	}
}
