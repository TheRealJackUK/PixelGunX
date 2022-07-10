using System;
using System.Collections;
using System.Collections.Generic;
using RilisoftBot;
using UnityEngine;

public sealed class ZombieCreator : MonoBehaviour
{
	private GameObject boss;

	public GameObject weaponBonus;

	public static ZombieCreator sharedCreator;

	private static int _ZombiesInWave;

	public int currentWave;

	private static List<List<string>> _enemiesInWaves;

	public static List<string> _allEnemiesSurvival;

	public List<GameObject> waveZombiePrefabs = new List<GameObject>();

	public static Dictionary<int, int> bossesSurvival;

	private static List<List<string>> _WeaponsAddedInWaves;

	public static List<string> survivalAvailableWeapons;

	private bool _generatingZombiesIsStopped;

	private int totalNumOfKilledEnemies;

	private AudioClip bossMus;

	private static int? _enemyCountInSurvivalWave;

	public GUIStyle labelStyle;

	private int[] _intervalArr = new int[3] { 6, 4, 3 };

	private int _genWithThisTimeInterval;

	private int _indexInTimesArray;

	private bool _drawWaveMsg;

	private string _msg = string.Empty;

	private GameObject[] _teleports;

	public bool bossShowm;

	public bool stopGeneratingBonuses;

	public List<GameObject> zombiePrefabs = new List<GameObject>();

	private bool _isMultiplayer;

	private int _numOfLiveZombies;

	private int _numOfDeadZombies;

	private int _numOfDeadZombsSinceLastFast;

	public float curInterval = 10f;

	private GameObject[] _enemyCreationZones;

	private List<string[]> _enemies = new List<string[]>();

	private PauseONGuiDrawer _onGUIDrawer;

	public GameObject[] bossGuads { get; private set; }

	public static int EnemyCountInSurvivalWave
	{
		get
		{
			return (!_enemyCountInSurvivalWave.HasValue) ? DefaultEnemyCountInSurvivalWave : _enemyCountInSurvivalWave.Value;
		}
		set
		{
			_enemyCountInSurvivalWave = value;
		}
	}

	public static int DefaultEnemyCountInSurvivalWave
	{
		get
		{
			return _ZombiesInWave;
		}
	}

	public int NumOfLiveZombies
	{
		get
		{
			return _numOfLiveZombies;
		}
		set
		{
			_numOfLiveZombies = value;
		}
	}

	public bool IsLasTMonsRemains
	{
		get
		{
			return NumOfDeadZombies + 1 == NumOfEnemisesToKill && !bossShowm;
		}
	}

	public int NumOfDeadZombies
	{
		get
		{
			return _numOfDeadZombies;
		}
		set
		{
			if (bossShowm)
			{
				bossShowm = false;
				if (!Defs.IsSurvival)
				{
					if (ZombieCreator.BossKilled != null)
					{
						ZombieCreator.BossKilled();
					}
					if (!LevelBox.weaponsFromBosses.ContainsKey(Application.loadedLevelName))
					{
						GameObject[] teleports = _teleports;
						foreach (GameObject gameObject in teleports)
						{
							gameObject.SetActive(true);
						}
					}
				}
				else
				{
					totalNumOfKilledEnemies++;
					NumOfLiveZombies--;
					NextWave();
				}
				return;
			}
			int num = value - _numOfDeadZombies;
			_numOfDeadZombies = value;
			totalNumOfKilledEnemies += num;
			NumOfLiveZombies -= num;
			if (!Defs.IsSurvival)
			{
				_numOfDeadZombsSinceLastFast += num;
				if (_numOfDeadZombsSinceLastFast == 12)
				{
					if (curInterval > 5f)
					{
						curInterval -= 5f;
					}
					_numOfDeadZombsSinceLastFast = 0;
				}
				if (IsLasTMonsRemains && ZombieCreator.LastEnemy != null)
				{
					ZombieCreator.LastEnemy();
				}
			}
			if (Defs.IsSurvival && NumOfDeadZombies == NumOfEnemisesToKill - 1)
			{
				stopGeneratingBonuses = true;
			}
			if (_numOfDeadZombies < NumOfEnemisesToKill)
			{
				return;
			}
			if (Defs.IsSurvival)
			{
				if (bossesSurvival.ContainsKey(currentWave))
				{
					CreateBoss();
				}
				else
				{
					NextWave();
				}
				return;
			}
			if (CurrentCampaignGame.currentLevel == 0)
			{
				GameObject[] teleports2 = _teleports;
				foreach (GameObject gameObject2 in teleports2)
				{
					if (Defs.IsTraining)
					{
						TrainingController.isNextStep = TrainingController.stepTrainingList["KillZombi"];
					}
					gameObject2.SetActive(true);
				}
				return;
			}
			CreateBoss();
			if (!(bossMus != null))
			{
				return;
			}
			GameObject gameObject3 = GameObject.FindGameObjectWithTag("BackgroundMusic");
			if (gameObject3 != null && (bool)gameObject3.GetComponent<AudioSource>())
			{
				gameObject3.GetComponent<AudioSource>().Stop();
				gameObject3.GetComponent<AudioSource>().clip = bossMus;
				if (Defs.isSoundMusic)
				{
					gameObject3.GetComponent<AudioSource>().Play();
				}
			}
		}
	}

