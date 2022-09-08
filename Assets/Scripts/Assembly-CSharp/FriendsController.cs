using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using Rilisoft;
using Rilisoft.MiniJson;
using SimpleJSON;
using UnityEngine;
using UnityEngine.Networking;

public sealed class FriendsController : MonoBehaviour
{
	private const string RejectsKey = "RejectsKey";

	private const string FriendsKey = "FriendsKey";

	private const string ToUsKey = "ToUsKey";

	private const string FromUsKey = "FromUsKey";

	private const string PlayerInfoKey = "PlayerInfoKey";

	private const string ClanInvitesKey = "ClanInvitesKey";

	public int Banned = -1;

	public static float onlineDelta = 60f;

	public static Dictionary<string, Dictionary<string, string>> mapPopularityDictionary = new Dictionary<string, Dictionary<string, string>>();

	public static bool readyToOperate = false;

	public static FriendsController sharedController = null;

	private bool friendsReceivedOnce;

	public string ClanID;

	public string clanLeaderID;

	public string clanLogo;

	public string clanName;

	public int NumberOfFriendsRequests;

	public int NumberOffFullInfoRequests;

	public int NumberOfBestPlayersRequests;

	public int NumberOfClanInfoRequests;

	public int NumberOfCreateClanRequests;

	private float lastTouchTm;

	private bool idle;

	private List<int> ids = new List<int>();

	public List<string> friendsDeletedLocal = new List<string>();

	public string JoinClanSent;

	private string AccountCreated = "AccountCreated";

	public string id;

	public List<Dictionary<string, string>> friends = new List<Dictionary<string, string>>();

	public List<Dictionary<string, string>> clanMembers = new List<Dictionary<string, string>>();

	public List<Dictionary<string, string>> invitesFromUs = new List<Dictionary<string, string>>();

	public List<Dictionary<string, string>> invitesToUs = new List<Dictionary<string, string>>();

	public List<Dictionary<string, string>> rejects = new List<Dictionary<string, string>>();

	public List<Dictionary<string, string>> ClanInvites = new List<Dictionary<string, string>>();

	public List<string> ClanSentInvites = new List<string>();

	public List<string> clanSentInvitesLocal = new List<string>();

	public List<string> clanCancelledInvitesLocal = new List<string>();

	public List<string> clanDeletedLocal = new List<string>();

	public Dictionary<string, Dictionary<string, object>> playersInfo = new Dictionary<string, Dictionary<string, object>>();

	public Dictionary<string, Dictionary<string, string>> onlineInfo = new Dictionary<string, Dictionary<string, string>>();

	public List<string> notShowAddIds = new List<string>();

	public Dictionary<string, Dictionary<string, object>> facebookFriendsInfo = new Dictionary<string, Dictionary<string, object>>();

	public string alphaIvory;

	private static HMAC _hmac;

	public string nick;

	public string skin;

	public int rank;

	public int coopScore;

	public int survivalScore;

	internal SaltedInt wins = new SaltedInt(641227346);

	public Dictionary<string, object> ourInfo;

	public string capeName;

	public string hatName;

	public string bootsName;

	public string capeSkin;

	public string armorName;

	public string id_fb;

	private string FacebookIDKey = "FacebookIDKey";

	public bool dataSent;

	private bool infoLoaded;

	public string tempClanID;

	public string tempClanLogo;

	public string tempClanName;

	public string tempClanCreatorID;

	private bool _shouldStopOnline;

	private bool _shouldStopOnlineWithClanInfo;

	private bool _shouldStopRefrClanOnline;

	public Action GetFacebookFriendsCallback;

	private string _inputToken;

	private KeyValuePair<string, int>? _winCountTimestamp;

	private bool ReceivedLastOnline;

	private bool _shouldStopRefreshingInfo;

	public bool ClanLimitReached
	{
		get
		{
			FriendsController friendsController = sharedController;
			return friendsController.clanMembers.Count + friendsController.ClanSentInvites.Count + friendsController.clanSentInvitesLocal.Count >= friendsController.ClanLimit;
		}
	}

	public int ClanLimit
	{
		get
		{
			return int.MaxValue;
		}
	}

	public static int CurrentPlatform
	{
		get
		{
			return (BuildSettings.BuildTarget != BuildTarget.iPhone) ? ((BuildSettings.BuildTarget == BuildTarget.Android) ? 1 : ((BuildSettings.BuildTarget != BuildTarget.WP8Player) ? 101 : 2)) : 0;
		}
	}

	public static string actionAddress
	{
		get
		{
			return URLs.Friends;
		}
	}

	public KeyValuePair<string, int>? WinCountTimestamp
	{
		get
		{
			return _winCountTimestamp;
		}
	}

	public static bool HasFriends
	{
		get
		{
			string @string = PlayerPrefs.GetString("FriendsKey", "[]");
			return !string.IsNullOrEmpty(@string) && @string != "[]";
		}
	}

	public static event Action FriendsUpdated;

	public static event Action ClanUpdated;

	public static event EventHandler FullInfoUpdated;

	public event Action FailedSendNewClan;

	public event Action<int> ReturnNewIDClan;

	public static event Action OurInfoUpdated;

	static FriendsController()
	{
		FriendsController.FriendsUpdated = null;
		FriendsController.FullInfoUpdated = null;
	}

