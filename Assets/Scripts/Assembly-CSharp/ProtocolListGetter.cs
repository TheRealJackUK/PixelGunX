using System.Collections;
using Rilisoft;
using UnityEngine;

public sealed class ProtocolListGetter : MonoBehaviour
{
	public static bool currentVersionIsSupported = true;

	private string CurrentVersionSupportedKey = "CurrentVersionSupportedKey" + GlobalGameController.AppVersion;

	public static int CurrentPlatform
	{
		get
		{
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				return 0;
			}
			if (BuildSettings.BuildTarget == BuildTarget.Android && Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon)
			{
				return 1;
			}
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				return 2;
			}
			if (BuildSettings.BuildTarget == BuildTarget.Android && Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				return 3;
			}
			return 101;
		}
	}

	private IEnumerator Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
		if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			yield break;
		}
		if (!Storager.hasKey(CurrentVersionSupportedKey))
		{
			Storager.setInt(CurrentVersionSupportedKey, 1, false);
		}
		currentVersionIsSupported = Storager.getInt(CurrentVersionSupportedKey, false) == 1;
		string response;
		while (true)
		{
			WWWForm form = new WWWForm();
			form.AddField("action", "check_version");
			form.AddField("app_version", CurrentPlatform + ":" + GlobalGameController.AppVersion);
			WWW download = new WWW(FriendsController.actionAddress, form);
			yield return download;
			response = URLs.Sanitize(download);
			if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
			{
				Debug.Log(response);
			}
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild)
				{
					Debug.LogWarning("ProtocolListGetter error: " + download.error);
				}
				yield return new WaitForSeconds(10f);
			}
			else
			{
				if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response))
				{
					break;
				}
				yield return new WaitForSeconds(10f);
			}
		}
		if ("no".Equals(response))
		{
			currentVersionIsSupported = false;
			Storager.setInt(CurrentVersionSupportedKey, 0, false);
		}
		else
		{
			currentVersionIsSupported = true;
			Storager.setInt(CurrentVersionSupportedKey, 1, false);
		}
	}
}
