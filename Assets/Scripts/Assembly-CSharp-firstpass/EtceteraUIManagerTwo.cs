using Prime31;
using UnityEngine;

public class EtceteraUIManagerTwo : MonoBehaviourGUI
{
	private int _fiveSecondNotificationId;

	private int _tenSecondNotificationId;

	private void OnGUI()
	{
		beginColumn();
		if (GUILayout.Button("Show Inline Web View"))
		{
			EtceteraAndroid.inlineWebViewShow("http://prime31.com/", 160, 430, Screen.width - 160, Screen.height - 100);
		}
		if (GUILayout.Button("Close Inline Web View"))
		{
			EtceteraAndroid.inlineWebViewClose();
		}
		if (GUILayout.Button("Set Url of Inline Web View"))
		{
			EtceteraAndroid.inlineWebViewSetUrl("http://google.com");
		}
		if (GUILayout.Button("Set Frame of Inline Web View"))
		{
			EtceteraAndroid.inlineWebViewSetFrame(80, 50, 300, 400);
		}
		if (GUILayout.Button("Get First 25 Contacts"))
		{
			EtceteraAndroid.loadContacts(0, 25);
		}
		endColumn(true);
		if (GUILayout.Button("Schedule Notification in 5 Seconds"))
		{
			_fiveSecondNotificationId = EtceteraAndroid.scheduleNotification(5L, "Notification Title - 5 Seconds", "The subtitle of the notification", "Ticker text gets ticked", "five-second-note");
			Debug.Log("notificationId: " + _fiveSecondNotificationId);
		}
		if (GUILayout.Button("Schedule Notification in 10 Seconds"))
		{
			_tenSecondNotificationId = EtceteraAndroid.scheduleNotification(10L, "Notiifcation Title - 10 Seconds", "The subtitle of the notification", "Ticker text gets ticked", "ten-second-note");
			Debug.Log("notificationId: " + _tenSecondNotificationId);
		}
		if (GUILayout.Button("Cancel 5 Second Notification"))
		{
			EtceteraAndroid.cancelNotification(_fiveSecondNotificationId);
		}
		if (GUILayout.Button("Cancel 10 Second Notification"))
		{
			EtceteraAndroid.cancelNotification(_tenSecondNotificationId);
		}
		if (GUILayout.Button("Check for Notifications"))
		{
			EtceteraAndroid.checkForNotifications();
		}
		if (GUILayout.Button("Cancel All Notifications"))
		{
			EtceteraAndroid.cancelAllNotifications();
		}
		if (GUILayout.Button("Quit App"))
		{
			Application.Quit();
		}
		endColumn();
		if (bottomRightButton("Previous Scene"))
		{
			Application.LoadLevel("EtceteraTestScene");
		}
	}
}
