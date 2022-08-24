using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;
using ExitGames.Client.Photon;
using Prime31;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

public sealed class NetworkStartTable : MonoBehaviour
{
	public struct infoClient
	{
		public string ipAddress;

		public string name;

		public string coments;
	}

	public string pixelBookID = "-1";

	private SaltedInt _scoreCommandFlag1 = new SaltedInt(818919);

	private SaltedInt _scoreCommandFlag2 = new SaltedInt(823016);

	public double timerFlag;

	private float maxTimerFlag = 150f;

	private float timerUpdateTimerFlag;

	private float maxTimerUpdateTimerFlag = 1f;

	public bool isShowAvard;

	private bool isEndInHunger;

	private int addExperience;

	public GameObject guiObj;

	public NetworkStartTableNGUIController networkStartTableNGUIController;

	public bool isRegimVidos;

	private int numberPlayerCun;

	private int numberPlayerCunId;

	public Player_move_c currentPlayerMoveCVidos;

	private bool oldIsZomming;

	private InGameGUI inGameGUI;

	public string playerVidosNick;

	public string playerVidosClanName;

	public Texture playerVidosClanTexture;

	public GameObject currentCamPlayer;

	public GameObject currentFPSPlayer;

	private GameObject currentBodyMech;

	public GameObject currentGameObjectPlayer;

	public bool isGoRandomRoom;

	public Texture mySkin;

	public List<GameObject> zombiePrefabs = new List<GameObject>();

	private GameObject _playerPrefab;

	public GameObject tempCam;

	public GameObject zombieManagerPrefab;

	public Texture2D serverLeftTheGame;

	public ExperienceController experienceController;

	private int addCoins;

	public bool isDeadInHungerGame;

	private bool showMessagFacebook;

	private bool showMessagTiwtter;

	private bool clickButtonFacebook;

	public bool isIwin;

	public int myCommand;

	public int myCommandOld;

	private bool isLocal;

	private bool isMine;

	private bool isCOOP;

	private bool isServer;

	private bool isCompany;

	private bool isMulti;

	private bool isInet;

	private float timeNotRunZombiManager;

	private bool isSendZaprosZombiManager;

	private bool isGetZaprosZombiManager;

	private ExperienceController expController;

	public Texture myClanTexture;

	public string myClanID = string.Empty;

	public string myClanName = string.Empty;

	public string myClanLeaderID = string.Empty;

	private LANBroadcastService lanScan;

	private bool isSetNewMapButton;

	public bool isDrawInHanger;

	public List<infoClient> players = new List<infoClient>();

	public GUIStyle labelStyle;

	public GUIStyle messagesStyle;

	public GUIStyle ozidanieStyle;

	private Vector2 scrollPosition = Vector2.zero;

	public GameObject _purchaseActivityIndicator;

	private float koofScreen = (float)Screen.height / 768f;

	public WeaponManager _weaponManager;

	public bool _showTable;

	public string nickPobeditelya;

	public bool _isShowNickTable;

	public bool runGame = true;

	public GameObject[] zoneCreatePlayer;

	private GameObject _cam;

	public bool isDrawInDeathMatch;

	public bool showDisconnectFromServer;

	public bool showDisconnectFromMasterServer;

	private float timerShow = -1f;

	public string NamePlayer = "Player";

	public int CountKills;

	public int oldCountKills;

	public string[] oldSpisokName;

	public string[] oldCountLilsSpisok;

	public string[] oldScoreSpisok;

	public int[] oldSpisokRanks;

	public string[] oldSpisokNameBlue;

	public string[] oldCountLilsSpisokBlue;

	public int[] oldSpisokRanksBlue;

	public string[] oldSpisokNameRed;

	public string[] oldCountLilsSpisokRed;

	public string[] oldScoreSpisokRed;

	public string[] oldScoreSpisokBlue;

	public int[] oldSpisokRanksRed;

	public bool[] oldIsDeadInHungerGame;

	public string[] oldSpisokPixelBookID;

	public string[] oldSpisokPixelBookIDBlue;

	public string[] oldSpisokPixelBookIDRed;

	public Texture[] oldSpisokMyClanLogo;

	public Texture[] oldSpisokMyClanLogoBlue;

	public Texture[] oldSpisokMyClanLogoRed;

	public int oldIndexMy;

	private GameObject tc;

	public int score;

	public int scoreOld;

	private PhotonView photonView;

	private float timeTomig = 0.5f;

	private float timerSynchScore = -1f;

	private int countMigZagolovok;

	private int commandWinner;

	private bool isMigZag;

	private HungerGameController hungerGameController;

	private bool _canUserUseFacebookComposer;

	private bool _hasPublishPermission;

	private bool _hasPublishActions;

	public int myRanks = 1;

	public Player_move_c myPlayerMoveC;

	private bool isHunger;

	private ShopNGUIController _shopInstance;

	private bool isStartPlayerCoroutine;

	private string waitingPlayerLocalize;

	private string matchLocalize;

	private string preparingLocalize;

	private Pauser _pauser;

	private PauseNGUIController _pauseController;

	private Stopwatch _matchStopwatch = new Stopwatch();

	public int scoreCommandFlag1
	{
		get
		{
			return _scoreCommandFlag1.Value;
		}
		set
		{
			_scoreCommandFlag1.Value = value;
		}
	}

	public int scoreCommandFlag2
	{
		get
		{
			return _scoreCommandFlag2.Value;
		}
		set
		{
			_scoreCommandFlag2.Value = value;
		}
	}

	public bool showTable
	{
		get
		{
			return _showTable;
		}
		set
		{
			_showTable = value;
			if (isMine)
			{
				Defs.showTableInNetworkStartTable = value;
			}
		}
	}

	public bool isShowNickTable
	{
		get
		{
			return _isShowNickTable;
		}
		set
		{
			_isShowNickTable = value;
			if (isMine)
			{
				Defs.showNickTableInNetworkStartTable = value;
			}
		}
	}

	public static Vector2 ExperiencePosRanks
	{
		get
		{
			return new Vector2(21f * Defs.Coef, 21f * Defs.Coef);
		}
	}

	private string _SocialMessage()
	{
		int @int = Storager.getInt(Defs.COOPScore, false);
		bool flag = Defs.isCOOP;
		int int2 = Storager.getInt("Rating", false);
		string applicationUrl = Defs2.ApplicationUrl;
		if (isIwin)
		{
			return (!flag) ? string.Format("Now I have {0} wins  in Pixel Gun 3D! Try it right now! {1}", int2, applicationUrl) : string.Format("Now I have {0} score in Pixel Gun 3D! Try it right now! {1}", @int, applicationUrl);
		}
		return (!flag) ? string.Format("I won {0} matches in Pixel Gun 3D! Try it right now! {1}", int2, applicationUrl) : string.Format("I received {0} points in Pixel Gun 3D! Try it right now! {1}", @int, applicationUrl);
	}

	private string _SocialSentSuccess(string SocialName)
	{
		return "Message was sent to " + SocialName;
	}

	private void completionHandler(string error, object result)
	{
		if (error != null)
		{
			UnityEngine.Debug.LogError(error);
			return;
		}
		Utils.logObject(result);
		showMessagFacebook = true;
		Invoke("hideMessag", 3f);
	}

