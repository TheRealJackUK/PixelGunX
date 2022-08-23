using System;
using System.Collections.Generic;
using UnityEngine;

public sealed class ZombiManager : MonoBehaviour
{
	public static ZombiManager sharedManager;

	public double timeGame;

	public float nextTimeSynch;

	public float nextAddZombi;

	public List<string> zombiePrefabs = new List<string>();

	private List<string[]> _enemies = new List<string[]>();

	private GameObject[] _enemyCreationZones;

	public bool startGame;

	public double maxTimeGame = 240.0;

	public PhotonView photonView;

	private void Awake()
	{
		//Discarded unreachable code: IL_00ae
		try
		{
			string[] array = null;
			array = new string[10] { "1", "15", "14", "2", "3", "9", "11", "12", "10", "16" };
			string[] array2 = array;
			foreach (string text in array2)
			{
				string item = "Enemies/Enemy" + text + "_go";
				zombiePrefabs.Add(item);
			}
		}
		catch (Exception exception)
		{
			Debug.LogError("Cooperative mode failure.");
			Debug.LogException(exception);
			throw;
		}
	}

	private void Start()
	{
		//Discarded unreachable code: IL_0064
		if (!Defs.isMulti && !Defs.isCOOP)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
		sharedManager = this;
		try
		{
			nextAddZombi = 5f;
			_enemyCreationZones = GameObject.FindGameObjectsWithTag("EnemyCreationZone");
			photonView = PhotonView.Get(this);
		}
		catch (Exception exception)
		{
			Debug.LogError("Cooperative mode failure.");
			Debug.LogException(exception);
			throw;
		}
	}

	[RPC]
	private void synchTime(float _time)
	{
	}

	public void EndMatch()
	{
		if (!photonView.isMine)
		{
			return;
		}
		startGame = false;
		timeGame = 0.0;
		GameObject[] array = GameObject.FindGameObjectsWithTag("NetworkTable");
		float num = -100f;
		string text = string.Empty;
		int num2 = 0;
		for (int i = 0; i < array.Length; i++)
		{
			if ((float)array[i].GetComponent<NetworkStartTable>().score > num)
			{
				num = array[i].GetComponent<NetworkStartTable>().score;
				text = array[i].GetComponent<NetworkStartTable>().NamePlayer;
				num2 = i;
			}
		}
		photonView.RPC("win", PhotonTargets.All, text);
		photonView.RPC("WinID", PhotonTargets.All, array[num2].GetComponent<PhotonView>().ownerId);
	}

	private void Update()
	{
		//Discarded unreachable code: IL_0158
		try
		{
			int num = GameObject.FindGameObjectsWithTag("Player").Length;
			if (!startGame && num > 0)
			{
				startGame = true;
				timeGame = 0.0;
				nextTimeSynch = 0f;
				nextAddZombi = 0f;
			}
			if (startGame && num == 0)
			{
				startGame = false;
				timeGame = 0.0;
				nextTimeSynch = 0f;
				nextAddZombi = 0f;
			}
			if (!startGame)
			{
				return;
			}
			timeGame = maxTimeGame - TimeGameController.sharedController.timerToEndMatch;
			if (timeGame > (double)nextAddZombi && photonView.isMine && GameObject.FindGameObjectsWithTag("Enemy").Length < 15)
			{
				float num2 = 4f;
				if (timeGame > maxTimeGame * 0.4000000059604645)
				{
					num2 = 3f;
				}
				if (timeGame > maxTimeGame * 0.800000011920929)
				{
					num2 = 2f;
				}
				nextAddZombi += num2;
				addZombi();
			}
		}
		catch (Exception exception)
		{
			Debug.LogError("Cooperative mode failure.");
			Debug.LogException(exception);
			throw;
		}
	}

	[RPC]
	private void win(string _winer)
	{
		WeaponManager.sharedManager.myNetworkStartTable.win(_winer);
	}

	private void addZombi()
	{
		GameObject gameObject = _enemyCreationZones[UnityEngine.Random.Range(0, _enemyCreationZones.Length)];
		BoxCollider component = gameObject.GetComponent<BoxCollider>();
		Vector2 vector = new Vector2(component.size.x * gameObject.transform.localScale.x, component.size.z * gameObject.transform.localScale.z);
		Rect rect = new Rect(gameObject.transform.position.x - vector.x / 2f, gameObject.transform.position.z - vector.y / 2f, vector.x, vector.y);
		Vector3 position = new Vector3(rect.x + UnityEngine.Random.Range(0f, rect.width), (!Defs.levelsWithVarY.Contains(GlobalGameController.currentLevel)) ? 0f : gameObject.transform.position.y, rect.y + UnityEngine.Random.Range(0f, rect.height));
		int index = 0;
		double num = timeGame / maxTimeGame * 100.0;
		if (num < 15.0)
		{
			index = UnityEngine.Random.Range(0, 3);
		}
		if (num >= 15.0 && num < 30.0)
		{
			index = UnityEngine.Random.Range(0, 5);
		}
		if (num >= 30.0 && num < 45.0)
		{
			index = UnityEngine.Random.Range(0, 6);
		}
		if (num >= 45.0 && num < 60.0)
		{
			index = UnityEngine.Random.Range(3, 8);
		}
		if (num >= 60.0 && num < 75.0)
		{
			index = UnityEngine.Random.Range(5, 9);
		}
		if (num >= 75.0)
		{
			index = UnityEngine.Random.Range(5, 10);
		}
		PhotonNetwork.InstantiateSceneObject(zombiePrefabs[index], position, Quaternion.identity, 0, null);
	}

	[RPC]
	private void WinID(int winID)
	{
		WeaponManager weaponManager = WeaponManager.sharedManager;
		if (weaponManager.myTable != null && weaponManager.myTable.GetComponent<PhotonView>().ownerId == winID)
		{
			int val = Storager.getInt(Defs.RatingCOOP, false) + 1;
			Storager.setInt(Defs.RatingCOOP, val, false);
			val = Storager.getInt("Rating", false) + 1;
			Storager.setInt("Rating", val, false);
			if (FriendsController.sharedController != null)
			{
				FriendsController.sharedController.TryIncrementWinCountTimestamp();
			}
			FriendsController.sharedController.wins.Value = val;
			FriendsController.sharedController.SendOurData(false);
		}
	}

	private void OnDestroy()
	{
		sharedManager = null;
	}
}
