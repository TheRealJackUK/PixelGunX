using UnityEngine;


public class BonusController : MonoBehaviour
{
	public static BonusController sharedController;

	public GameObject[] bonusPrefabs;

	public float creationInterval = 7f;

	public float timerToAddBonus;

	private bool isMulti;

	private bool isHunger;

	private bool isInet;

	private bool isStopCreateBonus;

	public bool isBeginCreateBonuses;

	private WeaponManager _weaponManager;

	private GameObject[] bonusCreationZones;

	private ZombieCreator zombieCreator;

	private PhotonView photonView;

	public int maxCountBonus = 5;

	private bool isTraining;

	private void Awake()
	{
		sharedController = this;
		if (Defs.IsSurvival)
		{
			creationInterval = 9f;
		}
		isTraining = Defs.IsTraining;
		timerToAddBonus = creationInterval;
		isMulti = Defs.isMulti;
		isInet = Defs.isInet;
		isHunger = Defs.isHunger;
		maxCountBonus = ((!Defs.IsSurvival) ? 5 : 3);
		if (!isMulti && !Defs.IsSurvival && !Defs.IsTraining && CurrentCampaignGame.currentLevel != 11)
		{
		}
	}

	private void Start()
	{
		photonView = PhotonView.Get(this);
		bonusCreationZones = GameObject.FindGameObjectsWithTag("BonusCreationZone");
		if (maxCountBonus > bonusCreationZones.Length)
		{
			maxCountBonus = bonusCreationZones.Length;
		}
		zombieCreator = GameObject.FindGameObjectWithTag("GameController").GetComponent<ZombieCreator>();
		_weaponManager = WeaponManager.sharedManager;
	}

	public void AddWeaponAfterKillPlayer(string _weaponName, Vector3 _pos)
	{
		photonView.RPC("AddWeaponAfterKillPlayerRPC", PhotonTargets.MasterClient, _weaponName, _pos);
	}

	[PunRPC]
	private void AddWeaponAfterKillPlayerRPC(string _weaponName, Vector3 _pos)
	{
		PhotonNetwork.InstantiateSceneObject("Weapon_Bonuses/" + _weaponName + "_Bonus", new Vector3(_pos.x, _pos.y - 0.5f, _pos.z), Quaternion.identity, 0, null);
	}

	public void AddBonusAfterKillPlayer(Vector3 _pos)
	{
		if (Defs.isInet)
		{
			photonView.RPC("AddBonusAfterKillPlayerRPC", PhotonTargets.All, IndexBonus(), _pos);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("AddBonusAfterKillPlayerRPC", PhotonTargets.All, IndexBonus(), _pos);
		}
	}

	[PunRPC]
	private void AddBonusAfterKillPlayerRPC(int _type, Vector3 _pos)
	{
		if (Defs.isMulti && Defs.isInet)
		{
			if (photonView.isMine && !Defs.isHunger)
			{
				AddBonus(_pos, _type);
			}
		}
		else
		{
			AddBonus(_pos, _type);
		}
	}

	private void AddBonus(Vector3 pos, int _type = -1)
	{
		if (!isMulti)
		{
			int num = GlobalGameController.EnemiesToKill - zombieCreator.NumOfDeadZombies;
			if ((!Defs.IsSurvival && num <= 0 && !zombieCreator.bossShowm) || (Defs.IsSurvival && zombieCreator.stopGeneratingBonuses))
			{
				if (!Defs.IsSurvival)
				{
					isStopCreateBonus = true;
				}
				return;
			}
		}
		int num2 = -1;
		bool flag = !pos.Equals(Vector3.zero);
		if (!flag)
		{
			GameObject[] array = GameObject.FindGameObjectsWithTag("Bonus");
			GameObject[] array2 = GameObject.FindGameObjectsWithTag("Chest");
			if (array.Length + array2.Length >= maxCountBonus)
			{
				return;
			}
			num2 = Random.Range(0, bonusCreationZones.Length);
			bool[] array3 = new bool[bonusCreationZones.Length];
			for (int i = 0; i < array3.Length; i++)
			{
				array3[i] = false;
			}
			for (int j = 0; j < array.Length; j++)
			{
				if (array[j].GetComponent<SettingBonus>().numberSpawnZone != -1)
				{
					array3[array[j].GetComponent<SettingBonus>().numberSpawnZone] = true;
				}
			}
			for (int k = 0; k < array2.Length; k++)
			{
				if (array2[k].GetComponent<SettingBonus>().numberSpawnZone != -1)
				{
					array3[array2[k].GetComponent<SettingBonus>().numberSpawnZone] = true;
				}
			}
			while (array3[num2])
			{
				num2++;
				if (num2 == array3.Length)
				{
					num2 = 0;
				}
			}
			GameObject gameObject = bonusCreationZones[num2];
			BoxCollider component = gameObject.GetComponent<BoxCollider>();
			Vector2 vector = new Vector2(component.size.x * gameObject.transform.localScale.x, component.size.z * gameObject.transform.localScale.z);
			Rect rect = new Rect(gameObject.transform.position.x - vector.x / 2f, gameObject.transform.position.z - vector.y / 2f, vector.x, vector.y);
			pos = new Vector3(rect.x + Random.Range(0f, rect.width), gameObject.transform.position.y, rect.y + Random.Range(0f, rect.height));
		}
		if (!isMulti || !isInet)
		{
			GameObject original = Resources.Load("Bonuses/Bonus_" + ((_type == -1) ? IndexBonus() : _type)) as GameObject;
			GameObject gameObject2 = (GameObject)Object.Instantiate(original, pos, Quaternion.identity);
			gameObject2.GetComponent<SettingBonus>().numberSpawnZone = num2;
			if (flag)
			{
				gameObject2.GetComponent<BonusItem>().SynchTimeKillBonusRPC(PhotonNetwork.time);
			}
		}
		else
		{
			GameObject gameObject2 = PhotonNetwork.InstantiateSceneObject("Bonuses/Bonus_" + ((_type == -1) ? IndexBonus() : _type), pos, Quaternion.identity, 0, null);
			gameObject2.GetComponent<SettingBonus>().SetNumberSpawnZone(num2);
			if (flag)
			{
				gameObject2.GetComponent<BonusItem>().SynchTimeKillBonus(PhotonNetwork.time);
			}
		}
	}

	private int IndexBonus()
	{
		if (isTraining)
		{
			return 0;
		}
		if (isHunger)
		{
			return 3;
		}
		int num = Random.Range(0, 100);
		if (Application.loadedLevelName.Equals("Knife") && num < 60)
		{
			num = 60;
		}
		int result = 0;
		if (num >= 60 && num < 75)
		{
			result = 1;
		}
		if (num >= 75 && num < 85)
		{
			result = 2;
		}
		if (num >= 85)
		{
			result = 4;
		}
		return result;
	}

	private void Update()
	{
		if ((!isMulti || (isMulti && !isInet) || (isMulti && isInet && photonView.isMine)) && !isStopCreateBonus)
		{
			timerToAddBonus -= Time.deltaTime;
		}
		if (timerToAddBonus < 0f)
		{
			timerToAddBonus = creationInterval;
			AddBonus(Vector3.zero);
		}
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
