using System;
using UnityEngine;

public sealed class WeaponSounds : MonoBehaviour
{
	public enum TypeDead
	{
		angel,
		explosion,
		energyBlue,
		energyRed,
		energyPink,
		energyCyan,
		energyLight,
		energyGreen,
		energyOrange,
		energyWhite
	}

	public bool isSlowdown;
	
	[Range(0.01f, 10f)]
	public float slowdownCoeff;

	public float slowdownTime;

	public bool isWaitWeapon = false;

	public float waitTime = 0f;

	public GameObject[] noFillObjects;

	private InnerWeaponPars _innerPars;

	public TypeDead typeDead;

	public Transform gunFlash;

	public Transform[] gunFlashDouble;

	public float lengthForShot;

	public float[] damageByTier = new float[6];

	public float[] dpses = new float[6];

	public float[] damageByTierInDeadly;

	public int tier;

	public int categoryNabor = 1;

	public int numOfMaximumShootDouble = 3;

	public bool isGrenadeWeapon;

	public int damageShop;

	public int fireRateShop;

	public int CapacityShop;

	public int mobilityShop;

	[Range(0f, 10f)]
	public int zoomShop;

	public bool AreaDamageShop;

	public bool WallsBreakShop;

	public bool AOE;

	public string AOEText;

	public int[] filterMap;

	public string alternativeName = WeaponManager.PistolWN;

	public bool isSerialShooting;

	public int ammoInClip = 12;

	public int InitialAmmo = 24;

	public int maxAmmo = 84;

	public int ammoForBonusShotMelee = 10;

	public bool isMelee;

	public bool isRoundMelee;

	public float radiusRoundMelee = 5f;

	public bool isShotGun;

	public bool isDoubleShot;

	public int countShots = 15;

	public bool isShotMelee;

	public bool isZooming;

	public bool isMagic;

	public bool flamethrower;

	public bool bulletExplode;

	public bool bazooka;

	public int countInSeriaBazooka = 1;

	public float stepTimeInSeriaBazooka = 0.2f;

	public bool railgun;

	public bool freezer;

	public bool grenadeLauncher;

	public float bazookaExplosionRadius = 5f;

	public float bazookaExplosionRadiusSelf = 2.5f;

	public float bazookaImpulseRadius = 6f;

	public float fieldOfViewZomm = 75f;

	public float range = 3f;

	public int damage = 50;

	public float speedModifier = 1f;

	public int Probability = 1;

	public Vector2 damageRange = new Vector2(-15f, 15f);

	public Vector3 gunPosition = new Vector3(0.35f, -0.25f, 0.6f);

	public int inAppExtensionModifier = 10;

	public float meleeAngle = 50f;

	public float multiplayerDamage = 1f;

	public float meleeAttackTimeModifier = 0.57f;

	public Vector2 startZone;

	public float tekKoof = 1f;

	public float upKoofFire = 0.5f;

	public float maxKoof = 4f;

	public float downKoofFirst = 0.2f;

	public float downKoof = 0.2f;

	public bool campaignOnly;

	public int rocketNum;

	public int scopeNum;

	public float scaleShop = 150f;

	public Vector3 positionShop;

	public Vector3 rotationShop;

	public string localizeWeaponKey;

	private float animLength;

	private float timeFromFire = 1000f;

	public float DPS
	{
		get
		{
			if (ExpController.Instance == null)
			{
				return 0f;
			}
			int ourTier = ExpController.Instance.OurTier;
			int num = Math.Max(ourTier, tier);
			if (dpses.Length <= num)
			{
				return 0f;
			}
			return dpses[num] * ((!isShotGun) ? 1f : ((float)countShots * WeaponManager.ShotgunShotsCountModif()));
		}
	}