	public static int NumOfEnemisesToKill
	{
		get
		{
			return (!Defs.IsSurvival) ? GlobalGameController.EnemiesToKill : EnemyCountInSurvivalWave;
		}
	}

	public static event Action LastEnemy;

	public static event Action BossKilled;

	static ZombieCreator()
	{
		sharedCreator = null;
		_ZombiesInWave = 45;
		_enemiesInWaves = new List<List<string>>();
		_allEnemiesSurvival = new List<string>();
		bossesSurvival = new Dictionary<int, int>();
		_WeaponsAddedInWaves = new List<List<string>>();
		survivalAvailableWeapons = new List<string>();
		List<string> list = new List<string>();
		List<string> list2 = new List<string>();
		List<string> list3 = new List<string>();
		List<string> list4 = new List<string>();
		List<string> list5 = new List<string>();
		list.Add("1");
		list.Add("2");
		list.Add("15");
		list2.Add("1");
		list2.Add("2");
		list2.Add("15");
		list2.Add("11");
		list2.Add("12");
		list3.Add("3");
		list3.Add("9");
		list3.Add("10");
		list3.Add("11");
		list3.Add("12");
		list3.Add("15");
		list4.Add("49");
		list4.Add("9");
		list4.Add("24");
		list4.Add("29");
		list4.Add("38");
		list4.Add("16");
		list4.Add("48");
		list4.Add("10");
		list5.Add("37");
		list5.Add("46");
		list5.Add("47");
		list5.Add("23");
		list5.Add("24");
		list5.Add("38");
		list5.Add("50");
		list5.Add("20");
		list5.Add("51");
		_enemiesInWaves.Add(list);
		_enemiesInWaves.Add(list2);
		_enemiesInWaves.Add(list3);
		_enemiesInWaves.Add(list4);
		_enemiesInWaves.Add(list5);
		_allEnemiesSurvival = new List<string>();
		foreach (List<string> enemiesInWave in _enemiesInWaves)
		{
			foreach (string item6 in enemiesInWave)
			{
				if (!_allEnemiesSurvival.Contains(item6))
				{
					_allEnemiesSurvival.Add(item6);
				}
			}
		}
		List<string> item = new List<string>
		{
			WeaponManager.PistolWN,
			WeaponManager.ShotgunWN,
			WeaponManager.MP5WN
		};
		List<string> item2 = new List<string>
		{
			WeaponManager.AK47WN,
			WeaponManager.RevolverWN
		};
		List<string> item3 = new List<string>
		{
			WeaponManager.M16_2WN,
			WeaponManager.ObrezWN
		};
		List<string> item4 = new List<string> { WeaponManager.MachinegunWN };
		List<string> item5 = new List<string> { WeaponManager.AlienGunWN };
		_WeaponsAddedInWaves.Add(item);
		_WeaponsAddedInWaves.Add(item2);
		_WeaponsAddedInWaves.Add(item3);
		_WeaponsAddedInWaves.Add(item4);
		_WeaponsAddedInWaves.Add(item5);
	}

	public void SuppressDrawingWaveMessage()
	{
		_drawWaveMsg = false;
	}

	private IEnumerator _DrawFirstMessage()
	{
		_drawWaveMsg = true;
		_msg = string.Format("{0} 1", LocalizationStore.Key_0349);
		yield return new WaitForSeconds(2f);
		_drawWaveMsg = false;
	}

