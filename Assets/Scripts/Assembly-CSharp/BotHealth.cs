using System;
using System.Collections;
using UnityEngine;

public sealed class BotHealth : MonoBehaviour
{
	public static bool _hurtAudioIsPlaying;

	private static SkinsManagerPixlGun _skinsManager;

	public string myName = "Bot";

	private bool IsLife = true;

	public Texture hitTexture;

	private BotAI ai;

	private Player_move_c healthDown;

	private bool _flashing;

	private GameObject _modelChild;

	private Sounds _soundClips;

	private Texture _skin;

	private bool _weaponCreated;

	private IEnumerator resetHurtAudio(float tm)
	{
		_hurtAudioIsPlaying = true;
		yield return new WaitForSeconds(tm);
		_hurtAudioIsPlaying = false;
	}

	public bool RequestPlayHurt(float tm)
	{
		if (_hurtAudioIsPlaying)
		{
			return false;
		}
		StartCoroutine(resetHurtAudio(tm));
		return true;
	}

	private void Awake()
	{
		if (Defs.isCOOP)
		{
			base.enabled = false;
		}
	}

	private void Start()
	{
		IEnumerator enumerator = base.transform.GetEnumerator();
		try
		{
			if (enumerator.MoveNext())
			{
				Transform transform = (Transform)enumerator.Current;
				_modelChild = transform.gameObject;
			}
		}
		finally
		{
			IDisposable disposable = enumerator as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
		_soundClips = _modelChild.GetComponent<Sounds>();
		if (Defs.IsSurvival && !Defs.isTrainingFlag)
		{
			if (ZombieCreator.sharedCreator.currentWave == 0)
			{
				_soundClips.notAttackingSpeed *= 0.75f;
				_soundClips.attackingSpeed *= 0.75f;
				_soundClips.health *= 0.7f;
			}
			if (ZombieCreator.sharedCreator.currentWave == 1)
			{
				_soundClips.notAttackingSpeed *= 0.85f;
				_soundClips.attackingSpeed *= 0.85f;
				_soundClips.health *= 0.8f;
			}
			if (ZombieCreator.sharedCreator.currentWave == 2)
			{
				_soundClips.notAttackingSpeed *= 0.9f;
				_soundClips.attackingSpeed *= 0.9f;
				_soundClips.health *= 0.9f;
			}
			if (ZombieCreator.sharedCreator.currentWave >= 7)
			{
				_soundClips.notAttackingSpeed *= 1.25f;
				_soundClips.attackingSpeed *= 1.25f;
			}
			if (ZombieCreator.sharedCreator.currentWave >= 9)
			{
				_soundClips.health *= 1.25f;
			}
		}
		ai = GetComponent<BotAI>();
		healthDown = GameObject.FindGameObjectWithTag("PlayerGun").GetComponent<Player_move_c>();
		if (base.gameObject.name.IndexOf("Boss") == -1)
		{
			_skin = SetSkinForObj(_modelChild);
			return;
		}
		Renderer componentInChildren = _modelChild.GetComponentInChildren<Renderer>();
		_skin = componentInChildren.material.mainTexture;
	}

	public static Texture SetSkinForObj(GameObject go)
	{
		if (!_skinsManager)
		{
			_skinsManager = GameObject.FindGameObjectWithTag("SkinsManager").GetComponent<SkinsManagerPixlGun>();
		}
		Texture texture = null;
		string text = SkinNameForObj(go.name);
		if (!(texture = _skinsManager.skins[text] as Texture))
		{
			Debug.Log("No skin: " + text);
		}
		SetTextureRecursivelyFrom(go, texture);
		return texture;
	}

	public static string SkinNameForObj(string objName)
	{
		return Defs.IsSurvival ? objName : ((!Defs.isTrainingFlag) ? (objName + "_Level" + CurrentCampaignGame.currentLevel) : (objName + "_Level3"));
	}

	public static void SetTextureRecursivelyFrom(GameObject obj, Texture txt)
	{
		foreach (Transform item in obj.transform)
		{
			if (!item.name.Equals("Ears"))
			{
				if ((bool)item.gameObject.GetComponent<Renderer>() && (bool)item.gameObject.GetComponent<Renderer>().material)
				{
					item.gameObject.GetComponent<Renderer>().material.mainTexture = txt;
				}
				SetTextureRecursivelyFrom(item.gameObject, txt);
			}
		}
	}

	private IEnumerator Flash()
	{
		_flashing = true;
		SetTextureRecursivelyFrom(_modelChild, hitTexture);
		yield return new WaitForSeconds(0.125f);
		SetTextureRecursivelyFrom(_modelChild, _skin);
		_flashing = false;
	}

	private void _CreateBonusWeapon()
	{
		if (LevelBox.weaponsFromBosses.ContainsKey(Application.loadedLevelName) && base.gameObject.name.Contains("Boss") && !_weaponCreated)
		{
			string weaponName = LevelBox.weaponsFromBosses[Application.loadedLevelName];
			Vector3 pos = base.gameObject.transform.position + new Vector3(0f, 0.25f, 0f);
			GameObject gameObject = ((!(GetComponent<BotMovement>()._gameController.weaponBonus != null)) ? BonusCreator._CreateBonus(weaponName, pos) : BonusCreator._CreateBonusFromPrefab(GetComponent<BotMovement>()._gameController.weaponBonus, pos));
			gameObject.AddComponent<GotToNextLevel>();
			GetComponent<BotMovement>()._gameController.weaponBonus = null;
			_weaponCreated = true;
		}
	}

	public void adjustHealth(float _health, Transform target)
	{
		if (_health < 0f && !_flashing)
		{
			StartCoroutine(Flash());
		}
		_soundClips.health += _health;
		if (_soundClips.health < 0f)
		{
			_soundClips.health = 0f;
		}
		if (Debug.isDebugBuild)
		{
			_CreateBonusWeapon();
			IsLife = false;
		}
		else if (_soundClips.health == 0f)
		{
			_CreateBonusWeapon();
			IsLife = false;
		}
		else
		{
			GlobalGameController.Score += 5;
		}
		if (RequestPlayHurt(_soundClips.hurt.length) && Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().PlayOneShot(_soundClips.hurt);
		}
		if ((target.CompareTag("Player") && !target.GetComponent<SkinName>().playerMoveC.isInvisible) || target.CompareTag("Turret"))
		{
			ai.SetTarget(target, true);
		}
	}

	public bool getIsLife()
	{
		return IsLife;
	}
}
