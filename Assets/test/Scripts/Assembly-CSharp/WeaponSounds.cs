using UnityEngine;

public class WeaponSounds : MonoBehaviour
{
	public enum TypeDead
	{
		angel = 0,
		explosion = 1,
		energyBlue = 2,
		energyRed = 3,
		energyPink = 4,
		energyCyan = 5,
		energyLight = 6,
		energyGreen = 7,
		energyOrange = 8,
		energyWhite = 9,
	}

	public TypeDead typeDead;
	public Transform gunFlash;
	public Transform[] gunFlashDouble;
	public float lengthForShot;
	public float[] damageByTier;
	public float[] dpses;
	public float[] damageByTierInDeadly;
	public int tier;
	public bool isGrenadeWeapon;
	public int damageShop;
	public int fireRateShop;
	public int CapacityShop;
	public int mobilityShop;
	public int zoomShop;
	public bool AreaDamageShop;
	public bool WallsBreakShop;
	public int[] filterMap;
	public string alternativeName;
	public bool isSerialShooting;
	public int InitialAmmo;
	public int ammoInClip;
	public int maxAmmo;
	public int ammoForBonusShotMelee;
	public bool isMelee;
	public bool isShotGun;
	public bool isDoubleShot;
	public int countShots;
	public bool isShotMelee;
	public bool isZooming;
	public bool isMagic;
	public bool flamethrower;
	public bool bazooka;
	public bool railgun;
	public bool freezer;
	public bool grenadeLauncher;
	public float bazookaExplosionRadius;
	public float bazookaExplosionRadiusSelf;
	public float bazookaImpulseRadius;
	public float fieldOfViewZomm;
	public float range;
	public int damage;
	public float speedModifier;
	public int Probability;
	public Vector2 damageRange;
	public Vector3 gunPosition;
	public int inAppExtensionModifier;
	public float meleeAngle;
	public float multiplayerDamage;
	public float meleeAttackTimeModifier;
	public Vector2 startZone;
	public float tekKoof;
	public float upKoofFire;
	public float maxKoof;
	public float downKoofFirst;
	public float downKoof;
	public bool campaignOnly;
	public int categoryNabor;
	public int rocketNum;
	public int scopeNum;
	public float scaleShop;
	public Vector3 positionShop;
	public Vector3 rotationShop;
	public string localizeWeaponKey;
}
