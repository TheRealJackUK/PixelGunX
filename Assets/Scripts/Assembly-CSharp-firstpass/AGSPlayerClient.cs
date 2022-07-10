using System;
using System.Collections.Generic;
using UnityEngine;

public class AGSPlayerClient : MonoBehaviour
{
	private static AmazonJavaWrapper JavaObject;

	private static readonly string PROXY_CLASS_NAME;

	public static event Action<AGSRequestPlayerResponse> RequestLocalPlayerCompleted;

	public static event Action<AGSRequestFriendIdsResponse> RequestFriendIdsCompleted;

	public static event Action<AGSRequestBatchFriendsResponse> RequestBatchFriendsCompleted;

	public static event Action<bool> OnSignedInStateChangedEvent;

	[Obsolete("PlayerReceivedEvent is deprecated. Use RequestLocalPlayerCompleted instead.")]
	public static event Action<AGSPlayer> PlayerReceivedEvent;

	[Obsolete("PlayerFailedEvent is deprecated. Use RequestLocalPlayerCompleted instead.")]
	public static event Action<string> PlayerFailedEvent;

	static AGSPlayerClient()
	{
		PROXY_CLASS_NAME = "com.amazon.ags.api.unity.PlayerClientProxyImpl";
		JavaObject = new AmazonJavaWrapper();
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass(PROXY_CLASS_NAME))
		{
			if (androidJavaClass.GetRawClass() == IntPtr.Zero)
			{
				AGSClient.LogGameCircleWarning("No java class " + PROXY_CLASS_NAME + " present, can't use AGSPlayerClient");
			}
			else
			{
				JavaObject.setAndroidJavaObject(androidJavaClass.CallStatic<AndroidJavaObject>("getInstance", new object[0]));
			}
		}
	}

	public static void RequestLocalPlayer(int userData = 0)
	{
		JavaObject.Call("requestLocalPlayer", userData);
	}

	public static void RequestFriendIds(int userData = 0)
	{
		JavaObject.Call("requestLocalPlayerFriends", userData);
	}

	public static void RequestBatchFriends(List<string> friendIds, int userData = 0)
	{
		string text = MiniJSON.jsonEncode(friendIds.ToArray());
		JavaObject.Call("requestBatchFriends", text, userData);
	}

	public static void LocalPlayerFriendsComplete(string json)
	{
		if (AGSPlayerClient.RequestFriendIdsCompleted != null)
		{
			AGSPlayerClient.RequestFriendIdsCompleted(AGSRequestFriendIdsResponse.FromJSON(json));
		}
	}

	public static void BatchFriendsRequestComplete(string json)
	{
		if (AGSPlayerClient.RequestBatchFriendsCompleted != null)
		{
			AGSPlayerClient.RequestBatchFriendsCompleted(AGSRequestBatchFriendsResponse.FromJSON(json));
		}
	}

	public static void PlayerReceived(string json)
	{
		AGSRequestPlayerResponse aGSRequestPlayerResponse = AGSRequestPlayerResponse.FromJSON(json);
		if (!aGSRequestPlayerResponse.IsError() && AGSPlayerClient.PlayerReceivedEvent != null)
		{
			AGSPlayerClient.PlayerReceivedEvent(aGSRequestPlayerResponse.player);
		}
		if (AGSPlayerClient.RequestLocalPlayerCompleted != null)
		{
			AGSPlayerClient.RequestLocalPlayerCompleted(aGSRequestPlayerResponse);
		}
	}

	public static void PlayerFailed(string json)
	{
		AGSRequestPlayerResponse aGSRequestPlayerResponse = AGSRequestPlayerResponse.FromJSON(json);
		if (aGSRequestPlayerResponse.IsError() && AGSPlayerClient.PlayerFailedEvent != null)
		{
			AGSPlayerClient.PlayerFailedEvent(aGSRequestPlayerResponse.error);
		}
		if (AGSPlayerClient.RequestLocalPlayerCompleted != null)
		{
			AGSPlayerClient.RequestLocalPlayerCompleted(aGSRequestPlayerResponse);
		}
	}

	public static bool IsSignedIn()
	{
		return JavaObject.Call<bool>("isSignedIn", new object[0]);
	}

	public static void OnSignedInStateChanged(bool isSignedIn)
	{
		if (AGSPlayerClient.OnSignedInStateChangedEvent != null)
		{
			AGSPlayerClient.OnSignedInStateChangedEvent(isSignedIn);
		}
	}
}