	public GameObject animationObject
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.animationObject;
		}
	}

	public Texture preview
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.preview;
		}
	}

	public AudioClip shoot
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.shoot;
		}
	}

	public AudioClip reload
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.reload;
		}
	}

	public AudioClip empty
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.empty;
		}
	}

	public GameObject bonusPrefab
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.bonusPrefab;
		}
	}

	public Texture2D aimTextureV
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.aimTextureV;
		}
	}

	public Texture2D aimTextureH
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.aimTextureH;
		}
	}

	public Transform LeftArmorHand
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.LeftArmorHand;
		}
	}

	public Transform RightArmorHand
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.RightArmorHand;
		}
	}

	public Transform grenatePoint
	{
		get
		{
			return (!(_innerPars != null)) ? null : _innerPars.grenatePoint;
		}
	}

	public int MaxAmmoWithEffectApplied
	{
		get
		{
			return (int)((float)maxAmmo * EffectsController.AmmoModForCategory(categoryNabor - 1));
		}
	}

	public int InitialAmmoWithEffectsApplied
	{
		get
		{
			return (int)((float)InitialAmmo * EffectsController.AmmoModForCategory(categoryNabor - 1));
		}
	}

	public string shopName
	{
		get
		{
			return LocalizationStore.Get(localizeWeaponKey);
		}
	}

	public string shopNameNonLocalized
	{
		get
		{
			return LocalizationStore.GetByDefault(localizeWeaponKey);
		}
	}

	private void Awake()
	{
		if (base.gameObject.name.Contains("Weapon"))
		{
			GameObject gameObject = Resources.Load(ResPath.Combine(Defs.InnerWeaponsFolder, base.gameObject.name.Replace("(Clone)", string.Empty) + Defs.InnerWeapons_Suffix)) as GameObject;
			if (gameObject != null)
			{
				_innerPars = (UnityEngine.Object.Instantiate(gameObject, new Vector3(0f, base.gameObject.transform.position.y, 0f), Quaternion.identity) as GameObject).GetComponent<InnerWeaponPars>();
				_innerPars.gameObject.transform.parent = base.gameObject.transform;
			}
		}
	}

	private void OnDestroy()
	{
		if (_innerPars != null)
		{
			_innerPars.transform.parent = null;
			UnityEngine.Object.Destroy(_innerPars.gameObject);
		}
	}

	private void Start()
	{
		if (Defs.isHunger && damageByTierInDeadly != null)
		{
			for (int i = 0; i < damageByTier.Length; i++)
			{
				if (i < damageByTierInDeadly.Length)
				{
					damageByTier[i] = damageByTierInDeadly[i];
				}
			}
		}
		for (int i = 0; i < damageByTier.Length; i++) {
			damageByTier[i] *= 0.65f;
		}
		if (!isMelee)
		{
			gunFlash = ((base.transform.childCount <= 0 || base.transform.GetChild(0).childCount <= 0) ? null : base.transform.GetChild(0).GetChild(0));
		}
		if (animationObject != null && animationObject.GetComponent<Animation>()["Shoot"] != null)
		{
			animLength = animationObject.GetComponent<Animation>()["Shoot"].length;
		}
	}

	private void Update()
	{
		if (base.transform.parent != null && base.transform.parent != null && base.transform.parent.GetComponent<Player_move_c>() != null && !base.transform.parent.GetComponent<Player_move_c>().isMine && base.transform.parent.GetComponent<Player_move_c>().isMulti)
		{
			animationObject.SetActive(!base.transform.parent.GetComponent<Player_move_c>().isInvisible);
		}
		if (timeFromFire < animLength)
		{
			timeFromFire += Time.deltaTime;
			if (tekKoof > 1f)
			{
				tekKoof -= downKoofFirst * Time.deltaTime / animLength;
			}
			if (tekKoof < 1f)
			{
				tekKoof = 1f;
			}
		}
		else
		{
			if (tekKoof > 1f)
			{
				tekKoof -= downKoof * Time.deltaTime / animLength;
			}
			if (tekKoof < 1f)
			{
				tekKoof = 1f;
			}
		}
	}

	public bool IsAvalibleFromFilter(int filter)
	{
		if (filterMap != null)
		{
			int[] array = filterMap;
			foreach (int num in array)
			{
				if (num == filter)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void fire()
	{
		timeFromFire = 0f;
		tekKoof += upKoofFire + downKoofFirst;
		if (tekKoof > maxKoof + downKoofFirst)
		{
			tekKoof = maxKoof + downKoofFirst;
		}
	}
}
