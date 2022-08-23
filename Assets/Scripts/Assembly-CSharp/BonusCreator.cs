using System.Collections;
using UnityEngine;


internal sealed class BonusCreator : MonoBehaviour
{
	public GameObject[] bonusPrefabs;

	public float creationInterval = 15f;

	public float weaponCreationInterval = 30f;

	private Object[] weaponPrefabs;

	private int _lastWeapon = -1;

	private bool _isMultiplayer;

	private ArrayList bonuses = new ArrayList();

	private ArrayList _weapons = new ArrayList();

	public WeaponManager _weaponManager;

	private GameObject[] _bonusCreationZones;

	private ZombieCreator _zombieCreator;

	private ArrayList _weaponsProbDistr = new ArrayList();

	private float _DistrSum()
	{
		float num = 0f;
		foreach (int item in _weaponsProbDistr)
		{
			num += (float)item;
		}
		return num;
	}

	private void Awake()
	{
		if (Defs.IsSurvival)
		{
			creationInterval = 9f;
			weaponCreationInterval = 15f;
		}
		if (Defs.isMulti)
		{
			_isMultiplayer = true;
		}
		else
		{
			_isMultiplayer = false;
		}
		if (!_isMultiplayer)
		{
			weaponPrefabs = WeaponManager.sharedManager.weaponsInGame;
			Object[] array = weaponPrefabs;
			for (int i = 0; i < array.Length; i++)
			{
				GameObject gameObject = (GameObject)array[i];
				WeaponSounds component = gameObject.GetComponent<WeaponSounds>();
				_weaponsProbDistr.Add(component.Probability);
			}
		}
	}

	private void Start()
	{
		_bonusCreationZones = GameObject.FindGameObjectsWithTag("BonusCreationZone");
		_zombieCreator = base.gameObject.GetComponent<ZombieCreator>();
		_weaponManager = WeaponManager.sharedManager;
	}

	public void BeginCreateBonuses()
	{
		if ((!Application.isEditor || !Defs.IsSurvival || Application.loadedLevelName.Equals(Defs.SurvivalMaps[Defs.CurrentSurvMapIndex % Defs.SurvivalMaps.Length])) && Defs.IsSurvival)
		{
			StartCoroutine(AddWeapon());
		}
	}

	public GameObject GetPrefabWithTag(string tagName)
	{
		Object[] array = weaponPrefabs;
		for (int i = 0; i < array.Length; i++)
		{
			GameObject gameObject = (GameObject)array[i];
			if (gameObject.CompareTag(tagName))
			{
				return gameObject;
			}
		}
		return null;
	}

	public void addBonusFromPhotonRPC(int _id, int _type, Vector3 _pos, Quaternion rot)
	{
		GameObject gameObject = (GameObject)Object.Instantiate(bonusPrefabs[_indexForType(_type)], _pos, rot);
		gameObject.GetComponent<PhotonView>().viewID = _id;
		gameObject.GetComponent<SettingBonus>().typeOfMass = _type;
	}

	private int _indexForType(int type)
	{
		int result = 0;
		switch (type)
		{
		case 9:
		case 10:
			result = 1;
			break;
		case 8:
			result = 2;
			break;
		}
		return result;
	}

	[PunRPC]
	private void delBonus(PhotonView id)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Bonus");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (id.Equals(gameObject.GetComponent<PhotonView>().viewID))
			{
				Object.Destroy(gameObject);
				break;
			}
		}
	}

	private IEnumerator AddWeapon()
	{
		while (true)
		{
			yield return new WaitForSeconds(weaponCreationInterval);
			while (_zombieCreator.stopGeneratingBonuses)
			{
				yield return null;
			}
			int enemiesLeft = GlobalGameController.EnemiesToKill - _zombieCreator.NumOfDeadZombies;
			if (!Defs.IsSurvival && enemiesLeft <= 0 && !_zombieCreator.bossShowm)
			{
				break;
			}
			GameObject spawnZone = _bonusCreationZones[Random.Range(0, _bonusCreationZones.Length)];
			BoxCollider spawnZoneCollider = spawnZone.GetComponent<BoxCollider>();
			Vector2 sz = new Vector2(spawnZoneCollider.size.x * spawnZone.transform.localScale.x, spawnZoneCollider.size.z * spawnZone.transform.localScale.z);
			Rect zoneRect = new Rect(spawnZone.transform.position.x - sz.x / 2f, spawnZone.transform.position.z - sz.y / 2f, sz.x, sz.y);
			Vector3 pos = new Vector3(zoneRect.x + Random.Range(0f, zoneRect.width), (!Defs.levelsWithVarY.Contains(_curLevel())) ? 0.24f : spawnZone.transform.position.y, zoneRect.y + Random.Range(0f, zoneRect.height));
			float sum = _DistrSum();
			int weaponNumber;
			do
			{
				weaponNumber = 0;
				float val = Random.Range(0f, sum);
				float curSum = 0f;
				for (int i = 0; i < _weaponsProbDistr.Count; i++)
				{
					if (val < curSum + (float)(int)_weaponsProbDistr[i])
					{
						weaponNumber = i;
						break;
					}
					curSum += (float)(int)_weaponsProbDistr[i];
				}
			}
			while (weaponNumber == _lastWeapon || (Defs.IsSurvival && !ZombieCreator.survivalAvailableWeapons.Contains(weaponPrefabs[weaponNumber].name)) || !ItemDb.IsWeaponCanDrop((weaponPrefabs[weaponNumber] as GameObject).tag));
			GameObject wp = (GameObject)weaponPrefabs[weaponNumber];
			GameObject newBonus = _CreateBonus(wp.name, pos);
			_weapons.Add(newBonus);
			if (_weapons.Count > ((!Defs.IsSurvival) ? 5 : 3))
			{
				Object.Destroy((GameObject)_weapons[0]);
				_weapons.RemoveAt(0);
			}
		}
	}

	public static GameObject _CreateBonusPrefab(string _weaponName)
	{
		GameObject gameObject = Resources.Load("Weapon_Bonuses/" + _weaponName + "_Bonus") as GameObject;
		if (gameObject == null)
		{
			Debug.Log("null");
			return null;
		}
		return gameObject;
	}

	public static GameObject _CreateBonus(string _weaponName, Vector3 pos)
	{
		GameObject gameObject = _CreateBonusPrefab(_weaponName);
		if (gameObject == null)
		{
			Debug.Log("null");
			return null;
		}
		return _CreateBonusFromPrefab(gameObject, pos);
	}

	public static GameObject _CreateBonusFromPrefab(GameObject bonus, Vector3 pos)
	{
		GameObject gameObject = (GameObject)Object.Instantiate(bonus, pos, Quaternion.identity);
		gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
		return gameObject;
	}

	private int _curLevel()
	{
		return Defs.isMulti ? GlobalGameController.currentLevel : CurrentCampaignGame.currentLevel;
	}
}
