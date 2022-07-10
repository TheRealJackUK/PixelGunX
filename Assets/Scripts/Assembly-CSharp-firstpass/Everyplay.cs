using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using EveryplayMiniJSON;
using UnityEngine;

public class Everyplay : MonoBehaviour
{
	public enum FaceCamPreviewOrigin
	{
		TopLeft,
		TopRight,
		BottomLeft,
		BottomRight
	}

	public enum UserInterfaceIdiom
	{
		Phone = 0,
		Tablet = 1,
		iPhone = 0,
		iPad = 1
	}

	public delegate void WasClosedDelegate();

	public delegate void ReadyForRecordingDelegate(bool enabled);

	public delegate void RecordingStartedDelegate();

	public delegate void RecordingStoppedDelegate();

	public delegate void FaceCamSessionStartedDelegate();

	public delegate void FaceCamRecordingPermissionDelegate(bool granted);

	public delegate void FaceCamSessionStoppedDelegate();

	public delegate void ThumbnailReadyAtFilePathDelegate(string filePath);

	[Obsolete("Use ThumbnailTextureReadyDelegate(Texture2D texture,bool portrait) instead.")]
	public delegate void ThumbnailReadyAtTextureIdDelegate(int textureId, bool portrait);

	public delegate void ThumbnailTextureReadyDelegate(Texture2D texture, bool portrait);

	public delegate void UploadDidStartDelegate(int videoId);

	public delegate void UploadDidProgressDelegate(int videoId, float progress);

	public delegate void UploadDidCompleteDelegate(int videoId);

	public delegate void ThumbnailLoadReadyDelegate(Texture2D texture);

	public delegate void ThumbnailLoadFailedDelegate(string error);

	public delegate void RequestReadyDelegate(string response);

	public delegate void RequestFailedDelegate(string error);

	private static string clientId;

	private static bool appIsClosing;

	private static EveryplayLegacy everyplayLegacy;

	private static Everyplay everyplayInstance;

	private static Texture2D currentThumbnailTargetTexture;

	private static AndroidJavaObject everyplayUnity;

	[Obsolete("Calling Everyplay with SharedInstance is deprecated, you may remove SharedInstance.")]
	public static EveryplayLegacy SharedInstance
	{
		get
		{
			if (EveryplayInstance != null && everyplayLegacy == null)
			{
				everyplayLegacy = everyplayInstance.gameObject.AddComponent<EveryplayLegacy>();
			}
			return everyplayLegacy;
		}
	}

	private static Everyplay EveryplayInstance
	{
		get
		{
			if (Application.platform == RuntimePlatform.IPhonePlayer)
			{
				return null;
			}
			if (everyplayInstance == null && !appIsClosing)
			{
				EveryplaySettings everyplaySettings = (EveryplaySettings)Resources.Load("EveryplaySettings");
				if (everyplaySettings != null && everyplaySettings.IsEnabled)
				{
					GameObject gameObject = new GameObject("Everyplay");
					if (gameObject != null)
					{
						everyplayInstance = gameObject.AddComponent<Everyplay>();
						if (everyplayInstance != null)
						{
							clientId = everyplaySettings.clientId;
							InitEveryplay(everyplaySettings.clientId, everyplaySettings.clientSecret, everyplaySettings.redirectURI);
							if (everyplaySettings.testButtonsEnabled)
							{
								AddTestButtons(gameObject);
							}
							UnityEngine.Object.DontDestroyOnLoad(gameObject);
						}
					}
				}
			}
			return everyplayInstance;
		}
	}

	public static event WasClosedDelegate WasClosed;

	public static event ReadyForRecordingDelegate ReadyForRecording;

	public static event RecordingStartedDelegate RecordingStarted;

	public static event RecordingStoppedDelegate RecordingStopped;

	public static event FaceCamSessionStartedDelegate FaceCamSessionStarted;

	public static event FaceCamRecordingPermissionDelegate FaceCamRecordingPermission;

	public static event FaceCamSessionStoppedDelegate FaceCamSessionStopped;

	public static event ThumbnailReadyAtFilePathDelegate ThumbnailReadyAtFilePath;