	private void Awake()
	{
		isLocal = !Defs.isInet;
		isInet = Defs.isInet;
		isCOOP = ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TimeBattle;
		isServer = PlayerPrefs.GetString("TypeGame").Equals("server");
		isMulti = Defs.isMulti;
		isCompany = ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight;
		isHunger = ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.DeadlyGames;
		experienceController = GameObject.FindGameObjectWithTag("ExperienceController").GetComponent<ExperienceController>();
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TimeBattle)
		{
			string[] array = null;
			array = new string[10] { "1", "15", "14", "2", "3", "9", "11", "12", "10", "16" };
			for (int i = 0; i < array.Length; i++)
			{
				GameObject item = Resources.Load("Enemies/Enemy" + array[i] + "_go") as GameObject;
				zombiePrefabs.Add(item);
			}
		}
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture)
		{
			maxTimerFlag = (float)int.Parse(PhotonNetwork.room.customProperties["MaxKill"].ToString()) * 60f;
		}
	}

	private bool IsShowAdd(string _pixelBookID)
	{
		bool result = true;
		if (_pixelBookID.Equals("-1") || _pixelBookID.Equals(FriendsController.sharedController.id))
		{
			return false;
		}
		foreach (Dictionary<string, string> friend in FriendsController.sharedController.friends)
		{
			if (friend["friend"].Equals(_pixelBookID))
			{
				result = false;
			}
		}
		foreach (Dictionary<string, string> invitesFromU in FriendsController.sharedController.invitesFromUs)
		{
			if (invitesFromU["friend"].Equals(_pixelBookID))
			{
				result = false;
			}
		}
		foreach (string notShowAddId in FriendsController.sharedController.notShowAddIds)
		{
			if (notShowAddId.Equals(_pixelBookID))
			{
				result = false;
			}
		}
		return result;
	}

	public void ImDeadInHungerGames()
	{
		if (Defs.isInet && NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.UpdateGoMapButtons();
			isSetNewMapButton = true;
		}
		_matchStopwatch.Stop();
		int @int = PlayerPrefs.GetInt("CountMatch", 0);
		PlayerPrefs.SetInt("CountMatch", @int + 1);
		if (ExperienceController.sharedController != null)
		{
			string key = "Statistics.MatchCount.Level" + ExperienceController.sharedController.currentLevel;
			int int2 = PlayerPrefs.GetInt(key, 0);
			PlayerPrefs.SetInt(key, int2 + 1);
			FlurryPluginWrapper.LogMatchCompleted(ConnectSceneNGUIController.regim.ToString());
		}
		IncreaseTimeInMode(3, _matchStopwatch.Elapsed.TotalMinutes);
		WWWForm wWWForm = new WWWForm();
		wWWForm.AddField("action", "time_in_match");
		wWWForm.AddField("mode", (int)ConnectSceneNGUIController.regim);
		wWWForm.AddField("time", _matchStopwatch.Elapsed.TotalSeconds.ToString());
		wWWForm.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		wWWForm.AddField("uniq_id", FriendsController.sharedController.id);
		wWWForm.AddField("auth", FriendsController.Hash("time_in_match"));
		if (ExperienceController.sharedController != null)
		{
			wWWForm.AddField("level", ExperienceController.sharedController.currentLevel);
		}
		wWWForm.AddField("paying", Convert.ToInt32(FlurryPluginWrapper.IsPayingUser()).ToString());
		wWWForm.AddField("developer", Convert.ToInt32(Defs.IsDeveloperBuild).ToString());
		UnityEngine.Debug.Log("Time in Match Event: " + Encoding.UTF8.GetString(wWWForm.data, 0, wWWForm.data.Length));
		WWW wWW = new WWW(URLs.Friends, wWWForm);
		_matchStopwatch.Reset();
		StoreKitEventListener.State.PurchaseKey = "End match";
		if (_cam != null)
		{
			_cam.SetActive(true);
		}
		NickLabelController.currentCamera = GameObject.FindGameObjectWithTag("GameController").GetComponent<Initializer>().tc.GetComponent<Camera>();
		showTable = true;
		isDeadInHungerGame = true;
		photonView.RPC("ImDeadInHungerGamesRPC", PhotonTargets.Others);
		if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.ShowEndInterface(string.Empty);
		}
		inGameGUI.ResetScope();
	}

	[PunRPC]
	public void ImDeadInHungerGamesRPC()
	{
		isDeadInHungerGame = true;
	}

	public void setScoreFromGlobalGameController()
	{
		score = GlobalGameController.Score;
		SynhScore();
	}

	[PunRPC]
	private void RunGame()
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("NetworkTable");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			gameObject.GetComponent<NetworkStartTable>().runGame = true;
		}
	}

	public void RemoveShop(bool disable = true)
	{
		ShopTapReceiver.ShopClicked -= HandleShopButton;
		if (_shopInstance != null)
		{
			if (disable)
			{
				ShopNGUIController.GuiActive = false;
			}
			_shopInstance.resumeAction = delegate
			{
			};
			_shopInstance = null;
		}
	}

	public void HandleShopButton()
	{
		if (_shopInstance == null)
		{
			FlurryPluginWrapper.LogEvent("Shop");
			_shopInstance = ShopNGUIController.sharedShop;
			if (_shopInstance != null)
			{
				_shopInstance.SetGearCatEnabled(false);
				ShopNGUIController.GuiActive = true;
				_shopInstance.resumeAction = HandleResumeFromShop;
			}
			else
			{
				UnityEngine.Debug.LogWarning("sharedShop == null");
			}
		}
	}

	public void HandleResumeFromShop()
	{
		if (_shopInstance != null)
		{
			expController.isShowRanks = true;
			ShopNGUIController.GuiActive = false;
			_shopInstance.resumeAction = delegate
			{
			};
			_shopInstance = null;
		}
	}

	public void BackButtonPress()
	{
		if (ExpController.Instance.IsLevelUpShown)
		{
			return;
		}
		NetworkStartTableNGUIController sharedController = NetworkStartTableNGUIController.sharedController;
		if (sharedController != null && sharedController.CheckHideInternalPanel())
		{
			return;
		}
		networkStartTableNGUIController.shopAnchor.SetActive(false);
		RemoveShop(true);
		if (!isInet)
		{
			if (isServer)
			{
				PhotonNetwork.Disconnect();
				GameObject.FindGameObjectWithTag("NetworkTable").GetComponent<LANBroadcastService>().StopBroadCasting();
			}
			else if (PhotonNetwork.countOfPlayers == 1)
			{
				PhotonNetwork.Disconnect();
			}
			if (_purchaseActivityIndicator == null)
			{
				UnityEngine.Debug.LogWarning("_purchaseActivityIndicator == null");
			}
			else
			{
				_purchaseActivityIndicator.SetActive(false);
			}
			ConnectSceneNGUIController.Local();
		}
		else
		{
			if (_purchaseActivityIndicator == null)
			{
				UnityEngine.Debug.LogWarning("_purchaseActivityIndicator == null");
			}
			else
			{
				_purchaseActivityIndicator.SetActive(false);
			}
			Defs.typeDisconnectGame = Defs.DisconectGameType.Exit;
			PhotonNetwork.Disconnect();
		}
		if (EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Paused || EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Recording)
		{
			EveryplayWrapper.Instance.Stop();
		}
	}

	public void StartPlayerButtonClick(int _command)
	{
		if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.HideEndInterface();
		}
		isShowNickTable = false;
		CountKills = 0;
		score = 0;
		GlobalGameController.Score = 0;
		GlobalGameController.CountKills = 0;
		myCommand = _command;
		SynhCommand();
		SynhCountKills();
		SynhScore();
		startPlayer();
		countMigZagolovok = 0;
		timeTomig = 0.7f;
		isMigZag = false;
	}

	public void RandomRoomClickBtnInHunger()
	{
		isGoRandomRoom = true;
		if (isRegimVidos)
		{
			isRegimVidos = false;
			if (inGameGUI != null)
			{
				inGameGUI.ResetScope();
			}
		}
		Defs.typeDisconnectGame = Defs.DisconectGameType.RandomGameInHunger;
		PhotonNetwork.LeaveRoom();
	}

	public void SetRegimVidos(bool _isRegimVidos)
	{
		bool flag = isRegimVidos;
		isRegimVidos = _isRegimVidos;
		if (isRegimVidos != flag && !isRegimVidos && inGameGUI != null)
		{
			inGameGUI.ResetScope();
		}
	}

	private void playersTable()
	{
		if (!isShowAvard)
		{
			ShopTapReceiver.AddClickHndIfNotExist(HandleShopButton);
			networkStartTableNGUIController.shopAnchor.SetActive(!isHunger && _shopInstance == null && (expController == null || !expController.isShowNextPlashka));
			if (_shopInstance != null)
			{
				_shopInstance.SetGearCatEnabled(false);
			}
		}
	}

	public void PostFacebookBtnClick()
	{
		UnityEngine.Debug.Log("show facebook dialog");
		FlurryPluginWrapper.LogFacebook();
		FacebookController.ShowPostDialog();
	}

	public void PostTwitterBtnClick()
	{
		FlurryPluginWrapper.LogTwitter();
		InitTwitter();
	}

	private IEnumerator StartPlayerCoroutine()
	{
		if (isStartPlayerCoroutine)
		{
			yield break;
		}
		isStartPlayerCoroutine = true;
		while (Defs.isMulti && Defs.isInet && PhotonNetwork.time > -0.01 && PhotonNetwork.time < 0.01)
		{
			yield return null;
		}
		isStartPlayerCoroutine = false;
		if (Defs.isMulti && !Defs.isHunger)
		{
			TimeGameController.sharedController.StartMatch();
		}
		isDrawInDeathMatch = false;
		_matchStopwatch.Start();
		StoreKitEventListener.State.PurchaseKey = "In game";
		StoreKitEventListener.State.Parameters.Clear();
		networkStartTableNGUIController.shopAnchor.SetActive(false);
		RemoveShop(true);
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture)
		{
			timerFlag = maxTimerFlag;
		}
		if (myRanks != expController.currentLevel)
		{
			SetRanks();
		}
		_playerPrefab = Resources.Load("Player") as GameObject;
		_cam = GameObject.FindGameObjectWithTag("CamTemp");
		_cam.SetActive(false);
		_weaponManager.useCam = null;
		zoneCreatePlayer = GameObject.FindGameObjectsWithTag((ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TimeBattle) ? "MultyPlayerCreateZoneCOOP" : ((ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight) ? ("MultyPlayerCreateZoneCommand" + myCommand) : ((ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture) ? ("MultyPlayerCreateZoneFlagCommand" + myCommand) : ((ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints) ? "MultyPlayerCreateZone" : ("MultyPlayerCreateZonePointZone" + myCommand)))));
		GameObject chestSpawnZone = null;
		int numberSpawnZone = 0;
		int numberZoneChest = 0;
		if (isHunger)
		{
			if (PlayerPrefs.GetInt("StartAfterDisconnect") != 1)
			{
				_weaponManager.Reset(0);
			}
			int _myId = photonView.owner.ID;
			GameObject[] tabMas = GameObject.FindGameObjectsWithTag("NetworkTable");
			for (int i = 0; i < tabMas.Length; i++)
			{
				if (tabMas[i].transform.GetComponent<PhotonView>().owner.ID < _myId)
				{
					numberSpawnZone++;
				}
			}
			numberZoneChest = numberSpawnZone;
			for (int k = 0; k < zoneCreatePlayer.Length; k++)
			{
				if (zoneCreatePlayer[k].GetComponent<NumberZone>().numberZone == numberSpawnZone)
				{
					numberSpawnZone = k;
					break;
				}
			}
			if (PlayerPrefs.GetInt("StartAfterDisconnect") != 1)
			{
				GameObject[] chestCreateZones = GameObject.FindGameObjectsWithTag("ChestCreateZone");
				for (int j = 0; j < chestCreateZones.Length; j++)
				{
					if (chestCreateZones[j].GetComponent<NumberZone>().numberZone == numberZoneChest)
					{
						chestSpawnZone = chestCreateZones[j];
						photonView.RPC("CreateChestRPC", PhotonTargets.MasterClient, chestSpawnZone.transform.position, chestSpawnZone.transform.rotation);
						break;
					}
				}
			}
		}
		GameObject spawnZone = zoneCreatePlayer[(!isHunger) ? UnityEngine.Random.Range(0, zoneCreatePlayer.Length - 1) : numberSpawnZone];
		BoxCollider spawnZoneCollider = spawnZone.GetComponent<BoxCollider>();
		Vector2 sz = new Vector2(spawnZoneCollider.size.x * spawnZone.transform.localScale.x, spawnZoneCollider.size.z * spawnZone.transform.localScale.z);
		Rect zoneRect = new Rect(spawnZone.transform.position.x - sz.x / 2f, spawnZone.transform.position.z - sz.y / 2f, sz.x, sz.y);
		Vector3 pos = ((!isHunger) ? new Vector3(zoneRect.x + UnityEngine.Random.Range(0f, zoneRect.width), spawnZone.transform.position.y + 2f, zoneRect.y + UnityEngine.Random.Range(0f, zoneRect.height)) : spawnZone.transform.position);
		Quaternion rot = spawnZone.transform.rotation;
		if (PlayerPrefs.GetInt("StartAfterDisconnect") == 1)
		{
			pos = GlobalGameController.posMyPlayer;
		}
		GameObject pl;
		if (isInet)
		{
			pl = PhotonNetwork.Instantiate("Player", pos, rot, 0);
			GameObject.FindGameObjectWithTag("GameController").GetComponent<BonusCreator>().BeginCreateBonuses();
		}
		else
		{
			pl = (GameObject)PhotonNetwork.Instantiate("Player", pos, rot, 0);
			pl.GetComponent<SkinName>().playerMoveC.SetIDMyTable(base.GetComponent<PhotonView>().ToString());
		}
		NickLabelController.currentCamera = pl.GetComponent<SkinName>().camPlayer.GetComponent<Camera>();
		_weaponManager.myPlayer = pl;
		_weaponManager.myPlayerMoveC = pl.GetComponent<SkinName>().playerMoveC;
		if (!isInet && isServer)
		{
			UnityEngine.Debug.Log("PhotonView.RPC(RunGame, PhotonTargets.OthersBuffered);");
			base.GetComponent<PhotonView>().RPC("RunGame", PhotonTargets.OthersBuffered);
			GameObject.FindGameObjectWithTag("GameController").GetComponent<BonusCreator>().BeginCreateBonuses();
		}
		GameObject.FindGameObjectWithTag("GameController").GetComponent<Initializer>().SetupObjectThatNeedsPlayer();
		if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.HideStartInterface();
		}
		showTable = false;
	}

	[Obfuscation(Exclude = true)]
	public void startPlayer()
	{
		StartCoroutine(StartPlayerCoroutine());
	}

	[PunRPC]
	public void CreateChestRPC(Vector3 pos, Quaternion rot)
	{
		PhotonNetwork.InstantiateSceneObject("HungerGames/Chest", pos, rot, 0, null);
	}

	[PunRPC]
	private void SetPixelBookID(string _pixelBookID)
	{
		pixelBookID = _pixelBookID;
	}

	public void OnPhotonPlayerConnected(PhotonPlayer player)
	{
		if (Defs.isFlag && (bool)photonView && photonView.isMine)
		{
			photonView.RPC("SynchScoreCommandRPC", PhotonTargets.All, 1, scoreCommandFlag1);
			photonView.RPC("SynchScoreCommandRPC", PhotonTargets.All, 2, scoreCommandFlag2);
		}
		if ((bool)photonView && photonView.isMine)
		{
			SynhCommand();
			SynhCountKills();
			SynhScore();
		}
	}

	public void SetNewNick()
	{
		NamePlayer = Defs.GetPlayerNameOrDefault();
		if (Defs.isInet)
		{
			PhotonNetwork.playerName = NamePlayer;
			photonView.RPC("SynhNickNameRPC", PhotonTargets.OthersBuffered, NamePlayer);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("SynhNickNameRPC", PhotonTargets.OthersBuffered, NamePlayer);
		}
	}

	[PunRPC]
	private void SynhNickNameRPC(string _nick)
	{
		UnityEngine.Debug.Log("SynhNickNameRPC <" + _nick + ">");
		NamePlayer = _nick;
	}

	public void SetRanks()
	{
		myRanks = expController.currentLevel;
		if (Defs.isInet)
		{
			photonView.RPC("SynhRanksRPC", PhotonTargets.OthersBuffered, myRanks);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("SynhRanksRPC", PhotonTargets.OthersBuffered, myRanks);
		}
	}

	[PunRPC]
	private void SynhRanksRPC(int _ranks)
	{
		myRanks = _ranks;
	}

	public void SynhCommand()
	{
		if (Defs.isInet)
		{
			photonView.RPC("SynhCommandRPC", PhotonTargets.Others, myCommand, myCommandOld);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("SynhCommandRPC", PhotonTargets.Others, myCommand, myCommandOld);
		}
	}

	[PunRPC]
	private void SynhCommandRPC(int _command, int _oldCommand)
	{
		myCommand = _command;
		myCommandOld = _oldCommand;
		if (myPlayerMoveC != null)
		{
			myPlayerMoveC.myCommand = myCommand;
			if (Initializer.redPlayers.Contains(myPlayerMoveC) && myCommand == 1)
			{
				Initializer.redPlayers.Remove(myPlayerMoveC);
			}
			if (Initializer.bluePlayers.Contains(myPlayerMoveC) && myCommand == 2)
			{
				Initializer.bluePlayers.Remove(myPlayerMoveC);
			}
			if (myCommand == 1 && !Initializer.bluePlayers.Contains(myPlayerMoveC))
			{
				Initializer.bluePlayers.Add(myPlayerMoveC);
			}
			if (myCommand == 2 && !Initializer.redPlayers.Contains(myPlayerMoveC))
			{
				Initializer.redPlayers.Add(myPlayerMoveC);
			}
			if (myPlayerMoveC.myNickLabelController != null)
			{
				myPlayerMoveC.myNickLabelController.isSetColor = false;
			}
		}
	}

	public void SynhCountKills()
	{
		if (Defs.isInet)
		{
			photonView.RPC("SynhCountKillsRPC", PhotonTargets.Others, CountKills, oldCountKills);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("SynhCountKillsRPC", PhotonTargets.Others, CountKills, oldCountKills);
		}
	}

	[PunRPC]
	private void SynhCountKillsRPC(int _countKills, int _oldCountKills)
	{
		CountKills = _countKills;
		oldCountKills = _oldCountKills;
	}

	public void SynhScore()
	{
		if (timerSynchScore < 0f)
		{
			timerSynchScore = 1f;
		}
	}

	public void SendSynhScore()
	{
		if (Defs.isInet)
		{
			photonView.RPC("SynhScoreRPC", PhotonTargets.Others, score, scoreOld);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("SynhScoreRPC", PhotonTargets.Others, score, scoreOld);
		}
	}

	[PunRPC]
	private void SynhScoreRPC(int _score, int _oldScore)
	{
		score = _score;
		scoreOld = _oldScore;
	}

	private void InitTwitter()
	{
		string empty = string.Empty;
		string empty2 = string.Empty;
		if (GlobalGameController.isFullVersion)
		{
			empty = "cuMbTHM8izr9Mb3bIfcTxA";
			empty2 = "mpTLWIku4kIaQq7sTTi91wRLlvAxADhalhlEresnuI";
		}
		else
		{
			empty = "Jb7CwCaMgCQQiMViQRNHw";
			empty2 = "zGVrax4vqgs3CYf04O7glsoRbNT3vhIafte6lfm8w";
		}
		ServiceLocator.TwitterFacade.Init(empty, empty2);
		if (!ServiceLocator.TwitterFacade.IsLoggedIn())
		{
			TwitterLogin();
		}
		else
		{
			TwitterPost();
		}
	}

	private void TwitterLogin()
	{
		TwitterManager.loginSucceededEvent += OnTwitterLogin;
		TwitterManager.loginFailedEvent += OnTwitterLoginFailed;
		ServiceLocator.TwitterFacade.ShowLoginDialog();
	}

	private void OnTwitterLogin(string s)
	{
		TwitterManager.loginSucceededEvent -= OnTwitterLogin;
		TwitterManager.loginFailedEvent -= OnTwitterLoginFailed;
		TwitterPost();
	}

	private void OnTwitterLoginFailed(string _error)
	{
		TwitterManager.loginSucceededEvent -= OnTwitterLogin;
		TwitterManager.loginFailedEvent -= OnTwitterLoginFailed;
	}

	private void TwitterPost()
	{
		TwitterManager.requestDidFinishEvent += OnTwitterPost;
		ServiceLocator.TwitterFacade.PostStatusUpdate(_SocialMessage());
	}

	private void OnTwitterPost(object result)
	{
		if (result != null)
		{
			TwitterManager.requestDidFinishEvent -= OnTwitterPost;
			showMessagTiwtter = true;
			Invoke("hideMessagTwitter", 3f);
		}
	}

	private void OnTwitterPostFailed(string _error)
	{
		TwitterManager.requestDidFinishEvent -= OnTwitterPost;
	}

	[Obfuscation(Exclude = true)]
	private void hideMessag()
	{
		showMessagFacebook = false;
	}

	[Obfuscation(Exclude = true)]
	private void hideMessagTwitter()
	{
		showMessagTiwtter = false;
	}

	private void Start()
	{
		waitingPlayerLocalize = LocalizationStore.Key_0565;
		matchLocalize = LocalizationStore.Key_0566;
		preparingLocalize = LocalizationStore.Key_0567;
		lanScan = GetComponent<LANBroadcastService>();
		try
		{
			StartUnsafe();
		}
		catch (Exception message)
		{
			UnityEngine.Debug.LogError(message);
		}
	}

	private void StartUnsafe()
	{
		Stopwatch stopwatch = Stopwatch.StartNew();
		photonView = PhotonView.Get(this);
		if (isMulti)
		{
			if (isLocal)
			{
				isMine = base.GetComponent<PhotonView>().isMine;
			}
			else
			{
				isMine = photonView.isMine;
			}
		}
		if (isMine)
		{
			networkStartTableNGUIController = ((GameObject)UnityEngine.Object.Instantiate(Resources.Load("NetworkStartTableNGUI"))).GetComponent<NetworkStartTableNGUIController>();
			_cam = GameObject.FindGameObjectWithTag("CamTemp");
			StoreKitEventListener.State.PurchaseKey = "Start table";
			if (FriendsController.sharedController.clanLogo != null && !string.IsNullOrEmpty(FriendsController.sharedController.clanLogo))
			{
				byte[] data = Convert.FromBase64String(FriendsController.sharedController.clanLogo);
				Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoWidth);
				texture2D.LoadImage(data);
				texture2D.filterMode = FilterMode.Point;
				texture2D.Apply();
				myClanTexture = texture2D;
				if (isInet)
				{
					photonView.RPC("SetMyClanTexture", PhotonTargets.AllBuffered, FriendsController.sharedController.clanLogo, FriendsController.sharedController.ClanID, FriendsController.sharedController.clanName, FriendsController.sharedController.clanLeaderID);
				}
				else
				{
					base.GetComponent<PhotonView>().RPC("SetMyClanTexture", PhotonTargets.AllBuffered, FriendsController.sharedController.clanLogo, FriendsController.sharedController.ClanID, FriendsController.sharedController.clanName, FriendsController.sharedController.clanLeaderID);
				}
			}
		}
		if (isHunger)
		{
			hungerGameController = HungerGameController.Instance;
		}
		expController = ExperienceController.sharedController;
		expController.posRanks = ExperiencePosRanks;
		if (Defs.isFlag && isInet && isMine && isServer)
		{
			AddFlag();
		}
		_purchaseActivityIndicator = StoreKitEventListener.purchaseActivityInd;
		_weaponManager = WeaponManager.sharedManager;
		if (isMulti && isMine)
		{
			if (PlayerPrefs.GetInt("StartAfterDisconnect") == 0)
			{
				if (NetworkStartTableNGUIController.sharedController != null)
				{
					NetworkStartTableNGUIController.sharedController.ShowStartInterface();
				}
				showTable = true;
			}
			else
			{
				showTable = GlobalGameController.showTableMyPlayer;
				isDeadInHungerGame = GlobalGameController.imDeadInHungerGame;
				UnityEngine.Debug.Log("set showTable showTable showTableshowTable showTable showTable=" + showTable);
				if (showTable || isEndInHunger)
				{
					if (!isDeadInHungerGame && !isEndInHunger)
					{
						if (NetworkStartTableNGUIController.sharedController != null)
						{
							NetworkStartTableNGUIController.sharedController.ShowStartInterface();
						}
					}
					else if (NetworkStartTableNGUIController.sharedController != null)
					{
						NetworkStartTableNGUIController.sharedController.ShowEndInterface(string.Empty);
					}
				}
				else
				{
					Invoke("startPlayer", 0.1f);
				}
			}
			NickLabelController.currentCamera = GameObject.FindGameObjectWithTag("GameController").GetComponent<Initializer>().tc.GetComponent<Camera>();
			tempCam.SetActive(true);
			string text = (NamePlayer = FilterBadWorld.FilterString(Defs.GetPlayerNameOrDefault()));
			pixelBookID = FriendsController.sharedController.id;
			if (!isInet)
			{
				base.GetComponent<PhotonView>().RPC("SetPixelBookID", PhotonTargets.OthersBuffered, pixelBookID);
			}
			else
			{
				photonView.RPC("SetPixelBookID", PhotonTargets.OthersBuffered, pixelBookID);
			}
			if (isServer && !isInet)
			{
				lanScan.serverMessage.name = PlayerPrefs.GetString("ServerName");
				lanScan.serverMessage.map = PlayerPrefs.GetString("MapName");
				lanScan.serverMessage.connectedPlayers = 0;
				lanScan.serverMessage.playerLimit = int.Parse(PlayerPrefs.GetString("PlayersLimits"));
				lanScan.serverMessage.comment = PlayerPrefs.GetString("MaxKill");
				lanScan.serverMessage.regim = (int)ConnectSceneNGUIController.regim;
				lanScan.StartAnnounceBroadCasting();
				UnityEngine.Debug.Log("lanScan.serverMessage.regim=" + lanScan.serverMessage.regim);
			}
			else
			{
				lanScan.enabled = false;
			}
			if (PlayerPrefs.GetInt("StartAfterDisconnect") == 1)
			{
				CountKills = GlobalGameController.CountKills;
				score = GlobalGameController.Score;
				Invoke("synchState", 1f);
			}
			else
			{
				CountKills = -1;
				score = -1;
				Invoke("synchState", 1f);
			}
			expController = ExperienceController.sharedController;
			SetNewNick();
			SetRanks();
			SynhCountKills();
			SynhScore();
			sendMySkin();
			ShopNGUIController.sharedShop.onEquipSkinAction = delegate
			{
				sendMySkin();
			};
		}
		else
		{
			showTable = false;
		}
		stopwatch.Stop();
	}

	[PunRPC]
	private void SetMyClanTexture(string str, string _clanID, string _clanName, string _clanLeaderId)
	{
		try
		{
			byte[] data = Convert.FromBase64String(str);
			Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoWidth);
			texture2D.LoadImage(data);
			texture2D.filterMode = FilterMode.Point;
			texture2D.Apply();
			myClanTexture = texture2D;
		}
		catch (Exception message)
		{
			UnityEngine.Debug.Log(message);
		}
		myClanID = _clanID;
		myClanName = _clanName;
		myClanLeaderID = _clanLeaderId;
	}

	[PunRPC]
	private void setMySkin(string str)
	{
		if (base.transform.GetComponent<PhotonView>() == null)
		{
			return;
		}
		byte[] data = Convert.FromBase64String(str);
		Texture2D texture2D = new Texture2D(64, 32);
		texture2D.LoadImage(data);
		texture2D.filterMode = FilterMode.Point;
		texture2D.Apply();
		mySkin = texture2D;
		GameObject[] array = GameObject.FindGameObjectsWithTag("PlayerGun");
		if (array == null)
		{
			return;
		}
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (isInet && (bool)gameObject && gameObject.GetComponent<PhotonView>() != null && gameObject.GetComponent<PhotonView>().owner != null && (bool)base.transform && base.transform.GetComponent<PhotonView>() != null && gameObject.GetComponent<PhotonView>().owner.Equals(base.transform.GetComponent<PhotonView>().owner))
			{
				gameObject.GetComponent<Player_move_c>().setMyTamble(base.gameObject);
				break;
			}
		}
	}

	[PunRPC]
	private void setMySkinLocal(string str1, string str2)
	{
		byte[] data = Convert.FromBase64String(str1 + str2);
		Texture2D texture2D = new Texture2D(64, 32);
		texture2D.LoadImage(data);
		texture2D.filterMode = FilterMode.Point;
		texture2D.Apply();
		mySkin = texture2D;
		if (base.GetComponent<PhotonView>().isMine && WeaponManager.sharedManager.myPlayer != null)
		{
			WeaponManager.sharedManager.myPlayerMoveC.SetIDMyTable(base.GetComponent<PhotonView>().ToString());
		}
	}

	public void sendMySkin()
	{
		mySkin = SkinsController.currentSkinForPers;
		Texture2D texture2D = mySkin as Texture2D;
		byte[] inArray = texture2D.EncodeToPNG();
		string text = Convert.ToBase64String(inArray);
		if (isInet)
		{
			photonView.RPC("setMySkin", PhotonTargets.AllBuffered, text);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("setMySkinLocal", PhotonTargets.AllBuffered, text.Substring(0, text.Length / 2), text.Substring(text.Length / 2, text.Length / 2));
		}
	}

	public void ResetCamPlayer(int _nextPrev = 0)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		if (_nextPrev != 0 && array.Length == 1)
		{
			return;
		}
		if (array.Length > 0)
		{
			if (_nextPrev == 0)
			{
				numberPlayerCun = UnityEngine.Random.Range(0, array.Length);
				numberPlayerCunId = array[numberPlayerCun].GetComponent<PhotonView>().ownerId;
			}
			if (_nextPrev == 1)
			{
				int num = 10000000;
				int num2 = array[0].GetComponent<PhotonView>().ownerId;
				GameObject[] array2 = array;
				foreach (GameObject gameObject in array2)
				{
					int ownerId = gameObject.GetComponent<PhotonView>().ownerId;
					if (ownerId < num2)
					{
						num2 = ownerId;
					}
					if (ownerId > numberPlayerCunId && ownerId < num)
					{
						num = ownerId;
					}
				}
				if (num == 10000000)
				{
					numberPlayerCunId = num2;
				}
				else
				{
					numberPlayerCunId = num;
				}
				for (int j = 0; j < array.Length; j++)
				{
					if (array[j].GetComponent<PhotonView>().ownerId == numberPlayerCunId)
					{
						numberPlayerCun = j;
						break;
					}
				}
			}
			if (_nextPrev == -1)
			{
				int num3 = -1;
				int num4 = array[0].GetComponent<PhotonView>().ownerId;
				GameObject[] array3 = array;
				foreach (GameObject gameObject2 in array3)
				{
					int ownerId2 = gameObject2.GetComponent<PhotonView>().ownerId;
					if (ownerId2 > num4)
					{
						num4 = ownerId2;
					}
					if (ownerId2 < numberPlayerCunId)
					{
						num3 = ownerId2;
					}
				}
				if (num3 == -1)
				{
					numberPlayerCunId = num4;
				}
				else
				{
					numberPlayerCunId = num3;
				}
				for (int l = 0; l < array.Length; l++)
				{
					if (array[l].GetComponent<PhotonView>().ownerId == numberPlayerCunId)
					{
						numberPlayerCun = l;
						break;
					}
				}
			}
			if (currentCamPlayer != null)
			{
				currentCamPlayer.SetActive(false);
				if (!currentPlayerMoveCVidos.isMechActive)
				{
					currentFPSPlayer.SetActive(true);
				}
				currentBodyMech.SetActive(true);
				Player_move_c.SetLayerRecursively(currentGameObjectPlayer.transform.GetChild(0).gameObject, 0);
				currentGameObjectPlayer.GetComponent<InterolationGameObject>().sglajEnabled = false;
				currentCamPlayer.transform.parent.GetComponent<ThirdPersonNetwork1>().sglajEnabledVidos = false;
				currentCamPlayer = null;
				currentFPSPlayer = null;
				currentBodyMech = null;
				currentGameObjectPlayer = null;
				currentPlayerMoveCVidos = null;
			}
			SkinName component = array[numberPlayerCun].GetComponent<SkinName>();
			component.camPlayer.SetActive(true);
			playerVidosNick = component.NickName;
			playerVidosClanName = component.playerMoveC.myTable.GetComponent<NetworkStartTable>().myClanName;
			playerVidosClanTexture = component.playerMoveC.myTable.GetComponent<NetworkStartTable>().myClanTexture;
			currentPlayerMoveCVidos = component.playerMoveC;
			currentCamPlayer = component.camPlayer;
			currentFPSPlayer = component.FPSplayerObject;
			currentBodyMech = component.playerMoveC.mechBody;
			array[numberPlayerCun].GetComponent<ThirdPersonNetwork1>().sglajEnabledVidos = true;
			currentGameObjectPlayer = component.playerGameObject;
			currentGameObjectPlayer.GetComponent<InterolationGameObject>().sglajEnabled = true;
			currentFPSPlayer.SetActive(false);
			currentBodyMech.SetActive(false);
			NickLabelController.currentCamera = component.camPlayer.GetComponent<Camera>();
			Player_move_c.SetLayerRecursively(currentGameObjectPlayer.transform.GetChild(0).gameObject, 9);
		}
		else
		{
			_cam.SetActive(true);
			showTable = true;
			isRegimVidos = false;
			NickLabelController.currentCamera = _cam.GetComponent<Camera>();
			if (inGameGUI != null)
			{
				inGameGUI.ResetScope();
			}
		}
	}

	private void ReplaceCommand()
	{
		myCommand = ((myCommand != 1) ? 1 : 2);
		SynhCommand();
		score = 0;
		CountKills = 0;
		GlobalGameController.Score = 0;
		GlobalGameController.CountKills = 0;
		if (WeaponManager.sharedManager.myPlayerMoveC != null)
		{
			WeaponManager.sharedManager.myPlayerMoveC.countKills = 0;
			WeaponManager.sharedManager.myPlayerMoveC.myCommand = myCommand;
			WeaponManager.sharedManager.myPlayerMoveC.myBaza = null;
			WeaponManager.sharedManager.myPlayerMoveC.myFlag = null;
			WeaponManager.sharedManager.myPlayerMoveC.enemyFlag = null;
			if (Initializer.redPlayers.Contains(WeaponManager.sharedManager.myPlayerMoveC) && myCommand == 1)
			{
				Initializer.redPlayers.Remove(WeaponManager.sharedManager.myPlayerMoveC);
			}
			if (Initializer.bluePlayers.Contains(WeaponManager.sharedManager.myPlayerMoveC) && myCommand == 2)
			{
				Initializer.bluePlayers.Remove(WeaponManager.sharedManager.myPlayerMoveC);
			}
			if (myCommand == 1 && !Initializer.bluePlayers.Contains(WeaponManager.sharedManager.myPlayerMoveC))
			{
				Initializer.bluePlayers.Add(WeaponManager.sharedManager.myPlayerMoveC);
			}
			if (myCommand == 2 && !Initializer.redPlayers.Contains(WeaponManager.sharedManager.myPlayerMoveC))
			{
				Initializer.redPlayers.Add(WeaponManager.sharedManager.myPlayerMoveC);
			}
		}
	}

	private void Update()
	{
		if (isMine)
		{
			if (timerSynchScore > 0f)
			{
				timerSynchScore -= Time.deltaTime;
				if (timerSynchScore < 0f)
				{
					SendSynhScore();
				}
			}
			bool flag = isShowNickTable || showDisconnectFromServer || showDisconnectFromMasterServer || showTable || showMessagFacebook || showMessagTiwtter;
			if (guiObj.activeSelf != flag)
			{
				guiObj.SetActive(flag);
			}
			if (inGameGUI == null)
			{
				inGameGUI = InGameGUI.sharedInGameGUI;
			}
			if (_pauser == null)
			{
				_pauser = UnityEngine.Object.FindObjectsOfType<Pauser>().FirstOrDefault((Pauser p) => p.gameObject.tag.Equals("GameController"));
			}
			if (ShopNGUIController.GuiActive || (ProfileController.Instance != null && ProfileController.Instance.InterfaceEnabled))
			{
				expController.isShowRanks = SkinEditorController.sharedController == null;
			}
			else if (_pauser != null && _pauser.paused)
			{
				if (_pauseController == null)
				{
					_pauseController = UnityEngine.Object.FindObjectOfType<PauseNGUIController>();
				}
				if (_pauseController != null)
				{
					expController.isShowRanks = !_pauseController.SettingsJoysticksPanel.activeInHierarchy;
				}
			}
			else if ((showTable || isShowNickTable) && !isRegimVidos && _shopInstance == null && !LoadingInAfterGame.isShowLoading)
			{
				expController.isShowRanks = !(networkStartTableNGUIController != null) || networkStartTableNGUIController.rentScreenPoint.childCount == 0;
			}
			else
			{
				expController.isShowRanks = false;
			}
			if (isRegimVidos && isDeadInHungerGame && _cam.activeInHierarchy && GameObject.FindGameObjectsWithTag("Player").Length > 0)
			{
				_cam.SetActive(false);
				ResetCamPlayer(0);
			}
			if (isRegimVidos && isDeadInHungerGame && currentCamPlayer == null)
			{
				ResetCamPlayer(0);
			}
			if (!isRegimVidos && isDeadInHungerGame && currentCamPlayer != null)
			{
				currentCamPlayer.SetActive(false);
				if (!currentPlayerMoveCVidos.isMechActive)
				{
					currentFPSPlayer.SetActive(true);
				}
				currentBodyMech.SetActive(true);
				currentCamPlayer = null;
				currentFPSPlayer = null;
				currentBodyMech = null;
				_cam.SetActive(true);
			}
			if (isRegimVidos && inGameGUI != null && currentPlayerMoveCVidos.isZooming != oldIsZomming)
			{
				oldIsZomming = currentPlayerMoveCVidos.isZooming;
				if (oldIsZomming)
				{
					string empty = string.Empty;
					float fieldOfView = 60f;
					if (currentGameObjectPlayer.transform.childCount > 0)
					{
						empty = currentGameObjectPlayer.transform.GetChild(0).tag;
						fieldOfView = currentGameObjectPlayer.transform.GetChild(0).GetComponent<WeaponSounds>().fieldOfViewZomm;
					}
					if (!empty.Equals(string.Empty))
					{
						inGameGUI.SetScopeForWeapon(string.Empty + currentGameObjectPlayer.transform.GetChild(0).GetComponent<WeaponSounds>().scopeNum);
					}
					currentPlayerMoveCVidos.myCamera.fieldOfView = fieldOfView;
					currentPlayerMoveCVidos.gunCamera.fieldOfView = 1f;
				}
				else
				{
					currentPlayerMoveCVidos.myCamera.fieldOfView = 44f;
					currentPlayerMoveCVidos.gunCamera.fieldOfView = 75f;
					inGameGUI.ResetScope();
				}
			}
			if ((Defs.isFlag || Defs.isCompany || Defs.isCapturePoints) && WeaponManager.sharedManager.myPlayer != null)
			{
				GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
				int num = 0;
				int num2 = 0;
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i] != null)
					{
						int num3 = array[i].GetComponent<SkinName>().playerMoveC.myCommand;
						if (num3 == 1)
						{
							num++;
						}
						if (num3 == 2)
						{
							num2++;
						}
					}
				}
				if ((num > 5 && myCommand == 1) || (num2 > 5 && myCommand == 2))
				{
					int[] array2 = new int[(myCommand != 1) ? num2 : num];
					int num4 = 0;
					if (Defs.isInet)
					{
						for (int j = 0; j < array.Length; j++)
						{
							if (array[j].GetComponent<SkinName>().playerMoveC.myCommand == myCommand)
							{
								array2[num4++] = array[j].GetComponent<PhotonView>().ownerId;
							}
						}
						for (int k = 0; k < array2.Length - 1; k++)
						{
							for (int l = k; l < array2.Length; l++)
							{
								if (array2[k] > array2[l])
								{
									int num5 = array2[k];
									array2[k] = array2[l];
									array2[l] = num5;
								}
							}
						}
						int ownerId = GetComponent<PhotonView>().ownerId;
						int num6 = 0;
						for (int m = 0; m < array2.Length; m++)
						{
							if (array2[m] == ownerId)
							{
								num6 = m;
								break;
							}
						}
						if (num6 > 3)
						{
							ReplaceCommand();
						}
					}
				}
				if (Defs.isFlag)
				{
					timerFlag = TimeGameController.sharedController.timerToEndMatch;
					if (timerFlag < 0.0)
					{
						timerFlag = 0.0;
					}
					if (timerFlag < 0.10000000149011612)
					{
						if (scoreCommandFlag1 != scoreCommandFlag2)
						{
							Invoke("ClearScoreCommandInFlagGame", 0.5f);
							ExitGames.Client.Photon.Hashtable hashtable = new ExitGames.Client.Photon.Hashtable();
							hashtable["TimeMatchEnd"] = -9000000.0;
							PhotonNetwork.room.SetCustomProperties(hashtable);
							if (scoreCommandFlag1 > scoreCommandFlag2)
							{
								win(string.Empty, 1, scoreCommandFlag1, scoreCommandFlag2);
							}
							else
							{
								win(string.Empty, 2, scoreCommandFlag1, scoreCommandFlag2);
							}
						}
						else if (Initializer.bluePlayers.Count == 0 || Initializer.redPlayers.Count == 0)
						{
							if (inGameGUI.message_draw.activeSelf)
							{
								inGameGUI.message_draw.SetActive(false);
							}
						}
						else if (inGameGUI.message_now.activeSelf)
						{
							if (inGameGUI.message_draw.activeSelf)
							{
								inGameGUI.message_draw.SetActive(false);
							}
						}
						else if (!inGameGUI.message_draw.activeSelf)
						{
							inGameGUI.message_draw.SetActive(true);
						}
					}
				}
			}
			if (isHunger && hungerGameController != null && hungerGameController.isStartGame && !hungerGameController.isRunPlayer && !isEndInHunger)
			{
				UnityEngine.Debug.Log("Start hunger player");
				hungerGameController.isRunPlayer = true;
				isShowNickTable = false;
				CountKills = 0;
				score = 0;
				GlobalGameController.Score = 0;
				isDrawInHanger = false;
				startPlayer();
				countMigZagolovok = 0;
				timeTomig = 0.7f;
				isMigZag = false;
				SynhCountKills();
				SynhScore();
				return;
			}
			if (isHunger && hungerGameController != null && !hungerGameController.isStartGame)
			{
				string text = string.Empty;
				if (!hungerGameController.isStartTimer)
				{
					text = waitingPlayerLocalize;
				}
				else
				{
					if (hungerGameController.startTimer > 0f && !hungerGameController.isStartGame)
					{
						float startTimer = hungerGameController.startTimer;
						text = matchLocalize + " " + Mathf.FloorToInt(startTimer / 60f) + ":" + ((Mathf.FloorToInt(startTimer - (float)(Mathf.FloorToInt(startTimer / 60f) * 60)) >= 10) ? string.Empty : "0") + Mathf.FloorToInt(startTimer - (float)(Mathf.FloorToInt(startTimer / 60f) * 60));
					}
					if (hungerGameController.startTimer < 0f && !hungerGameController.isStartGame)
					{
						text = preparingLocalize;
					}
				}
				if (NetworkStartTableNGUIController.sharedController != null)
				{
					NetworkStartTableNGUIController.sharedController.HungerStartLabel.text = text;
				}
			}
		}
		if (!isLocal && isMine)
		{
			GlobalGameController.showTableMyPlayer = showTable;
			GlobalGameController.imDeadInHungerGame = isDeadInHungerGame;
		}
		if (isLocal && isServer && lanScan != null)
		{
			lanScan.serverMessage.connectedPlayers = GameObject.FindGameObjectsWithTag("NetworkTable").Length;
		}
		if (!(timerShow >= 0f))
		{
			return;
		}
		timerShow -= Time.deltaTime;
		if (timerShow < 0f)
		{
			if (_purchaseActivityIndicator == null)
			{
				UnityEngine.Debug.LogWarning("_purchaseActivityIndicator == null");
			}
			else
			{
				_purchaseActivityIndicator.SetActive(false);
			}
			ConnectSceneNGUIController.Local();
		}
	}

	private void OnPlayerConnected(PhotonPlayer player)
	{
		if (base.GetComponent<PhotonView>().isMine)
		{
			SynhCommand();
			SynhCountKills();
			SynhScore();
		}
	}

	private void OnDisconnectedFromPhoton(DisconnectCause info)
	{
		UnityEngine.Debug.Log("OnDisconnectedFromServer");
		showDisconnectFromServer = true;
		timerShow = 3f;
	}

	private void OnPlayerDisconnected(PhotonPlayer player)
	{
		PhotonNetwork.RemoveRPCs(player);
		PhotonNetwork.DestroyPlayerObjects(player);
		GameObject[] array = GameObject.FindGameObjectsWithTag("PlayerGun");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			NickLabelController[] lables = NickLabelStack.sharedStack.lables;
			NickLabelController[] array3 = lables;
			foreach (NickLabelController nickLabelController in array3)
			{
				if (nickLabelController.target == gameObject.transform)
				{
					nickLabelController.target = null;
					break;
				}
			}
			UnityEngine.Object.Destroy(gameObject.transform.parent.transform.gameObject);
		}
	}

	private void OnFailedToConnectToMasterServer(DisconnectCause info)
	{
		UnityEngine.Debug.Log("Could not connect to master server: " + info);
		showDisconnectFromMasterServer = true;
		timerShow = 3f;
	}

	public void WinInHunger()
	{
		isIwin = true;
		photonView.RPC("winInHungerRPC", PhotonTargets.AllBuffered, NamePlayer);
	}

	public void DrawInHanger()
	{
		if (photonView != null)
		{
			photonView.RPC("DrawInHangerRPC", PhotonTargets.AllBuffered);
		}
	}

	[PunRPC]
	public void DrawInHangerRPC()
	{
		isEndInHunger = true;
		isDrawInHanger = true;
		showTable = true;
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		for (int i = 0; i < array.Length; i++)
		{
			UnityEngine.Object.Destroy(array[i]);
		}
		if (_cam != null)
		{
			_cam.SetActive(true);
		}
		NickLabelController.currentCamera = GameObject.FindGameObjectWithTag("GameController").GetComponent<Initializer>().tc.GetComponent<Camera>();
		if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.ShowEndInterface("Time's out!");
		}
	}

	[PunRPC]
	public void winInHungerRPC(string winner)
	{
		isEndInHunger = true;
		if (_weaponManager != null && _weaponManager.myTable != null)
		{
			_weaponManager.myTable.GetComponent<NetworkStartTable>().win(winner);
		}
	}

	public static void IncreaseTimeInMode(int mode, double minutes)
	{
		if (!(ExperienceController.sharedController != null))
		{
			return;
		}
		string key = mode.ToString();
		string key2 = "Statistics.TimeInMode.Level" + ExperienceController.sharedController.currentLevel;
		if (PlayerPrefs.HasKey(key2))
		{
			string @string = PlayerPrefs.GetString(key2, "{}");
			UnityEngine.Debug.Log("Time in mode string:    " + @string);
			try
			{
				Dictionary<string, object> dictionary = (Rilisoft.MiniJson.Json.Deserialize(@string) as Dictionary<string, object>) ?? new Dictionary<string, object>();
				object value;
				if (dictionary.TryGetValue(key, out value))
				{
					double num = Convert.ToDouble(value) + minutes;
					dictionary[key] = num;
				}
				else
				{
					dictionary.Add(key, minutes);
				}
				string value2 = Rilisoft.MiniJson.Json.Serialize(dictionary);
				PlayerPrefs.SetString(key2, value2);
			}
			catch (OverflowException exception)
			{
				UnityEngine.Debug.LogError("Cannot deserialize time-in-mode:    " + @string);
				UnityEngine.Debug.LogException(exception);
			}
			catch (Exception exception2)
			{
				UnityEngine.Debug.LogError("Unknown exception:    " + @string);
				UnityEngine.Debug.LogException(exception2);
			}
		}
		string key3 = "Statistics.RoundsInMode.Level" + ExperienceController.sharedController.currentLevel;
		if (PlayerPrefs.HasKey(key3))
		{
			string string2 = PlayerPrefs.GetString(key3);
			Dictionary<string, object> dictionary2 = (Rilisoft.MiniJson.Json.Deserialize(string2) as Dictionary<string, object>) ?? new Dictionary<string, object>();
			object value3;
			if (dictionary2.TryGetValue(key, out value3))
			{
				int num2 = Convert.ToInt32(value3) + 1;
				dictionary2[key] = num2;
			}
			else
			{
				dictionary2.Add(key, 1);
			}
			string value4 = Rilisoft.MiniJson.Json.Serialize(dictionary2);
			PlayerPrefs.SetString(key3, value4);
		}
		PlayerPrefs.Save();
	}

	public void win(string winner, int _commandWin = 0, int blueCount = 0, int redCount = 0)
	{
		UnityEngine.Debug.Log("win _commandWin=" + _commandWin + " blueCount=" + blueCount + " redCount=" + redCount);
		_matchStopwatch.Stop();
		if (Defs.isHunger)
		{
			isEndInHunger = true;
		}
		if (Defs.isFlag && myCommand == _commandWin)
		{
			int val = Storager.getInt(Defs.RatingFlag, false) + 1;
			Storager.setInt(Defs.RatingFlag, val, false);
		}
		StoreKitEventListener.State.PurchaseKey = "End match";
		if (!Defs.isHunger)
		{
			int @int = PlayerPrefs.GetInt("CountMatch", 0);
			PlayerPrefs.SetInt("CountMatch", @int + 1);
			if (ExperienceController.sharedController != null)
			{
				string key = "Statistics.MatchCount.Level" + ExperienceController.sharedController.currentLevel;
				int int2 = PlayerPrefs.GetInt(key, 0);
				PlayerPrefs.SetInt(key, int2 + 1);
				FlurryPluginWrapper.LogMatchCompleted(ConnectSceneNGUIController.regim.ToString());
			}
			IncreaseTimeInMode((int)ConnectSceneNGUIController.regim, _matchStopwatch.Elapsed.TotalMinutes);
			WWWForm wWWForm = new WWWForm();
			wWWForm.AddField("action", "time_in_match");
			wWWForm.AddField("mode", (int)ConnectSceneNGUIController.regim);
			wWWForm.AddField("time", _matchStopwatch.Elapsed.TotalSeconds.ToString());
			wWWForm.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			wWWForm.AddField("uniq_id", FriendsController.sharedController.id);
			wWWForm.AddField("auth", FriendsController.Hash("time_in_match"));
			if (ExperienceController.sharedController != null)
			{
				wWWForm.AddField("level", ExperienceController.sharedController.currentLevel);
			}
			wWWForm.AddField("paying", Convert.ToInt32(FlurryPluginWrapper.IsPayingUser()).ToString());
			wWWForm.AddField("developer", Convert.ToInt32(Defs.IsDeveloperBuild).ToString());
			UnityEngine.Debug.Log("Time in Match Event: " + Encoding.UTF8.GetString(wWWForm.data, 0, wWWForm.data.Length));
			WWW wWW = new WWW(URLs.Friends, wWWForm);
			_matchStopwatch.Reset();
		}
		isShowAvard = false;
		commandWinner = _commandWin;
		GlobalGameController.countKillsBlue = 0;
		GlobalGameController.countKillsRed = 0;
		int int3 = Storager.getInt(Defs.COOPScore, false);
		if (GlobalGameController.Score > int3)
		{
			Storager.setInt(Defs.COOPScore, GlobalGameController.Score, false);
			FriendsController.sharedController.coopScore = GlobalGameController.Score;
			FriendsController.sharedController.SendOurData(false);
		}
		nickPobeditelya = winner;
		GameObject[] array = GameObject.FindGameObjectsWithTag("NetworkTable");
		List<GameObject> list = new List<GameObject>();
		List<GameObject> list2 = new List<GameObject>();
		List<GameObject> list3 = new List<GameObject>();
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.Deathmatch)
		{
			isDrawInDeathMatch = true;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i].GetComponent<NetworkStartTable>().score >= AdminSettingsController.minScoreDeathMath)
				{
					isDrawInDeathMatch = false;
				}
			}
		}
		for (int j = 1; j < array.Length; j++)
		{
			NetworkStartTable component = array[j].GetComponent<NetworkStartTable>();
			for (int k = 0; k < j; k++)
			{
				NetworkStartTable component2 = array[k].GetComponent<NetworkStartTable>();
				if ((!Defs.isFlag && (component.score > component2.score || (component.score == component2.score && component.CountKills > component2.CountKills))) || (Defs.isFlag && (component.CountKills > component2.CountKills || (component.CountKills == component2.CountKills && component.score > component2.score))))
				{
					GameObject gameObject = array[j];
					for (int num = j - 1; num >= k; num--)
					{
						array[num + 1] = array[num];
					}
					array[k] = gameObject;
					break;
				}
			}
		}
		int num2 = 0;
		for (int l = 0; l < array.Length; l++)
		{
			int num3 = array[l].GetComponent<NetworkStartTable>().myCommand;
			if (num3 == -1)
			{
				num3 = array[l].GetComponent<NetworkStartTable>().myCommandOld;
			}
			if (num3 == 0)
			{
				if (array[l].Equals(base.gameObject))
				{
					num2 = list3.Count;
				}
				list3.Add(array[l]);
			}
			if (num3 == 1)
			{
				if (array[l].Equals(base.gameObject))
				{
					num2 = list.Count;
				}
				list.Add(array[l]);
			}
			if (num3 == 2)
			{
				if (array[l].Equals(base.gameObject))
				{
					num2 = list2.Count;
				}
				list2.Add(array[l]);
			}
		}
		oldSpisokName = new string[list3.Count];
		oldScoreSpisok = new string[list3.Count];
		oldCountLilsSpisok = new string[list3.Count];
		oldSpisokRanks = new int[list3.Count];
		oldIsDeadInHungerGame = new bool[list3.Count];
		oldSpisokPixelBookID = new string[list3.Count];
		oldSpisokMyClanLogo = new Texture[list3.Count];
		oldSpisokNameBlue = new string[list.Count];
		oldCountLilsSpisokBlue = new string[list.Count];
		oldSpisokRanksBlue = new int[list.Count];
		oldSpisokPixelBookIDBlue = new string[list.Count];
		oldSpisokMyClanLogoBlue = new Texture[list.Count];
		oldScoreSpisokBlue = new string[list.Count];
		oldSpisokNameRed = new string[list2.Count];
		oldCountLilsSpisokRed = new string[list2.Count];
		oldSpisokRanksRed = new int[list2.Count];
		oldSpisokPixelBookIDRed = new string[list2.Count];
		oldSpisokMyClanLogoRed = new Texture[list2.Count];
		oldScoreSpisokRed = new string[list2.Count];
		addCoins = 0;
		addExperience = 0;
		if (isInet)
		{
			UnityEngine.Debug.Log("myCommand=" + myCommand + " _commandWin=" + _commandWin);
			if (myCommand == _commandWin || (!Defs.isCompany && !Defs.isFlag && !Defs.isCapturePoints))
			{
				int timeGame = int.Parse(PhotonNetwork.room.customProperties["MaxKill"].ToString());
				AdminSettingsController.Avard avardAfterMatch = AdminSettingsController.GetAvardAfterMatch(ConnectSceneNGUIController.regim, timeGame, num2, score, CountKills, isIwin);
				addCoins = avardAfterMatch.coin;
				addExperience = avardAfterMatch.expierense;
			}
			if (addCoins > 0 || addExperience > 0)
			{
				if (Defs.isCompany)
				{
					int val2 = Storager.getInt(Defs.RatingTeamBattle, false) + 1;
					Storager.setInt(Defs.RatingTeamBattle, val2, false);
				}
				if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.Deathmatch)
				{
					int val3 = Storager.getInt(Defs.RatingDeathmatch, false) + 1;
					Storager.setInt(Defs.RatingDeathmatch, val3, false);
				}
				if (ExperienceController.sharedController != null)
				{
					string key2 = "Statistics.WinCount.Level" + ExperienceController.sharedController.currentLevel;
					int int4 = PlayerPrefs.GetInt(key2, 0);
					PlayerPrefs.SetInt(key2, int4 + 1);
					FlurryPluginWrapper.LogWinInMatch(ConnectSceneNGUIController.regim.ToString());
				}
				isShowAvard = true;
				if (PhotonNetwork.room != null && !PhotonNetwork.room.customProperties["pass"].Equals(string.Empty))
				{
					addCoins = 0;
					addExperience = 0;
					isShowAvard = false;
				}
				if (!Defs.isCOOP)
				{
					FriendsController.sharedController.SendRoundWon();
					if (PlayerPrefs.GetInt("LogCountMatch", 0) == 1)
					{
						PlayerPrefs.SetInt("LogCountMatch", 0);
						int int5 = PlayerPrefs.GetInt("CountMatch", 0);
						Dictionary<string, string> dictionary = new Dictionary<string, string>();
						dictionary.Add("Count matchs", int5.ToString());
						Dictionary<string, string> parameters = dictionary;
						FlurryPluginWrapper.LogEventAndDublicateToConsole("First WIN in Multiplayer", parameters);
						if (Social.localUser.authenticated)
						{
							string achievementID = "CgkIr8rGkPIJEAIQAg";
							Social.ReportProgress(achievementID, 100.0, delegate(bool success)
							{
								UnityEngine.Debug.Log("Achievement First Win completed: " + success);
							});
						}
					}
				}
			}
		}
		for (int m = 0; m < list3.Count; m++)
		{
			if ((bool)_weaponManager && list3[m].Equals(_weaponManager.myTable))
			{
				oldIndexMy = m;
			}
			oldSpisokName[m] = list3[m].GetComponent<NetworkStartTable>().NamePlayer;
			oldSpisokRanks[m] = list3[m].GetComponent<NetworkStartTable>().myRanks;
			oldSpisokPixelBookID[m] = list3[m].GetComponent<NetworkStartTable>().pixelBookID;
			oldSpisokMyClanLogo[m] = list3[m].GetComponent<NetworkStartTable>().myClanTexture;
			oldScoreSpisok[m] = ((list3[m].GetComponent<NetworkStartTable>().score == -1) ? (string.Empty + list3[m].GetComponent<NetworkStartTable>().scoreOld) : (string.Empty + list3[m].GetComponent<NetworkStartTable>().score));
			oldCountLilsSpisok[m] = ((list3[m].GetComponent<NetworkStartTable>().CountKills == -1) ? (string.Empty + list3[m].GetComponent<NetworkStartTable>().oldCountKills) : (string.Empty + list3[m].GetComponent<NetworkStartTable>().CountKills));
			oldIsDeadInHungerGame[m] = list3[m].GetComponent<NetworkStartTable>().isDeadInHungerGame;
		}
		for (int n = 0; n < list.Count; n++)
		{
			if ((bool)_weaponManager && list[n].Equals(_weaponManager.myTable))
			{
				oldIndexMy = n;
			}
			oldSpisokNameBlue[n] = list[n].GetComponent<NetworkStartTable>().NamePlayer;
			oldSpisokRanksBlue[n] = list[n].GetComponent<NetworkStartTable>().myRanks;
			oldSpisokPixelBookIDBlue[n] = list[n].GetComponent<NetworkStartTable>().pixelBookID;
			oldSpisokMyClanLogoBlue[n] = list[n].GetComponent<NetworkStartTable>().myClanTexture;
			oldScoreSpisokBlue[n] = ((list[n].GetComponent<NetworkStartTable>().score == -1) ? (string.Empty + list[n].GetComponent<NetworkStartTable>().scoreOld) : (string.Empty + list[n].GetComponent<NetworkStartTable>().score));
			oldCountLilsSpisokBlue[n] = ((list[n].GetComponent<NetworkStartTable>().CountKills == -1) ? (string.Empty + list[n].GetComponent<NetworkStartTable>().oldCountKills) : (string.Empty + list[n].GetComponent<NetworkStartTable>().CountKills));
		}
		for (int num4 = 0; num4 < list2.Count; num4++)
		{
			if ((bool)_weaponManager && list2[num4].Equals(_weaponManager.myTable))
			{
				oldIndexMy = num4;
			}
			oldSpisokNameRed[num4] = list2[num4].GetComponent<NetworkStartTable>().NamePlayer;
			oldSpisokRanksRed[num4] = list2[num4].GetComponent<NetworkStartTable>().myRanks;
			oldSpisokPixelBookIDRed[num4] = list2[num4].GetComponent<NetworkStartTable>().pixelBookID;
			oldSpisokMyClanLogoRed[num4] = list2[num4].GetComponent<NetworkStartTable>().myClanTexture;
			oldScoreSpisokRed[num4] = ((list2[num4].GetComponent<NetworkStartTable>().score == -1) ? (string.Empty + list2[num4].GetComponent<NetworkStartTable>().scoreOld) : (string.Empty + list2[num4].GetComponent<NetworkStartTable>().score));
			oldCountLilsSpisokRed[num4] = ((list2[num4].GetComponent<NetworkStartTable>().CountKills == -1) ? (string.Empty + list2[num4].GetComponent<NetworkStartTable>().oldCountKills) : (string.Empty + list2[num4].GetComponent<NetworkStartTable>().CountKills));
		}
		myCommandOld = myCommand;
		oldCountKills = CountKills;
		scoreOld = score;
		score = -1;
		GlobalGameController.Score = -1;
		scoreCommandFlag1 = 0;
		scoreCommandFlag2 = 0;
		CountKills = -1;
		if (isCompany || Defs.isFlag || Defs.isCapturePoints)
		{
			myCommand = -1;
		}
		SynhCommand();
		SynhCountKills();
		SynhScore();
		NickLabelController.currentCamera = GameObject.FindGameObjectWithTag("GameController").GetComponent<Initializer>().tc.GetComponent<Camera>();
		if (WeaponManager.sharedManager.myPlayerMoveC != null && WeaponManager.sharedManager.myPlayerMoveC.showRanks)
		{
			NetworkStartTableNGUIController.sharedController.BackPressFromRanksTable(true);
		}
		if (!isInet)
		{
			DestroyMyPlayer();
		}
		else if ((bool)_weaponManager && (bool)_weaponManager.myPlayer)
		{
			PhotonNetwork.Destroy(_weaponManager.myPlayer);
		}
		GameObject gameObject2 = GameObject.FindGameObjectWithTag("DamageFrame");
		if (gameObject2 != null)
		{
			UnityEngine.Object.Destroy(gameObject2);
		}
		if (_cam != null)
		{
			_cam.SetActive(true);
			_cam.GetComponent<RPG_Camera>().enabled = false;
		}
		string winner2;
		if (isCompany || Defs.isFlag || Defs.isCapturePoints)
		{
			string text = string.Format("{0}{1}", LocalizationStore.Get("Key_0569"), LocalizationStore.Key_0318);
			string text2 = string.Format("{0}{1}", LocalizationStore.Get("Key_0569"), LocalizationStore.Key_0319);
			string key_ = LocalizationStore.Key_0571;
			winner2 = ((commandWinner == 1) ? text : ((commandWinner != 2) ? key_ : text2));
		}
		else
		{
			winner2 = (((isHunger && isDrawInHanger) || isDrawInDeathMatch) ? LocalizationStore.Key_0568 : ((!((!Defs.isHunger) ? (num2 == 0) : isIwin)) ? LocalizationStore.Get("Key_1116") : LocalizationStore.Get("Key_1115")));
		}
		if (Defs.isInet && NetworkStartTableNGUIController.sharedController != null && !isSetNewMapButton)
		{
			NetworkStartTableNGUIController.sharedController.UpdateGoMapButtons();
		}
		if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.totalBlue.text = blueCount.ToString();
			NetworkStartTableNGUIController.sharedController.totalRed.text = redCount.ToString();
			NetworkStartTableNGUIController.sharedController.ranksTable.totalBlue = blueCount;
			NetworkStartTableNGUIController.sharedController.ranksTable.totalRed = redCount;
		}
		if (isShowAvard)
		{
			if (NetworkStartTableNGUIController.sharedController != null)
			{
				NetworkStartTableNGUIController.sharedController.showAvardPanel(winner2, addCoins, addExperience, !Defs.isInet || (PhotonNetwork.room != null && !PhotonNetwork.room.customProperties["pass"].Equals(string.Empty)));
			}
		}
		else if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.ShowEndInterface(winner2);
		}
		isShowAvard = false;
		showTable = false;
		isShowNickTable = true;
	}

	[Obfuscation(Exclude = true)]
	private void DestroyMyPlayer()
	{
		if (WeaponManager.sharedManager.myPlayer != null)
		{
			PhotonNetwork.RemoveRPCs(_weaponManager.myPlayer.GetComponent<PhotonView>());
			PhotonNetwork.Destroy(_weaponManager.myPlayer);
		}
	}

	private void finishTable()
	{
		playersTable();
	}

	public void MyOnGUI()
	{
		if (experienceController.isShowAdd)
		{
			GUI.enabled = false;
		}
		if (showDisconnectFromServer)
		{
			GUI.DrawTexture(new Rect((float)(Screen.width / 2) - (float)serverLeftTheGame.width * 0.5f * koofScreen, (float)(Screen.height / 2) - (float)serverLeftTheGame.height * 0.5f * koofScreen, (float)serverLeftTheGame.width * koofScreen, (float)serverLeftTheGame.height * koofScreen), serverLeftTheGame);
			GUI.enabled = false;
		}
		if (showDisconnectFromMasterServer)
		{
			GUI.DrawTexture(new Rect((float)(Screen.width / 2) - (float)serverLeftTheGame.width * 0.5f * koofScreen, (float)(Screen.height / 2) - (float)serverLeftTheGame.height * 0.5f * koofScreen, (float)serverLeftTheGame.width * koofScreen, (float)serverLeftTheGame.height * koofScreen), serverLeftTheGame);
		}
		if (showTable)
		{
			playersTable();
		}
		if (isShowNickTable)
		{
			finishTable();
		}
		if (showMessagFacebook)
		{
			labelStyle.fontSize = Player_move_c.FontSizeForMessages;
			GUI.Label(Player_move_c.SuccessMessageRect(), _SocialSentSuccess("Facebook"), labelStyle);
		}
		if (showMessagTiwtter)
		{
			labelStyle.fontSize = Player_move_c.FontSizeForMessages;
			GUI.Label(Player_move_c.SuccessMessageRect(), _SocialSentSuccess("Twitter"), labelStyle);
		}
		GUI.enabled = true;
	}

	[Obfuscation(Exclude = true)]
	public void ClearScoreCommandInFlagGame()
	{
		photonView.RPC("ClearScoreCommandInFlagGameRPC", PhotonTargets.Others);
	}

	[PunRPC]
	public void ClearScoreCommandInFlagGameRPC()
	{
		if (WeaponManager.sharedManager.myTable != null)
		{
			WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().scoreCommandFlag1 = 0;
			WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().scoreCommandFlag2 = 0;
		}
	}

	private void AddFlag()
	{
		GameObject gameObject = GameObject.FindGameObjectWithTag("BazaZoneCommand1");
		GameObject gameObject2 = GameObject.FindGameObjectWithTag("BazaZoneCommand2");
		GameObject gameObject3 = PhotonNetwork.InstantiateSceneObject("Flags/Flag1", gameObject.transform.position, gameObject.transform.rotation, 0, null);
		GameObject gameObject4 = PhotonNetwork.InstantiateSceneObject("Flags/Flag2", gameObject2.transform.position, gameObject2.transform.rotation, 0, null);
	}

	[PunRPC]
	private void AddPaticleBazeRPC(int _command)
	{
		GameObject gameObject = GameObject.FindGameObjectWithTag("BazaZoneCommand" + _command);
		UnityEngine.Object.Instantiate(Resources.Load((_command != 1) ? "Ring_Particle_Red" : "Ring_Particle_Blue"), new Vector3(gameObject.transform.position.x, gameObject.transform.position.y + 0.22f, gameObject.transform.position.z), gameObject.transform.rotation);
	}

	public void AddScore()
	{
		CountKills++;
		GlobalGameController.CountKills = CountKills;
		photonView.RPC("AddPaticleBazeRPC", PhotonTargets.All, myCommand);
		if (myCommand == 1)
		{
			photonView.RPC("SynchScoreCommandRPC", PhotonTargets.All, 1, scoreCommandFlag1 + 1);
		}
		else
		{
			photonView.RPC("SynchScoreCommandRPC", PhotonTargets.All, 2, scoreCommandFlag2 + 1);
		}
		SynhCountKills();
	}

	[PunRPC]
	private void SynchScoreCommandRPC(int _command, int _score)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("NetworkTable");
		for (int i = 0; i < array.Length; i++)
		{
			if (_command == 1)
			{
				array[i].GetComponent<NetworkStartTable>().scoreCommandFlag1 = _score;
			}
			else
			{
				array[i].GetComponent<NetworkStartTable>().scoreCommandFlag2 = _score;
			}
		}
	}

	private void OnDestroy()
	{
		if (isMine)
		{
			ShopNGUIController.sharedShop.onEquipSkinAction = null;
			RemoveShop(false);
			if (networkStartTableNGUIController != null)
			{
				UnityEngine.Object.Destroy(networkStartTableNGUIController.gameObject);
			}
			if (ShopNGUIController.sharedShop != null)
			{
				ShopNGUIController.sharedShop.resumeAction = null;
			}
		}
	}
}
