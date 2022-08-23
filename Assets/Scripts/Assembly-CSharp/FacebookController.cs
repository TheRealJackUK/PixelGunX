using System;
using System.Collections;
using System.Collections.Generic;
using Prime31;
using UnityEngine;

public class FacebookController : MonoBehaviour
{
	public static FacebookController sharedController;

	public string selfID = string.Empty;

	private Action<string, object> handlerForPost;

	private bool hasPublishPermission;

	private bool hasPublishActions;

	private bool isGetPermitionFromSendMessage;

	private string postMessage;

	private int totalFriends;

	private int loadedAvatars;

	public List<Friend> friendsList;

	private float showMessageTimer;

	private string message;

	private string titleInvite = "Invite a Friend to Play!";

	private string messageInvite = "Join me in playing a new game!";

	private string _appId = string.Empty;

	private string _redirectUrl = string.Empty;

	private string _appSecret = string.Empty;

	public string AppId
	{
		get
		{
			return _appId;
		}
		set
		{
			_appId = value ?? string.Empty;
		}
	}

	public string RedirectUrl
	{
		get
		{
			return _redirectUrl;
		}
		set
		{
			_redirectUrl = value ?? string.Empty;
		}
	}

	public string AppSecret
	{
		get
		{
			return _appSecret;
		}
		set
		{
			_appSecret = value ?? string.Empty;
		}
	}

	public static event Action<string> PostCompleted;

	public static event Action<string> ReceivedSelfID;

	private void Awake()
	{
		friendsList = new List<Friend>();
	}

	private void Start()
	{
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		sharedController = this;
		InitFacebook();
	}

	public static void LogEvent(string eventName, Dictionary<string, object> parameters = null)
	{
		//FacebookAndroid.logEvent(eventName, parameters);
	}

	public static void ShowPostDialog()
	{
		PlayerPrefs.SetInt("PostFacebookCount", PlayerPrefs.GetInt("PostFacebookCount", 0));
		PlayerPrefs.Save();
		if (PlayerPrefs.GetInt("Active_loyal_users_payed_send", 0) == 0 && PlayerPrefs.GetInt("PostFacebookCount", 0) > 2 && StoreKitEventListener.GetDollarsSpent() > 0 && PlayerPrefs.GetInt("PostVideo", 0) > 0)
		{
			LogEvent("Active_loyal_users_payed");
			PlayerPrefs.SetInt("Active_loyal_users_payed_send", 1);
		}
		if (PlayerPrefs.GetInt("Active_loyal_users_send", 0) == 0 && PlayerPrefs.GetInt("PostFacebookCount", 0) > 2 && PlayerPrefs.GetInt("PostVideo", 0) > 0)
		{
			LogEvent("Active_loyal_users");
			PlayerPrefs.SetInt("Active_loyal_users_send", 1);
		}
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		dictionary.Add("link", Defs2.ApplicationUrl);
		dictionary.Add("name", "Pixel Gun 3D");
		dictionary.Add("picture", "http://pixelgun3d.com/iconforpost.png");
		dictionary.Add("caption", "I've just played the super battle in Pixel Gun 3D :)");
		dictionary.Add("description", "DOWNLOAD IT FOR FREE AND JOIN ME NOW!");
		Dictionary<string, object> parameters = dictionary;
		//FacebookAndroid.showFacebookShareDialog(parameters);
	}

	public void PostMessage(string _message, Action<string, object> _completionHandler)
	{
		Debug.Log("Post to Facebook");
		//Facebook.instance.postMessage(_message, _completionHandler);
		//hasPublishActions = GetSessionPermissions().Contains("publish_actions");
		if (hasPublishActions)
		{
			//Facebook.instance.postMessage(_message, _completionHandler);
			return;
		}
		Debug.Log("Get permissions for post");
		isGetPermitionFromSendMessage = true;
		postMessage = _message;
		handlerForPost = _completionHandler;
		if (!IsSessionValid())
		{
			Debug.Log("!IsSessionValid");
			string[] permissions = new string[1] { "email" };
			LoginWithReadPermissions(permissions);
		}
		else
		{
			Debug.Log("Post hasPublishActions=false");
			string[] permissions2 = new string[2] { "publish_actions", "publish_stream" };
			ReauthorizeWithPublishPermissions(permissions2, FacebookSessionDefaultAudience.Everyone);
		}
	}

