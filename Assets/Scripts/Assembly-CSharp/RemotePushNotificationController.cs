using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Text;
using Rilisoft;
using UnityEngine;

public class RemotePushNotificationController : MonoBehaviour
{
	[CompilerGenerated]
	private sealed class _003CReciveUpdateDataToServer_003Ec__Iterator94 : IEnumerator, IDisposable, IEnumerator<object>
	{
		internal bool _003CfriendsControllerIsNotInitialized_003E__0;

		internal WWWForm _003Cform_003E__1;

		internal string _003CappVersion_003E__2;

		internal string _003CplayerId_003E__3;

		internal string _003ClanguageCode_003E__4;

		internal string _003CisPayingPlayer_003E__5;

		internal string _003CdateLastPaying_003E__6;

		internal TimeSpan _003CtimeUtcOffset_003E__7;

		internal string _003CtimeUtcOffsetString_003E__8;

		internal string _003CcountMoney_003E__9;

		internal string _003CcountGems_003E__10;

		internal string _003CplayerLevel_003E__11;

		internal string deviceToken;

		internal StringBuilder _003CdataLog_003E__12;

		internal Dictionary<string, string> _003Cheaders_003E__13;

		internal WWW _003Crequest_003E__14;

		internal int _0024PC;

		internal object _0024current;

		internal string _003C_0024_003EdeviceToken;

		internal RemotePushNotificationController _003C_003Ef__this;

		object IEnumerator<object>.Current
		{
			[DebuggerHidden]
			get
			{
				return _0024current;
			}
		}

		object IEnumerator.Current
		{
			[DebuggerHidden]
			get
			{
				return _0024current;
			}
		}

