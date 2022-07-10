using UnityEngine;

public class EveryplaySettings : ScriptableObject
{
	public string clientId;

	public string clientSecret;

	public string redirectURI = "https://m.everyplay.com/auth";

	public bool iosSupportEnabled;

	public bool androidSupportEnabled;

	public bool testButtonsEnabled;

	public bool IsEnabled
	{
		get
		{
			return androidSupportEnabled;
		}
	}

	public bool IsValid
	{
		get
		{
			if (clientId != null && clientSecret != null && redirectURI != null && clientId.Trim().Length > 0 && clientSecret.Trim().Length > 0 && redirectURI.Trim().Length > 0)
			{
				return true;
			}
			return false;
		}
	}
}
