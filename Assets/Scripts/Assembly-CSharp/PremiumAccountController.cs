using System;
using System.Collections;
using System.Collections.Generic;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

public class PremiumAccountController : MonoBehaviour
{
	public enum AccountType
	{
		OneDay,
		ThreeDay,
		SevenDays,
		Month,
		None
	}

	public delegate void OnAccountChangedDelegate();

	private const float PremInfoTimeout = 1200f;

	private DateTime _timeStart;

	private DateTime _timeEnd;

	private TimeSpan _timeToEndAccount;

	private float _lastCheckTime;

	private int _additionalAccountDays;

	private long _lastLoggedAccountTime;

	private int _countCeilDays;

	private DateTime _timeEndCheat;

	private bool _isGetPremInfoRunning;

	private float _premGetInfoStartTime;

	public static PremiumAccountController Instance { get; private set; }

	public bool isAccountActive { get; private set; }

	public static bool AccountHasExpired { get; set; }

	public int RewardCoeff
	{
		get
		{
			return (!isAccountActive) ? 1 : 2;
		}
	}

	public static float VirtualCurrencyMultiplier
	{
		get
		{
			if (Instance == null)
			{
				return 1f;
			}
			switch (Instance.GetCurrentAccount())
			{
			case AccountType.SevenDays:
				return 1.05f;
			case AccountType.Month:
				return 1.1f;
			default:
				return 1f;
			}
		}
	}

	public double oneDayAccountLive { get; set; }

	public double threeDayAccountLive { get; set; }

	public double sevenDayAccountLive { get; set; }

	public double monthDayAccountLive { get; set; }

	public static event OnAccountChangedDelegate OnAccountChanged;

	public static bool MapAvailableDueToPremiumAccount(string mapName)
	{
		if (mapName == null || Instance == null)
		{
			return false;
		}
		return Defs.PremiumMaps != null && Defs.PremiumMaps.ContainsKey(mapName) && Instance.isAccountActive;
	}

	private void Start()
	{
		oneDayAccountLive = 60.0;
		threeDayAccountLive = 180.0;
		sevenDayAccountLive = 420.0;
		monthDayAccountLive = 1800.0;
		Instance = this;
		_timeToEndAccount = default(TimeSpan);
		_additionalAccountDays = GetAllTimeOtherAccountFromHistory();
		isAccountActive = CheckInitializeCurrentAccount();
		CheckTimeHack();
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		StartCoroutine(GetPremInfoLoop());
	}

	private void OnApplicationPause(bool pause)
	{
		if (pause)
		{
			UpdateLastLoggedTime();
			return;
		}
		CheckTimeHack();
		StartCoroutine(DownloadPremInfo());
	}

	private void Destroy()
	{
		UpdateLastLoggedTime();
		Instance = null;
	}

	private void CheckTimeHack()
	{
		_lastLoggedAccountTime = GetLastLoggedTime();
		if (_lastLoggedAccountTime != 0L && PromoActionsManager.CurrentUnixTime < _lastLoggedAccountTime)
		{
			StopAccountsWork();
		}
	}

	private long GetLastLoggedTime()
	{
		if (!isAccountActive)
		{
			return 0L;
		}
		if (!Storager.hasKey("LastLoggedTimePremiumAccount"))
		{
			return 0L;
		}
		string @string = Storager.getString("LastLoggedTimePremiumAccount", false);
		long result;
		long.TryParse(@string, out result);
		return result;
	}

	private void UpdateLastLoggedTime()
	{
		if (isAccountActive)
		{
			Storager.setString("LastLoggedTimePremiumAccount", PromoActionsManager.CurrentUnixTime.ToString(), false);
		}
	}

	private bool CheckInitializeCurrentAccount()
	{
		DateTime parsedDate = default(DateTime);
		bool flag = Tools.ParseDateTimeFromPlayerPrefs("StartTimePremiumAccount", out parsedDate);
		DateTime parsedDate2 = default(DateTime);
		bool flag2 = Tools.ParseDateTimeFromPlayerPrefs("EndTimePremiumAccount", out parsedDate2);
		if (!flag || !flag2)
		{
			return false;
		}
		_timeStart = parsedDate;
		_timeEnd = parsedDate2;
		Tools.ParseDateTimeFromPlayerPrefs("EndCheatTimePremiumAccount", out _timeEndCheat);
		return true;
	}

	private void Update()
	{
		if (isAccountActive && Time.realtimeSinceStartup - _lastCheckTime >= 1f)
		{
			_timeToEndAccount = _timeEnd - DateTime.UtcNow;
			isAccountActive = DateTime.UtcNow <= _timeEndCheat;
			if (!isAccountActive)
			{
				ChangeCurrentAccount();
			}
			_lastCheckTime = Time.realtimeSinceStartup;
		}
	}