	[Obsolete("Use ThumbnailTextureReady instead.")]
	public static event ThumbnailReadyAtTextureIdDelegate ThumbnailReadyAtTextureId;

	public static event ThumbnailTextureReadyDelegate ThumbnailTextureReady;

	public static event UploadDidStartDelegate UploadDidStart;

	public static event UploadDidProgressDelegate UploadDidProgress;

	public static event UploadDidCompleteDelegate UploadDidComplete;

	public static void Initialize()
	{
		if (EveryplayInstance == null)
		{
			Debug.Log("Unable to initialize Everyplay. Everyplay might be disabled for this platform or the app is closing.");
		}
	}

	public static void Show()
	{
		if (EveryplayInstance != null)
		{
			EveryplayShow();
		}
	}

	public static void ShowWithPath(string path)
	{
		if (EveryplayInstance != null)
		{
			EveryplayShowWithPath(path);
		}
	}

	public static void PlayVideoWithURL(string url)
	{
		if (EveryplayInstance != null)
		{
			EveryplayPlayVideoWithURL(url);
		}
	}

	public static void PlayVideoWithDictionary(Dictionary<string, object> dict)
	{
		if (EveryplayInstance != null)
		{
			EveryplayPlayVideoWithDictionary(Json.Serialize(dict));
		}
	}

	public static void MakeRequest(string method, string url, Dictionary<string, object> data, RequestReadyDelegate readyDelegate, RequestFailedDelegate failedDelegate)
	{
		if (EveryplayInstance != null)
		{
			EveryplayInstance.AsyncMakeRequest(method, url, data, readyDelegate, failedDelegate);
		}
	}