		public bool MoveNext()
		{
			//Discarded unreachable code: IL_0590
			uint num = (uint)_0024PC;
			_0024PC = -1;
			switch (num)
			{
			case 0u:
				if (_003C_003Ef__this._isResponceRuning)
				{
					goto default;
				}
				_003C_003Ef__this._isResponceRuning = true;
				_003CfriendsControllerIsNotInitialized_003E__0 = FriendsController.sharedController == null;
				if (Defs.IsDeveloperBuild && FriendsController.sharedController == null)
				{
					UnityEngine.Debug.Log("Waiting FriendsController being initialized...");
				}
				goto case 1u;
			case 1u:
				if (FriendsController.sharedController == null)
				{
					_0024current = null;
					_0024PC = 1;
					break;
				}
				if (_003CfriendsControllerIsNotInitialized_003E__0)
				{
					_0024current = null;
					_0024PC = 2;
					break;
				}
				goto case 2u;
			case 2u:
				if (Defs.IsDeveloperBuild && FriendsController.sharedController.id == null)
				{
					UnityEngine.Debug.Log("Waiting FriendsController.id being initialized...");
				}
				goto case 3u;
			case 3u:
				if (FriendsController.sharedController.id == null)
				{
					_0024current = null;
					_0024PC = 3;
					break;
				}
				_003C_003Ef__this._isStartUpdateRecive = true;
				_003Cform_003E__1 = new WWWForm();
				_003CappVersion_003E__2 = string.Format("{0}:{1}", ProtocolListGetter.CurrentPlatform, GlobalGameController.AppVersion);
				_003CplayerId_003E__3 = FriendsController.sharedController.id;
				_003ClanguageCode_003E__4 = LocalizationStore.GetCurrentLanguageCode();
				_003CisPayingPlayer_003E__5 = Storager.getInt("PayingUser", true).ToString();
				_003CdateLastPaying_003E__6 = PlayerPrefs.GetString("Last Payment Time", string.Empty);
				if (string.IsNullOrEmpty(_003CdateLastPaying_003E__6))
				{
					_003CdateLastPaying_003E__6 = "None";
				}
				_003CtimeUtcOffset_003E__7 = DateTimeOffset.Now.Offset;
				_003CtimeUtcOffsetString_003E__8 = _003CtimeUtcOffset_003E__7.Hours.ToString();
				_003CcountMoney_003E__9 = Storager.getInt("Coins", false).ToString();
				_003CcountGems_003E__10 = Storager.getInt("GemsCurrency", false).ToString();
				_003CplayerLevel_003E__11 = ExperienceController.GetCurrentLevel().ToString();
				_003Cform_003E__1.AddField("app_version", _003CappVersion_003E__2);
				_003Cform_003E__1.AddField("device_token", deviceToken);
				_003Cform_003E__1.AddField("uniq_id", _003CplayerId_003E__3);
				_003Cform_003E__1.AddField("is_paying", _003CisPayingPlayer_003E__5);
				_003Cform_003E__1.AddField("last_payment_date", _003CdateLastPaying_003E__6);
				_003Cform_003E__1.AddField("utc_shift", _003CtimeUtcOffsetString_003E__8);
				_003Cform_003E__1.AddField("coins", _003CcountMoney_003E__9);
				_003Cform_003E__1.AddField("gems", _003CcountGems_003E__10);
				_003Cform_003E__1.AddField("level", _003CplayerLevel_003E__11);
				_003Cform_003E__1.AddField("language", _003ClanguageCode_003E__4);
				if (Defs.IsDeveloperBuild)
				{
					UnityEngine.Debug.Log("RemotePushNotificationController(ReciveDeviceTokenToServer): form data");
					_003CdataLog_003E__12 = new StringBuilder();
					_003CdataLog_003E__12.AppendLine("app_version: " + _003CappVersion_003E__2);
					_003CdataLog_003E__12.AppendLine("device_token: " + deviceToken);
					_003CdataLog_003E__12.AppendLine("uniq_id: " + _003CplayerId_003E__3);
					_003CdataLog_003E__12.AppendLine("is_paying: " + _003CisPayingPlayer_003E__5);
					_003CdataLog_003E__12.AppendLine("last_payment_date: " + _003CdateLastPaying_003E__6);
					_003CdataLog_003E__12.AppendLine("utc_shift: " + _003CtimeUtcOffsetString_003E__8);
					_003CdataLog_003E__12.AppendLine("coins: " + _003CcountMoney_003E__9);
					_003CdataLog_003E__12.AppendLine("gems: " + _003CcountGems_003E__10);
					_003CdataLog_003E__12.AppendLine("level: " + _003CplayerLevel_003E__11);
					_003CdataLog_003E__12.AppendLine("language: " + _003ClanguageCode_003E__4);
					UnityEngine.Debug.Log(_003CdataLog_003E__12.ToString());
				}
				_003Cheaders_003E__13 = new Dictionary<string, string>();
				_003Cheaders_003E__13.Add("Authorization", FriendsController.HashForPush(_003Cform_003E__1.data));
				if (Defs.IsDeveloperBuild)
				{
					UnityEngine.Debug.Log("Trying to send device token to server: " + deviceToken);
				}
				_003Crequest_003E__14 = new WWW("https://secure.pixelgunserver.com/push_service", _003Cform_003E__1.data, _003Cheaders_003E__13);
				_0024current = _003Crequest_003E__14;
				_0024PC = 4;
				break;
			case 4u:
				try
				{
					if (string.IsNullOrEmpty(_003Crequest_003E__14.error))
					{
						if (!string.IsNullOrEmpty(_003Crequest_003E__14.text))
						{
							if (Defs.IsDeveloperBuild)
							{
								UnityEngine.Debug.Log("RemotePushNotificationController(ReciveDeviceTokenToServer): request.text = " + _003Crequest_003E__14.text);
							}
							if (BuildSettings.BuildTarget == BuildTarget.Android)
							{
								if (Defs.IsDeveloperBuild)
								{
									UnityEngine.Debug.Log("Saving push notification token: " + deviceToken);
								}
								PlayerPrefs.SetString("RemotePushNotificationToken", deviceToken);
							}
						}
						goto IL_0585;
					}
					if (Defs.IsDeveloperBuild)
					{
						UnityEngine.Debug.Log("RemotePushNotificationController(ReciveDeviceTokenToServer): error = " + _003Crequest_003E__14.error);
					}
				}
				finally
				{
					_003C_003E__Finally0();
				}
				goto default;
			default:
				{
					return false;
				}
				IL_0585:
				_0024PC = -1;
				goto default;
			}
			return true;
		}

		[DebuggerHidden]
		public void Dispose()
		{
			_0024PC = -1;
		}

		[DebuggerHidden]
		public void Reset()
		{
			throw new NotSupportedException();
		}

		private void _003C_003E__Finally0()
		{
			_003C_003Ef__this._isResponceRuning = false;
		}
	}

	private const string UrlPushNotificationServer = "https://secure.pixelgunserver.com/push_service";

	private bool _isResponceRuning;

	private bool _isStartUpdateRecive;

	private IEnumerator Start()
	{
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
		{
			if (Application.isEditor)
			{
				UnityEngine.Debug.Log("Google Cloud Messaging initialization skipped in editor.");
			}
			else if (!IsDeviceRegistred())
			{
				UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			}
		}
		yield break;
	}

	private void HandleError(string error)
	{
		UnityEngine.Debug.LogError(error);
	}

	private void HandleRegistered(string registrationId)
	{
		if (string.IsNullOrEmpty(registrationId))
		{
			if (Defs.IsDeveloperBuild)
			{
				UnityEngine.Debug.LogError("Registration id is empty.");
			}
			return;
		}
		if (Defs.IsDeveloperBuild)
		{
			UnityEngine.Debug.Log("Registration id: " + registrationId);
		}
		StartCoroutine(ReciveUpdateDataToServer(registrationId));
	}