	private static void FillList(string key, List<Dictionary<string, string>> list)
	{
		string @string = PlayerPrefs.GetString(key, "[]");
		List<object> list2 = Json.Deserialize(@string) as List<object>;
		if (list2 == null || list2.Count <= 0)
		{
			return;
		}
		foreach (Dictionary<string, object> item in list2.OfType<Dictionary<string, object>>())
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			foreach (KeyValuePair<string, object> item2 in item)
			{
				string text = item2.Value as string;
				if (text != null)
				{
					dictionary.Add(item2.Key, text);
				}
			}
			list.Add(dictionary);
		}
	}

	private static void FillDictionary(string key, Dictionary<string, Dictionary<string, object>> dictionary)
	{
		string text = string.Empty;
		using (new StopwatchLogger("Storager extracting " + key))
		{
			text = PlayerPrefs.GetString(key, "{}");
		}
		Debug.Log(key + " (length): " + text.Length);
		Dictionary<string, object> dictionary2 = null;
		using (new StopwatchLogger("Json decoding " + key))
		{
			dictionary2 = Json.Deserialize(text) as Dictionary<string, object>;
		}
		if (dictionary2 == null || dictionary2.Count <= 0)
		{
			return;
		}
		Debug.Log(key + " (count): " + dictionary2.Count);
		using (new StopwatchLogger("Dictionary copying " + key))
		{
			foreach (KeyValuePair<string, object> item in dictionary2)
			{
				Dictionary<string, object> dictionary3 = item.Value as Dictionary<string, object>;
				if (dictionary3 != null)
				{
					dictionary.Add(item.Key, dictionary3);
				}
			}
		}
	}

	public static string CreateMD5(string input)
	{
	    using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
	    {
	        byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
	        byte[] hashBytes = md5.ComputeHash(inputBytes);
	        StringBuilder sb = new System.Text.StringBuilder();
	        for (int i = 0; i < hashBytes.Length; i++)
	        {
	            sb.Append(hashBytes[i].ToString("X2"));
	        }
	        return sb.ToString();
	    }
	}

	private void Awake()
	{
		sharedController = this;
	}

	public IEnumerator GetBanListLoop() {
		StartCoroutine("GetBanList");
		yield return new WaitForSeconds(4f);
		StartCoroutine("GetBanListLoop");
		yield break;
	}

	private IEnumerator Start()
	{
		string secret = alphaIvory ?? string.Empty;
		if (string.IsNullOrEmpty(secret))
		{
			Debug.LogError("Secret is empty!");
		}
		_hmac = new HMACSHA1(Encoding.UTF8.GetBytes(secret), true);
		StopCoroutine("GetBanListLoop");
		StartCoroutine("GetBanListLoop");
		StartCoroutine("GetPopularityMap");
		if (!Storager.hasKey(FacebookIDKey))
		{
			Storager.setString(FacebookIDKey, string.Empty, false);
		}
		id_fb = Storager.getString(FacebookIDKey, false);
		FacebookController.ReceivedSelfID += HandleReceivedSelfID;
		lastTouchTm = Time.realtimeSinceStartup + 15f;
		FillList("FriendsKey", friends);
		yield return null;
		FillList("ToUsKey", invitesToUs);
		yield return null;
		FillList("FromUsKey", invitesFromUs);
		yield return null;
		FillDictionary("PlayerInfoKey", playersInfo);
		yield return null;
		FillList("ClanInvitesKey", ClanInvites);
		yield return null;
		List<object> _rejects = Json.Deserialize(PlayerPrefs.GetString("RejectsKey", string.Empty)) as List<object>;
		if (_rejects == null)
		{
			Debug.LogWarning(" _rejects = null");
		}
		else
		{
			foreach (Dictionary<string, object> d in _rejects)
			{
				Dictionary<string, string> newd = new Dictionary<string, string>();
				foreach (KeyValuePair<string, object> kvp in d)
				{
					newd.Add(kvp.Key, kvp.Value as string);
				}
				rejects.Add(newd);
			}
		}
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		/*if (!PlayerPrefs.HasKey(AccountCreated))
		{
			PlayerPrefs.SetString(AccountCreated, string.Empty);
		}*/
		id = Storager.getString(AccountCreated, "", false);
		if (string.IsNullOrEmpty(id))
		{
			StartCoroutine(CreatePlayer());
			yield break;
		}
		Debug.Log("Account id:    " + id);
		StartCoroutine(CheckOurIDExists());
	}

	private void HandleReceivedSelfID(string idfb)
	{
		if (!string.IsNullOrEmpty(idfb) && (string.IsNullOrEmpty(id_fb) || !idfb.Equals(id_fb)))
		{
			id_fb = idfb;
			if (!Storager.hasKey(FacebookIDKey))
			{
				Storager.setString(FacebookIDKey, string.Empty, false);
			}
			Storager.setString(FacebookIDKey, id_fb, false);
			SendOurData(false);
			Debug.Log("Facebook ID Data Sent");
		}
	}

	public void UnbanUs(Action onSuccess)
	{
		if (readyToOperate)
		{
			StartCoroutine(UnbanUsCoroutine(onSuccess));
		}
	}

	private IEnumerator UnbanUsCoroutine(Action onSuccess)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "unban_us");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("unban_us"));
		WWW download = new WWW("http://secure.pixelgunserver.com/unbanme.php", form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (response != null && response.Equals("ok"))
		{
			if (onSuccess != null)
			{
				onSuccess();
			}
		}
	}

	public void ChangeClanLogo()
	{
		if (readyToOperate)
		{
			StartCoroutine(_ChangeClanLogo());
		}
	}

	public void GetOurWins()
	{
		if (readyToOperate)
		{
			StartCoroutine(_GetOurWins());
		}
	}

	public void SendRoundWon()
	{
		if (readyToOperate)
		{
			int num = -1;
			if (PhotonNetwork.room != null)
			{
				num = (int)ConnectSceneNGUIController.regim;
			}
			if (num != -1)
			{
				StartCoroutine(_SendRoundWon(num));
			}
		}
	}

	public static string Hash(string action, string token = null)
	{
		if (action == null)
		{
			Debug.LogWarning("Hash: action is null");
			return string.Empty;
		}
		string text = token ?? ((!(sharedController != null)) ? null : sharedController.id);
		if (text == null)
		{
			Debug.LogWarning("Hash: Token is null");
			return string.Empty;
		}
		string text2 = ((!action.Equals("get_player_online")) ? (ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion) : "*:*.*.*");
		string s = text2 + text + action;
		byte[] bytes = Encoding.UTF8.GetBytes(s);
		byte[] array = _hmac.ComputeHash(bytes);
		string text3 = BitConverter.ToString(array);
		return text3.Replace("-", string.Empty).ToLower();
	}

	public static string HashForPush(byte[] responceData)
	{
		if (responceData == null)
		{
			Debug.LogWarning("HashForPush: responceData is null");
			return string.Empty;
		}
		if (_hmac == null)
		{
			throw new InvalidOperationException("Hmac is not initialized yet.");
		}
		byte[] array = _hmac.ComputeHash(responceData);
		string text = BitConverter.ToString(array);
		return text.Replace("-", string.Empty).ToLower();
	}

	private IEnumerator _GetOurWins()
	{
		string response;
		while (true)
		{
			WWWForm form = new WWWForm();
			form.AddField("action", "get_info_by_id");
			form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			form.AddField("id", id);
			form.AddField("uniq_id", sharedController.id);
			form.AddField("auth", Hash("get_info_by_id"));
			WWW download = new WWW(actionAddress, form);
			yield return download;
			response = URLs.Sanitize(download);
			if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
			{
				Debug.Log("_GetOurWins: " + response);
			}
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("_GetOurWins error: " + download.error);
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (string.IsNullOrEmpty(response) || !response.Equals("fail"))
			{
				break;
			}
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_GetOurWins fail.");
			}
			yield return StartCoroutine(MyWaitForSeconds(10f));
		}
		Dictionary<string, object> __newInfo = ParseInfo(response);
		if (__newInfo == null)
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning(" _GetOurWins newInfo = null");
			}
			yield break;
		}
		ourInfo = __newInfo;
		if (FriendsController.OurInfoUpdated != null)
		{
			FriendsController.OurInfoUpdated();
		}
	}

	private IEnumerator _SendRoundWon(int mode)
	{
		while (true)
		{
			WWWForm form = new WWWForm();
			form.AddField("action", "round_won");
			form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			form.AddField("uniq_id", id);
			form.AddField("mode", mode);
			form.AddField("auth", Hash("round_won"));
			WWW download = new WWW(actionAddress, form);
			yield return download;
			string response = URLs.Sanitize(download);
			if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
			{
				Debug.Log("_SendRoundWon: " + response);
			}
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("_SendRoundWon error: " + download.error);
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (string.IsNullOrEmpty(response) || !response.Equals("fail"))
			{
				break;
			}
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_SendRoundWon fail.");
			}
			yield return StartCoroutine(MyWaitForSeconds(10f));
		}
		PlayerPrefs.SetInt("TotalWinsForLeaderboards", PlayerPrefs.GetInt("TotalWinsForLeaderboards", 0) + 1);
	}

	private IEnumerator _ChangeClanLogo()
	{
		while (true)
		{
			WWWForm form = new WWWForm();
			form.AddField("action", "change_logo");
			form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			form.AddField("id_clan", ClanID);
			form.AddField("logo", clanLogo);
			form.AddField("id", id);
			form.AddField("uniq_id", id);
			form.AddField("auth", Hash("change_logo"));
			WWW download = new WWW(actionAddress, form);
			yield return download;
			string response = URLs.Sanitize(download);
			if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
			{
				Debug.Log("_ChangeClanLogo: " + response);
			}
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("_ChangeClanLogo error: " + download.error);
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (!string.IsNullOrEmpty(response) && response.Equals("fail"))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("_ChangeClanLogo fail.");
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			break;
		}
	}

	public void ChangeClanName(string newNm, Action onSuccess, Action<string> onFailure)
	{
		if (readyToOperate)
		{
			StartCoroutine(_ChangeClanName(newNm, onSuccess, onFailure));
		}
	}

	private IEnumerator _ChangeClanName(string newNm, Action onSuccess, Action<string> onFailure)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "change_clan_name");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_clan", ClanID);
		form.AddField("id", id);
		string filteredNick = newNm;
		if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.gameObject != null && WeaponManager.sharedManager.gameObject.GetComponent<FilterBadWorld>() != null)
		{
			filteredNick = FilterBadWorld.FilterString(newNm);
		}
		form.AddField("name", filteredNick);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("change_clan_name"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.Log("_ChangeClanName: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_ChangeClanName error: " + download.error);
			}
			if (onFailure != null)
			{
				onFailure(download.error);
			}
		}
		else if (!string.IsNullOrEmpty(response) && response.Equals("fail"))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_ChangeClanName fail.");
			}
			if (onFailure != null)
			{
				onFailure(response);
			}
		}
		else if (onSuccess != null)
		{
			onSuccess();
		}
	}

	private IEnumerator GetPopularityMap()
	{
		Dictionary<string, object> dict;
		while (true)
		{
			WWW download = new WWW(URLs.PopularityMapUrl);
			yield return download;
			string response = URLs.Sanitize(download);
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("CheckMapPopularity error: " + download.error);
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (!string.IsNullOrEmpty(response) && response.Equals("fail"))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("CheckMapPopularity fail.");
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			object o = Json.Deserialize(response);
			dict = o as Dictionary<string, object>;
			if (dict != null)
			{
				break;
			}
			if (Application.isEditor || Debug.isDebugBuild)
			{
				Debug.LogWarning(" GetPopularityMap dict = null");
			}
			yield return StartCoroutine(MyWaitForSeconds(20f));
		}
		foreach (KeyValuePair<string, object> kvp in dict)
		{
			Dictionary<string, string> _mapPopularityInRegim = new Dictionary<string, string>();
			Dictionary<string, object> dict2 = kvp.Value as Dictionary<string, object>;
			if (dict2 == null)
			{
				continue;
			}
			foreach (KeyValuePair<string, object> kvp2 in dict2)
			{
				_mapPopularityInRegim.Add(kvp2.Key, kvp2.Value.ToString());
			}
			if (_mapPopularityInRegim.Count > 0 && !mapPopularityDictionary.ContainsKey(kvp.Key))
			{
				mapPopularityDictionary.Add(kvp.Key, _mapPopularityInRegim);
			}
		}
		if (Application.isEditor)
		{
			Debug.Log("__________________________________________________________________");
			Debug.Log("mapPopularityDictionary.count=" + mapPopularityDictionary.Count + " " + Json.Serialize(mapPopularityDictionary));
			string _str8 = ConnectSceneNGUIController.RegimGame.Deathmatch.ToString() + ":\n";
			int sumCount4 = 0;
			string[] masMapName = ConnectSceneNGUIController.masMapName;
			foreach (string _mapName in masMapName)
			{
				int _count = int.Parse((!mapPopularityDictionary["0"].ContainsKey(Defs.levelNumsForMusicInMult[_mapName].ToString())) ? "0" : mapPopularityDictionary["0"][Defs.levelNumsForMusicInMult[_mapName].ToString()]);
				_str8 = _str8 + _mapName + ":" + _count + "\n";
				sumCount4 += _count;
			}
			_str8 = _str8 + "SUMMA: " + sumCount4 + "\n";
			_str8 = _str8 + "\n" + ConnectSceneNGUIController.RegimGame.TimeBattle.ToString() + ":\n";
			sumCount4 = 0;
			string[] masMapNameCOOP = ConnectSceneNGUIController.masMapNameCOOP;
			foreach (string _mapName2 in masMapNameCOOP)
			{
				int _count2 = int.Parse((!mapPopularityDictionary["1"].ContainsKey(Defs.levelNumsForMusicInMult[_mapName2].ToString())) ? "0" : mapPopularityDictionary["1"][Defs.levelNumsForMusicInMult[_mapName2].ToString()]);
				_str8 = _str8 + _mapName2 + ":" + _count2 + "\n";
				sumCount4 += _count2;
			}
			_str8 = _str8 + "SUMMA: " + sumCount4 + "\n";
			_str8 = _str8 + "\n" + ConnectSceneNGUIController.RegimGame.TeamFight.ToString() + ":\n";
			sumCount4 = 0;
			string[] masMapNameCompany = ConnectSceneNGUIController.masMapNameCompany;
			foreach (string _mapName3 in masMapNameCompany)
			{
				int _count3 = int.Parse((!mapPopularityDictionary["2"].ContainsKey(Defs.levelNumsForMusicInMult[_mapName3].ToString())) ? "0" : mapPopularityDictionary["2"][Defs.levelNumsForMusicInMult[_mapName3].ToString()]);
				_str8 = _str8 + _mapName3 + ":" + _count3 + "\n";
				sumCount4 += _count3;
			}
			_str8 = _str8 + "SUMMA: " + sumCount4 + "\n";
			_str8 = _str8 + "\n" + ConnectSceneNGUIController.RegimGame.FlagCapture.ToString() + ":\n";
			sumCount4 = 0;
			string[] masMapNameflag = ConnectSceneNGUIController.masMapNameflag;
			foreach (string _mapName4 in masMapNameflag)
			{
				int _count4 = int.Parse((!mapPopularityDictionary["4"].ContainsKey(Defs.levelNumsForMusicInMult[_mapName4].ToString())) ? "0" : mapPopularityDictionary["4"][Defs.levelNumsForMusicInMult[_mapName4].ToString()]);
				_str8 = _str8 + _mapName4 + ":" + _count4 + "\n";
				sumCount4 += _count4;
			}
			_str8 = _str8 + "SUMMA: " + sumCount4 + "\n";
			Debug.Log(_str8);
		}
	}

	private IEnumerator GetBanList()
	{
		string i1 = string.Empty;
		string url2 = "https://ip.42.pl/raw";
    	using (UnityWebRequest www = UnityWebRequest.Get(url2))
   		{
   		    yield return www.SendWebRequest();
   		    string test = www.downloadHandler.text;
   		    i1 = CreateMD5(test);
   		}
		int ban;
		while (true)
		{
			if (string.IsNullOrEmpty(id))
			{
				yield return null;
				continue;
			}
			WWWForm form = new WWWForm();
			form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			form.AddField("id", id);
			form.AddField("device_identifier", SystemInfo.deviceUniqueIdentifier);
			form.AddField("md5ip", i1);
			WWW download = new WWW(URLs.BanURL, form);
			yield return download;
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("GetBanList error: " + download.error);
				}
				yield return StartCoroutine(MyWaitForSeconds(1f));
				continue;
			}
			string responseText = URLs.Sanitize(download);
			if (int.TryParse(responseText, out ban))
			{
				break;
			}
			Debug.LogWarning("GetBanList cannot parse ban!" + responseText);
			yield return StartCoroutine(MyWaitForSeconds(1f));
		}
		if (ban > 1) {
			ban = 1;
		}
		Banned = ban;
		if (Debug.isDebugBuild)
		{
			Debug.Log("GetBanList Banned: " + Banned);
		}
		if (ban.Equals(1))
		{
			Application.LoadLevel("Cheat");
		}
	}

	private IEnumerator CheckOurIDExists()
	{
		string response;
		while (true)
		{
			WWWForm form = new WWWForm();
			form.AddField("action", "start_check");
			form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			form.AddField("platform", CurrentPlatform.ToString());
			form.AddField("uniq_id", sharedController.id);
			form.AddField("auth", Hash("start_check"));
			form.AddField("abuse_method", Storager.getInt("AbuseMethod", false));
			if (Launcher.PackageInfo.HasValue)
			{
			}
			WWW download = new WWW(actionAddress, form);
			yield return download;
			response = URLs.Sanitize(download);
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild)
				{
					Debug.LogWarning("CheckOurIDExists error: " + download.error);
				}
				yield return StartCoroutine(MyWaitForSeconds(1f));
				continue;
			}
			if (!"fail".Equals(response))
			{
				break;
			}
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("CheckOurIDExists fail.");
				StartCoroutine(CreatePlayer());
			}
			yield return StartCoroutine(MyWaitForSeconds(10f));
		}
		int newId;
		if (!int.TryParse(response, out newId))
		{
			Dictionary<string, object> clanInfo = Json.Deserialize(response) as Dictionary<string, object>;
			if (clanInfo == null)
			{
				Debug.LogWarning("CheckOurIDExists cannot parse clan info!");
			}
			else
			{
				object clanIDObj;
				if (clanInfo.TryGetValue("id", out clanIDObj) && clanIDObj != null && !clanIDObj.Equals("null"))
				{
					ClanID = Convert.ToString(clanIDObj);
				}
				object clanCreatorObj;
				if (clanInfo.TryGetValue("creator_id", out clanCreatorObj) && clanCreatorObj != null && !clanCreatorObj.Equals("null"))
				{
					clanLeaderID = clanCreatorObj as string;
				}
				object clanNameObj;
				if (clanInfo.TryGetValue("name", out clanNameObj) && clanNameObj != null && !clanNameObj.Equals("null"))
				{
					clanName = clanNameObj as string;
				}
				object clanLogoObj;
				if (clanInfo.TryGetValue("logo", out clanLogoObj) && clanLogoObj != null && !clanLogoObj.Equals("null"))
				{
					clanLogo = clanLogoObj as string;
				}
			}
		}
		else
		{
			Storager.getString(AccountCreated, response, false);
			id = response;
			onlineInfo.Clear();
			friends.Clear();
			invitesFromUs.Clear();
			playersInfo.Clear();
			invitesToUs.Clear();
			ClanInvites.Clear();
			rejects.Clear();
			notShowAddIds.Clear();
			SaveCurrentState();
			PlayerPrefs.SetString("RejectsKey", string.Empty);
			PlayerPrefs.Save();
		}
		readyToOperate = true;
		StartCoroutine(UpdatePlayer(true));
		StartCoroutine(GetFriendData());
		StartCoroutine(GetClanDataLoop());
		GetOurLAstOnline();
		StartCoroutine(RequestWinCountTimestampCoroutine());
		GetOurWins();
	}

	public void InitOurInfo()
	{
		nick = Defs.GetPlayerNameOrDefault();
		// SkinsController.sharedController.Start();
		/*while (SkinsController.currentSkinForPers != null) {
		}*/
		byte[] inArray = SkinsController.currentSkinForPers.EncodeToPNG();
		skin = "";
		try {
			skin = Convert.ToBase64String(inArray);
		}catch(Exception e){

		}
		rank = ExperienceController.sharedController.currentLevel;
		wins.Value = Storager.getInt("Rating", false);
		survivalScore = PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0);
		coopScore = PlayerPrefs.GetInt(Defs.COOPScore, 0);
		capeName = Storager.getString(Defs.CapeEquppedSN, false);
		if (capeName.Equals(Wear.cape_Custom))
		{
			capeSkin = PlayerPrefs.GetString("User Cape Skin");
			if (string.IsNullOrEmpty(capeSkin))
			{
				capeSkin = SkinsController.StringFromTexture(Resources.Load("cape_CustomTexture") as Texture2D);
			}
		}
		else
		{
			capeSkin = string.Empty;
		}
		hatName = Storager.getString(Defs.HatEquppedSN, false);
		bootsName = Storager.getString(Defs.BootsEquppedSN, false);
		armorName = Storager.getString(Defs.ArmorNewEquppedSN, false);
		infoLoaded = true;
	}

	public void SendOurData(bool SendSkin = false)
	{
		Debug.Log("SendOurData:" + readyToOperate);
		if (readyToOperate)
		{
			StartCoroutine(UpdatePlayer(SendSkin));
		}
	}

	private void SaveCurrentState()
	{
		if (friends != null)
		{
			string text = Json.Serialize(friends);
			PlayerPrefs.SetString("FriendsKey", text ?? "[]");
		}
		if (invitesToUs != null)
		{
			string text2 = Json.Serialize(invitesToUs);
			PlayerPrefs.SetString("ToUsKey", text2 ?? "[]");
		}
		if (invitesFromUs != null)
		{
			string text3 = Json.Serialize(invitesFromUs);
			PlayerPrefs.SetString("FromUsKey", text3 ?? "[]");
		}
		if (playersInfo != null)
		{
			string text4 = Json.Serialize(playersInfo);
			PlayerPrefs.SetString("PlayerInfoKey", text4 ?? "{}");
		}
		if (ClanInvites != null)
		{
			string text5 = Json.Serialize(ClanInvites);
			PlayerPrefs.SetString("ClanInvitesKey", text5 ?? "[]");
		}
	}

	private void DumpCurrentState()
	{
		SaveCurrentState();
		friends.Clear();
		invitesToUs.Clear();
		invitesFromUs.Clear();
		playersInfo.Clear();
		ClanInvites.Clear();
	}

	private void OnApplicationQuit()
	{
		DumpCurrentState();
		if (rejects != null)
		{
			string text = Json.Serialize(rejects);
			PlayerPrefs.SetString("RejectsKey", text ?? string.Empty);
		}
		rejects = null;
	}

	private void OnApplicationPause(bool pause)
	{
		if (pause)
		{
			SaveCurrentState();
			if (rejects != null)
			{
				string text = Json.Serialize(rejects);
				PlayerPrefs.SetString("RejectsKey", text ?? string.Empty);
			}
			return;
		}
		StopCoroutine("GetBanListLoop");
		StartCoroutine("GetBanListLoop");
		StopCoroutine("GetPopularityMap");
		StartCoroutine("GetPopularityMap");
		StartCoroutine(GetFriendDataOnce(true));
		if (Application.loadedLevelName.Equals("Friends"))
		{
			UpdatePLayersInfo();
			if (FriendsGUIController.ShowProfile && FriendProfileController.currentFriendId != null && readyToOperate)
			{
				StartCoroutine(GetInfoById(FriendProfileController.currentFriendId));
			}
		}
		if (Application.loadedLevelName.Equals("Clans"))
		{
			if (!string.IsNullOrEmpty(ClanID))
			{
				StartCoroutine(GetClanDataOnce());
			}
			if (ClansGUIController.AtAddPanel)
			{
				StartCoroutine(GetAllPlayersOnline());
			}
			else
			{
				StartCoroutine(GetClanPlayersOnline());
			}
			if (ClansGUIController.ShowProfile && FriendProfileController.currentFriendId != null && readyToOperate)
			{
				StartCoroutine(GetInfoById(FriendProfileController.currentFriendId));
			}
		}
		MarafonBonusController.Get.ResetSessionState();
		DownloadInfoByEverydayDelta();
	}

	private void OnDestroy()
	{
		DumpCurrentState();
		if (rejects != null)
		{
			string text = Json.Serialize(rejects);
			PlayerPrefs.SetString("RejectsKey", text ?? string.Empty);
		}
		rejects = null;
	}

	public void SendInvitation(string personId)
	{
		if (!string.IsNullOrEmpty(personId) && readyToOperate)
		{
			StartCoroutine(FriendRequest(personId));
		}
	}

	public void SendCreateClan(string personId, string nameClan, string skinClan, Action<string> ErrorHandler)
	{
		if (!string.IsNullOrEmpty(personId) && !string.IsNullOrEmpty(nameClan) && !string.IsNullOrEmpty(skinClan) && readyToOperate)
		{
			StartCoroutine(_SendCreateClan(personId, nameClan, skinClan, ErrorHandler));
		}
		else if (ErrorHandler != null)
		{
			ErrorHandler("Error: FALSE:  ! string.IsNullOrEmpty (personId) && ! string.IsNullOrEmpty (nameClan) && ! string.IsNullOrEmpty (skinClan) && readyToOperate");
		}
	}

	public void SendClanInvitation(string personId)
	{
		if (!string.IsNullOrEmpty(personId) && readyToOperate)
		{
			StartCoroutine(_SendClanInvitation(personId));
		}
	}

	public void AcceptInvite(string recordId, string accepteeId)
	{
		if (!string.IsNullOrEmpty(recordId) && !string.IsNullOrEmpty(accepteeId) && readyToOperate)
		{
			StartCoroutine(AcceptFriend(recordId, accepteeId));
		}
	}

	public void AcceptClanInvite(string recordId)
	{
		if (!string.IsNullOrEmpty(recordId) && readyToOperate)
		{
			StartCoroutine(_AcceptClanInvite(recordId));
		}
	}

	private IEnumerator _AcceptClanInvite(string recordId)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "accept_invite");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_player", id);
		form.AddField("id_clan", recordId);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("accept_invite"));
		WWW download = new WWW(actionAddress, form);
		JoinClanSent = recordId;
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.Log("Accept clan invite: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_AcceptClanInvite error: " + download.error);
			}
			JoinClanSent = null;
		}
		else if (!string.IsNullOrEmpty(response) && response.Equals("fail"))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_AcceptClanInvite fail.");
			}
			JoinClanSent = null;
		}
		else
		{
			clanLogo = tempClanLogo;
			ClanID = tempClanID;
			clanName = tempClanName;
			clanLeaderID = tempClanCreatorID;
		}
	}

	public void StartRefreshingOnline()
	{
		if (readyToOperate)
		{
			_shouldStopOnline = false;
			StartCoroutine(RefreshOnlinePlayer());
		}
	}

	public void StopRefreshingOnline()
	{
		if (readyToOperate)
		{
			_shouldStopOnline = true;
		}
	}

	public void StartRefreshingOnlineWithClanInfo()
	{
		if (readyToOperate)
		{
			_shouldStopOnlineWithClanInfo = false;
			StartCoroutine(RefreshOnlinePlayerWithClanInfo());
		}
	}

	public void StopRefreshingOnlineWithClanInfo()
	{
		if (readyToOperate)
		{
			_shouldStopOnlineWithClanInfo = true;
		}
	}

	private IEnumerator RefreshOnlinePlayerWithClanInfo()
	{
		while (true)
		{
			if (idle)
			{
				yield return null;
				continue;
			}
			StartCoroutine(GetAllPlayersOnlineWithClanInfo());
			float startTime = Time.realtimeSinceStartup;
			do
			{
				yield return null;
			}
			while (Time.realtimeSinceStartup - startTime < 20f && !_shouldStopOnlineWithClanInfo);
			if (_shouldStopOnlineWithClanInfo)
			{
				break;
			}
		}
		_shouldStopOnlineWithClanInfo = false;
	}

	private IEnumerator RefreshOnlinePlayer()
	{
		while (true)
		{
			if (idle)
			{
				yield return null;
				continue;
			}
			StartCoroutine(GetAllPlayersOnline());
			float startTime = Time.realtimeSinceStartup;
			do
			{
				yield return null;
			}
			while (Time.realtimeSinceStartup - startTime < 20f && !_shouldStopOnline);
			if (_shouldStopOnline)
			{
				break;
			}
		}
		_shouldStopOnline = false;
	}

	public void StartRefreshingClanOnline()
	{
		if (readyToOperate)
		{
			_shouldStopRefrClanOnline = false;
			StartCoroutine(RefreshClanOnline());
		}
	}

	public void StopRefreshingClanOnline()
	{
		if (readyToOperate)
		{
			_shouldStopRefrClanOnline = true;
		}
	}

	private IEnumerator RefreshClanOnline()
	{
		while (true)
		{
			if (idle)
			{
				yield return null;
				continue;
			}
			StartCoroutine(GetClanPlayersOnline());
			float startTime = Time.realtimeSinceStartup;
			do
			{
				yield return null;
			}
			while (Time.realtimeSinceStartup - startTime < 20f && !_shouldStopRefrClanOnline);
			if (_shouldStopRefrClanOnline)
			{
				break;
			}
		}
		_shouldStopRefrClanOnline = false;
	}

	private IEnumerator GetClanPlayersOnline()
	{
		if (!readyToOperate)
		{
			yield break;
		}
		List<int> ids = new List<int>();
		foreach (Dictionary<string, string> fr in clanMembers)
		{
			string firIdStr;
			int frId;
			if (fr.TryGetValue("id", out firIdStr) && int.TryParse(firIdStr, out frId))
			{
				ids.Add(frId);
			}
		}
		yield return StartCoroutine(_GetOnlineForPlayerIDs(ids));
	}

	private IEnumerator GetAllPlayersOnline()
	{
		if (!readyToOperate)
		{
			yield break;
		}
		List<int> ids = new List<int>();
		foreach (Dictionary<string, string> fr in friends)
		{
			string firIdStr;
			int frId;
			if (fr.TryGetValue("friend", out firIdStr) && int.TryParse(firIdStr, out frId))
			{
				ids.Add(frId);
			}
		}
		yield return StartCoroutine(_GetOnlineForPlayerIDs(ids));
	}

	private IEnumerator GetAllPlayersOnlineWithClanInfo()
	{
		if (!readyToOperate)
		{
			yield break;
		}
		List<int> ids = new List<int>();
		foreach (Dictionary<string, string> fr in friends)
		{
			string firIdStr;
			int frId;
			if (fr.TryGetValue("friend", out firIdStr) && int.TryParse(firIdStr, out frId))
			{
				ids.Add(frId);
			}
		}
		yield return StartCoroutine(_GetOnlineWithClanInfoForPlayerIDs(ids));
	}

	private IEnumerator _GetOnlineForPlayerIDs(List<int> ids)
	{
		if (ids.Count == 0)
		{
			yield break;
		}
		string json = Json.Serialize(ids);
		if (json == null)
		{
			yield break;
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "get_all_players_online");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", id);
		form.AddField("ids", json);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_all_players_online"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.Log(response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("GetAllPlayersOnline  error: " + download.error);
			}
			yield break;
		}
		Dictionary<string, object> __list = Json.Deserialize(response) as Dictionary<string, object>;
		if (__list == null)
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning(" GetAllPlayersOnline info = null");
			}
			yield break;
		}
		Dictionary<string, Dictionary<string, string>> list = new Dictionary<string, Dictionary<string, string>>();
		foreach (string key2 in __list.Keys)
		{
			Dictionary<string, object> d2 = __list[key2] as Dictionary<string, object>;
			Dictionary<string, string> newd = new Dictionary<string, string>();
			foreach (KeyValuePair<string, object> kvp in d2)
			{
				newd.Add(kvp.Key, kvp.Value as string);
			}
			list.Add(key2, newd);
		}
		onlineInfo.Clear();
		foreach (string key in list.Keys)
		{
			Dictionary<string, string> d = list[key];
			if (!onlineInfo.ContainsKey(key))
			{
				onlineInfo.Add(key, d);
			}
			else
			{
				onlineInfo[key] = d;
			}
		}
	}

	private IEnumerator _GetOnlineWithClanInfoForPlayerIDs(List<int> ids)
	{
		if (ids.Count == 0)
		{
			yield break;
		}
		string json = Json.Serialize(ids);
		if (json == null)
		{
			yield break;
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "get_all_players_online_with_clan_info");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", id);
		form.AddField("ids", json);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_all_players_online_with_clan_info"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.Log(response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_GetOnlineWithClanInfoForPlayerIDs  error: " + download.error);
			}
			yield break;
		}
		Dictionary<string, object> allDict = Json.Deserialize(response) as Dictionary<string, object>;
		if (allDict == null)
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning(" _GetOnlineWithClanInfoForPlayerIDs allDict = null");
			}
			yield break;
		}
		Dictionary<string, object> __list = allDict["online"] as Dictionary<string, object>;
		if (__list == null)
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning(" _GetOnlineWithClanInfoForPlayerIDs __list = null");
			}
			yield break;
		}
		Dictionary<string, Dictionary<string, string>> list = new Dictionary<string, Dictionary<string, string>>();
		foreach (string key3 in __list.Keys)
		{
			Dictionary<string, object> d3 = __list[key3] as Dictionary<string, object>;
			Dictionary<string, string> newd2 = new Dictionary<string, string>();
			foreach (KeyValuePair<string, object> kvp2 in d3)
			{
				newd2.Add(kvp2.Key, kvp2.Value as string);
			}
			list.Add(key3, newd2);
		}
		onlineInfo.Clear();
		foreach (string key2 in list.Keys)
		{
			Dictionary<string, string> d2 = list[key2];
			if (!onlineInfo.ContainsKey(key2))
			{
				onlineInfo.Add(key2, d2);
			}
			else
			{
				onlineInfo[key2] = d2;
			}
		}
		Dictionary<string, object> clanInfo = allDict["clan_info"] as Dictionary<string, object>;
		if (clanInfo == null)
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning(" _GetOnlineWithClanInfoForPlayerIDs clanInfo = null");
			}
			yield break;
		}
		Dictionary<string, Dictionary<string, string>> convertedClanInfo = new Dictionary<string, Dictionary<string, string>>();
		foreach (string key in clanInfo.Keys)
		{
			Dictionary<string, object> d = clanInfo[key] as Dictionary<string, object>;
			Dictionary<string, string> newd = new Dictionary<string, string>();
			foreach (KeyValuePair<string, object> kvp in d)
			{
				newd.Add(kvp.Key, kvp.Value as string);
			}
			convertedClanInfo.Add(key, newd);
		}
		foreach (string playerID in convertedClanInfo.Keys)
		{
			Dictionary<string, string> playerClanInfo = convertedClanInfo[playerID];
			if (!sharedController.playersInfo.ContainsKey(playerID))
			{
				continue;
			}
			Dictionary<string, object> pl = sharedController.playersInfo[playerID];
			if (pl.ContainsKey("player"))
			{
				Dictionary<string, object> plpl = pl["player"] as Dictionary<string, object>;
				if (plpl.ContainsKey("clan_creator_id"))
				{
					plpl["clan_creator_id"] = playerClanInfo["clan_creator_id"];
				}
				else
				{
					plpl.Add("clan_creator_id", playerClanInfo["clan_creator_id"]);
				}
				if (plpl.ContainsKey("clan_name"))
				{
					plpl["clan_name"] = playerClanInfo["clan_name"];
				}
				else
				{
					plpl.Add("clan_name", playerClanInfo["clan_name"]);
				}
				if (plpl.ContainsKey("clan_logo"))
				{
					plpl["clan_logo"] = playerClanInfo["clan_logo"];
				}
				else
				{
					plpl.Add("clan_logo", playerClanInfo["clan_logo"]);
				}
			}
		}
	}

	public void GetFacebookFriendsInfo(Action callb)
	{
		if (readyToOperate)
		{
			StartCoroutine(_GetFacebookFriendsInfo(callb));
		}
	}

	private IEnumerator _GetFacebookFriendsInfo(Action callb)
	{
		if (FacebookController.sharedController.friendsList == null)
		{
			yield break;
		}
		GetFacebookFriendsCallback = callb;
		List<string> ids = new List<string>();
		foreach (Friend f in FacebookController.sharedController.friendsList)
		{
			ids.Add(f.id);
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "get_info_by_facebook_ids");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("platform", CurrentPlatform.ToString());
		form.AddField("id", id);
		string json = Json.Serialize(ids);
		form.AddField("ids", json);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_info_by_facebook_ids"));
		Debug.Log("facebook json: " + json);
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.Log(response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("_GetFacebookFriendsInfo error: " + download.error);
			}
			GetFacebookFriendsCallback = null;
			yield break;
		}
		List<object> __info = Json.Deserialize(response) as List<object>;
		if (__info == null)
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning(" _GetFacebookFriendsInfo info = null");
			}
			GetFacebookFriendsCallback = null;
			yield break;
		}
		foreach (Dictionary<string, object> d in __info)
		{
			Dictionary<string, object> ff = new Dictionary<string, object>();
			foreach (KeyValuePair<string, object> i in d)
			{
				ff.Add(i.Key, i.Value);
			}
			object ffid;
			if (ff.TryGetValue("id", out ffid))
			{
				facebookFriendsInfo.Add(ffid as string, ff);
			}
		}
		if (GetFacebookFriendsCallback != null)
		{
			GetFacebookFriendsCallback();
		}
		GetFacebookFriendsCallback = null;
	}

	private IEnumerator UpdatePlayerOnlineLoop()
	{
		while (true)
		{
			if (idle)
			{
				yield return null;
				continue;
			}
			int gameMode = -1;
			int platform = (int)ConnectSceneNGUIController.myPlatformConnect;
			if (PhotonNetwork.room != null && ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.DeadlyGames)
			{
				gameMode = (int)ConnectSceneNGUIController.regim;
				if (!string.IsNullOrEmpty(PhotonNetwork.room.customProperties["pass"].ToString()))
				{
					platform = 3;
				}
			}
			if (gameMode != -1)
			{
				StartCoroutine(UpdatePlayerOnline(platform * 100 + ConnectSceneNGUIController.gameTier * 10 + gameMode));
			}
			yield return StartCoroutine(MyWaitForSeconds(12f));
		}
	}

	private IEnumerator UpdatePlayerOnline(int gameMode)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "update_player_online");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", id);
		form.AddField("game_mode", gameMode.ToString("D3"));
		form.AddField("room_name", (PhotonNetwork.room == null || PhotonNetwork.room.name == null) ? string.Empty : PhotonNetwork.room.name);
		form.AddField("map", (PhotonNetwork.room == null || PhotonNetwork.room.customProperties == null) ? string.Empty : PhotonNetwork.room.customProperties["map"].ToString());
		form.AddField("protocol", GlobalGameController.MultiplayerProtocolVersion);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("update_player_online"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("UpdatePlayerOnline error: " + download.error);
			}
		}
		else if (!string.IsNullOrEmpty(response) && response.Equals("fail") && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.LogWarning("UpdatePlayerOnline fail.");
		}
	}

	private IEnumerator GetToken()
	{
		string response;
		while (true)
		{
			WWWForm form = new WWWForm();
			form.AddField("action", "create_player_intent");
			form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			WWW download = new WWW(actionAddress, form);
			yield return download;
			response = URLs.Sanitize(download);
			if (!string.IsNullOrEmpty(download.error))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("create_player_intent error: " + download.error);
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (!string.IsNullOrEmpty(response) && response.Equals("fail"))
			{
				if (Debug.isDebugBuild || Application.isEditor)
				{
					Debug.LogWarning("create_player_intent fail.");
				}
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (response != null)
			{
				break;
			}
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("create_player_intent response == null");
			}
			yield return StartCoroutine(MyWaitForSeconds(10f));
		}
		_inputToken = response;
	}

	private IEnumerator CreatePlayer()
	{
		string response;
		/*if (!PlayerPrefs.GetString("AccountCreated", string.Empty).Equals()) {
			yield break;
		}*/
		while (true)
		{
			yield return StartCoroutine(GetToken());
			while (string.IsNullOrEmpty(_inputToken))
			{
				yield return null;
			}
			WWWForm form = new WWWForm();
			form.AddField("action", "create_player");
			form.AddField("platform", CurrentPlatform.ToString());
			form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			string hash = Hash("create_player", _inputToken);
			form.AddField("auth", hash);
			form.AddField("token", _inputToken);
			// SystemInfo.deviceUniqueIdentifier
			form.AddField("deviceid", SystemInfo.deviceUniqueIdentifier);
			string tokenHashString = string.Format("token:hash = {0}:{1}", _inputToken, hash);
			_inputToken = null;
			bool canPrintSecuritySensitiveInfo = Debug.isDebugBuild || Defs.IsDeveloperBuild || BuildSettings.BuildTarget == BuildTarget.WP8Player;
			if (canPrintSecuritySensitiveInfo)
			{
				Debug.Log("CreatePlayer: Trying to perform request for “" + tokenHashString + "”...");
			}
			WWW download = new WWW(actionAddress, form);
			yield return download;
			response = download.text;
			if (canPrintSecuritySensitiveInfo)
			{
				Debug.Log("CreatePlayer: Response for “" + tokenHashString + "” received:    “" + response + "”");
			}
			if (!string.IsNullOrEmpty(download.error))
			{
				Debug.LogWarning("CreatePlayer error:    “" + download.error + "”");
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (!string.IsNullOrEmpty(response) && response.Equals("fail"))
			{
				Debug.LogWarning("CreatePlayer failed.");
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (string.IsNullOrEmpty(response))
			{
				Debug.LogWarning("CreatePlayer response is empty.");
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			long resultId;
			if (!long.TryParse(response, out resultId))
			{
				Debug.LogWarning("CreatePlayer parsing error in response:    “" + response + "”");
				yield return StartCoroutine(MyWaitForSeconds(10f));
				continue;
			}
			if (resultId >= 1)
			{
				break;
			}
			Debug.LogWarning("CreatePlayer bad id:    “" + response + "”");
			yield return StartCoroutine(MyWaitForSeconds(10f));
		}
		Debug.Log("CreatePlayer succeeded with response:    “" + response + "”");
		Storager.setString(AccountCreated, response, false);
		id = response;
		readyToOperate = true;
		StartCoroutine(UpdatePlayer(true));
		StartCoroutine(GetFriendData());
		StartCoroutine(GetClanDataLoop());
		GetOurLAstOnline();
		GetOurWins();
	}

	private void SetWinCountTimestamp(string timestamp, int winCount)
	{
		_winCountTimestamp = new KeyValuePair<string, int>(timestamp, winCount);
		string text = string.Format("{{ \"{0}\": {1} }}", timestamp, winCount);
		Storager.setString("Win Count Timestamp", text, false);
		if (Application.isEditor)
		{
			Debug.Log("Setting win count timestamp:    " + text);
		}
	}

	public bool TryIncrementWinCountTimestamp()
	{
		if (!_winCountTimestamp.HasValue)
		{
			return false;
		}
		_winCountTimestamp = new KeyValuePair<string, int>(_winCountTimestamp.Value.Key, _winCountTimestamp.Value.Value + 1);
		return true;
	}

	private IEnumerator RequestWinCountTimestampCoroutine()
	{
		yield break;
	}

	private void GetOurLAstOnline()
	{
		StartCoroutine(GetInfoByEverydayDelta());
		if (Debug.isDebugBuild)
		{
			Debug.LogWarning(" GetOurLAstOnline finished");
		}
		ReceivedLastOnline = true;
		StartCoroutine(UpdatePlayerOnlineLoop());
	}

	public void DownloadInfoByEverydayDelta()
	{
		StartCoroutine(GetInfoByEverydayDelta());
	}

	private IEnumerator GetInfoByEverydayDelta()
	{
		bool needTakeMarathonBonus = false;
		WWWForm form = new WWWForm();
		form.AddField("action", "get_player_online");
		form.AddField("id", id);
		form.AddField("app_version", "*:*.*.*");
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_player_online"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (!string.IsNullOrEmpty(download.error))
		{
			Debug.LogWarning("GetInfoByEverydayDelta()    Error: " + download.error);
			yield return StartCoroutine(MyWaitForSeconds(120f));
			yield break;
		}
		if ("fail".Equals(response))
		{
			Debug.LogWarning("GetInfoByEverydayDelta()    Fail returned.");
			yield return StartCoroutine(MyWaitForSeconds(120f));
			yield break;
		}
		JSONNode data = JSON.Parse(response);
		if (data == null)
		{
			Debug.LogWarning("GetInfoByEverydayDelta()    Cannot deserialize response: " + response);
			yield return StartCoroutine(MyWaitForSeconds(120f));
			yield break;
		}
		string deltaData = data["delta"].Value;
		float deltaValue;
		if (float.TryParse(deltaData, out deltaValue))
		{
			if (deltaValue > 82800f)
			{
				NotificationController.isGetEveryDayMoney = true;
				if (PlayerPrefs.GetInt(Defs.MarathonTestMode, 0) == 0 && Storager.getInt(Defs.NeedTakeMarathonBonus, false) == 0)
				{
					Storager.setInt(Defs.NeedTakeMarathonBonus, 1, false);
				}
			}
			if (PlayerPrefs.GetInt(Defs.MarathonTestMode, 0) == 1 && deltaValue > 1f && Storager.getInt(Defs.NeedTakeMarathonBonus, false) == 0)
			{
				Storager.setInt(Defs.NeedTakeMarathonBonus, 1, false);
			}
		}
		else
		{
			Debug.LogWarning("GetInfoByEverydayDelta()    Cannot parse delta: " + deltaData);
			yield return StartCoroutine(MyWaitForSeconds(120f));
		}
	}

	private IEnumerator UpdatePlayer(bool sendSkin)
	{
		// InitOurInfo();
		/*while (!ReceivedLastOnline || !infoLoaded)
		{
			yield return null;
		}*/
		InitOurInfo();
		WWWForm form = new WWWForm();
		form.AddField("action", "update_player");
		form.AddField("id", id);
		string filteredNick = nick;
		if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.gameObject != null && WeaponManager.sharedManager.gameObject.GetComponent<FilterBadWorld>() != null)
		{
			filteredNick = FilterBadWorld.FilterString(nick);
		}
		if (filteredNick.Length > 20)
		{
			filteredNick = filteredNick.Substring(0, 20);
		}
		form.AddField("nick", filteredNick);
		form.AddField("skin", (!sendSkin) ? string.Empty : skin);
		form.AddField("rank", rank);
		form.AddField("wins", wins.Value);
		int totalWinCount = PlayerPrefs.GetInt("TotalWinsForLeaderboards", 0);
		form.AddField("total_wins", totalWinCount);
		form.AddField("id_fb", id_fb);
		form.AddField("id_clan", "0");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		BankController.GiveInitialNumOfCoins();
		form.AddField("coins", Storager.getInt("Coins", false).ToString());
		form.AddField("gems", Storager.getInt("GemsCurrency", false).ToString());
		form.AddField("paying", Storager.getInt("PayingUser", true).ToString());
		if (Application.platform == RuntimePlatform.IPhonePlayer)
		{
			string advertisingId = string.Empty;
			if (Defs.IsDeveloperBuild)
			{
				Debug.Log("iOS advertising id: " + advertisingId);
			}
			form.AddField("ad_id", advertisingId);
		}
		Dictionary<string, string> accesdictOne = new Dictionary<string, string>
		{
			{ "type", "0" },
			{ "name", capeName },
			{ "skin", capeSkin }
		};
		Dictionary<string, string> accesdictTwo = new Dictionary<string, string>
		{
			{ "type", "1" },
			{ "name", hatName },
			{
				"skin",
				string.Empty
			}
		};
		Dictionary<string, string> accessDictThree = new Dictionary<string, string>
		{
			{ "type", "2" },
			{ "name", bootsName },
			{
				"skin",
				string.Empty
			}
		};
		Dictionary<string, string> accessDictFour = new Dictionary<string, string>
		{
			{ "type", "3" },
			{ "name", armorName },
			{
				"skin",
				string.Empty
			}
		};
		form.AddField("accessories", Json.Serialize(new List<Dictionary<string, string>> { accesdictOne, accesdictTwo, accessDictThree, accessDictFour }));
		Dictionary<string, string> scoresdictOne = new Dictionary<string, string>
		{
			{ "game", "0" },
			{
				"max_score",
				survivalScore.ToString()
			}
		};
		Dictionary<string, string> scoresdictTwo = new Dictionary<string, string>
		{
			{ "game", "1" },
			{
				"max_score",
				coopScore.ToString()
			}
		};
		string serializedScores = Json.Serialize(new List<Dictionary<string, string>> { scoresdictOne, scoresdictTwo });
		form.AddField("scores", serializedScores);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("update_player"));
		form.AddField("coins_bought", Storager.getInt(Defs.AllCurrencyBought + "Coins", false).ToString());
		form.AddField("coins_bought_current", Storager.getInt("BoughtCurrencyCoins", false).ToString());
		form.AddField("gems_bought", Storager.getInt(Defs.AllCurrencyBought + "GemsCurrency", false).ToString());
		form.AddField("gems_bought_current", Storager.getInt("BoughtCurrencyGemsCurrency", false).ToString());
		WWW download = new WWW(actionAddress, form);
		string request = Encoding.UTF8.GetString(form.data, 0, form.data.Length);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.Log("Update: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning("Update error: " + download.error);
			}
		}
		else if (!string.IsNullOrEmpty(response) && response.Equals("fail") && (Debug.isDebugBuild || Application.isEditor))
		{
			Debug.LogWarning("Update fail.");
		}
	}

	private IEnumerator GetFriendData()
	{
		while (true)
		{
			if ((idle || !Application.loadedLevelName.Equals("Friends")) && friendsReceivedOnce)
			{
				yield return null;
				continue;
			}
			StartCoroutine(GetFriendDataOnce(false));
			yield return StartCoroutine(MyWaitForSeconds(20f));
		}
	}

	private IEnumerator GetClanDataLoop()
	{
		while (true)
		{
			if (idle || !Application.loadedLevelName.Equals("Clans") || (Application.loadedLevelName.Equals("Clans") && string.IsNullOrEmpty(ClanID)))
			{
				yield return null;
				continue;
			}
			StartCoroutine(GetClanDataOnce());
			yield return StartCoroutine(MyWaitForSeconds(20f));
		}
	}

	public IEnumerator MyWaitForSeconds(float tm)
	{
		float startTime = Time.realtimeSinceStartup;
		do
		{
			yield return null;
		}
		while (Time.realtimeSinceStartup - startTime < tm);
	}

	public IEnumerator GetFriendDataOnce(bool requestAllInfo = false)
	{
		if (!readyToOperate)
		{
			yield break;
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "get_inbox_data");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_inbox_data"));
		WWW download = new WWW(actionAddress, form);
		NumberOfFriendsRequests++;
		try
		{
			yield return download;
		}
		finally
		{
			NumberOfFriendsRequests--;
		}
		string response = URLs.Sanitize(download);
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetFriendDataOnce error: " + download.error);
			}
			yield break;
		}
		if (response.Equals("fail"))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetFriendDataOnce fail.");
			}
			yield break;
		}
		if (Debug.isDebugBuild)
		{
			if (string.IsNullOrEmpty(response))
			{
				Debug.Log("Friends response is null or empty.");
			}
			else if (response.Length > 256)
			{
				Debug.Log("Friends response is too long to display.");
			}
			else
			{
				Debug.Log("Friends updated: " + response);
			}
		}
		friendsReceivedOnce = true;
		_UpdateFriends(response, requestAllInfo);
		if (FriendsController.FriendsUpdated != null)
		{
			FriendsController.FriendsUpdated();
		}
	}

	private IEnumerator GetClanDataOnce()
	{
		if (!readyToOperate)
		{
			yield break;
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "get_clan_info");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_player", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_clan_info"));
		WWW download = new WWW(actionAddress, form);
		NumberOfClanInfoRequests++;
		try
		{
			yield return download;
		}
		finally
		{
			NumberOfClanInfoRequests--;
		}
		string response = URLs.Sanitize(download);
		int code;
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetClanDataOnce error: " + download.error);
			}
		}
		else if (response.Equals("fail"))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetClanDataOnce fail.");
			}
		}
		else if (int.TryParse(response, out code))
		{
			ClearClanData();
		}
		else if (!string.IsNullOrEmpty(response))
		{
			_UpdateClanMembers(response);
			if (FriendsController.ClanUpdated != null)
			{
				FriendsController.ClanUpdated();
			}
		}
	}

	public void ClearClanData()
	{
		ClanID = null;
		clanName = string.Empty;
		clanLogo = string.Empty;
		clanLeaderID = string.Empty;
		clanMembers.Clear();
		ClanSentInvites.Clear();
		clanSentInvitesLocal.Clear();
	}

	private void _UpdateClanMembers(string text)
	{
		object obj2 = Json.Deserialize(text);
		Dictionary<string, object> dictionary = obj2 as Dictionary<string, object>;
		if (dictionary == null)
		{
			if (Application.isEditor || Debug.isDebugBuild)
			{
				Debug.LogWarning(" _UpdateClanMembers dict = null");
			}
			return;
		}
		List<string> toRem__;
		foreach (KeyValuePair<string, object> item in dictionary)
		{
			switch (item.Key)
			{
			case "info":
			{
				Dictionary<string, object> dictionary2 = item.Value as Dictionary<string, object>;
				if (dictionary2 != null)
				{
					object value;
					if (dictionary2.TryGetValue("name", out value))
					{
						clanName = value as string;
					}
					object value2;
					if (dictionary2.TryGetValue("logo", out value2))
					{
						clanLogo = value2 as string;
					}
					object value3;
					if (dictionary2.TryGetValue("creator_id", out value3))
					{
						clanLeaderID = value3 as string;
					}
				}
				break;
			}
			case "players":
			{
				List<object> list2 = item.Value as List<object>;
				if (list2 != null)
				{
					clanMembers.Clear();
					foreach (Dictionary<string, object> item2 in list2)
					{
						Dictionary<string, string> dictionary4 = new Dictionary<string, string>();
						foreach (KeyValuePair<string, object> item3 in item2)
						{
							if (item3.Value is string)
							{
								dictionary4.Add(item3.Key, item3.Value as string);
							}
						}
						clanMembers.Add(dictionary4);
					}
				}
				toRem__ = new List<string>();
				foreach (string item4 in clanDeletedLocal)
				{
					bool flag = false;
					foreach (Dictionary<string, string> clanMember in clanMembers)
					{
						if (clanMember.ContainsKey("id") && clanMember["id"].Equals(item4))
						{
							flag = true;
							break;
						}
					}
					if (!flag)
					{
						toRem__.Add(item4);
					}
				}
				clanDeletedLocal.RemoveAll((string obj) => toRem__.Contains(obj));
				break;
			}
			case "invites":
			{
				ClanSentInvites.Clear();
				List<object> list = item.Value as List<object>;
				if (list == null)
				{
					break;
				}
				foreach (string item5 in list)
				{
					int result;
					if (int.TryParse(item5, out result) && !ClanSentInvites.Contains(result.ToString()))
					{
						ClanSentInvites.Add(result.ToString());
						clanSentInvitesLocal.Remove(result.ToString());
					}
				}
				break;
			}
			}
		}
		List<string> toRem = new List<string>();
		foreach (string item6 in clanCancelledInvitesLocal)
		{
			if (!ClanSentInvites.Contains(item6))
			{
				toRem.Add(item6);
			}
		}
		clanCancelledInvitesLocal.RemoveAll((string obj) => toRem.Contains(obj));
		if (FriendsController.ClanUpdated != null)
		{
			FriendsController.ClanUpdated();
		}
	}

	private void _UpdateFriends(string text, bool requestAllInfo)
	{
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		UnityEngine.Debug.LogWarning("_UpdateFriends request " + text);
		invitesFromUs.Clear();
		invitesToUs.Clear();
		friends.Clear();
		rejects.Clear();
		ClanInvites.Clear();
		friendsDeletedLocal.Clear();
		object obj = Json.Deserialize(text);
		Dictionary<string, object> dictionary = obj as Dictionary<string, object>;
		object value;
		if (dictionary == null)
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning(" _UpdateFriends dict = null");
			}
		}
		else if (dictionary.TryGetValue("friends", out value))
		{
			List<object> list = value as List<object>;
			if (list == null)
			{
				if (Application.isEditor || Debug.isDebugBuild)
				{
					Debug.LogWarning(" _UpdateFriends __list = null");
				}
				return;
			}
			_ProcessFriendsList(list, requestAllInfo);
			object value2;
			if (dictionary.TryGetValue("clans_invites", out value2))
			{
				List<object> list2 = value2 as List<object>;
				if (list2 == null)
				{
					if (Application.isEditor || Debug.isDebugBuild)
					{
						Debug.LogWarning(" _UpdateFriends clanInv = null");
					}
				}
				else
				{
					_ProcessClanInvitesList(list2);
				}
			}
			else
			{
				Debug.LogWarning(" _UpdateFriends clanInvObj!");
			}
		}
		else
		{
			Debug.LogWarning(" _UpdateFriends friendsObj!");
		}
	}

	private void _ProcessClanInvitesList(List<object> clanInv)
	{
		List<Dictionary<string, string>> list = new List<Dictionary<string, string>>();
		foreach (Dictionary<string, object> item in clanInv)
		{
			Dictionary<string, string> dictionary2 = new Dictionary<string, string>();
			foreach (KeyValuePair<string, object> item2 in item)
			{
				dictionary2.Add(item2.Key, item2.Value as string);
			}
			list.Add(dictionary2);
		}
		ClanInvites.Clear();
		ClanInvites = list;
	}

	private void _ProcessFriendsList(List<object> __list, bool requestAllInfo)
	{
		List<Dictionary<string, string>> list = new List<Dictionary<string, string>>();
		foreach (Dictionary<string, object> item in __list)
		{
			Dictionary<string, string> dictionary2 = new Dictionary<string, string>();
			foreach (KeyValuePair<string, object> item2 in item)
			{
				dictionary2.Add(item2.Key, item2.Value as string);
			}
			list.Add(dictionary2);
		}
		foreach (Dictionary<string, string> item3 in list)
		{
			Dictionary<string, string> dictionary3 = new Dictionary<string, string>();
			if (item3["who"].Equals(id) && item3["status"].Equals("0"))
			{
				foreach (string key3 in item3.Keys)
				{
					if (!key3.Equals("who") && !key3.Equals("status"))
					{
						UnityEngine.Debug.LogWarning("key3 == " + key3);
						UnityEngine.Debug.LogWarning("dict3 new == " + ((!key3.Equals("whom")) ? key3 : "friend"));
						dictionary3.Add((!key3.Equals("whom")) ? key3 : "friend", item3[key3]);
					}
				}
				invitesFromUs.Add(dictionary3);
				notShowAddIds.Remove(item3["whom"]);
			}
			if (item3["whom"].Equals(id) && item3["status"].Equals("0"))
			{
				foreach (string key4 in item3.Keys)
				{
					if (!key4.Equals("whom") && !key4.Equals("status"))
					{
						try
						{
							dictionary3.Add((!key4.Equals("who")) ? key4 : "friend", item3[key4]);
						}
						catch
						{
						}
					}
				}
				invitesToUs.Add(dictionary3);
				notShowAddIds.Remove(item3["who"]);
			}
			if (item3["status"].Equals("1"))
			{
				string text = ((!item3["who"].Equals(id)) ? "whom" : "who");
				string text2 = ((!text.Equals("who")) ? "who" : "whom");
				foreach (string key5 in item3.Keys)
				{
					if (!key5.Equals(text) && !key5.Equals("status"))
					{
						dictionary3.Add((!key5.Equals(text2)) ? key5 : "friend", item3[key5]);
					}
				}
				friends.Add(dictionary3);
				notShowAddIds.Remove(item3[text2]);
			}
			if ((item3["who"].Equals(id) && item3["status"].Equals("2")) || (item3["whom"].Equals(id) && item3["status"].Equals("3")))
			{
				string text3 = ((!item3["who"].Equals(id)) ? "whom" : "who");
				string key = ((!text3.Equals("who")) ? "who" : "whom");
				notShowAddIds.Remove(item3[key]);
			}
			else
			{
				if ((!item3["who"].Equals(id) || !item3["status"].Equals("3")) && (!item3["whom"].Equals(id) || !item3["status"].Equals("2")))
				{
					continue;
				}
				bool flag = false;
				foreach (Dictionary<string, string> reject in rejects)
				{
					if (reject["id"].Equals(item3["id"]))
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					rejects.Add(item3);
				}
				string text4 = ((!item3["who"].Equals(id)) ? "whom" : "who");
				string key2 = ((!text4.Equals("who")) ? "who" : "whom");
				notShowAddIds.Remove(item3[key2]);
				StartCoroutine(RejectFriend(item3["id"], item3["whom"], null, false));
			}
		}
		if (requestAllInfo)
		{
			UpdatePLayersInfo();
		}
		else
		{
			_UpdatePlayersInfo();
		}
	}

	private void _UpdatePlayersInfo()
	{
		List<int> list = new List<int>();
		foreach (Dictionary<string, string> friend in friends)
		{
			int result;
			if (friend.ContainsKey("friend") && friend["friend"] != null && !playersInfo.ContainsKey(friend["friend"]) && int.TryParse(friend["friend"], out result))
			{
				list.Add(result);
			}
		}
		foreach (Dictionary<string, string> invitesToU in invitesToUs)
		{
			int result2;
			if (invitesToU.ContainsKey("friend") && invitesToU["friend"] != null && !playersInfo.ContainsKey(invitesToU["friend"]) && int.TryParse(invitesToU["friend"], out result2))
			{
				list.Add(result2);
			}
		}
		foreach (Dictionary<string, string> invitesFromU in invitesFromUs)
		{
			int result3;
			if (invitesFromU.ContainsKey("friend") && invitesFromU["friend"] != null && !playersInfo.ContainsKey(invitesFromU["friend"]) && int.TryParse(invitesFromU["friend"], out result3))
			{
				list.Add(result3);
			}
		}
		if (list.Count > 0)
		{
			StartCoroutine(GetInfoAboutNPlayers(list));
		}
	}

	private IEnumerator GetInfoAboutNPlayers()
	{
		List<int> ids = new List<int>();
		List<Dictionary<string, string>> allFriends = new List<Dictionary<string, string>>();
		allFriends.AddRange(friends);
		allFriends.AddRange(invitesToUs);
		allFriends.AddRange(invitesFromUs);
		int N = allFriends.Count;
		int currentN = 0;
		do
		{
			for (int i = currentN; i < Math.Min(currentN + N, allFriends.Count); i++)
			{
				string frIdStr;
				int frId;
				if (allFriends[i].TryGetValue("friend", out frIdStr) && int.TryParse(frIdStr, out frId))
				{
					ids.Add(frId);
				}
			}
			currentN += N;
		}
		while (currentN < allFriends.Count);
		if (ids.Count != 0)
		{
			yield return StartCoroutine(GetInfoAboutNPlayers(ids));
		}
	}

	private IEnumerator GetInfoAboutNPlayers(List<int> ids)
	{
		string json = Json.Serialize(ids);
		if (json == null)
		{
			yield break;
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "get_all_short_info_by_id");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("ids", json);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_all_short_info_by_id"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		Debug.LogWarning("GetInfoAboutNPlayers response " + response);
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetInfoAboutNPlayers error: " + download.error);
			}
			yield break;
		}
		if (response.Equals("fail"))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetInfoAboutNPlayers fail.");
			}
			yield break;
		}
		Dictionary<string, object> __list = Json.Deserialize(response) as Dictionary<string, object>;
		if (__list == null)
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning(" GetInfoAboutNPlayers info = null");
			}
			yield break;
		}
		Dictionary<string, Dictionary<string, object>> list = new Dictionary<string, Dictionary<string, object>>();
		foreach (string key2 in __list.Keys)
		{
			Dictionary<string, object> d2 = __list[key2] as Dictionary<string, object>;
			Dictionary<string, object> newd = new Dictionary<string, object>();
			foreach (KeyValuePair<string, object> kvp in d2)
			{
				newd.Add(kvp.Key, kvp.Value);
			}
			list.Add(key2, newd);
		}
		foreach (string key in list.Keys)
		{
			Dictionary<string, object> d = list[key];
			if (playersInfo.ContainsKey(key))
			{
				playersInfo[key] = d;
			}
			else
			{
				playersInfo.Add(key, d);
			}
		}
	}

	public void UpdatePLayersInfo()
	{
		if (readyToOperate)
		{
			StartCoroutine(GetInfoAboutNPlayers());
		}
	}

	public void StartRefreshingInfo(string playerId)
	{
		if (readyToOperate)
		{
			_shouldStopRefreshingInfo = false;
			StartCoroutine(GetIfnoAboutPlayerLoop(playerId));
		}
	}

	public void StopRefreshingInfo()
	{
		if (readyToOperate)
		{
			_shouldStopRefreshingInfo = true;
		}
	}

	private IEnumerator GetIfnoAboutPlayerLoop(string playerId)
	{
		while (true)
		{
			if (idle)
			{
				yield return null;
				continue;
			}
			StartCoroutine(GetInfoById(playerId));
			float startTime = Time.realtimeSinceStartup;
			do
			{
				yield return null;
			}
			while (Time.realtimeSinceStartup - startTime < 20f && !_shouldStopRefreshingInfo);
			if (!_shouldStopRefreshingInfo)
			{
				continue;
			}
			break;
		}
	}

	private IEnumerator GetInfoById(string playerId)
	{
		if (string.IsNullOrEmpty(playerId))
		{
			yield break;
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "get_info_by_id");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", playerId);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("get_info_by_id"));
		WWW download = new WWW(actionAddress, form);
		NumberOffFullInfoRequests++;
		try
		{
			yield return download;
		}
		finally
		{
			NumberOffFullInfoRequests--;
		}
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("Info for id " + playerId + ": " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetInfoById error: " + download.error);
			}
			yield break;
		}
		if (response.Equals("fail"))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("GetInfoById fail.");
			}
			yield break;
		}
		Dictionary<string, object> __newInfo = ParseInfo(response);
		if (__newInfo == null)
		{
			if (Debug.isDebugBuild || Application.isEditor)
			{
				Debug.LogWarning(" GetInfoById newInfo = null");
			}
			yield break;
		}
		playersInfo[playerId] = __newInfo;
		if (FriendsController.FullInfoUpdated != null)
		{
			FriendsController.FullInfoUpdated(null, EventArgs.Empty);
		}
	}

	private Dictionary<string, object> ParseInfo(string info)
	{
		return Json.Deserialize(info) as Dictionary<string, object>;
	}

	private IEnumerator FriendRequest(string personId)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "friend_request");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", id);
		form.AddField("whom", personId);
		form.AddField("type", 0);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("friend_request"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("Friend request: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("FriendRequest error: " + download.error);
			}
		}
		else if (response.Equals("fail") && Debug.isDebugBuild)
		{
			Debug.LogWarning("FriendRequest fail.");
		}
	}

	private IEnumerator _SendCreateClan(string personId, string nameClan, string skinClan, Action<string> ErrorHandler)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "create_clan");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", personId);
		string filteredNick = nameClan;
		if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.gameObject != null && WeaponManager.sharedManager.gameObject.GetComponent<FilterBadWorld>() != null)
		{
			filteredNick = FilterBadWorld.FilterString(nameClan);
		}
		form.AddField("name", filteredNick);
		form.AddField("logo", skinClan);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("create_clan"));
		Debug.Log(form);
		WWW download2 = new WWW(actionAddress, form);
		NumberOfCreateClanRequests++;
		float tm = Time.realtimeSinceStartup;
		try
		{
			while (!download2.isDone && string.IsNullOrEmpty(download2.error) && Time.realtimeSinceStartup - tm < 25f)
			{
				yield return null;
			}
		}
		finally
		{
			NumberOfCreateClanRequests--;
		}
		bool timeout = !download2.isDone && string.IsNullOrEmpty(download2.error) && Time.realtimeSinceStartup - tm >= 25f;
		string response = ((!timeout) ? URLs.Sanitize(download2) : string.Empty);
		if (!timeout && string.IsNullOrEmpty(download2.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("_SendCreateClan request: " + response);
		}
		int newClanID;
		if (timeout || !string.IsNullOrEmpty(download2.error))
		{
			string errorMessage = ((!timeout) ? download2.error : "TIMEOUT");
			if (ErrorHandler != null)
			{
				ErrorHandler(errorMessage);
			}
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_SendCreateClan error: " + errorMessage);
			}
			if (timeout)
			{
				download2.Dispose();
				download2 = null;
			}
		}
		else if ("fail".Equals(response))
		{
			if (ErrorHandler != null)
			{
				ErrorHandler("fail");
			}
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_SendCreateClan fail.");
			}
		}
		else if (int.TryParse(response, out newClanID))
		{
			if (newClanID != -1)
			{
				ClanID = newClanID.ToString();
			}
			if (this.ReturnNewIDClan != null)
			{
				this.ReturnNewIDClan(newClanID);
			}
		}
	}

	public void ExitClan(string who = null)
	{
		if (readyToOperate)
		{
			StartCoroutine(_ExitClan(who));
		}
	}

	private IEnumerator _ExitClan(string who)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "exit_clan");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_player", who ?? id);
		form.AddField("id_clan", ClanID);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("exit_clan"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("_ExitClan: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_ExitClan error: " + download.error);
			}
		}
		else if ("fail".Equals(response) && Debug.isDebugBuild)
		{
			Debug.LogWarning("_ExitClan fail.");
		}
	}

	public void DeleteClan()
	{
		if (readyToOperate && ClanID != null)
		{
			StartCoroutine(_DeleteClan());
		}
	}

	private IEnumerator _DeleteClan()
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "delete_clan");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_clan", ClanID);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("delete_clan"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("_DeleteClan: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_DeleteClan error: " + download.error);
			}
		}
		else if ("fail".Equals(response) && Debug.isDebugBuild)
		{
			Debug.LogWarning("_DeleteClan fail.");
		}
	}

	private IEnumerator _SendClanInvitation(string personID)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "invite_to_clan");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_player", personID);
		form.AddField("id_clan", ClanID);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("invite_to_clan"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("_SendClanInvitation: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_SendClanInvitation error: " + download.error);
			}
			clanSentInvitesLocal.Remove(personID);
		}
		else if ("fail".Equals(response))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_SendClanInvitation fail.");
			}
			clanSentInvitesLocal.Remove(personID);
		}
	}

	private IEnumerator AcceptFriend(string recordId, string accepteeId)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "accept_friend");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", recordId);
		form.AddField("player_id", id);
		form.AddField("acceptee_id", accepteeId);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("accept_friend"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("Accept friend: " + response);
		}
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("AcceptFriend error: " + download.error);
			}
		}
		else if ("fail".Equals(response) && Debug.isDebugBuild)
		{
			Debug.LogWarning("AcceptFriend fail.");
		}
	}

	public void RejectInvite(string recordId, string rejecteeId, Action<bool> action = null)
	{
		if (!string.IsNullOrEmpty(recordId) && readyToOperate)
		{
			StartCoroutine(RejectFriend(recordId, rejecteeId, action));
		}
	}

	public void RejectClanInvite(string clanID, string playerID = null)
	{
		if (!string.IsNullOrEmpty(clanID) && readyToOperate)
		{
			StartCoroutine(_RejectClanInvite(clanID, playerID));
		}
	}

	private IEnumerator RejectFriend(string recordId, string rejecteeId, Action<bool> action = null, bool requestFriends = true)
	{
		if (action != null)
		{
			action(true);
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "reject_friend");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id", recordId);
		form.AddField("rejector_id", id);
		form.AddField("rejectee_id", rejecteeId);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("reject_friend"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("RejectFriend error: " + download.error);
			}
			if (action != null)
			{
				action(false);
			}
		}
		else if ("fail".Equals(response))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("RejectFriend fail.");
			}
			if (action != null)
			{
				action(false);
			}
		}
		else if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("Reject friend: " + response);
		}
	}

	private IEnumerator _RejectClanInvite(string clanID, string playerID)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "reject_invite");
		form.AddField("app_version", string.Empty + ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_player", playerID ?? id);
		form.AddField("id_clan", clanID);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("reject_invite"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_RejectClanInvite error: " + download.error);
			}
			clanCancelledInvitesLocal.Remove(playerID);
		}
		else if ("fail".Equals(response))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_RejectClanInvite fail.");
			}
			clanCancelledInvitesLocal.Remove(playerID);
		}
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("_RejectClanInvite: " + response);
		}
	}

	public void DeleteClanMember(string memebrID)
	{
		if (!string.IsNullOrEmpty(memebrID) && readyToOperate)
		{
			StartCoroutine(_DeleteClanMember(memebrID));
		}
	}

	private IEnumerator _DeleteClanMember(string memberID)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "delete_clan_member");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		form.AddField("id_player", memberID);
		form.AddField("id_clan", ClanID);
		form.AddField("id", id);
		form.AddField("uniq_id", sharedController.id);
		form.AddField("auth", Hash("delete_clan_member"));
		WWW download = new WWW(actionAddress, form);
		yield return download;
		string response = URLs.Sanitize(download);
		if (!string.IsNullOrEmpty(download.error))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_DeleteClanMember error: " + download.error);
			}
			clanDeletedLocal.Remove(memberID);
		}
		else if ("fail".Equals(response))
		{
			if (Debug.isDebugBuild)
			{
				Debug.LogWarning("_DeleteClanMember fail.");
			}
			clanDeletedLocal.Remove(memberID);
		}
		if (string.IsNullOrEmpty(download.error) && !string.IsNullOrEmpty(response) && Debug.isDebugBuild)
		{
			Debug.Log("_DeleteClanMember: " + response);
		}
	}

	private void Update()
	{
		if (Banned == 1 && PhotonNetwork.connected)
		{
			PhotonNetwork.Disconnect();
		}
		if (Input.touchCount > 0)
		{
			if (Time.realtimeSinceStartup - lastTouchTm > 30f)
			{
				idle = true;
			}
		}
		else
		{
			lastTouchTm = Time.realtimeSinceStartup;
			idle = false;
		}
	}
}