	public static string AccessToken()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayAccountAccessToken();
		}
		return null;
	}

	public static void ShowSharingModal()
	{
		if (EveryplayInstance != null)
		{
			EveryplayShowSharingModal();
		}
	}

	public static void StartRecording()
	{
		if (EveryplayInstance != null)
		{
			EveryplayStartRecording();
		}
	}

	public static void StopRecording()
	{
		if (EveryplayInstance != null)
		{
			EveryplayStopRecording();
		}
	}

	public static void PauseRecording()
	{
		if (EveryplayInstance != null)
		{
			EveryplayPauseRecording();
		}
	}

	public static void ResumeRecording()
	{
		if (EveryplayInstance != null)
		{
			EveryplayResumeRecording();
		}
	}

	public static bool IsRecording()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayIsRecording();
		}
		return false;
	}

	public static bool IsRecordingSupported()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayIsRecordingSupported();
		}
		return false;
	}

	public static bool IsPaused()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayIsPaused();
		}
		return false;
	}

	public static bool SnapshotRenderbuffer()
	{
		if (EveryplayInstance != null)
		{
			return EveryplaySnapshotRenderbuffer();
		}
		return false;
	}

	public static bool IsSupported()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayIsSupported();
		}
		return false;
	}

	public static bool IsSingleCoreDevice()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayIsSingleCoreDevice();
		}
		return false;
	}

	public static int GetUserInterfaceIdiom()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayGetUserInterfaceIdiom();
		}
		return 0;
	}

	public static void PlayLastRecording()
	{
		if (EveryplayInstance != null)
		{
			EveryplayPlayLastRecording();
		}
	}

	public static void SetMetadata(string key, object val)
	{
		if (EveryplayInstance != null && key != null && val != null)
		{
			Dictionary<string, object> dictionary = new Dictionary<string, object>();
			dictionary.Add(key, val);
			EveryplaySetMetadata(Json.Serialize(dictionary));
		}
	}

	public static void SetMetadata(Dictionary<string, object> dict)
	{
		if (EveryplayInstance != null && dict != null && dict.Count > 0)
		{
			EveryplaySetMetadata(Json.Serialize(dict));
		}
	}

	public static void SetTargetFPS(int fps)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetTargetFPS(fps);
		}
	}

	public static void SetMotionFactor(int factor)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetMotionFactor(factor);
		}
	}

	public static void SetMaxRecordingMinutesLength(int minutes)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetMaxRecordingMinutesLength(minutes);
		}
	}

	public static void SetLowMemoryDevice(bool state)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetLowMemoryDevice(state);
		}
	}

	public static void SetDisableSingleCoreDevices(bool state)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetDisableSingleCoreDevices(state);
		}
	}

	public static void LoadThumbnailFromFilePath(string filePath, ThumbnailLoadReadyDelegate readyDelegate, ThumbnailLoadFailedDelegate failedDelegate)
	{
		if (EveryplayInstance != null)
		{
			EveryplayInstance.AsyncLoadThumbnailFromFilePath(filePath, readyDelegate, failedDelegate);
		}
	}

	public static bool FaceCamIsVideoRecordingSupported()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayFaceCamIsVideoRecordingSupported();
		}
		return false;
	}

	public static bool FaceCamIsAudioRecordingSupported()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayFaceCamIsAudioRecordingSupported();
		}
		return false;
	}

	public static bool FaceCamIsHeadphonesPluggedIn()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayFaceCamIsHeadphonesPluggedIn();
		}
		return false;
	}

	public static bool FaceCamIsSessionRunning()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayFaceCamIsSessionRunning();
		}
		return false;
	}

	public static bool FaceCamIsRecordingPermissionGranted()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayFaceCamIsRecordingPermissionGranted();
		}
		return false;
	}

	public static float FaceCamAudioPeakLevel()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayFaceCamAudioPeakLevel();
		}
		return 0f;
	}

	public static float FaceCamAudioPowerLevel()
	{
		if (EveryplayInstance != null)
		{
			return EveryplayFaceCamAudioPowerLevel();
		}
		return 0f;
	}

	public static void FaceCamSetMonitorAudioLevels(bool enabled)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetMonitorAudioLevels(enabled);
		}
	}

	public static void FaceCamSetAudioOnly(bool audioOnly)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetAudioOnly(audioOnly);
		}
	}

	public static void FaceCamSetPreviewVisible(bool visible)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetPreviewVisible(visible);
		}
	}

	public static void FaceCamSetPreviewScaleRetina(bool autoScale)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetPreviewScaleRetina(autoScale);
		}
	}

	public static void FaceCamSetPreviewSideWidth(int width)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetPreviewSideWidth(width);
		}
	}

	public static void FaceCamSetPreviewBorderWidth(int width)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetPreviewBorderWidth(width);
		}
	}

	public static void FaceCamSetPreviewPositionX(int x)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetPreviewPositionX(x);
		}
	}

	public static void FaceCamSetPreviewPositionY(int y)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetPreviewPositionY(y);
		}
	}

	public static void FaceCamSetPreviewBorderColor(float r, float g, float b, float a)
	{
		if (!(EveryplayInstance != null))
		{
		}
	}

	public static void FaceCamSetPreviewOrigin(FaceCamPreviewOrigin origin)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetPreviewOrigin((int)origin);
		}
	}

	public static void SetThumbnailWidth(int thumbnailWidth)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetThumbnailWidth(thumbnailWidth);
		}
	}

	public static void FaceCamSetTargetTexture(Texture2D texture)
	{
		if (EveryplayInstance != null)
		{
			if (texture != null)
			{
				EveryplayFaceCamSetTargetTextureId(texture.GetNativeTextureID());
				EveryplayFaceCamSetTargetTextureWidth(texture.width);
				EveryplayFaceCamSetTargetTextureHeight(texture.height);
			}
			else
			{
				EveryplayFaceCamSetTargetTextureId(0);
			}
		}
	}

	[Obsolete("Use FaceCamSetTargetTexture(Texture2D texture) instead.")]
	public static void FaceCamSetTargetTextureId(int textureId)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetTargetTextureId(textureId);
		}
	}

	[Obsolete("Defining texture width is no longer required when FaceCamSetTargetTexture(Texture2D texture) is used.")]
	public static void FaceCamSetTargetTextureWidth(int textureWidth)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetTargetTextureWidth(textureWidth);
		}
	}

	[Obsolete("Defining texture height is no longer required when FaceCamSetTargetTexture(Texture2D texture) is used.")]
	public static void FaceCamSetTargetTextureHeight(int textureHeight)
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamSetTargetTextureHeight(textureHeight);
		}
	}

	public static void FaceCamStartSession()
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamStartSession();
		}
	}

	public static void FaceCamRequestRecordingPermission()
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamRequestRecordingPermission();
		}
	}

	public static void FaceCamStopSession()
	{
		if (EveryplayInstance != null)
		{
			EveryplayFaceCamStopSession();
		}
	}

	public static void SetThumbnailTargetTexture(Texture2D texture)
	{
		if (EveryplayInstance != null)
		{
			currentThumbnailTargetTexture = texture;
			if (texture != null)
			{
				EveryplaySetThumbnailTargetTextureId(currentThumbnailTargetTexture.GetNativeTextureID());
				EveryplaySetThumbnailTargetTextureWidth(currentThumbnailTargetTexture.width);
				EveryplaySetThumbnailTargetTextureHeight(currentThumbnailTargetTexture.height);
			}
			else
			{
				EveryplaySetThumbnailTargetTextureId(0);
			}
		}
	}

	[Obsolete("Use SetThumbnailTargetTexture(Texture2D texture) instead.")]
	public static void SetThumbnailTargetTextureId(int textureId)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetThumbnailTargetTextureId(textureId);
		}
	}

	[Obsolete("Defining texture width is no longer required when SetThumbnailTargetTexture(Texture2D texture) is used.")]
	public static void SetThumbnailTargetTextureWidth(int textureWidth)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetThumbnailTargetTextureWidth(textureWidth);
		}
	}

	[Obsolete("Defining texture height is no longer required when SetThumbnailTargetTexture(Texture2D texture) is used.")]
	public static void SetThumbnailTargetTextureHeight(int textureHeight)
	{
		if (EveryplayInstance != null)
		{
			EveryplaySetThumbnailTargetTextureHeight(textureHeight);
		}
	}

	public static void TakeThumbnail()
	{
		if (EveryplayInstance != null)
		{
			EveryplayTakeThumbnail();
		}
	}

	private static void RemoveAllEventHandlers()
	{
		Everyplay.WasClosed = null;
		Everyplay.ReadyForRecording = null;
		Everyplay.RecordingStarted = null;
		Everyplay.RecordingStopped = null;
		Everyplay.FaceCamSessionStarted = null;
		Everyplay.FaceCamRecordingPermission = null;
		Everyplay.FaceCamSessionStopped = null;
		Everyplay.ThumbnailReadyAtFilePath = null;
		Everyplay.ThumbnailReadyAtTextureId = null;
		Everyplay.ThumbnailTextureReady = null;
		Everyplay.UploadDidStart = null;
		Everyplay.UploadDidProgress = null;
		Everyplay.UploadDidComplete = null;
	}

	private static void AddTestButtons(GameObject gameObject)
	{
		Texture2D texture2D = (Texture2D)Resources.Load("everyplay-test-buttons", typeof(Texture2D));
		if (texture2D != null)
		{
			EveryplayRecButtons everyplayRecButtons = gameObject.AddComponent<EveryplayRecButtons>();
			if (everyplayRecButtons != null)
			{
				everyplayRecButtons.atlasTexture = texture2D;
			}
		}
	}

	private void AsyncLoadThumbnailFromFilePath(string filePath, ThumbnailLoadReadyDelegate readyDelegateMethod, ThumbnailLoadFailedDelegate failedDelegateMethod)
	{
		if (filePath != null)
		{
			StartCoroutine(LoadThumbnailEnumerator(filePath, readyDelegateMethod, failedDelegateMethod));
		}
		else
		{
			failedDelegateMethod("Everyplay error: Thumbnail is not ready.");
		}
	}

	private IEnumerator LoadThumbnailEnumerator(string fileName, ThumbnailLoadReadyDelegate readyDelegateMethod, ThumbnailLoadFailedDelegate failedDelegateMethod)
	{
		WWW www = new WWW("file://" + fileName);
		yield return www;
		if (!string.IsNullOrEmpty(www.error))
		{
			failedDelegateMethod("Everyplay error: " + www.error);
		}
		else if ((bool)www.texture)
		{
			readyDelegateMethod(www.texture);
		}
		else
		{
			failedDelegateMethod("Everyplay error: Loading thumbnail failed.");
		}
	}

	private void AsyncMakeRequest(string method, string url, Dictionary<string, object> data, RequestReadyDelegate readyDelegate, RequestFailedDelegate failedDelegate)
	{
		StartCoroutine(MakeRequestEnumerator(method, url, data, readyDelegate, failedDelegate));
	}

	private IEnumerator MakeRequestEnumerator(string method, string url, Dictionary<string, object> data, RequestReadyDelegate readyDelegate, RequestFailedDelegate failedDelegate)
	{
		if (data == null)
		{
			data = new Dictionary<string, object>();
		}
		if (url.IndexOf("http") != 0)
		{
			if (url.IndexOf("/") != 0)
			{
				url = "/" + url;
			}
			url = "https://api.everyplay.com" + url;
		}
		method = method.ToLower();
		Dictionary<string, string> headers = new Dictionary<string, string>();
		string accessToken = AccessToken();
		if (accessToken != null)
		{
			headers["Authorization"] = "Bearer " + accessToken;
		}
		else if (url.IndexOf("client_id") == -1)
		{
			url = ((url.IndexOf("?") != -1) ? (url + "&") : (url + "?"));
			url = url + "client_id=" + clientId;
		}
		data.Add("_method", method);
		string dataString = Json.Serialize(data);
		byte[] dataArray = Encoding.UTF8.GetBytes(dataString);
		headers["Accept"] = "application/json";
		headers["Content-Type"] = "application/json";
		headers["Data-Type"] = "json";
		headers["Content-Length"] = dataArray.Length.ToString();
		WWW www = new WWW(url, dataArray, headers);
		yield return www;
		if (!string.IsNullOrEmpty(www.error) && failedDelegate != null)
		{
			failedDelegate("Everyplay error: " + www.error);
		}
		else if (string.IsNullOrEmpty(www.error) && readyDelegate != null)
		{
			readyDelegate(www.text);
		}
	}

	private void OnApplicationQuit()
	{
		if (currentThumbnailTargetTexture != null)
		{
			SetThumbnailTargetTexture(null);
			currentThumbnailTargetTexture = null;
		}
		RemoveAllEventHandlers();
		appIsClosing = true;
		everyplayInstance = null;
	}

	private void EveryplayHidden(string msg)
	{
		if (Everyplay.WasClosed != null)
		{
			Everyplay.WasClosed();
		}
	}

	private void EveryplayReadyForRecording(string jsonMsg)
	{
		if (Everyplay.ReadyForRecording != null)
		{
			Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
			bool value;
			if (dict.TryGetValue<bool>("enabled", out value))
			{
				Everyplay.ReadyForRecording(value);
			}
		}
	}

	private void EveryplayRecordingStarted(string msg)
	{
		if (Everyplay.RecordingStarted != null)
		{
			Everyplay.RecordingStarted();
		}
	}

	private void EveryplayRecordingStopped(string msg)
	{
		if (Everyplay.RecordingStopped != null)
		{
			Everyplay.RecordingStopped();
		}
	}

	private void EveryplayFaceCamSessionStarted(string msg)
	{
		if (Everyplay.FaceCamSessionStarted != null)
		{
			Everyplay.FaceCamSessionStarted();
		}
	}

	private void EveryplayFaceCamRecordingPermission(string jsonMsg)
	{
		if (Everyplay.FaceCamRecordingPermission != null)
		{
			Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
			bool value;
			if (dict.TryGetValue<bool>("granted", out value))
			{
				Everyplay.FaceCamRecordingPermission(value);
			}
		}
	}

	private void EveryplayFaceCamSessionStopped(string msg)
	{
		if (Everyplay.FaceCamSessionStopped != null)
		{
			Everyplay.FaceCamSessionStopped();
		}
	}

	private void EveryplayThumbnailReadyAtFilePath(string jsonMsg)
	{
		if (Everyplay.ThumbnailReadyAtFilePath != null)
		{
			Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
			string value;
			if (dict.TryGetValue<string>("thumbnailFilePath", out value))
			{
				Everyplay.ThumbnailReadyAtFilePath(value);
			}
		}
	}

	private void EveryplayThumbnailReadyAtTextureId(string jsonMsg)
	{
		if (Everyplay.ThumbnailReadyAtTextureId == null && Everyplay.ThumbnailTextureReady == null)
		{
			return;
		}
		Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
		int value;
		bool value2;
		if (dict.TryGetValue<int>("textureId", out value) && dict.TryGetValue<bool>("portrait", out value2))
		{
			if (Everyplay.ThumbnailReadyAtTextureId != null)
			{
				Everyplay.ThumbnailReadyAtTextureId(value, value2);
			}
			if (Everyplay.ThumbnailTextureReady != null && currentThumbnailTargetTexture != null && currentThumbnailTargetTexture.GetNativeTextureID() == value)
			{
				Everyplay.ThumbnailTextureReady(currentThumbnailTargetTexture, value2);
			}
		}
	}

	private void EveryplayThumbnailTextureReady(string jsonMsg)
	{
		if (Everyplay.ThumbnailTextureReady == null)
		{
			return;
		}
		Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
		long value;
		bool value2;
		if (currentThumbnailTargetTexture != null && dict.TryGetValue<long>("texturePtr", out value) && dict.TryGetValue<bool>("portrait", out value2))
		{
			long num = (long)currentThumbnailTargetTexture.GetNativeTexturePtr();
			if (num == value)
			{
				Everyplay.ThumbnailTextureReady(currentThumbnailTargetTexture, value2);
			}
		}
	}

	private void EveryplayUploadDidStart(string jsonMsg)
	{
		if (Everyplay.UploadDidStart != null)
		{
			Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
			int value;
			if (dict.TryGetValue<int>("videoId", out value))
			{
				Everyplay.UploadDidStart(value);
			}
		}
	}

	private void EveryplayUploadDidProgress(string jsonMsg)
	{
		if (Everyplay.UploadDidProgress != null)
		{
			Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
			int value;
			double value2;
			if (dict.TryGetValue<int>("videoId", out value) && dict.TryGetValue<double>("progress", out value2))
			{
				Everyplay.UploadDidProgress(value, (float)value2);
			}
		}
	}

	private void EveryplayUploadDidComplete(string jsonMsg)
	{
		if (Everyplay.UploadDidComplete != null)
		{
			Dictionary<string, object> dict = EveryplayDictionaryExtensions.JsonToDictionary(jsonMsg);
			int value;
			if (dict.TryGetValue<int>("videoId", out value))
			{
				Everyplay.UploadDidComplete(value);
			}
		}
	}

	public static void InitEveryplay(string clientId, string clientSecret, string redirectURI)
	{
		AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
		AndroidJavaObject @static = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
		everyplayUnity = new AndroidJavaObject("com.everyplay.Everyplay.unity.EveryplayUnity3DWrapper");
		everyplayUnity.Call("initEveryplay", @static, clientId, clientSecret, redirectURI);
	}

	public static void EveryplayShow()
	{
		everyplayUnity.Call<bool>("showEveryplay", new object[0]);
	}

	public static void EveryplayShowWithPath(string path)
	{
		everyplayUnity.Call<bool>("showEveryplay", new object[1] { path });
	}

	public static void EveryplayPlayVideoWithURL(string url)
	{
		everyplayUnity.Call("playVideoWithURL", url);
	}

	public static void EveryplayPlayVideoWithDictionary(string dic)
	{
		everyplayUnity.Call("playVideoWithDictionary", dic);
	}

	public static string EveryplayAccountAccessToken()
	{
		return everyplayUnity.Call<string>("getAccessToken", new object[0]);
	}

	public static void EveryplayShowSharingModal()
	{
		everyplayUnity.Call("showSharingModal");
	}

	public static void EveryplayStartRecording()
	{
		everyplayUnity.Call("startRecording");
	}

	public static void EveryplayStopRecording()
	{
		everyplayUnity.Call("stopRecording");
	}

	public static void EveryplayPauseRecording()
	{
		everyplayUnity.Call("pauseRecording");
	}

	public static void EveryplayResumeRecording()
	{
		everyplayUnity.Call("resumeRecording");
	}

	public static bool EveryplayIsRecording()
	{
		return everyplayUnity.Call<bool>("isRecording", new object[0]);
	}

	public static bool EveryplayIsRecordingSupported()
	{
		return everyplayUnity.Call<bool>("isRecordingSupported", new object[0]);
	}

	public static bool EveryplayIsPaused()
	{
		return everyplayUnity.Call<bool>("isPaused", new object[0]);
	}

	public static bool EveryplaySnapshotRenderbuffer()
	{
		return everyplayUnity.Call<bool>("snapshotRenderbuffer", new object[0]);
	}

	public static void EveryplayPlayLastRecording()
	{
		everyplayUnity.Call("playLastRecording");
	}

	public static void EveryplaySetMetadata(string json)
	{
		everyplayUnity.Call("setMetadata", json);
	}

	public static void EveryplaySetTargetFPS(int fps)
	{
		everyplayUnity.Call("setTargetFPS", fps);
	}

	public static void EveryplaySetMotionFactor(int factor)
	{
		everyplayUnity.Call("setMotionFactor", factor);
	}

	public static void EveryplaySetMaxRecordingMinutesLength(int minutes)
	{
		everyplayUnity.Call("setMaxRecordingMinutesLength", minutes);
	}

	public static void EveryplaySetLowMemoryDevice(bool state)
	{
		everyplayUnity.Call("setLowMemoryDevice", state ? 1 : 0);
	}

	public static void EveryplaySetDisableSingleCoreDevices(bool state)
	{
		everyplayUnity.Call("setDisableSingleCoreDevices", state ? 1 : 0);
	}

	public static bool EveryplayIsSupported()
	{
		return everyplayUnity.Call<bool>("isSupported", new object[0]);
	}

	public static bool EveryplayIsSingleCoreDevice()
	{
		return everyplayUnity.Call<bool>("isSingleCoreDevice", new object[0]);
	}

	public static int EveryplayGetUserInterfaceIdiom()
	{
		return everyplayUnity.Call<int>("getUserInterfaceIdiom", new object[0]);
	}

	public static bool EveryplayFaceCamIsVideoRecordingSupported()
	{
		return false;
	}

	public static bool EveryplayFaceCamIsAudioRecordingSupported()
	{
		return false;
	}

	public static bool EveryplayFaceCamIsHeadphonesPluggedIn()
	{
		return false;
	}

	public static bool EveryplayFaceCamIsSessionRunning()
	{
		return false;
	}

	public static bool EveryplayFaceCamIsRecordingPermissionGranted()
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
		return false;
	}

	public static float EveryplayFaceCamAudioPeakLevel()
	{
		return 0f;
	}

	public static float EveryplayFaceCamAudioPowerLevel()
	{
		return 0f;
	}

	public static void EveryplayFaceCamSetMonitorAudioLevels(bool enabled)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetAudioOnly(bool audioOnly)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewVisible(bool visible)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewScaleRetina(bool autoScale)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewSideWidth(int width)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewBorderWidth(int width)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewPositionX(int x)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewPositionY(int y)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewBorderColor(float r, float g, float b, float a)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetPreviewOrigin(int origin)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetTargetTextureId(int textureId)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetTargetTextureWidth(int textureHeight)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static void EveryplayFaceCamSetTargetTextureHeight(int textureWidth)
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static bool EveryplayFaceCamStartSession()
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
		return false;
	}

	public static void EveryplayFaceCamRequestRecordingPermission()
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
	}

	public static bool EveryplayFaceCamStopSession()
	{
		Debug.Log(MethodBase.GetCurrentMethod().Name + " not yet implemented");
		return false;
	}

	public static void EveryplaySetThumbnailWidth(int thumbnailWidth)
	{
		everyplayUnity.Call("setThumbnailWidth", thumbnailWidth);
	}

	public static void EveryplaySetThumbnailTargetTextureId(int textureId)
	{
		everyplayUnity.Call("setThumbnailTargetTextureId", textureId);
	}

	public static void EveryplaySetThumbnailTargetTextureWidth(int textureWidth)
	{
		everyplayUnity.Call("setThumbnailTargetTextureWidth", textureWidth);
	}

	public static void EveryplaySetThumbnailTargetTextureHeight(int textureHeight)
	{
		everyplayUnity.Call("setThumbnailTargetTextureHeight", textureHeight);
	}

	public static void EveryplayTakeThumbnail()
	{
		everyplayUnity.Call("takeThumbnail");
	}
}