	private IEnumerator _DrawWaveMessage(Action act)
	{
		Dictionary<string, string> parameters = new Dictionary<string, string>
		{
			{
				"Wave (All)",
				currentWave.ToString()
			},
			{
				(!FlurryPluginWrapper.IsPayingUser()) ? "Wave (Non Paying)" : "Wave (Paying)",
				currentWave.ToString()
			}
		};
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Survived Wave", parameters);
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.waveDone.gameObject.SetActive(true);
		}
		yield return new WaitForSeconds(5f);
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.waveDone.gameObject.SetActive(false);
		}
		_drawWaveMsg = true;
		for (int i = 5; i > 0; i--)
		{
			_msg = i.ToString();
			yield return new WaitForSeconds(1f);
		}
		_drawWaveMsg = false;
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.newWave.gameObject.SetActive(true);
		}
		act();
		yield return new WaitForSeconds(1f);
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.newWave.gameObject.SetActive(false);
		}
	}

	private void OnDestroy()
	{
		sharedCreator = null;
		if (Defs.IsSurvival)
		{
			PlayerPrefs.SetInt(Defs.KilledZombiesSett, totalNumOfKilledEnemies);
			PlayerPrefs.SetInt(Defs.WavesSurvivedS, currentWave);
			if (!Defs.isMulti && (bool)_onGUIDrawer)
			{
				_onGUIDrawer.act = null;
			}
		}
	}

	private void _UpdateIntervalStructures()
	{
		_genWithThisTimeInterval = 0;
		_indexInTimesArray = 0;
		curInterval = _intervalArr[_indexInTimesArray];
	}

	private void SetWaveNumberInGUI()
	{
		if (InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.SurvivalWaveNumber != null)
		{
			InGameGUI.sharedInGameGUI.SurvivalWaveNumber.text = string.Format("{0} {1}", LocalizationStore.Get("Key_0349"), currentWave + 1);
		}
	}

	public void NextWave()
	{
		currentWave++;
		StoreKitEventListener.State.Parameters.Clear();
		StoreKitEventListener.State.Parameters.Add("Waves", ((currentWave >= 10) ? (string.Empty + currentWave / 10 * 10 + "-" + ((currentWave / 10 + 1) * 10 - 1)) : (string.Empty + (currentWave + 1))) + " In game");
		StartCoroutine(_DrawWaveMessage(delegate
		{
			_UpdateIntervalStructures();
			_numOfDeadZombies = 0;
			_numOfDeadZombsSinceLastFast = 0;
			_SetZombiePrefabs();
			_UpdateAvailableWeapons();
			_generatingZombiesIsStopped = false;
			stopGeneratingBonuses = false;
			SetWaveNumberInGUI();
		}));
		Vector3 pos = ((!Application.loadedLevelName.Equals("Pizza")) ? new Vector3(0f, 1f, 0f) : new Vector3(-7.83f, 0.46f, -2.44f));
		GameObject gameObject = Initializer.CreateCoinAtPos(pos);
		gameObject.GetComponent<CoinBonus>().SetPlayer();
	}

	public static void SetLayerRecursively(GameObject go, int layerNumber)
	{
		if (!(go == null))
		{
			Transform[] componentsInChildren = go.GetComponentsInChildren<Transform>(true);
			foreach (Transform transform in componentsInChildren)
			{
				transform.gameObject.layer = layerNumber;
			}
		}
	}

	private IEnumerator _PrerenderBoss()
	{
		GameObject prer = UnityEngine.Object.Instantiate(Resources.Load("ObjectPrerenderer") as GameObject, new Vector3(0f, 0f, -10000f), Quaternion.identity) as GameObject;
		ObjectPrerenderer op = prer.GetComponentInChildren<ObjectPrerenderer>();
		if ((bool)op)
		{
			GameObject bc = UnityEngine.Object.Instantiate(boss.transform.GetChild(0).gameObject) as GameObject;
			bc.transform.parent = op.transform;
			bc.transform.localPosition = new Vector3(0f, 0f, 2.7f);
			bc.layer = op.gameObject.layer;
			SetLayerRecursively(bc, bc.layer);
			if (weaponBonus != null)
			{
				GameObject w = BonusCreator._CreateBonusFromPrefab(weaponBonus, Vector3.zero);
				w.transform.parent = op.transform;
				w.transform.localPosition = new Vector3(1.5f, 0f, 3f);
				w.layer = op.gameObject.layer;
				SetLayerRecursively(w, w.layer);
			}
			yield return null;
			op.Render_();
			UnityEngine.Object.Destroy(prer);
		}
	}

	private void TryCreateBossGuard(GameObject bossObj)
	{
		bossGuads = null;
		BaseBot botScriptForObject = BaseBot.GetBotScriptForObject(bossObj.transform);
		if (botScriptForObject == null)
		{
			return;
		}
		int num = botScriptForObject.guards.Length;
		if (num != 0)
		{
			bossGuads = new GameObject[num];
			for (int i = 0; i < num; i++)
			{
				GameObject original = botScriptForObject.guards[i];
				bossGuads[i] = UnityEngine.Object.Instantiate(original) as GameObject;
				bossGuads[i].name = string.Format("{0}{1}", "BossGuard", i + 1);
				bossGuads[i].SetActive(false);
			}
		}
	}

	private void Awake()
	{
		stopGeneratingBonuses = false;
		sharedCreator = this;
		if (Defs.isMulti)
		{
			return;
		}
		if (!Defs.IsSurvival && CurrentCampaignGame.currentLevel != 0)
		{
			string b = "Boss" + CurrentCampaignGame.currentLevel;
			boss = UnityEngine.Object.Instantiate(Resources.Load(ResPath.Combine("Bosses", b))) as GameObject;
			TryCreateBossGuard(boss);
			boss.SetActive(false);
			if (LevelBox.weaponsFromBosses.ContainsKey(Application.loadedLevelName))
			{
				string weaponName = LevelBox.weaponsFromBosses[Application.loadedLevelName];
				weaponBonus = BonusCreator._CreateBonusPrefab(weaponName);
			}
			StartCoroutine(_PrerenderBoss());
			bossMus = Resources.Load("Snd/boss_campaign") as AudioClip;
		}
		GlobalGameController.curThr = GlobalGameController.thrStep;
		_enemies.Add(new string[6] { "1", "2", "1", "11", "12", "13" });
		_enemies.Add(new string[6] { "30", "31", "32", "33", "34", "77" });
		_enemies.Add(new string[9] { "1", "2", "3", "9", "10", "12", "14", "15", "78" });
		_enemies.Add(new string[7] { "1", "2", "4", "11", "9", "16", "78" });
		_enemies.Add(new string[7] { "1", "2", "4", "9", "11", "10", "12" });
		_enemies.Add(new string[6] { "43", "44", "45", "46", "47", "73" });
		_enemies.Add(new string[3] { "6", "7", "7" });
		_enemies.Add(new string[7] { "1", "2", "8", "10", "11", "12", "76" });
		_enemies.Add(new string[3] { "18", "19", "20" });
		_enemies.Add(new string[6] { "21", "22", "23", "24", "25", "75" });
		_enemies.Add(new string[2] { "1", "15" });
		_enemies.Add(new string[8] { "1", "3", "9", "10", "14", "15", "16", "78" });
		_enemies.Add(new string[4] { "8", "21", "22", "79" });
		_enemies.Add(new string[5] { "26", "27", "28", "29", "57" });
		_enemies.Add(new string[6] { "35", "36", "37", "38", "48", "57" });
		_enemies.Add(new string[5] { "39", "40", "41", "42", "74" });
		_enemies.Add(new string[4] { "53", "55", "57", "61" });
		_enemies.Add(new string[4] { "59", "56", "54", "60" });
		_enemies.Add(new string[4] { "67", "68", "66", "69" });
		_enemies.Add(new string[3] { "70", "71", "72" });
		_enemies.Add(new string[4] { "58", "63", "64", "65" });
		UpdateBotPrefabs();
		if (Defs.IsSurvival)
		{
			_SetZombiePrefabs();
		}
		survivalAvailableWeapons.Clear();
		_UpdateAvailableWeapons();
		_UpdateIntervalStructures();
		StartCoroutine(_DrawFirstMessage());
	}

	private void _SetZombiePrefabs()
	{
		waveZombiePrefabs.Clear();
		int index = ((currentWave < _enemiesInWaves.Count) ? currentWave : (_enemiesInWaves.Count - 1));
		foreach (GameObject zombiePrefab in zombiePrefabs)
		{
			string item = zombiePrefab.name.Substring("Enemy".Length).Substring(0, zombiePrefab.name.Substring("Enemy".Length).IndexOf("_"));
			if (_enemiesInWaves[index].Contains(item))
			{
				waveZombiePrefabs.Add(zombiePrefab);
			}
		}
	}

	private void _UpdateAvailableWeapons()
	{
		if (currentWave >= _WeaponsAddedInWaves.Count)
		{
			return;
		}
		foreach (string item in _WeaponsAddedInWaves[currentWave])
		{
			survivalAvailableWeapons.Add(item);
		}
	}

	private void UpdateBotPrefabs()
	{
		zombiePrefabs.Clear();
		string[] array = null;
		array = (Defs.IsSurvival ? _allEnemiesSurvival.ToArray() : ((CurrentCampaignGame.currentLevel != 0) ? _enemies[CurrentCampaignGame.currentLevel - 1] : new string[1] { "1" }));
		string[] array2 = array;
		foreach (string text in array2)
		{
			GameObject item = Resources.Load("Enemies/Enemy" + text + "_go") as GameObject;
			zombiePrefabs.Add(item);
		}
	}

	private void Start()
	{
		if (Defs.IsSurvival)
		{
			StoreKitEventListener.State.Parameters.Clear();
			StoreKitEventListener.State.Parameters.Add("Waves", currentWave + 1 + " In game");
		}
		labelStyle.fontSize = Mathf.RoundToInt(50f * Defs.Coef);
		labelStyle.font = LocalizationStore.GetFontByLocalize("Key_04B_03");
		if (Defs.isMulti)
		{
			_isMultiplayer = true;
		}
		else
		{
			_isMultiplayer = false;
		}
		_teleports = GameObject.FindGameObjectsWithTag("Portal");
		GameObject[] teleports = _teleports;
		foreach (GameObject gameObject in teleports)
		{
			gameObject.SetActive(false);
		}
		if (_isMultiplayer)
		{
			return;
		}
		_enemyCreationZones = GameObject.FindGameObjectsWithTag("EnemyCreationZone");
		if (!Defs.IsSurvival)
		{
			_ResetInterval();
			return;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(Resources.Load("PauseONGuiDrawer") as GameObject) as GameObject;
		gameObject2.transform.parent = base.transform;
		_onGUIDrawer = gameObject2.GetComponent<PauseONGuiDrawer>();
		if ((bool)_onGUIDrawer)
		{
			_onGUIDrawer.act = DoOnGUI;
		}
	}

	private void DoOnGUI()
	{
		if (Defs.IsSurvival && _drawWaveMsg && InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.pausePanel != null && !InGameGUI.sharedInGameGUI.pausePanel.activeInHierarchy)
		{
			GUI.depth = 25;
			float num = (float)Screen.width / 2f;
			float num2 = (float)Screen.height / 3f;
			Rect position = new Rect((float)Screen.width / 2f - num / 2f, (float)Screen.height / 2f - num2, num, num2);
			GUI.Label(position, _msg, labelStyle);
		}
	}

	private void _ResetInterval()
	{
		curInterval = Mathf.Max(1f, curInterval);
	}

	public void BeganCreateEnemies()
	{
		if (!Application.isEditor || !Defs.IsSurvival || Application.loadedLevelName.Equals(Defs.SurvivalMaps[Defs.CurrentSurvMapIndex % Defs.SurvivalMaps.Length]))
		{
			if (Defs.IsSurvival)
			{
				SetWaveNumberInGUI();
			}
			StartCoroutine(AddZombies());
		}
	}

	public static int GetCountMobsForLevel()
	{
		Dictionary<string, int> counCreateMobsInLevel = Switcher.counCreateMobsInLevel;
		string levelSceneName = CurrentCampaignGame.levelSceneName;
		if (counCreateMobsInLevel.ContainsKey(levelSceneName))
		{
			return counCreateMobsInLevel[levelSceneName];
		}
		return GlobalGameController.ZombiesInWave;
	}

	private IEnumerator AddZombies()
	{
		float halfLLength = 17f;
		float radius = 2.5f;
		do
		{
			int numOfZombsToAdd = GlobalGameController.ZombiesInWave;
			numOfZombsToAdd = Mathf.Min(numOfZombsToAdd, GlobalGameController.SimultaneousEnemiesOnLevelConstraint - NumOfLiveZombies);
			numOfZombsToAdd = Mathf.Min(numOfZombsToAdd, NumOfEnemisesToKill - (NumOfDeadZombies + NumOfLiveZombies));
			string[] enemyNumbers2 = null;
			if (!Defs.IsSurvival)
			{
				enemyNumbers2 = ((CurrentCampaignGame.currentLevel != 0) ? _enemies[CurrentCampaignGame.currentLevel - 1] : new string[1] { "1" });
			}
			else
			{
				int ind = ((currentWave < _enemiesInWaves.Count) ? currentWave : (_enemiesInWaves.Count - 1));
				enemyNumbers2 = _enemiesInWaves[ind].ToArray();
			}
			for (int i = 0; i < numOfZombsToAdd; i++)
			{
				int typeOfZomb = UnityEngine.Random.Range(0, enemyNumbers2.Length);
				GameObject spawnZone = ((!Defs.IsSurvival) ? _enemyCreationZones[UnityEngine.Random.Range(0, _enemyCreationZones.Length)] : _enemyCreationZones[i % _enemyCreationZones.Length]);
				UnityEngine.Object.Instantiate(position: _createPos(spawnZone), original: (!Defs.IsSurvival) ? zombiePrefabs[typeOfZomb] : waveZombiePrefabs[typeOfZomb], rotation: Quaternion.identity);
			}
			if (Defs.IsSurvival && NumOfDeadZombies + NumOfLiveZombies >= NumOfEnemisesToKill)
			{
				_generatingZombiesIsStopped = true;
				do
				{
					yield return new WaitForEndOfFrame();
				}
				while (_generatingZombiesIsStopped);
			}
			yield return new WaitForSeconds(curInterval);
			if (Defs.IsSurvival)
			{
				_genWithThisTimeInterval++;
				if (_genWithThisTimeInterval == 3 && _indexInTimesArray < _intervalArr.Length - 1)
				{
					_indexInTimesArray++;
				}
				curInterval = _intervalArr[_indexInTimesArray];
			}
		}
		while (NumOfDeadZombies + NumOfLiveZombies < NumOfEnemisesToKill || Defs.IsSurvival);
	}

	private Vector3 _createPos(GameObject spawnZone)
	{
		BoxCollider component = spawnZone.GetComponent<BoxCollider>();
		Vector2 vector = new Vector2(component.size.x * spawnZone.transform.localScale.x, component.size.z * spawnZone.transform.localScale.z);
		Rect rect = new Rect(spawnZone.transform.position.x - vector.x / 2f, spawnZone.transform.position.z - vector.y / 2f, vector.x, vector.y);
		Vector3 result = new Vector3(rect.x + UnityEngine.Random.Range(0f, rect.width), (!Defs.levelsWithVarY.Contains(CurrentCampaignGame.currentLevel) || Defs.IsSurvival) ? 0f : spawnZone.transform.position.y, rect.y + UnityEngine.Random.Range(0f, rect.height));
		return result;
	}

	private void ShowGuards(Vector3 bossPosition)
	{
		if (bossGuads != null)
		{
			for (int i = 0; i < bossGuads.Length; i++)
			{
				bossGuads[i].transform.position = BaseBot.GetPositionSpawnGuard(bossPosition);
				bossGuads[i].transform.rotation = Quaternion.identity;
				bossGuads[i].SetActive(true);
			}
		}
	}

	private void CreateBoss()
	{
		GameObject gameObject = null;
		float num = float.PositiveInfinity;
		GameObject gameObject2 = GameObject.FindGameObjectWithTag("Player");
		if (!gameObject2)
		{
			return;
		}
		GameObject[] enemyCreationZones = _enemyCreationZones;
		foreach (GameObject gameObject3 in enemyCreationZones)
		{
			float num2 = Vector3.SqrMagnitude(gameObject2.transform.position - gameObject3.transform.position);
			float num3 = Mathf.Abs(gameObject2.transform.position.y - gameObject3.transform.position.y);
			if (num2 > 225f && num2 < num && num3 < 2.5f)
			{
				num = num2;
				gameObject = gameObject3;
			}
		}
		if (!gameObject)
		{
			gameObject = _enemyCreationZones[0];
		}
		Vector3 vector = _createPos(gameObject);
		if (boss != null)
		{
			GameObject gameObject4 = GameObject.FindGameObjectWithTag("BossRespawnPoint");
			if (gameObject4 != null)
			{
				vector = gameObject4.transform.position;
			}
			boss.transform.position = vector;
			boss.transform.rotation = Quaternion.identity;
			boss.SetActive(true);
			ShowGuards(vector);
		}
		else if (Defs.IsSurvival && bossesSurvival.ContainsKey(currentWave))
		{
			string b = "Boss" + bossesSurvival[currentWave];
			boss = UnityEngine.Object.Instantiate(Resources.Load(ResPath.Combine("Bosses", b))) as GameObject;
			boss.transform.position = vector;
			boss.transform.rotation = Quaternion.identity;
		}
		boss = null;
		bossShowm = true;
	}
}