	public void SetMyId()
	{
		Debug.Log("SetMyId Run");
	}

	public string GetMyId()
	{
		return selfID;
	}

	private void InitFacebook()
	{
		//FacebookAndroid.init(true);
		FacebookManager.graphRequestCompletedEvent += delegate(object result)
		{
			Utils.logObject(result);
		};
		FacebookManager.sessionOpenedEvent += delegate
		{
			//List<object> sessionPermissions2 = GetSessionPermissions();
			//hasPublishPermission = sessionPermissions2.Contains("publish_stream");
			//hasPublishActions = sessionPermissions2.Contains("publish_actions");
		};
		FacebookManager.reauthorizationSucceededEvent += delegate
		{
			//List<object> sessionPermissions = GetSessionPermissions();
			//hasPublishPermission = sessionPermissions.Contains("publish_stream");
			//hasPublishActions = sessionPermissions.Contains("publish_actions");
		};
	}

	private void completionHandler(string error, object result)
	{
		if (error != null)
		{
			Debug.LogError("completion error: " + error);
			Utils.logObject(result);
		}
		else
		{
			Debug.Log("messagesPostSuccess");
			Utils.logObject(result);
		}
	}

	public IEnumerator GetPlaingFriends()
	{
		float elapsedTime = 0f;
		Debug.Log("Get Playing Friends");
		if (!IsSessionValid())
		{
			Debug.Log("!IsSessionValid");
			string[] permissions2 = new string[1] { "email" };
			LoginWithReadPermissions(permissions2);
		}
		else if (hasPublishPermission)
		{
			if (selfID == string.Empty)
			{
			
				while (selfID == string.Empty)
				{
					elapsedTime += Time.deltaTime;
					if (elapsedTime >= 35f)
					{
						break;
					}
					yield return null;
				}
				if (selfID == string.Empty)
				{
					Debug.Log("Error geting self ID: Time is out!");
					StopCoroutine("GetPlaingFriends");
					yield break;
				}
			}
			loadedAvatars = 0;
			Dictionary<string, object> parameters = new Dictionary<string, object> { { "q", "SELECT uid,name,is_app_user,pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=me())" } };
		}
		else
		{
			Debug.Log("get permissions");
			string[] permissions = new string[2] { "publish_actions", "publish_stream" };
			ReauthorizeWithPublishPermissions(permissions, FacebookSessionDefaultAudience.Everyone);
		}
	}

	public void InputFacebookFriends()
	{
		if (!IsSessionValid())
		{
			string[] permissions = new string[1] { "email" };
			LoginWithReadPermissions(permissions);
		}
		else
		{
			//FacebookAndroid.logout();
			string[] permissions2 = new string[1] { "email" };
			LoginWithReadPermissions(permissions2);
		}
	}