	private void ChangeCurrentAccount()
	{
		if (!ChangeAccountOnNext())
		{
			StopAccountsWork();
		}
	}

	private DateTime GetTimeEndAccount(DateTime startTime, AccountType accountType)
	{
		DateTime result = startTime;
		switch (accountType)
		{
		case AccountType.OneDay:
			result = result.AddDays(1.0);
			break;
		case AccountType.ThreeDay:
			result = result.AddDays(3.0);
			break;
		case AccountType.SevenDays:
			result = result.AddDays(7.0);
			break;
		case AccountType.Month:
			result = result.AddDays(30.0);
			break;
		}
		return result;
	}

	public void BuyAccount(AccountType accountType)
	{
		AccountType currentAccount = GetCurrentAccount();
		if (currentAccount == AccountType.None)
		{
			StartNewAccount(accountType);
		}
		AddBoughtAccountInHistory(accountType);
		_additionalAccountDays = GetAllTimeOtherAccountFromHistory();
		AccountHasExpired = false;
		PlayerPrefs.Save();
	}

	private void StartNewAccount(AccountType accountType)
	{
		isAccountActive = true;
		_timeStart = DateTime.UtcNow;
		Storager.setString("StartTimePremiumAccount", _timeStart.ToString("s"), false);
		_timeEnd = GetTimeEndAccount(_timeStart, accountType);
		Storager.setString("EndTimePremiumAccount", _timeEnd.ToString("s"), false);
		_timeEndCheat = GetTimeEndAccountCheat(_timeStart, accountType);
		Storager.setString("EndCheatTimePremiumAccount", _timeEndCheat.ToString("s"), false);
	}

	private void AddBoughtAccountInHistory(AccountType accountType)
	{
		string @string = Storager.getString("BuyHistoryPremiumAccount", false);
		@string = ((!string.IsNullOrEmpty(@string)) ? (@string + string.Format(",{0}", (int)accountType)) : string.Format("{0}", (int)accountType));
		Storager.setString("BuyHistoryPremiumAccount", @string, false);
	}

	private void DeleteBoughtAccountFromHistory()
	{
		string @string = Storager.getString("BuyHistoryPremiumAccount", false);
		if (!string.IsNullOrEmpty(@string))
		{
			int num = @string.IndexOf(',');
			@string = ((num <= 0) ? string.Empty : @string.Remove(0, num + 1));
			Storager.setString("BuyHistoryPremiumAccount", @string, false);
		}
	}

	public AccountType GetCurrentAccount()
	{
		string @string = Storager.getString("BuyHistoryPremiumAccount", false);
		if (string.IsNullOrEmpty(@string))
		{
			return AccountType.None;
		}
		string[] array = @string.Split(',');
		if (array.Length == 0)
		{
			return AccountType.None;
		}
		int result = 0;
		if (!int.TryParse(array[0], out result))
		{
			return AccountType.None;
		}
		return (AccountType)result;
	}

	private bool ChangeAccountOnNext()
	{
		DeleteBoughtAccountFromHistory();
		_additionalAccountDays = GetAllTimeOtherAccountFromHistory();
		AccountType currentAccount = GetCurrentAccount();
		if (currentAccount == AccountType.None)
		{
			return false;
		}
		StartNewAccount(currentAccount);
		if (PremiumAccountController.OnAccountChanged != null)
		{
			PremiumAccountController.OnAccountChanged();
		}
		PlayerPrefs.Save();
		return true;
	}

	private void StopAccountsWork()
	{
		isAccountActive = false;
		if (PremiumAccountController.OnAccountChanged != null)
		{
			PremiumAccountController.OnAccountChanged();
		}
		Storager.setString("StartTimePremiumAccount", string.Empty, false);
		Storager.setString("EndTimePremiumAccount", string.Empty, false);
		Storager.setString("BuyHistoryPremiumAccount", string.Empty, false);
		Storager.setString("EndCheatTimePremiumAccount", string.Empty, false);
		_timeToEndAccount = TimeSpan.FromMinutes(0.0);
		_additionalAccountDays = 0;
		_countCeilDays = 0;
		AccountHasExpired = true;
	}

	private int GetDaysAccountByType(int codeAccount)
	{
		switch (codeAccount)
		{
		case 0:
			return 1;
		case 1:
			return 3;
		case 2:
			return 7;
		case 3:
			return 30;
		default:
			return 0;
		}
	}

