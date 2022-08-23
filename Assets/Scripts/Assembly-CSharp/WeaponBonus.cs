using System.Collections.Generic;
using Photon;
using UnityEngine;

public class WeaponBonus : Photon.MonoBehaviour
{
	public GameObject weaponPrefab;

	private GameObject _player;

	private Player_move_c _playerMoveC;

	private bool runLoading;

	private bool oldIsMaster;

	public WeaponManager _weaponManager;

	private bool isHunger;

	public bool isKilled;

	private void Start()
	{
		string text = base.gameObject.name.Substring(0, base.gameObject.name.Length - 13);
		weaponPrefab = Resources.Load("Weapons/" + text) as GameObject;
		_weaponManager = WeaponManager.sharedManager;
		isHunger = Defs.isHunger;
		if (!isHunger)
		{
			_player = GameObject.FindGameObjectWithTag("Player");
			_playerMoveC = GameObject.FindGameObjectWithTag("PlayerGun").GetComponent<Player_move_c>();
		}
		else
		{
			_player = _weaponManager.myPlayer;
			if (_player != null)
			{
				_playerMoveC = _player.GetComponent<SkinName>().playerGameObject.GetComponent<Player_move_c>();
			}
		}
		if (!Defs.IsSurvival && !isHunger)
		{
			GameObject gameObject = Object.Instantiate(Resources.Load("BonusFX") as GameObject, Vector3.zero, Quaternion.identity) as GameObject;
			gameObject.transform.parent = base.transform;
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.layer = base.gameObject.layer;
			ZombieCreator.SetLayerRecursively(gameObject, base.gameObject.layer);
		}
	}

	private void Update()
	{
		if (!oldIsMaster && PhotonNetwork.isMasterClient && isKilled)
		{
			PhotonNetwork.Destroy(base.gameObject);
			return;
		}
		oldIsMaster = PhotonNetwork.isMasterClient;
		float num = 120f;
		base.transform.Rotate(base.transform.InverseTransformDirection(Vector3.up), num * Time.deltaTime);
		if (runLoading)
		{
			return;
		}
		if (isHunger && (_player == null || _playerMoveC == null))
		{
			_player = _weaponManager.myPlayer;
			if (!(_player != null))
			{
				return;
			}
			_playerMoveC = _player.GetComponent<SkinName>().playerGameObject.GetComponent<Player_move_c>();
		}
		if (_playerMoveC.isGrenadePress || isKilled || _playerMoveC.isKilled || !(Vector3.SqrMagnitude(base.transform.position - _player.transform.position) < 2.25f))
		{
			return;
		}
		_playerMoveC.AddWeapon(weaponPrefab);
		isKilled = true;
		if (Defs.IsSurvival || Defs.IsTraining || isHunger)
		{
			if (Defs.IsTraining)
			{
				TrainingController.isNextStep = TrainingController.stepTrainingList["GetTheGun"];
			}
			if (!isHunger)
			{
				Object.Destroy(base.gameObject);
			}
			else
			{
				base.photonView.RPC("DestroyRPC", PhotonTargets.AllBuffered);
			}
			return;
		}
		string[] array = Storager.getString(Defs.WeaponsGotInCampaign, false).Split('#');
		List<string> list = new List<string>();
		string[] array2 = array;
		foreach (string item in array2)
		{
			list.Add(item);
		}
		if (!list.Contains(LevelBox.weaponsFromBosses[Application.loadedLevelName]))
		{
			list.Add(LevelBox.weaponsFromBosses[Application.loadedLevelName]);
			Storager.setString(Defs.WeaponsGotInCampaign, string.Join("#", list.ToArray()), false);
		}
		Object.Destroy(base.gameObject);
		runLoading = true;
		LevelCompleteLoader.action = null;
		LevelCompleteLoader.sceneName = "LevelComplete";
		AutoFade.LoadLevel("LevelToCompleteProm", 2f, 0f, Color.white);
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.SetEnablePerfectLabel(true);
		}
		GameObject gameObject = Object.Instantiate(Resources.Load("PauseONGuiDrawer") as GameObject) as GameObject;
		gameObject.transform.parent = base.transform;
	}

	[RPC]
	public void DestroyRPC()
	{
		if (PhotonNetwork.isMasterClient)
		{
			PhotonNetwork.Destroy(base.gameObject);
		}
		else
		{
			base.transform.position = new Vector3(0f, -10000f, 0f);
		}
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.SetEnablePerfectLabel(false);
		}
	}

	private void OnDestroy()
	{
		if (!Defs.IsSurvival && !Defs.IsTraining && !isHunger)
		{
		}
	}
}
