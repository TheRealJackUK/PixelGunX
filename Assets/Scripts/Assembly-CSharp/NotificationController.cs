using System;
using System.Collections.Generic;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

internal sealed class NotificationController : MonoBehaviour
{
	private const string ScheduledNotificationsKey = "Scheduled Notifications";

	public static bool isGetEveryDayMoney;

	public static float timeStartApp;

	public bool pauserTemp;

	private static bool _paused;

	private readonly List<int> _notificationIds = new List<int>();

	internal static bool Paused
	{
		get
		{
			return _paused;
		}
	}

	private void Start()
	{
		if (!Load.LoadBool("bilZapuskKey"))
		{
			Save.SaveBool("bilZapuskKey", true);
		}
		else
		{
			appStart();
		}
	}

	private void Update()
	{
		if (pauserTemp)
		{
			pauserTemp = false;
			_paused = true;
			PhotonNetwork.Disconnect();
		}
	}

	internal static void ResetPaused()
	{
		_paused = false;
	}

	private void appStop()
	{
		bool flag = BankController.Instance != null && BankController.Instance.InterfaceEnabled;
		if (Application.platform == RuntimePlatform.Android && PhotonNetwork.connected)
		{
			_paused = true;
			PhotonNetwork.Disconnect();
		}
		Save.SaveString("appStopTime", DateTime.Now.ToString());
		int hour = DateTime.Now.Hour;
		int num = 82800;
		hour += 23;
		if (hour > 24)
		{
			hour -= 24;
		}
		int num2 = ((hour <= 16) ? (16 - hour) : (24 - hour + 16));
		num += num2 * 3600;
		DateTime now = DateTime.Now;
		DateTime dateTime = now + TimeSpan.FromHours(23.0);
		DateTime dateTime2 = ((dateTime.Hour >= 16) ? dateTime.Date.AddHours(40.0) : dateTime.Date.AddHours(16.0));
		TimeSpan timeSpan = TimeSpan.FromDays(1.0);
		for (int i = 0; i < 15; i++)
		{
			int num3 = num + i * 86400;
			num3 = num3 - 1800 + UnityEngine.Random.Range(0, 3600);
			DateTime dateTime3 = dateTime2 + TimeSpan.FromTicks(timeSpan.Ticks * i);
			int num4 = (int)(dateTime3 - now).TotalSeconds + UnityEngine.Random.Range(-1800, 1800);
			string empty = string.Empty;
			int item = EtceteraAndroid.scheduleNotification(num4, "Challenge", "Daily prize is available! Open the game and get it!", "Cool!", empty);
			_notificationIds.Add(item);
		}
		string text = Json.Serialize(_notificationIds);
		Debug.Log("Notifications to save: " + text);
		PlayerPrefs.SetString("Scheduled Notifications", text);
	}

	private void appStart()
	{
		if (PhotonNetwork.connected)
		{
			PhotonNetwork.FetchServerTimestamp();
		}
		timeStartApp = Time.time;
		string text = Load.LoadString("appStopTime");
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		TimeSpan timeSpan = DateTime.Now.Subtract(DateTime.Parse(text));
		string @string = PlayerPrefs.GetString("Scheduled Notifications", "[]");
		Debug.Log("Notifications to discard: " + @string);
		object obj = Json.Deserialize(@string);
		List<object> list = obj as List<object>;
		if (list != null)
		{
			foreach (object item in list)
			{
				int notificationId = Convert.ToInt32(item);
				EtceteraAndroid.cancelNotification(notificationId);
			}
			PlayerPrefs.DeleteKey("Scheduled Notifications");
		}
		else if (!Application.isEditor)
		{
			Debug.LogWarning("scheduledNotifications == null    " + obj.GetType());
		}
		Save.SaveString("appStopTime", string.Empty);
	}

	private void OnApplicationPause(bool pauseStatus)
	{
		if (pauseStatus)
		{
			appStop();
			return;
		}
		appStart();
		Tools.AddSessionNumber();
	}
}