	private int GetAllTimeOtherAccountFromHistory()
	{
		string @string = Storager.getString("BuyHistoryPremiumAccount", false);
		if (string.IsNullOrEmpty(@string))
		{
			return 0;
		}
		string[] array = @string.Split(',');
		if (array.Length == 0)
		{
			return 0;
		}
		int result = 0;
		int num = 0;
		for (int i = 1; i < array.Length; i++)
		{
			int.TryParse(array[i], out result);
			num += GetDaysAccountByType(result);
		}
		return num;
	}

	public string GetTimeToEndAllAccounts()
	{
		if (!isAccountActive)
		{
			return string.Empty;
		}
		TimeSpan timeSpan = _timeToEndAccount.Add(TimeSpan.FromDays(_additionalAccountDays));
		if (timeSpan.Days > 0)
		{
			string arg = "Days";
			_countCeilDays = Mathf.CeilToInt((float)_timeToEndAccount.TotalDays) + _additionalAccountDays;
			return string.Format("{0}: {1}", arg, _countCeilDays);
		}
		return string.Format("{0:00}:{1:00}:{2:00}", timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds);
	}

	public int GetDaysToEndAllAccounts()
	{
		return _countCeilDays + _additionalAccountDays;
	}

	public void CheatRemoveCurrentAccount()
	{
		ChangeCurrentAccount();
	}

	public void CheatStopAllAccounts()
	{
		StopAccountsWork();
	}

	public void CheatChangeTimeLiveAccount(AccountType accountType, double time)
	{
		switch (accountType)
		{
		case AccountType.OneDay:
			oneDayAccountLive = time;
			break;
		case AccountType.ThreeDay:
			threeDayAccountLive = time;
			break;
		case AccountType.SevenDays:
			sevenDayAccountLive = time;
			break;
		case AccountType.Month:
			monthDayAccountLive = time;
			break;
		}
	}

	private DateTime GetTimeEndAccountCheat(DateTime startTime, AccountType accountType)
	{
		switch (accountType)
		{
		case AccountType.OneDay:
			return startTime.AddMinutes(oneDayAccountLive);
		case AccountType.ThreeDay:
			return startTime.AddMinutes(threeDayAccountLive);
		case AccountType.SevenDays:
			return startTime.AddMinutes(sevenDayAccountLive);
		case AccountType.Month:
			return startTime.AddMinutes(monthDayAccountLive);
		default:
			return startTime;
		}
	}

	private IEnumerator GetPremInfoLoop()
	{
		while (true)
		{
			yield return StartCoroutine(DownloadPremInfo());
			while (Time.realtimeSinceStartup - _premGetInfoStartTime < 1200f)
			{
				yield return null;
			}
		}
	}

	private IEnumerator DownloadPremInfo()
	{
		if (_isGetPremInfoRunning)
		{
			yield break;
		}
		_premGetInfoStartTime = Time.realtimeSinceStartup;
		_isGetPremInfoRunning = true;
		if (string.IsNullOrEmpty(URLs.PremiumAccount))
		{
			_isGetPremInfoRunning = false;
			yield break;
		}
		WWW response = new WWW(URLs.PremiumAccount);
		yield return response;
		string responseText = URLs.Sanitize(response);
		if (!string.IsNullOrEmpty(response.error))
		{
			Debug.LogWarning("Prem response error: " + response.error);
			_isGetPremInfoRunning = false;
			yield break;
		}
		if (string.IsNullOrEmpty(responseText))
		{
			Debug.LogWarning("Prem response is empty");
			_isGetPremInfoRunning = false;
			yield break;
		}
		object premInfoObj = Json.Deserialize(responseText);
		Dictionary<string, object> premInfo = premInfoObj as Dictionary<string, object>;
		if (premInfo == null)
		{
			Debug.LogWarning("Prem response is bad");
			_isGetPremInfoRunning = false;
			yield break;
		}
		if (premInfo.ContainsKey("enable"))
		{
			Storager.setInt(val: ((long)premInfo["enable"] == 1) ? 1 : 0, key: Defs.PremiumEnabledFromServer, useICloud: false);
		}
		_isGetPremInfoRunning = false;
	}

	public bool IsActiveOrWasActiveBeforeStartMatch()
	{
		if (isAccountActive)
		{
			return true;
		}
		Player_move_c player_move_c = ((!(WeaponManager.sharedManager == null)) ? WeaponManager.sharedManager.myPlayerMoveC : null);
		if (player_move_c == null)
		{
			return false;
		}
		return player_move_c.isNeedTakePremiumAccountRewards;
	}

	public int GetRewardCoeffByActiveOrActiveBeforeMatch()
	{
		return (!IsActiveOrWasActiveBeforeStartMatch()) ? 1 : 2;
	}
}
