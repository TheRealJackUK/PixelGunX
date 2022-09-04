using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using ExitGames.Client.Photon;
using Rilisoft;

public class EasterEggController : MonoBehaviour
{
    public ButtonHandler AngryHerobrineButton;
    public ButtonHandler BryantButton;
    public ButtonHandler BackButton;
    private LoadingNGUIController _loadingNGUIController;
    public string theName = "";

    public enum PlatformConnect
	{
		ios = 1,
		android,
		custom
	}

	public enum RegimGame
	{
		Deathmatch,
		TimeBattle,
		TeamFight,
		DeadlyGames,
		FlagCapture,
		CapturePoints
	}

    private void JoinRandomRoom()
	{
		string goMapName = theName;
		ExitGames.Client.Photon.Hashtable hashtable = new ExitGames.Client.Photon.Hashtable();
		hashtable["pass"] = "this is a secret map, you won't be able to enter this match, god bye";
		hashtable["map"] = Defs.levelNumsForMusicInMult[theName];
		hashtable["starting"] = 0;
		hashtable["regim"] = RegimGame.Deathmatch;
		hashtable["platform"] = (int)PlatformConnect.custom;
		if (ExperienceController.sharedController != null)
		{
			for (int i = 0; i < ExperienceController.maxLevel; i++)
			{
				if (ExperienceController.accessByLevels[ExperienceController.sharedController.currentLevel - 1, i] == 0)
				{
					hashtable["Level_" + (i + 1)] = 0;
				}
			}
		}
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(goMapName) ? Defs.filterMaps[goMapName] : 0);
		}
		StartCoroutine(SetFonLoadingWaitForReset(goMapName));
		PlayerPrefs.SetString("TypeGame", "client");
		PhotonNetwork.JoinRandomRoom(hashtable, 0);
	}

	private void OnPhotonRandomJoinFailed()
	{
		Debug.Log("OnPhotonJoinRoomFailed");
		PlayerPrefs.SetString("TypeGame", "server");
		int num = 7;
		string[] array = new string[num + ExperienceController.maxLevel];
		array[0] = "starting";
		array[1] = "map";
		array[2] = "MaxKill";
		array[3] = "pass";
		array[4] = "regim";
		array[5] = "TimeMatchEnd";
		array[6] = "platform";
		for (int i = num; i < num + ExperienceController.maxLevel; i++)
		{
			array[i] = "Level_" + (i - num + 1);
		}
		ExitGames.Client.Photon.Hashtable hashtable = new ExitGames.Client.Photon.Hashtable();
		PlayerPrefs.SetString("PlayersLimits", "10");
		hashtable["starting"] = 0;
		hashtable["map"] = Defs.levelNumsForMusicInMult[theName];
		hashtable["MaxKill"] = 4;
		hashtable["pass"] = "this is a secret map, you won't be able to enter this match, god bye";
		hashtable["regim"] = RegimGame.Deathmatch;
		hashtable["TimeMatchEnd"] = PhotonNetwork.time;
		hashtable["platform"] = (int)PlatformConnect.custom;
		for (int j = num; j < num + ExperienceController.maxLevel; j++)
		{
			hashtable["Level_" + (j - num + 1)] = ((ExperienceController.sharedController != null && ExperienceController.sharedController.currentLevel == j - num + 1) ? 1 : 0);
		}
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(theName) ? Defs.filterMaps[theName] : 0);
		}
		StartCoroutine(SetFonLoadingWaitForReset(theName));
		PhotonNetwork.CreateRoom("", 10, hashtable, array);
		Debug.LogError("calling createroom!");
	}

    private IEnumerator MoveToGameScene(string _goMapName)
	{
		Debug.Log("MoveToGameScene=" + _goMapName);
		Defs.isGameFromFriends = false;
		Defs.isGameFromClans = false;
		Defs.isMulti = true;
		Defs.isInet = true;
		Defs.isCOOP = false;
		Defs.isCompany = false;
		Defs.isHunger = false;
		Defs.isFlag = false;
		Defs.isCapturePoints = false;
		Defs.IsSurvival = false;
		yield return null;
		yield return Resources.UnloadUnusedAssets();
		StartCoroutine(SetFonLoadingWaitForReset(_goMapName, true));
		AsyncOperation async = Application.LoadLevelAsync("PromScene");
		FlurryPluginWrapper.LogEvent("Play_" + _goMapName);
		yield return async;
	}

    private void ShowLoadingGUI(string _mapName)
	{
		LoadConnectScene.textureToShow = Resources.Load("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading_" + _mapName) as Texture2D;
		LoadConnectScene.sceneToLoad = theName;
		_loadingNGUIController = (UnityEngine.Object.Instantiate(Resources.Load<GameObject>("LoadingGUI")) as GameObject).GetComponent<LoadingNGUIController>();
		_loadingNGUIController.SceneToLoad = theName;
		_loadingNGUIController.loadingNGUITexture.mainTexture = LoadConnectScene.textureToShow;
		_loadingNGUIController.transform.parent = null;
		_loadingNGUIController.transform.localPosition = Vector3.zero;
		_loadingNGUIController.Init();
	}

    private IEnumerator SetFonLoadingWaitForReset(string _mapName = "", bool isAddCountRun = false)
	{
		if (_loadingNGUIController != null)
		{
			UnityEngine.Object.Destroy(_loadingNGUIController.gameObject);
			_loadingNGUIController = null;
		}
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

    public void OnConnectedToMaster()
	{
		Debug.Log("OnConnectedToMaster");
		PhotonNetwork.playerName = Defs.GetPlayerNameOrDefault();
		JoinRandomRoom();
	}

    public void HandleBack(object sender, System.EventArgs e){
        Application.LoadLevel(Defs.MainMenuScene);
	}

    public void HandleBryant(object sender, System.EventArgs e){
        LoadMap("Pool_Brian");
	}

    public void HandleAngryHerobrine(object sender, System.EventArgs e){
        LoadMap("gameplay slender 5");
	}

	private void OnJoinedRoom()
	{
		Debug.Log("OnJoinedRoom " + theName);
		PhotonNetwork.isMessageQueueRunning = false;
		NotificationController.ResetPaused();
		StartCoroutine(MoveToGameScene(theName));
	}

    public void Start() {
        if (BackButton != null)
		{
			BackButton.Clicked += HandleBack;
		}
        if (AngryHerobrineButton != null)
		{
			AngryHerobrineButton.Clicked += HandleAngryHerobrine;
		}
		if (BryantButton != null)
		{
			BryantButton.Clicked += HandleBryant;
		}
    }

    public void LoadMap(string name) {
        Defs.isMulti = true;
        if (_loadingNGUIController != null)
		{
			UnityEngine.Object.Destroy(_loadingNGUIController.gameObject);
			_loadingNGUIController = null;
		}
		theName = name;
        int gameTier = 1;
		Debug.LogError(Initializer.Separator + RegimGame.Deathmatch.ToString() + gameTier + "v" + GlobalGameController.MultiplayerProtocolVersion);
		PhotonNetwork.ConnectUsingSettings(Initializer.Separator + RegimGame.Deathmatch.ToString() + gameTier + "v" + GlobalGameController.MultiplayerProtocolVersion);
    }
}
