using System;
using System.Collections;
using System.Reflection;
using UnityEngine;

internal sealed class JoinRoomFromFrends : MonoBehaviour
{
	public int game_mode;

	public string room_name;

	public static JoinRoomFromFrends sharedJoinRoomFromFrends;

	public GameObject fon;

	public GameObject friendsPanel;

	public GameObject connectPanel;

	public static GameObject friendProfilePanel;

	public UILabel label;

	public GameObject plashkaLabel;

	private bool isFaledConnectToRoom;

	private bool oldActivFriendPanel;

	private bool oldActivProfileProfile;

	public UITexture fonConnectTexture;

	private string passwordRoom;

	public GameObject WrongPasswordLabel;

	private float timerShowWrongPassword;

	public GameObject PasswordPanel;

	private bool isBackFromPassword;

	public UIInput inputPassworLabel;

	private LoadingNGUIController _loadingNGUIController;

	private void Start()
	{
		sharedJoinRoomFromFrends = this;
	}

	private void OnDestroy()
	{
		sharedJoinRoomFromFrends = null;
	}

	public void BackFromPasswordButton()
	{
		isBackFromPassword = true;
		SetEnabledPasswordPanel(false);
		PhotonNetwork.Disconnect();
		Debug.Log("BackFromPasswordButton");
	}

	public void EnterPassword(string pass)
	{
		if (pass == passwordRoom)
		{
			PhotonNetwork.isMessageQueueRunning = false;
			StartCoroutine(MoveToGameScene());
			if (ActivityIndicator.sharedActivityIndicator != null)
			{
				ActivityIndicator.sharedActivityIndicator.SetActive(true);
			}
		}
		else
		{
			timerShowWrongPassword = 3f;
			WrongPasswordLabel.SetActive(true);
		}
	}

	private void ShowLoadingGUI(string _mapName)
	{
		_loadingNGUIController = (UnityEngine.Object.Instantiate(Resources.Load<GameObject>("LoadingGUI")) as GameObject).GetComponent<LoadingNGUIController>();
		_loadingNGUIController.SceneToLoad = _mapName;
		_loadingNGUIController.loadingNGUITexture.mainTexture = Resources.Load<Texture2D>("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading_" + _mapName);
		_loadingNGUIController.transform.parent = fonConnectTexture.transform.parent;
		_loadingNGUIController.transform.localPosition = Vector3.zero;
		_loadingNGUIController.Init();
	}

	private void RemoveLoadingGUI()
	{
		if (_loadingNGUIController != null)
		{
			UnityEngine.Object.Destroy(_loadingNGUIController.gameObject);
			_loadingNGUIController = null;
		}
	}

	private IEnumerator SetFonLoadingWaitForReset(string _mapName = "", bool isAddCountRun = false)
	{
		RemoveLoadingGUI();
		while (WeaponManager.sharedManager == null)
		{
			yield return null;
		}
		while (WeaponManager.sharedManager.LockGetWeaponPrefabs > 0)
		{
			yield return null;
		}
		ShowLoadingGUI(_mapName);
	}

