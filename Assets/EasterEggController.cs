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

    private IEnumerator MoveToGameScene(string _goMapName)
	{
		Debug.Log("MoveToGameScene=" + _goMapName);
		Defs.isGameFromFriends = false;
		Defs.isGameFromClans = false;
		yield return null;
		yield return Resources.UnloadUnusedAssets();
		StartCoroutine(SetFonLoadingWaitForReset(_goMapName, true));
		AsyncOperation async = Application.LoadLevelAsync("PromScene");
		FlurryPluginWrapper.LogEvent("Play_" + _goMapName);
		yield return async;
	}

    private void ShowLoadingGUI(string _mapName)
	{
		_loadingNGUIController = (UnityEngine.Object.Instantiate(Resources.Load<GameObject>("LoadingGUI")) as GameObject).GetComponent<LoadingNGUIController>();
		_loadingNGUIController.SceneToLoad = _mapName;
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