	private bool IsDeviceRegistred()
	{
		string @string = PlayerPrefs.GetString("RemotePushNotificationToken", string.Empty);
		return !string.IsNullOrEmpty(@string);
	}

	private IEnumerator ReciveUpdateDataToServer(string deviceToken)
	{
		if (_isResponceRuning)
		{
			yield break;
		}
		_isResponceRuning = true;
		bool friendsControllerIsNotInitialized = FriendsController.sharedController == null;
		if (Defs.IsDeveloperBuild && FriendsController.sharedController == null)
		{
			UnityEngine.Debug.Log("Waiting FriendsController being initialized...");
		}
		while (FriendsController.sharedController == null)
		{
			yield return null;
		}
		if (friendsControllerIsNotInitialized)
		{
			yield return null;
		}
		if (Defs.IsDeveloperBuild && FriendsController.sharedController.id == null)
		{
			UnityEngine.Debug.Log("Waiting FriendsController.id being initialized...");
		}
		while (FriendsController.sharedController.id == null)
		{
			yield return null;
		}
		_isStartUpdateRecive = true;
		WWWForm form = new WWWForm();
		string appVersion = string.Format("{0}:{1}", ProtocolListGetter.CurrentPlatform, GlobalGameController.AppVersion);
		string playerId = FriendsController.sharedController.id;
		string languageCode = LocalizationStore.GetCurrentLanguageCode();
		string isPayingPlayer = Storager.getInt("PayingUser", true).ToString();
		string dateLastPaying = PlayerPrefs.GetString("Last Payment Time", string.Empty);
		if (string.IsNullOrEmpty(dateLastPaying))
		{
			dateLastPaying = "None";
		}
		string timeUtcOffsetString = DateTimeOffset.Now.Offset.Hours.ToString();
		string countMoney = Storager.getInt("Coins", false).ToString();
		string countGems = Storager.getInt("GemsCurrency", false).ToString();
		string playerLevel = ExperienceController.GetCurrentLevel().ToString();
		form.AddField("app_version", appVersion);
		form.AddField("device_token", deviceToken);
		form.AddField("uniq_id", playerId);
		form.AddField("is_paying", isPayingPlayer);
		form.AddField("last_payment_date", dateLastPaying);
		form.AddField("utc_shift", timeUtcOffsetString);
		form.AddField("coins", countMoney);
		form.AddField("gems", countGems);
		form.AddField("level", playerLevel);
		form.AddField("language", languageCode);
		if (Defs.IsDeveloperBuild)
		{
			UnityEngine.Debug.Log("RemotePushNotificationController(ReciveDeviceTokenToServer): form data");
			StringBuilder dataLog = new StringBuilder();
			dataLog.AppendLine("app_version: " + appVersion);
			dataLog.AppendLine("device_token: " + deviceToken);
			dataLog.AppendLine("uniq_id: " + playerId);
			dataLog.AppendLine("is_paying: " + isPayingPlayer);
			dataLog.AppendLine("last_payment_date: " + dateLastPaying);
			dataLog.AppendLine("utc_shift: " + timeUtcOffsetString);
			dataLog.AppendLine("coins: " + countMoney);
			dataLog.AppendLine("gems: " + countGems);
			dataLog.AppendLine("level: " + playerLevel);
			dataLog.AppendLine("language: " + languageCode);
			UnityEngine.Debug.Log(dataLog.ToString());
		}
		Dictionary<string, string> headers = new Dictionary<string, string> { 
		{
			"Authorization",
			FriendsController.HashForPush(form.data)
		} };
		if (Defs.IsDeveloperBuild)
		{
			UnityEngine.Debug.Log("Trying to send device token to server: " + deviceToken);
		}
		WWW request = new WWW("https://secure.pixelgunserver.com/push_service", form.data, headers);
		yield return request;
		try
		{
			if (!string.IsNullOrEmpty(request.error))
			{
				if (Defs.IsDeveloperBuild)
				{
					UnityEngine.Debug.Log("RemotePushNotificationController(ReciveDeviceTokenToServer): error = " + request.error);
				}
			}
			else
			{
				if (string.IsNullOrEmpty(request.text))
				{
					yield break;
				}
				if (Defs.IsDeveloperBuild)
				{
					UnityEngine.Debug.Log("RemotePushNotificationController(ReciveDeviceTokenToServer): request.text = " + request.text);
				}
				if (BuildSettings.BuildTarget == BuildTarget.Android)
				{
					if (Defs.IsDeveloperBuild)
					{
						UnityEngine.Debug.Log("Saving push notification token: " + deviceToken);
					}
					PlayerPrefs.SetString("RemotePushNotificationToken", deviceToken);
				}
			}
		}
		finally
		{
			//((_003CReciveUpdateDataToServer_003Ec__Iterator94)(object)this)._003C_003E__Finally0();
		}
	}
}