	public void ConnectToRoom(int _game_mode, string _room_name, string _map)
	{
		int gameTier = ((_game_mode <= 99) ? (_game_mode / 10) : (_game_mode % 100 / 10));
		game_mode = _game_mode % 10;
		room_name = _room_name;
		Defs.isMulti = true;
		Defs.isInet = true;
		Defs.isFlag = false;
		Defs.isCOOP = false;
		Defs.isCompany = false;
		Defs.isHunger = false;
		Defs.isCapturePoints = false;
		switch (game_mode)
		{
		default:
			return;
		case 0:
			StoreKitEventListener.State.Mode = "Deathmatch Wordwide";
			ConnectSceneNGUIController.regim = ConnectSceneNGUIController.RegimGame.Deathmatch;
			break;
		case 1:
			StoreKitEventListener.State.Mode = "Time Survival";
			Defs.isCOOP = true;
			ConnectSceneNGUIController.regim = ConnectSceneNGUIController.RegimGame.TimeBattle;
			break;
		case 2:
			StoreKitEventListener.State.Mode = "Team Battle";
			Defs.isCompany = true;
			ConnectSceneNGUIController.regim = ConnectSceneNGUIController.RegimGame.TeamFight;
			break;
		case 3:
			if (true)
			{
				Defs.isHunger = true;
				StoreKitEventListener.State.Mode = "Deadly Games";
				ConnectSceneNGUIController.regim = ConnectSceneNGUIController.RegimGame.DeadlyGames;
				break;
			}
			if (ShowNoJoinConnectFromRanks.sharedController != null)
			{
				ShowNoJoinConnectFromRanks.sharedController.resetShow(3);
			}
			return;
		case 4:
			if (true)
			{
				Defs.isFlag = true;
				ConnectSceneNGUIController.regim = ConnectSceneNGUIController.RegimGame.FlagCapture;
				break;
			}
			StoreKitEventListener.State.Mode = "Flag Capture";
			if (ShowNoJoinConnectFromRanks.sharedController != null)
			{
				ShowNoJoinConnectFromRanks.sharedController.resetShow(4);
			}
			return;
		case 5:
			Defs.isCapturePoints = true;
			ConnectSceneNGUIController.regim = ConnectSceneNGUIController.RegimGame.CapturePoints;
			break;
		}
		if (ActivityIndicator.sharedActivityIndicator != null)
		{
			ActivityIndicator.sharedActivityIndicator.SetActive(true);
		}
		oldActivFriendPanel = friendsPanel.activeSelf;
		if (friendProfilePanel != null)
		{
			oldActivProfileProfile = friendProfilePanel.activeSelf;
		}
		if (oldActivFriendPanel)
		{
			fon.SetActive(false);
		}
		connectPanel.SetActive(true);
		friendsPanel.SetActive(false);
		if (friendProfilePanel != null)
		{
			friendProfilePanel.SetActive(false);
		}
		label.gameObject.SetActive(false);
		plashkaLabel.SetActive(false);
		Debug.Log("fonConnectTexture.mainTexture=" + _map + " " + Defs.levelNamesFromNums[_map]);
		WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(Defs.levelNamesFromNums[_map].ToString()) ? Defs.filterMaps[Defs.levelNamesFromNums[_map].ToString()] : 0);
		StartCoroutine(SetFonLoadingWaitForReset(Defs.levelNamesFromNums[_map]));
		string gameVersion = Initializer.Separator + ConnectSceneNGUIController.regim.ToString() + gameTier + "v" + GlobalGameController.MultiplayerProtocolVersion;
		ConnectSceneNGUIController.gameTier = gameTier;
		Debug.Log("Connect -" + gameVersion);
		PhotonNetwork.autoJoinLobby = false;
		if (Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[_map]))
		{
			if (Storager.getInt(Defs.levelNamesFromNums[_map] + "Key", true) == 1 || PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[_map]))
			{
				PhotonNetwork.ConnectUsingSettings(gameVersion);
				return;
			}
			Action successfulUnlockCallback = delegate
			{
				PhotonNetwork.ConnectUsingSettings(gameVersion);
			};
			ShowUnlockMapDialog(successfulUnlockCallback, Defs.levelNamesFromNums[_map]);
		}
		else
		{
			PhotonNetwork.ConnectUsingSettings(gameVersion);
		}
	}

	private void Update()
	{
		if (coinsPlashka.thisScript != null)
		{
			coinsPlashka.thisScript.enabled = coinsShop.thisScript != null && coinsShop.thisScript.enabled;
		}
		if (timerShowWrongPassword > 0f && WrongPasswordLabel.activeSelf)
		{
			timerShowWrongPassword -= Time.deltaTime;
		}
		if (timerShowWrongPassword <= 0f && WrongPasswordLabel.activeSelf)
		{
			WrongPasswordLabel.SetActive(false);
		}
	}

	private void ShowUnlockMapDialog(Action successfulUnlockCallback, string levelName)
	{
		if (string.IsNullOrEmpty(levelName))
		{
			Debug.LogWarning("Level name shoul not be empty.");
			return;
		}
		GameObject gameObject = GameObject.Find("UI Root");
		if (gameObject != null)
		{
			UnityEngine.Object original = Resources.Load("UnlockPremiumMapView");
			GameObject gameObject2 = UnityEngine.Object.Instantiate(original) as GameObject;
			gameObject2.transform.parent = gameObject.transform;
			gameObject2.transform.localScale = Vector3.one;
			if (ActivityIndicator.sharedActivityIndicator != null)
			{
				ActivityIndicator.sharedActivityIndicator.SetActive(false);
			}
			UnlockPremiumMapView unlockPremiumMapView = gameObject2.GetComponent<UnlockPremiumMapView>();
			if (unlockPremiumMapView == null)
			{
				Debug.LogError("UnlockPremiumMapView should not be null.");
				return;
			}
			int value = 0;
			Defs.PremiumMaps.TryGetValue(levelName, out value);
			unlockPremiumMapView.Price = value;
			EventHandler value2 = delegate
			{
				HandleCloseUnlockDialog(unlockPremiumMapView);
			};
			EventHandler value3 = delegate
			{
				HandleUnlockPressed(unlockPremiumMapView, successfulUnlockCallback, levelName);
			};
			unlockPremiumMapView.ClosePressed += value2;
			unlockPremiumMapView.UnlockPressed += value3;
		}
		else
		{
			Debug.Log("Failed to instantiate Unlock dialog window: UI Root is not found.");
		}
	}

	private void HandleCloseUnlockDialog(UnlockPremiumMapView unlockPremiumMapView)
	{
		closeConnectPanel();
		UnityEngine.Object.Destroy(unlockPremiumMapView.gameObject);
	}

	private void HandleUnlockPressed(UnlockPremiumMapView unlockPremiumMapView, Action successfulUnlockCallback, string levelName)
	{
		ShopNGUIController.TryToBuy(unlockPremiumMapView.gameObject, new ItemPrice(unlockPremiumMapView.Price, "Coins"), delegate
		{
			Storager.setInt(levelName + "Key", 1, true);
			PlayerPrefs.Save();
			ShopNGUIController.SynchronizeAndroidPurchases("Friend's map unlocked: " + levelName);
			FlurryPluginWrapper.LogEvent("Unlock " + levelName + " map");
			if (coinsPlashka.thisScript != null)
			{
				coinsPlashka.thisScript.enabled = false;
			}
			successfulUnlockCallback();
			UnityEngine.Object.Destroy(unlockPremiumMapView.gameObject);
		}, delegate
		{
			FlurryPluginWrapper.LogEvent("Try_Enable " + levelName + " map");
			StoreKitEventListener.State.PurchaseKey = "In map selection In Friends";
		});
	}

	[Obfuscation(Exclude = true)]
	public void closeConnectPanel()
	{
		if (oldActivFriendPanel)
		{
			fon.SetActive(true);
		}
		fonConnectTexture.mainTexture = null;
		RemoveLoadingGUI();
		connectPanel.SetActive(false);
		label.gameObject.SetActive(false);
		plashkaLabel.SetActive(false);
		if (ActivityIndicator.sharedActivityIndicator != null)
		{
			ActivityIndicator.sharedActivityIndicator.SetActive(false);
		}
		friendsPanel.SetActive(oldActivFriendPanel);
		if (friendProfilePanel != null)
		{
			friendProfilePanel.SetActive(oldActivProfileProfile);
		}
	}

	private void ShowLabel(string text)
	{
		label.text = text;
		label.gameObject.SetActive(true);
		plashkaLabel.SetActive(true);
		if (ActivityIndicator.sharedActivityIndicator != null)
		{
			ActivityIndicator.sharedActivityIndicator.SetActive(false);
		}
		Invoke("closeConnectPanel", 3f);
	}

	private void OnDisconnectedFromPhoton()
	{
		if (isFaledConnectToRoom)
		{
			ShowLabel("Game is unavailable...");
		}
		else if (isBackFromPassword)
		{
			closeConnectPanel();
		}
		else
		{
			ShowLabel("Can't connect ...");
		}
		isFaledConnectToRoom = false;
		isBackFromPassword = false;
		Debug.Log("OnDisconnectedFromPhoton");
	}

	private void OnFailedToConnectToPhoton(object parameters)
	{
		ShowLabel("Can't connect ...");
		Debug.Log("OnFailedToConnectToPhoton. StatusCode: " + parameters);
	}

	public void OnConnectedToMaster()
	{
		ConnectToRoom();
	}

	public void OnJoinedLobby()
	{
		ConnectToRoom();
	}

	[Obfuscation(Exclude = true)]
	private void ConnectToRoom()
	{
		PhotonNetwork.playerName = Defs.GetPlayerNameOrDefault();
		Debug.Log("OnJoinedLobby " + room_name);
		PhotonNetwork.JoinRoom(room_name);
		PlayerPrefs.SetString("RoomName", room_name);
	}

	private void OnPhotonJoinRoomFailed()
	{
		Debug.Log("OnPhotonJoinRoomFailed - init");
		isFaledConnectToRoom = true;
		PhotonNetwork.Disconnect();
	}

	private void SetEnabledPasswordPanel(bool enabled)
	{
		PasswordPanel.SetActive(enabled);
		if (_loadingNGUIController != null)
		{
			_loadingNGUIController.SetEnabledMapName(!enabled);
			_loadingNGUIController.SetEnabledGunsScroll(!enabled);
		}
	}

	private void OnJoinedRoom()
	{
		Debug.Log("OnJoinedRoom - init");
		if (PhotonNetwork.room != null && PhotonNetwork.room.customProperties["starting"].Equals(0))
		{
			passwordRoom = PhotonNetwork.room.customProperties["pass"].ToString();
			PhotonNetwork.isMessageQueueRunning = false;
			if (passwordRoom.Equals(string.Empty))
			{
				PhotonNetwork.isMessageQueueRunning = false;
				StartCoroutine(MoveToGameScene());
				return;
			}
			Debug.Log("Show Password Panel " + passwordRoom);
			if (ActivityIndicator.sharedActivityIndicator != null)
			{
				ActivityIndicator.sharedActivityIndicator.SetActive(false);
			}
			inputPassworLabel.value = string.Empty;
			SetEnabledPasswordPanel(true);
		}
		else
		{
			PhotonNetwork.Disconnect();
			ShowLabel("Game is unavailable...");
		}
	}

	private IEnumerator MoveToGameScene()
	{
		if (Application.loadedLevelName.Equals("Clans"))
		{
			Defs.isGameFromFriends = false;
			Defs.isGameFromClans = true;
		}
		else
		{
			Defs.isGameFromFriends = true;
			Defs.isGameFromClans = false;
		}
		WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(Defs.levelNamesFromNums[PhotonNetwork.room.customProperties["map"].ToString()].ToString()) ? Defs.filterMaps[Defs.levelNamesFromNums[PhotonNetwork.room.customProperties["map"].ToString()].ToString()] : 0);
		Debug.Log("MoveToGameScene");
		while (PhotonNetwork.room == null)
		{
			yield return 0;
		}
		Debug.Log("map=" + PhotonNetwork.room.customProperties["map"].ToString());
		Debug.Log(Defs.levelNamesFromNums[PhotonNetwork.room.customProperties["map"].ToString()]);
		LoadConnectScene.textureToShow = Resources.Load("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading_" + Defs.levelNamesFromNums[PhotonNetwork.room.customProperties["map"].ToString()]) as Texture2D;
		LoadConnectScene.sceneToLoad = Defs.levelNamesFromNums[PhotonNetwork.room.customProperties["map"].ToString()];
		LoadConnectScene.noteToShow = null;
		yield return Application.LoadLevelAsync("PromScene");
	}
}