	public void InvitePlayer()
	{
		if (!IsSessionValid())
		{
			Debug.Log("!IsSessionValid");
			string[] permissions = new string[1] { "email" };
			LoginWithReadPermissions(permissions);
			return;
		}
		Debug.Log("IsSessionValid hasPublishPermission=" + hasPublishPermission);
		if (hasPublishPermission)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary["message"] = messageInvite;
			dictionary["title"] = titleInvite;
			//FacebookAndroid.showDialog("apprequests", dictionary);
		}
		else
		{
			Debug.Log("get permissions");
			string[] permissions2 = new string[2] { "publish_actions", "publish_stream" };
			ReauthorizeWithPublishPermissions(permissions2, FacebookSessionDefaultAudience.Everyone);
		}
	}

	private IEnumerator LoadAvatar(int userCount, string url)
	{
		WWW www = new WWW(url);
		yield return www;
		float elapsedTime = 0f;
		while (!www.isDone)
		{
			elapsedTime += Time.deltaTime;
			if (elapsedTime >= 4f)
			{
				break;
			}
			yield return null;
		}
		friendsList[userCount].SetAvatar(www.texture);
		Debug.Log("Added avatar to friend : " + friendsList[userCount].name);
	}

	private void OnEnable()
	{
		FacebookManager.preLoginSucceededEvent += OnEventFacebookLoginSucceededEvent;
		FacebookManager.loginFailedEvent += OnEventFacebookLoginFailed;
		FacebookManager.sessionOpenedEvent += OnEventFacebookSessionOpened;
		FacebookManager.reauthorizationSucceededEvent += FacebookReauthorizationSucceededEvent;
		FacebookManager.reauthorizationFailedEvent += FacebookReauthorizationFailedEvent;
	}

	private void OnDisable()
	{
		FacebookManager.preLoginSucceededEvent -= OnEventFacebookLoginSucceededEvent;
		FacebookManager.loginFailedEvent -= OnEventFacebookLoginFailed;
		FacebookManager.sessionOpenedEvent -= OnEventFacebookSessionOpened;
		FacebookManager.reauthorizationSucceededEvent -= FacebookReauthorizationSucceededEvent;
		FacebookManager.reauthorizationFailedEvent -= FacebookReauthorizationFailedEvent;
	}

	public bool IsSessionValid()
	{
		//return FacebookAndroid.isSessionValid();
		return false;
	}

	public void LoginWithReadPermissions(string[] permissions)
	{
		//FacebookAndroid.loginWithReadPermissions(permissions);
	}

	public void ReauthorizeWithPublishPermissions(string[] permissions, FacebookSessionDefaultAudience defaultAudience)
	{
		Debug.Log("ReauthorizeWithPublishPermissions: " + permissions);
		//FacebookAndroid.reauthorizeWithPublishPermissions(permissions, defaultAudience);
		Debug.Log("end ");
	}

	public List<object> GetSessionPermissions()
	{
		//return FacebookAndroid.getSessionPermissions();
		return null;
	}

	private void OnEventFacebookSessionOpened()
	{
		//List<object> sessionPermissions = GetSessionPermissions();
		//hasPublishPermission = sessionPermissions.Contains("publish_stream");
		//hasPublishActions = sessionPermissions.Contains("publish_actions");
		Debug.Log("OnEventFacebookSessionOpened hasPublishPermission=" + hasPublishActions);
		SetMyId();
	}

	private void OnEventFacebookLoginSucceededEvent()
	{
		Debug.Log(" OnEventFacebookLoginSucceededEvent");
	}

	private void OnEventFacebookLoginFailed(P31Error error)
	{
		Debug.Log("OnEventFacebookLoginFailed=" + error);
	}

	private void FacebookReauthorizationSucceededEvent()
	{
		Debug.Log(" FacebookReauthorizationSucceededEvent");
		if (isGetPermitionFromSendMessage)
		{
			isGetPermitionFromSendMessage = false;
			PostMessage(postMessage, handlerForPost);
		}
		//hasPublishPermission = GetSessionPermissions().Contains("publish_stream");
		Debug.Log("FacebookReauthorizationSucceededEvent hasPublishPermission=" + hasPublishPermission);
		if (hasPublishPermission)
		{
			SetMyId();
		}
	}

	private void FacebookReauthorizationFailedEvent(P31Error error)
	{
		Debug.Log("FacebookReauthorizationFailedEvent=" + error);
	}

	private void FacebookGraphRequestCompletedEvent()
	{
		Debug.Log("FacebookGraphRequestCompletedEvent");
	}

	private void FacebookGraphRequestFailedEvent(P31Error error)
	{
		Debug.Log("FacebookGraphRequestFailedEvent=" + error);
	}
}
