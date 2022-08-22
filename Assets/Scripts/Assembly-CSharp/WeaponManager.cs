using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

public sealed class WeaponManager : MonoBehaviour
{
	public struct infoClient
	{
		public string ipAddress;

		public string name;

		public string coments;
	}

	public const int NumOfWeaponCategories = 5;

	public static List<KeyValuePair<string, string>> replaceConstWithTemp;

	public GameObject _grenadeWeaponCache;

	public GameObject _turretWeaponCache;

	public GameObject _rocketCache;

	public GameObject _turretCache;

	public static string WeaponPreviewsPath;

	private static List<WeaponSounds> allWeaponPrefabs;

	private List<GameObject> cachedInnerPrefabs = new List<GameObject>();

	public string myCAnim(string a){
        return Defs.CAnim(currentWeaponSounds.animationObject, a);
    }

	public static Dictionary<string, string> campaignBonusWeapons;

	public static Dictionary<string, string> tagToStoreIDMapping;

	public static Dictionary<string, string> storeIDtoDefsSNMapping;

	private static readonly HashSet<string> _purchasableWeaponSet;

	public static string _3_shotgun_2_WN;

	public static string _3_shotgun_3_WN;

	public static string flower_2_WN;

	public static string flower_3_WN;

	public static string gravity_2_WN;

	public static string gravity_3_WN;

	public static string grenade_launcher_3_WN;

	public static string revolver_2_2_WN;

	public static string revolver_2_3_WN;

	public static string scythe_3_WN;

	public static string plazma_2_WN;

	public static string plazma_3_WN;

	public static string plazma_pistol_2_WN;

	public static string plazma_pistol_3_WN;

	public static string railgun_2_WN;

	public static string railgun_3_WN;

	public static string Razer_3_WN;

	public static string tesla_3_WN;

	public static string Flamethrower_3_WN;

	public static string FreezeGun_0_WN;

	public static string svd_3_WN;

	public static string barret_3_WN;

	public static string minigun_3_WN;

	public static string LightSword_3_WN;

	public static string Sword_2_3_WN;

	public static string Staff_3_WN;

	public static string DragonGun_WN;

	public static string Bow_3_WN;

	public static string Bazooka_1_3_WN;

	public static string Bazooka_2_1_WN;

	public static string Bazooka_2_3_WN;

	public static string m79_2_WN;

	public static string m79_3_WN;

	public static string m32_1_2_WN;

	public static string Red_Stone_3_WN;

	public static string XM8_1_WN;

	public static string PumpkinGun_1_WN;

	public static string XM8_2_WN;

	public static string XM8_3_WN;

	public static string PumpkinGun_2_WN;

	public static string Rocketnitza_WN;

	public static WeaponManager sharedManager;

	public List<int> newWeaponsInCats = new List<int>(5);

	public static readonly int LastNotNewWeapon;

	public List<string> shownWeapons = new List<string>();

	public HostData hostDataServer;

	public string ServerIp;

	public GameObject myPlayer;

	public Player_move_c myPlayerMoveC;

	public GameObject myGun;

	public GameObject myTable;

	public NetworkStartTable myNetworkStartTable;

	private UnityEngine.Object[] _weaponsInGame;

	private List<GameObject> _highMEmoryDevicesInnerPrefabsCache = new List<GameObject>();

	private UnityEngine.Object[] _multiWeapons;

	private UnityEngine.Object[] _hungerWeapons;

	private ArrayList _playerWeapons = new ArrayList();

	private ArrayList _allAvailablePlayerWeapons = new ArrayList();

	public int CurrentWeaponIndex;

	public Camera useCam;

	private WeaponSounds _currentWeaponSounds = new WeaponSounds();

	private Dictionary<string, Action<string, int>> _purchaseActinos = new Dictionary<string, Action<string, int>>(300);

	public List<infoClient> players = new List<infoClient>();

	public List<List<GameObject>> _weaponsByCat = new List<List<GameObject>>();

	private List<GameObject> _playerWeaponsSetInnerPrefabsCache = new List<GameObject>();

	private int _lockGetWeaponPrefabs;

	private static List<string> _Removed150615_Guns;

	private static bool firstTagsForTiersInitialized;

	private static Dictionary<string, string> firstTagsWithRespecToOurTier;

	private static string[] oldTags;

	private bool _resetLock;

	public int _currentFilterMap;

	private bool _initialized;

	private string[] DefaultWeaponForCat = new string[5] { MP5WN, PistolWN, KnifeWN, CampaignRifle_WN, Rocketnitza_WN };

	private string[] DefaultWeaponForCatCampaign = new string[5]
	{
		ShotgunWN,
		PistolWN,
		KnifeWN,
		string.Empty,
		string.Empty
	};

	private AnimationClip[] _profileAnimClips;

	private Comparison<WeaponSounds> dpsComparerWS = delegate(WeaponSounds leftWS, WeaponSounds rightWS)
	{
		if (ExpController.Instance == null || leftWS == null || rightWS == null)
		{
			return 0;
		}
		float num2 = leftWS.DPS - rightWS.DPS;
		return (num2 > 0f) ? 1 : ((!(num2 < 0f)) ? Array.IndexOf(WeaponComparer.multiplayerWeaponsOrd, leftWS.gameObject.tag).CompareTo(Array.IndexOf(WeaponComparer.multiplayerWeaponsOrd, rightWS.gameObject.tag)) : (-1));
	};

	private Comparison<GameObject> dpsComparer = delegate(GameObject leftw, GameObject rightw)
	{
		if (leftw == null || rightw == null)
		{
			return 0;
		}
		WeaponSounds component = leftw.GetComponent<WeaponSounds>();
		WeaponSounds component2 = rightw.GetComponent<WeaponSounds>();
		if (ExpController.Instance == null || component == null || component2 == null)
		{
			return 0;
		}
		float num = component.DPS - component2.DPS;
		return (num > 0f) ? 1 : ((!(num < 0f)) ? Array.IndexOf(WeaponComparer.multiplayerWeaponsOrd, leftw.tag).CompareTo(Array.IndexOf(WeaponComparer.multiplayerWeaponsOrd, rightw.tag)) : (-1));
	};

	public bool ResetLockSet
	{
		get
		{
			return _resetLock;
		}
	}

	public static int WeaponUsedCategory { get; set; }

	public static List<float> DefaultReloadSpeeds
	{
		get
		{
			List<float> list = new List<float>(5);
			for (int i = 0; i < 5; i++)
			{
				list.Add(1f);
			}
			return list;
		}
	}

	public static string PistolWN
	{
		get
		{
			return "Weapon1";
		}
	}

	public static string ShotgunWN
	{
		get
		{
			return "Weapon2";
		}
	}

	public static string MP5WN
	{
		get
		{
			return "Weapon3";
		}
	}

	public static string RevolverWN
	{
		get
		{
			return "Weapon4";
		}
	}

	public static string MachinegunWN
	{
		get
		{
			return "Weapon5";
		}
	}

	public static string AK47WN
	{
		get
		{
			return "Weapon8";
		}
	}

	public static string KnifeWN
	{
		get
		{
			return "Weapon9";
		}
	}

	public static string ObrezWN
	{
		get
		{
			return "Weapon51";
		}
	}

	public static string AlienGunWN
	{
		get
		{
			return "Weapon52";
		}
	}

	public static string BugGunWN
	{
		get
		{
			return "Weapon250";
		}
	}

	public static string _initialWeaponName
	{
		get
		{
			return "FirstPistol";
		}
	}

	public static string PickWeaponName
	{
		get
		{
			return "Weapon6";
		}
	}

	public static string MultiplayerMeleeTag
	{
		get
		{
			return "Knife";
		}
	}

	public static string SwordWeaponName
	{
		get
		{
			return "Weapon7";
		}
	}

	public static string CombatRifleWeaponName
	{
		get
		{
			return "Weapon10";
		}
	}

	public static string GoldenEagleWeaponName
	{
		get
		{
			return "Weapon11";
		}
	}

	public static string MagicBowWeaponName
	{
		get
		{
			return "Weapon12";
		}
	}

	public static string SpasWeaponName
	{
		get
		{
			return "Weapon13";
		}
	}

	public static string GoldenAxeWeaponnName
	{
		get
		{
			return "Weapon14";
		}
	}

	public static string ChainsawWN
	{
		get
		{
			return "Weapon15";
		}
	}

	public static string FAMASWN
	{
		get
		{
			return "Weapon16";
		}
	}

	public static string GlockWN
	{
		get
		{
			return "Weapon17";
		}
	}

	public static string ScytheWN
	{
		get
		{
			return "Weapon18";
		}
	}

	public static string Scythe_2_WN
	{
		get
		{
			return "Weapon68";
		}
	}

	public static string ShovelWN
	{
		get
		{
			return "Weapon19";
		}
	}

	public static string HammerWN
	{
		get
		{
			return "Weapon20";
		}
	}

	public static string Sword_2_WN
	{
		get
		{
			return "Weapon21";
		}
	}

	public static string StaffWN
	{
		get
		{
			return "Weapon22";
		}
	}

	public static string LaserRifleWN
	{
		get
		{
			return "Weapon23";
		}
	}

	public static string LightSwordWN
	{
		get
		{
			return "Weapon24";
		}
	}

	public static string BerettaWN
	{
		get
		{
			return "Weapon25";
		}
	}

	public static string Beretta_2_WN
	{
		get
		{
			return "Weapon71";
		}
	}

	public static string MaceWN
	{
		get
		{
			return "Weapon26";
		}
	}

	public static string CrossbowWN
	{
		get
		{
			return "Weapon27";
		}
	}

	public static string MinigunWN
	{
		get
		{
			return "Weapon28";
		}
	}

	public static string GoldenPickWN
	{
		get
		{
			return "Weapon29";
		}
	}

	public static string CrystalPickWN
	{
		get
		{
			return "Weapon30";
		}
	}

	public static string IronSwordWN
	{
		get
		{
			return "Weapon31";
		}
	}

	public static string GoldenSwordWN
	{
		get
		{
			return "Weapon32";
		}
	}

	public static string GoldenRed_StoneWN
	{
		get
		{
			return "Weapon33";
		}
	}

	public static string GoldenSPASWN
	{
		get
		{
			return "Weapon34";
		}
	}

	public static string GoldenGlockWN
	{
		get
		{
			return "Weapon35";
		}
	}

	public static string RedMinigunWN
	{
		get
		{
			return "Weapon36";
		}
	}

	public static string CrystalCrossbowWN
	{
		get
		{
			return "Weapon37";
		}
	}

	public static string RedLightSaberWN
	{
		get
		{
			return "Weapon38";
		}
	}

	public static string SandFamasWN
	{
		get
		{
			return "Weapon39";
		}
	}

	public static string WhiteBerettaWN
	{
		get
		{
			return "Weapon40";
		}
	}

	public static string BlackEagleWN
	{
		get
		{
			return "Weapon41";
		}
	}

	public static string CrystalAxeWN
	{
		get
		{
			return "Weapon42";
		}
	}

	public static string SteelAxeWN
	{
		get
		{
			return "Weapon43";
		}
	}

	public static string WoodenBowWN
	{
		get
		{
			return "Weapon44";
		}
	}

	public static string Chainsaw2WN
	{
		get
		{
			return "Weapon45";
		}
	}

	public static string SteelCrossbowWN
	{
		get
		{
			return "Weapon46";
		}
	}

	public static string Hammer2WN
	{
		get
		{
			return "Weapon47";
		}
	}

	public static string Mace2WN
	{
		get
		{
			return "Weapon48";
		}
	}

	public static string Sword_22WN
	{
		get
		{
			return "Weapon49";
		}
	}

	public static string Staff2WN
	{
		get
		{
			return "Weapon50";
		}
	}

	public static string M16_2WN
	{
		get
		{
			return "Weapon53";
		}
	}

	public static string M16_3WN
	{
		get
		{
			return "Weapon69";
		}
	}

	public static string M16_4WN
	{
		get
		{
			return "Weapon70";
		}
	}

	public static string CrystalGlockWN
	{
		get
		{
			return "Weapon54";
		}
	}

	public static string CrystalSPASWN
	{
		get
		{
			return "Weapon55";
		}
	}

	public static string TreeWN
	{
		get
		{
			return "Weapon56";
		}
	}

	public static string Tree_2_WN
	{
		get
		{
			return "Weapon72";
		}
	}

	public static string FireAxeWN
	{
		get
		{
			return "Weapon57";
		}
	}

	public static string _3pl_shotgunWN
	{
		get
		{
			return "Weapon58";
		}
	}

	public static string Revolver2WN
	{
		get
		{
			return "Weapon59";
		}
	}

	public static string BarrettWN
	{
		get
		{
			return "Weapon60";
		}
	}

	public static string svdWN
	{
		get
		{
			return "Weapon61";
		}
	}

	public static string NavyFamasWN
	{
		get
		{
			return "Weapon62";
		}
	}

	public static string svd_2WN
	{
		get
		{
			return "Weapon63";
		}
	}

	public static string Eagle_3WN
	{
		get
		{
			return "Weapon64";
		}
	}

	public static string Barrett_2WN
	{
		get
		{
			return "Weapon65";
		}
	}

	public static string UZI_WN
	{
		get
		{
			return "Weapon66";
		}
	}

	public static string CampaignRifle_WN
	{
		get
		{
			return "Weapon67";
		}
	}

	public static string Flamethrower_WN
	{
		get
		{
			return "Weapon73";
		}
	}

	public static string Flamethrower_2_WN
	{
		get
		{
			return "Weapon74";
		}
	}

	public static string Bazooka_WN
	{
		get
		{
			return "Weapon75";
		}
	}

	public static string Bazooka_2_WN
	{
		get
		{
			return "Weapon76";
		}
	}

	public static string Railgun_WN
	{
		get
		{
			return "Weapon77";
		}
	}

	public static string Tesla_WN
	{
		get
		{
			return "Weapon78";
		}
	}

	public static string GrenadeLunacher_WN
	{
		get
		{
			return "Weapon79";
		}
	}

	public static string GrenadeLunacher_2_WN
	{
		get
		{
			return "Weapon80";
		}
	}

	public static string Tesla_2_WN
	{
		get
		{
			return "Weapon81";
		}
	}

	public static string Bazooka_3_WN
	{
		get
		{
			return "Weapon82";
		}
	}

	public static string Gravigun_WN
	{
		get
		{
			return "Weapon83";
		}
	}

	public static string AUG_WN
	{
		get
		{
			return "Weapon84";
		}
	}

	public static string AUG_2_WN
	{
		get
		{
			return "Weapon85";
		}
	}

	public static string Razer_WN
	{
		get
		{
			return "Weapon86";
		}
	}

	public static string Razer_2_WN
	{
		get
		{
			return "Weapon87";
		}
	}

	public static string katana_WN
	{
		get
		{
			return "Weapon88";
		}
	}

	public static string katana_2_WN
	{
		get
		{
			return "Weapon89";
		}
	}

	public static string katana_3_WN
	{
		get
		{
			return "Weapon90";
		}
	}

	public static string plazma_WN
	{
		get
		{
			return "Weapon91";
		}
	}

	public static string plazma_pistol_WN
	{
		get
		{
			return "Weapon92";
		}
	}

	public static string Flower_WN
	{
		get
		{
			return "Weapon93";
		}
	}

	public static string Buddy_WN
	{
		get
		{
			return "Weapon94";
		}
	}

	public static string Mauser_WN
	{
		get
		{
			return "Weapon95";
		}
	}

	public static string Shmaiser_WN
	{
		get
		{
			return "Weapon96";
		}
	}

	public static string Thompson_WN
	{
		get
		{
			return "Weapon97";
		}
	}

	public static string Thompson_2_WN
	{
		get
		{
			return "Weapon98";
		}
	}

	public static string BassCannon_WN
	{
		get
		{
			return "Weapon99";
		}
	}

	public static string SpakrlyBlaster_WN
	{
		get
		{
			return "Weapon100";
		}
	}

	public static string CherryGun_WN
	{
		get
		{
			return "Weapon101";
		}
	}

	public static string AK74_WN
	{
		get
		{
			return "Weapon102";
		}
	}

	public static string AK74_2_WN
	{
		get
		{
			return "Weapon103";
		}
	}

	public static string AK74_3_WN
	{
		get
		{
			return "Weapon104";
		}
	}

	public static string FreezeGun_WN
	{
		get
		{
			return "Weapon105";
		}
	}

	public UnityEngine.Object[] weaponsInGame
	{
		get
		{
			return _weaponsInGame;
		}
	}

	public ArrayList playerWeapons
	{
		get
		{
			return _playerWeapons;
		}
	}

	public List<Weapon> weaponsInSlots
	{
		get
		{
			if (playerWeapons == null)
			{
				return null;
			}
			List<Weapon> list = new List<Weapon>(5);
			for (int i = 0; i < 5; i++)
			{
				list.Add(null);
			}
			foreach (Weapon playerWeapon in playerWeapons)
			{
				int num = playerWeapon.weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1;
				if (num >= 0 && num <= 5)
				{
					list[num] = playerWeapon;
				}
			}
			return list;
		}
	}

	public ArrayList allAvailablePlayerWeapons
	{
		get
		{
			return _allAvailablePlayerWeapons;
		}
	}

	public WeaponSounds currentWeaponSounds
	{
		get
		{
			return _currentWeaponSounds;
		}
		set
		{
			_currentWeaponSounds = value;
		}
	}

	public int LockGetWeaponPrefabs
	{
		get
		{
			return _lockGetWeaponPrefabs;
		}
	}

	public bool Initialized
	{
		get
		{
			return _initialized;
		}
	}

	public static event Action<int> WeaponEquipped;

	static WeaponManager()
	{
		replaceConstWithTemp = new List<KeyValuePair<string, string>>();
		WeaponPreviewsPath = "WeaponPreviews";
		allWeaponPrefabs = null;
		campaignBonusWeapons = new Dictionary<string, string>();
		tagToStoreIDMapping = new Dictionary<string, string>(999);
		storeIDtoDefsSNMapping = new Dictionary<string, string>(999);
		_purchasableWeaponSet = new HashSet<string>();
		_3_shotgun_2_WN = "Weapon107";
		_3_shotgun_3_WN = "Weapon108";
		flower_2_WN = "Weapon109";
		flower_3_WN = "Weapon110";
		gravity_2_WN = "Weapon111";
		gravity_3_WN = "Weapon112";
		grenade_launcher_3_WN = "Weapon113";
		revolver_2_2_WN = "Weapon114";
		revolver_2_3_WN = "Weapon115";
		scythe_3_WN = "Weapon116";
		plazma_2_WN = "Weapon117";
		plazma_3_WN = "Weapon118";
		plazma_pistol_2_WN = "Weapon119";
		plazma_pistol_3_WN = "Weapon120";
		railgun_2_WN = "Weapon121";
		railgun_3_WN = "Weapon122";
		Razer_3_WN = "Weapon123";
		tesla_3_WN = "Weapon124";
		Flamethrower_3_WN = "Weapon125";
		FreezeGun_0_WN = "Weapon126";
		svd_3_WN = "Weapon128";
		barret_3_WN = "Weapon129";
		minigun_3_WN = "Weapon127";
		LightSword_3_WN = "Weapon130";
		Sword_2_3_WN = "Weapon131";
		Staff_3_WN = "Weapon132";
		DragonGun_WN = "Weapon133";
		Bow_3_WN = "Weapon134";
		Bazooka_1_3_WN = "Weapon135";
		Bazooka_2_1_WN = "Weapon136";
		Bazooka_2_3_WN = "Weapon137";
		m79_2_WN = "Weapon138";
		m79_3_WN = "Weapon139";
		m32_1_2_WN = "Weapon140";
		Red_Stone_3_WN = "Weapon141";
		XM8_1_WN = "Weapon142";
		PumpkinGun_1_WN = "Weapon143";
		XM8_2_WN = "Weapon144";
		XM8_3_WN = "Weapon145";
		PumpkinGun_2_WN = "Weapon147";
		Rocketnitza_WN = "Weapon162";
		sharedManager = null;
		LastNotNewWeapon = 76;
		_Removed150615_Guns = null;
		firstTagsForTiersInitialized = false;
		firstTagsWithRespecToOurTier = new Dictionary<string, string>();
		oldTags = new string[53]
		{
			WeaponTags.MinersWeaponTag,
			WeaponTags.Sword_2_3_Tag,
			WeaponTags.RailgunTag,
			WeaponTags.SteelAxeTag,
			WeaponTags.IronSwordTag,
			WeaponTags.Red_Stone_3_Tag,
			WeaponTags.SPASTag,
			WeaponTags.SteelCrossbowTag,
			WeaponTags.minigun_3_Tag,
			WeaponTags.LightSword_3_Tag,
			WeaponTags.FAMASTag,
			WeaponTags.FreezeGunTag,
			WeaponTags.BerettaTag,
			WeaponTags.EagleTag,
			WeaponTags.GlockTag,
			WeaponTags.svdTag,
			WeaponTags.m16Tag,
			WeaponTags.TreeTag,
			WeaponTags.revolver_2_3_Tag,
			WeaponTags.FreezeGun_0_Tag,
			WeaponTags.TeslaTag,
			WeaponTags.Bazooka_3Tag,
			WeaponTags.GrenadeLuancher_2Tag,
			WeaponTags.BazookaTag,
			WeaponTags.AUGTag,
			WeaponTags.AK74Tag,
			WeaponTags.GravigunTag,
			WeaponTags.XM8_1_Tag,
			WeaponTags.PumpkinGun_1_Tag,
			WeaponTags.SnowballMachingun_Tag,
			WeaponTags.SnowballGun_Tag,
			WeaponTags.HeavyShotgun_Tag,
			WeaponTags.TwoBolters_Tag,
			WeaponTags.TwoRevolvers_Tag,
			WeaponTags.AutoShotgun_Tag,
			WeaponTags.Solar_Ray_Tag,
			WeaponTags.Water_Pistol_Tag,
			WeaponTags.Solar_Power_Cannon_Tag,
			WeaponTags.Water_Rifle_Tag,
			WeaponTags.Valentine_Shotgun_Tag,
			WeaponTags.Needle_Throw_Tag,
			WeaponTags.Needle_Throw_Tag,
			WeaponTags.Carrot_Sword_Tag,
			WeaponTags._3_shotgun_3_Tag,
			WeaponTags.plazma_3_Tag,
			WeaponTags.katana_3_Tag,
			WeaponTags.DragonGun_Tag,
			WeaponTags.Bazooka_2_3_Tag,
			WeaponTags.buddy_Tag,
			WeaponTags.barret_3_Tag,
			WeaponTags.Flamethrower_3_Tag,
			WeaponTags.SparklyBlasterTag,
			WeaponTags.Thompson_2_Tag
		};
		WeaponManager.WeaponEquipped = null;
		WeaponUsedCategory = 4;
		ItemDb.Fill_tagToStoreIDMapping(tagToStoreIDMapping);
		ItemDb.Fill_storeIDtoDefsSNMapping(storeIDtoDefsSNMapping);
		_purchasableWeaponSet.UnionWith(storeIDtoDefsSNMapping.Values);
		if (BuildSettings.BuildTarget != BuildTarget.Android)
		{
		}
	}

	public static GameObject AddRay(Vector3 pos, Vector3 forw, string nm)
	{
		GameObject gameObject = Resources.Load(ResPath.Combine("Rays", nm)) as GameObject;
		if (gameObject == null)
		{
			gameObject = Resources.Load(ResPath.Combine("Rays", "Weapon77")) as GameObject;
		}
		if (gameObject == null)
		{
			return null;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, pos, Quaternion.identity) as GameObject;
		gameObject2.transform.forward = forw;
		return gameObject2;
	}

	public static void SetGunFlashActive(GameObject gunFlash, bool _a)
	{
		if (!(gunFlash == null))
		{
			Transform transform = null;
			if (gunFlash.transform.childCount > 0)
			{
				transform = gunFlash.transform.GetChild(0);
			}
			if (transform != null)
			{
				transform.gameObject.SetActive(_a);
			}
		}
	}

	public static List<WeaponSounds> AllWrapperPrefabs()
	{
		if (allWeaponPrefabs == null)
		{
			allWeaponPrefabs = Resources.LoadAll<WeaponSounds>("Weapons").ToList();
		}
		return allWeaponPrefabs;
	}

	public void PrepareForShopWeaponCategory(int catNum)
	{
		if (catNum > 4)
		{
			return;
		}
		ClearCachedInnerPrefabs();
		foreach (GameObject item in _weaponsByCat[catNum])
		{
			cachedInnerPrefabs.Add(InnerPrefabForWeapon(item));
		}
	}

	public void ClearCachedInnerPrefabs()
	{
		cachedInnerPrefabs.Clear();
		if (Device.IsLoweMemoryDevice)
		{
			Resources.UnloadUnusedAssets();
		}
	}

	public static GameObject InnerPrefabForWeapon(GameObject weapon)
	{
		return InnerPrefabForWeapon(weapon.name);
	}

	public static string FirstUnboughtOrForOurTier(string tg)
	{
		string text = FirstUnboughtTag(tg);
		if (tagToStoreIDMapping.ContainsKey(tg))
		{
			string text2 = FirstTagForOurTier(tg);
			List<string> list = WeaponUpgrades.ChainForTag(tg);
			if (text2 != null && list != null && list.IndexOf(text2) > list.IndexOf(text))
			{
				text = text2;
			}
		}
		return text;
	}

	public static GameObject InnerPrefabForWeapon(string weapon)
	{
		return Resources.Load<GameObject>(Defs.InnerWeaponsFolder + "/" + weapon + Defs.InnerWeapons_Suffix);
	}

	public static bool PurchasableWeaponSetContains(string weaponTag)
	{
		return _purchasableWeaponSet.Contains(weaponTag);
	}

	public void WeaponShowed(string tg)
	{
		GameObject gameObject = null;
		UnityEngine.Object[] array = weaponsInGame;
		for (int i = 0; i < array.Length; i++)
		{
			GameObject gameObject2 = (GameObject)array[i];
			if (gameObject2.CompareTag(tg))
			{
				gameObject = gameObject2;
				break;
			}
		}
		if (gameObject == null)
		{
			return;
		}
		int result = 0;
		if (int.TryParse(gameObject.name.Substring("Weapon".Length), out result) && result > LastNotNewWeapon && !shownWeapons.Contains(gameObject.name))
		{
			WeaponSounds component = gameObject.GetComponent<WeaponSounds>();
			if (!component.campaignOnly)
			{
				shownWeapons.Add(gameObject.name);
				Save.SaveStringArray(Defs.ShownNewWeaponsSN, shownWeapons.ToArray());
				PlayerPrefs.Save();
				List<int> list;
				List<int> list2 = (list = newWeaponsInCats);
				int index;
				int index2 = (index = component.categoryNabor - 1);
				index = list[index];
				list2[index2] = index - 1;
			}
		}
	}

	public void SaveWeaponSet(string sn, string wn, int pos)
	{
		string text = LoadWeaponSet(sn);
		string[] array = text.Split('#');
		array[pos] = wn;
		string text2 = string.Join("#", array);
		PlayerPrefs.SetString(sn, text2);
	}

	private string _KnifeSet()
	{
		return "##" + KnifeWN + "##";
	}

	private string _KnifeAndPistolSet()
	{
		return "#" + PistolWN + "#" + KnifeWN + "##";
	}

	public string _KnifeAndPistolAndShotgunSet()
	{
		return ShotgunWN + "#" + PistolWN + "#" + KnifeWN + "##";
	}

	public string _KnifeAndPistolAndMP5AndSniperAndRocketnitzaSet()
	{
		return MP5WN + "#" + PistolWN + "#" + KnifeWN + "#" + CampaignRifle_WN + "#" + Rocketnitza_WN;
	}

	public string LoadWeaponSet(string sn)
	{
		string text = ((!sn.Equals(Defs.MultiplayerWSSN)) ? _KnifeAndPistolAndShotgunSet() : _KnifeAndPistolAndMP5AndSniperAndRocketnitzaSet());
		return PlayerPrefs.GetString(sn, text);
	}

	public void SetWeaponsSet(int filterMap = 0)
	{
		_playerWeapons.Clear();
		bool isMulti = Defs.isMulti;
		bool isHunger = Defs.isHunger;
		bool insideTraining = GlobalGameController.InsideTraining;
		string text = null;
		text = (isMulti ? (isHunger ? _KnifeSet() : LoadWeaponSet(Defs.MultiplayerWSSN)) : ((!Defs.IsSurvival && !insideTraining) ? LoadWeaponSet(Defs.CampaignWSSN) : ((!Defs.IsSurvival || insideTraining) ? _KnifeAndPistolSet() : LoadWeaponSet(Defs.MultiplayerWSSN))));
		string[] array = text.Split('#');
		string[] array2 = array;
		foreach (string value in array2)
		{
			if (string.IsNullOrEmpty(value))
			{
				continue;
			}
			foreach (Weapon allAvailablePlayerWeapon in allAvailablePlayerWeapons)
			{
				if (allAvailablePlayerWeapon.weaponPrefab.name.Equals(value))
				{
					EquipWeapon(allAvailablePlayerWeapon, false);
					break;
				}
			}
		}
		if (filterMap == 2)
		{
			foreach (Weapon allAvailablePlayerWeapon2 in allAvailablePlayerWeapons)
			{
				if (allAvailablePlayerWeapon2.weaponPrefab.name.Equals(KnifeWN))
				{
					EquipWeapon(allAvailablePlayerWeapon2, false);
					break;
				}
			}
			foreach (Weapon allAvailablePlayerWeapon3 in allAvailablePlayerWeapons)
			{
				if (allAvailablePlayerWeapon3.weaponPrefab.name.Equals(PistolWN))
				{
					EquipWeapon(allAvailablePlayerWeapon3, false);
					break;
				}
			}
		}
		if (filterMap == 2 && playerWeapons.Count == 2)
		{
			foreach (Weapon allAvailablePlayerWeapon4 in allAvailablePlayerWeapons)
			{
				if (allAvailablePlayerWeapon4.weaponPrefab.name.Equals(CampaignRifle_WN))
				{
					EquipWeapon(allAvailablePlayerWeapon4, false);
					break;
				}
			}
		}
		if (playerWeapons.Count == 0)
		{
			UpdatePlayersWeaponSetCache();
		}
	}

	public static string LastBoughtTag(string tg)
	{
		if (tg == null)
		{
			return null;
		}
		if (tagToStoreIDMapping.ContainsKey(tg))
		{
			bool flag = false;
			List<string> list = null;
			foreach (List<string> upgrade in WeaponUpgrades.upgrades)
			{
				if (upgrade.Contains(tg))
				{
					list = upgrade;
					flag = true;
					break;
				}
			}
			if (flag)
			{
				for (int num = list.Count - 1; num >= 0; num--)
				{
					if (Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[list[num]]], true) == 1)
					{
						return list[num];
					}
				}
				return null;
			}
			bool flag2 = ItemDb.IsTemporaryGun(tg);
			if ((!flag2 && Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[tg]], true) == 1) || (flag2 && TempItemsController.sharedController.ContainsItem(tg)))
			{
				return tg;
			}
			return null;
		}
		foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item in Wear.wear)
		{
			foreach (List<string> item2 in item.Value)
			{
				if (!item2.Contains(tg))
				{
					continue;
				}
				if (TempItemsController.PriceCoefs.ContainsKey(tg))
				{
					return (!(TempItemsController.sharedController != null) || !TempItemsController.sharedController.ContainsItem(tg)) ? null : tg;
				}
				if (Storager.getInt(item2[0], true) == 0)
				{
					return null;
				}
				for (int i = 1; i < item2.Count; i++)
				{
					if (Storager.getInt(item2[i], true) == 0)
					{
						return item2[i - 1];
					}
				}
				return item2[item2.Count - 1];
			}
		}
		return tg;
	}

	public static string FirstUnboughtTag(string tg)
	{
		if (tg == null)
		{
			return null;
		}
		if (tagToStoreIDMapping.ContainsKey(tg))
		{
			bool flag = false;
			List<string> list = null;
			foreach (List<string> upgrade in WeaponUpgrades.upgrades)
			{
				if (upgrade.Contains(tg))
				{
					list = upgrade;
					flag = true;
					break;
				}
			}
			if (flag)
			{
				for (int num = list.Count - 1; num >= 0; num--)
				{
					if (Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[list[num]]], true) == 1)
					{
						if (num < list.Count - 1)
						{
							return list[num + 1];
						}
						return list[num];
					}
				}
				return list[0];
			}
			return tg;
		}
		if (TempItemsController.PriceCoefs.ContainsKey(tg))
		{
			return tg;
		}
		foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item in Wear.wear)
		{
			foreach (List<string> item2 in item.Value)
			{
				if (!item2.Contains(tg))
				{
					continue;
				}
				for (int i = 0; i < item2.Count; i++)
				{
					if (Storager.getInt(item2[i], true) == 0)
					{
						return item2[i];
					}
				}
				return item2[item2.Count - 1];
			}
		}
		return tg;
	}

	private void UpdatePlayersWeaponSetCache()
	{
		List<GameObject> list = new List<GameObject>();
		foreach (Weapon playerWeapon in playerWeapons)
		{
			list.Add(InnerPrefabForWeapon(playerWeapon.weaponPrefab));
		}
		_playerWeaponsSetInnerPrefabsCache.Clear();
		_playerWeaponsSetInnerPrefabsCache = list;
		if (Device.IsLoweMemoryDevice)
		{
			Resources.UnloadUnusedAssets();
		}
	}

	public void EquipWeapon(Weapon w, bool shouldSave = true)
	{
		if (w == null)
		{
			UnityEngine.Debug.LogWarning("Exiting from EquipWeapon(), because weapon is null.");
			return;
		}
		bool isMulti = Defs.isMulti;
		bool isHunger = Defs.isHunger;
		bool insideTraining = GlobalGameController.InsideTraining;
		int categoryNabor = w.weaponPrefab.GetComponent<WeaponSounds>().categoryNabor;
		bool flag = false;
		for (int i = 0; i < playerWeapons.Count; i++)
		{
			if ((playerWeapons[i] as Weapon).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor == categoryNabor)
			{
				flag = true;
				playerWeapons[i] = w;
				UpdatePlayersWeaponSetCache();
				break;
			}
		}
		if (!flag)
		{
			playerWeapons.Add(w);
			UpdatePlayersWeaponSetCache();
		}
		playerWeapons.Sort(new WeaponComparer());
		playerWeapons.Reverse();
		CurrentWeaponIndex = playerWeapons.IndexOf(w);
		if (!shouldSave)
		{
			return;
		}
		string[] array = Storager.getString(Defs.WeaponsGotInCampaign, false).Split('#');
		List<string> list = new List<string>();
		string[] array2 = array;
		foreach (string item in array2)
		{
			list.Add(item);
		}
		bool flag2 = !w.weaponPrefab.name.Equals(Rocketnitza_WN) && (!w.weaponPrefab.name.Equals(MP5WN) || list.Contains(MP5WN)) && (!w.weaponPrefab.name.Equals(CampaignRifle_WN) || list.Contains(CampaignRifle_WN));
		if (isMulti)
		{
			if (!isHunger)
			{
				SaveWeaponSet(Defs.MultiplayerWSSN, w.weaponPrefab.name, categoryNabor - 1);
				if (flag2)
				{
					SaveWeaponSet(Defs.CampaignWSSN, w.weaponPrefab.name, categoryNabor - 1);
				}
			}
		}
		else if (!Defs.IsSurvival && !insideTraining)
		{
			if (!w.weaponPrefab.GetComponent<WeaponSounds>().campaignOnly && !w.weaponPrefab.name.Equals(AlienGunWN))
			{
				SaveWeaponSet(Defs.MultiplayerWSSN, w.weaponPrefab.name, categoryNabor - 1);
			}
			SaveWeaponSet(Defs.CampaignWSSN, w.weaponPrefab.name, categoryNabor - 1);
		}
		else if (Defs.IsSurvival && !insideTraining && !w.weaponPrefab.GetComponent<WeaponSounds>().campaignOnly && !w.weaponPrefab.name.Equals(AlienGunWN))
		{
			SaveWeaponSet(Defs.MultiplayerWSSN, w.weaponPrefab.name, categoryNabor - 1);
			if (flag2)
			{
				SaveWeaponSet(Defs.CampaignWSSN, w.weaponPrefab.name, categoryNabor - 1);
			}
		}
		if (WeaponManager.WeaponEquipped != null)
		{
			WeaponManager.WeaponEquipped(categoryNabor - 1);
		}
	}

	public void GetWeaponPrefabs(int filterMap = 0)
	{
		IEnumerator weaponPrefabsCoroutine = GetWeaponPrefabsCoroutine(filterMap);
		while (weaponPrefabsCoroutine.MoveNext())
		{
			object current = weaponPrefabsCoroutine.Current;
		}
	}

	private void AddInnerPrefabToCache(GameObject o)
	{
		if (!Device.IsLoweMemoryDevice)
		{
			GameObject gameObject = InnerPrefabForWeapon(o);
			if (gameObject != null && !_highMEmoryDevicesInnerPrefabsCache.Contains(gameObject))
			{
				_highMEmoryDevicesInnerPrefabsCache.Add(gameObject);
			}
		}
	}

	private IEnumerator GetWeaponPrefabsCoroutine(int filterMap = 0)
	{
		_lockGetWeaponPrefabs++;
		List<UnityEngine.Object> wInG = new List<UnityEngine.Object>();
		Stopwatch stopwatch = Stopwatch.StartNew();
		UnityEngine.Debug.Log(">>> Resources.LoadAll(\"Weapons\")");
		List<GameObject> wp = new List<GameObject>(1000);
		List<GameObject> innerP = new List<GameObject>(1000);
		int yieldCount = 0;
		for (int i = 0; i < Resources.LoadAll<WeaponSounds>("Weapons").ToArray().Length; i++)
		{
			GameObject w = Resources.Load<GameObject>("Weapons/Weapon" + i);
			GameObject iw = (Device.IsLoweMemoryDevice ? null : ((!(w != null)) ? null : InnerPrefabForWeapon(w)));
			if (w != null)
			{
				wp.Add(w);
				if (iw != null)
				{
					innerP.Add(iw);
				}
				if (yieldCount % 8 == 7)
				{
					yield return null;
				}
				yieldCount++;
			}
		}
		stopwatch.Stop();
		UnityEngine.Debug.Log("<<< Resources.LoadAll(\"Weapons\"): " + stopwatch.ElapsedMilliseconds);
		bool isMulti = Defs.isMulti;
		bool isHungry = isMulti && Defs.isHunger;
		bool isTraining = GlobalGameController.InsideTraining;
		bool isCampaign = !Defs.IsSurvival && !isTraining && !isMulti;
		if (Device.IsLoweMemoryDevice)
		{
			_highMEmoryDevicesInnerPrefabsCache.Clear();
		}
		foreach (GameObject o in wp)
		{
			WeaponSounds ws = o.GetComponent<WeaponSounds>();
			if (filterMap != 0 && !ws.IsAvalibleFromFilter(filterMap))
			{
				continue;
			}
			if (isMulti)
			{
				if (!isHungry)
				{
					if (!ws.campaignOnly || ws.IsAvalibleFromFilter(filterMap))
					{
						wInG.Add(o);
						AddInnerPrefabToCache(o);
					}
					continue;
				}
				int num = int.Parse(o.name.Substring("Weapon".Length));
				if (num == 9 || ChestController.weaponForHungerGames.Contains(num))
				{
					wInG.Add(o);
					AddInnerPrefabToCache(o);
				}
			}
			else if (Defs.IsSurvival || !o.name.Equals(Rocketnitza_WN))
			{
				wInG.Add(o);
				AddInnerPrefabToCache(o);
			}
		}
		wp.Clear();
		innerP.Clear();
		_weaponsInGame = wInG.ToArray();
		Resources.UnloadUnusedAssets();
		_lockGetWeaponPrefabs--;
	}

	private bool _WeaponAvailable(GameObject prefab, List<string> weaponsGotInCampaign, int filterMap)
	{
		bool isMulti = Defs.isMulti;
		bool isHunger = Defs.isHunger;
		bool insideTraining = GlobalGameController.InsideTraining;
		bool flag = !Defs.IsSurvival && !insideTraining && !isMulti;
		if (prefab.name.Equals("Weapon9"))
		{
    		return true;
		}
		if (prefab.name.Equals("Weapon1") && !isHunger)
		{
   			return true;
		}
		if (prefab.name.Equals(ShotgunWN) && !isHunger && !insideTraining)
		{
    		return true;
		}
		if (prefab.name.Equals(MP5WN) && (isMulti || Defs.IsSurvival) && !isHunger && !insideTraining)
		{
   			return true;
		}
		if (prefab.name.Equals(CampaignRifle_WN) && (isMulti || Defs.IsSurvival) && !isHunger && !insideTraining)
		{
    		return true;
		}
		if (prefab.name.Equals(Rocketnitza_WN) && (isMulti || Defs.IsSurvival) && !isHunger && !insideTraining)
		{
    		return true;
		}
		WeaponSounds component = prefab.GetComponent<WeaponSounds>();
		if (!isHunger && prefab.name != null && TempItemsController.sharedController.ContainsItem(prefab.name) && (filterMap == 0 || (component.filterMap != null && component.filterMap.Contains(filterMap))))
		{
		    return true;
		}
		if (flag && LevelBox.weaponsFromBosses.ContainsValue(prefab.name) && weaponsGotInCampaign.Contains(prefab.name))
		{
		    return true;
		}
		bool flag2 = prefab.name.Equals(BugGunWN) && weaponsGotInCampaign.Contains(BugGunWN);
		if (Defs.IsSurvival && !insideTraining && !isMulti && flag2)
		{
			return true;
		}
		if (!Defs.IsSurvival && !insideTraining && isMulti && !isHunger && flag2)
		{
			return true;
		}
		return false;
	}

	public static float ShotgunShotsCountModif()
	{
		return 2f / 3f;
	}

	private void _SortShopLists()
	{
		for (int i = 0; i < 5; i++)
		{
			Dictionary<string, List<GameObject>> dictionary = new Dictionary<string, List<GameObject>>();
			foreach (GameObject item in _weaponsByCat[i])
			{
				string key = WeaponUpgrades.TagOfFirstUpgrade(item.tag);
				if (dictionary.ContainsKey(key))
				{
					dictionary[key].Add(item);
					continue;
				}
				dictionary.Add(key, new List<GameObject> { item });
			}
			List<List<GameObject>> list = dictionary.Values.ToList();
			foreach (List<GameObject> item2 in list)
			{
				if (item2.Count > 1)
				{
					item2.Sort(dpsComparer);
				}
			}
			List<List<GameObject>> list2 = new List<List<GameObject>>();
			List<List<GameObject>> list3 = new List<List<GameObject>>();
			foreach (List<GameObject> item3 in list)
			{
				string text = WeaponUpgrades.TagOfFirstUpgrade(item3[0].tag);
				((!ItemDb.IsCanBuy(text)) ? list3 : list2).Add(item3);
			}
			Comparison<List<GameObject>> comparison = delegate(List<GameObject> leftList, List<GameObject> rightList)
			{
				if (leftList == null || rightList == null || leftList.Count < 1 || rightList.Count < 1)
				{
					return 0;
				}
				WeaponSounds component = leftList[0].GetComponent<WeaponSounds>();
				WeaponSounds component2 = rightList[0].GetComponent<WeaponSounds>();
				if (ExpController.Instance == null || component == null || component2 == null)
				{
					return 0;
				}
				float num = component.DPS - component2.DPS;
				return (num > 0f) ? 1 : ((!(num < 0f)) ? Array.IndexOf(WeaponComparer.multiplayerWeaponsOrd, component.gameObject.tag).CompareTo(Array.IndexOf(WeaponComparer.multiplayerWeaponsOrd, component2.gameObject.tag)) : (-1));
			};
			list2.Sort(comparison);
			list3.Sort(comparison);
			List<GameObject> list4 = new List<GameObject>();
			foreach (List<GameObject> item4 in list3)
			{
				list4.AddRange(item4);
			}
			foreach (List<GameObject> item5 in list2)
			{
				list4.AddRange(item5);
			}
			_weaponsByCat[i] = list4;
		}
	}

	private void _AddWeaponToShopListsIfNeeded(GameObject w)
	{
		WeaponSounds component = w.GetComponent<WeaponSounds>();
		bool flag = false;
		bool flag2 = false;
		List<string> list = null;
		string text = "Undefined";
		try
		{
			text = w.tag;
		}
		catch (UnityException exception)
		{
			UnityEngine.Debug.LogError("Tag issue encountered.");
			UnityEngine.Debug.LogException(exception);
		}
		foreach (List<string> upgrade in WeaponUpgrades.upgrades)
		{
			if (upgrade.Contains(text))
			{
				flag2 = true;
				list = upgrade;
				break;
			}
		}
		/*try {
			if (Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[text]], true) == 1 || LastBoughtTag(text)) UnityEngine.Debug.Log("a");;
		}catch (Exception e){
			UnityEngine.Debug.LogError("Error 1: " + e.Message);
		}
		try {
			if (LastBoughtTag(text) != null) UnityEngine.Debug.Log("a");
		}catch (Exception e){
			UnityEngine.Debug.LogError("Error 2: " + e.Message);
		}*/
		if (flag2)
		{
			int num = list.IndexOf(text);
			if (Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[text]], true) == 1)
			{
				if (num == list.Count - 1)
				{
					flag = true;
				}
				else if (num < list.Count - 1 && Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[list[num + 1]]], true) == 0)
				{
					flag = true;
				}
			}
			else
			{
				string text2 = FirstTagForOurTier(text);
				if (((num > 0 && ((text2 != null && text2.Equals(text)) || Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[list[num - 1]]], true) == 1) && component.tier < 100) || (num == 0 && text2 != null && text2.Equals(text) && ExpController.Instance != null && ExpController.Instance.OurTier >= component.tier)) || LastBoughtTag(text) != null)
				{
					flag = true;
				}
			}
		}
		else
		{
			try {
				flag = ((ExpController.Instance != null && ExpController.Instance.OurTier >= component.tier) || Storager.getInt(storeIDtoDefsSNMapping[tagToStoreIDMapping[text]], true) == 1 || LastBoughtTag(text) != null);
			}catch(Exception e){
				flag = true;
			}
		}
		if (!flag)
		{
			return;
		}
		try
		{
			if (component.categoryNabor != 6){
				_weaponsByCat[component.categoryNabor - 1].Add(w);
			}
		}
		catch (Exception ex)
		{
			if (Application.isEditor || UnityEngine.Debug.isDebugBuild)
			{
				UnityEngine.Debug.LogError("WeaponManager: exception: " + ex);
			}
		}
	}

	private void AddTempGunsToShopCategoryLists(int filterMap, bool isHungry, bool isTraining)
	{
		if (isHungry || isTraining)
		{
			return;
		}
		try
		{
			IEnumerable<WeaponSounds> enumerable = from o in weaponsInGame.OfType<GameObject>()
				select o.GetComponent<WeaponSounds>() into ws
				where ItemDb.IsTemporaryGun(ws.gameObject.tag) && TempItemsController.sharedController != null && TempItemsController.sharedController.ContainsItem(ws.tag)
				select ws;
			if (filterMap != 0)
			{
				enumerable = enumerable.Where((WeaponSounds ws) => ws.filterMap != null && ws.filterMap.Contains(filterMap));
			}
			foreach (WeaponSounds item in enumerable)
			{
				_weaponsByCat[item.categoryNabor - 1].Add(item.gameObject);
			}
		}
		catch (Exception ex)
		{
			UnityEngine.Debug.LogWarning("Exception " + ex);
		}
	}

	private void _InitShopCategoryLists(int filterMap = 0)
	{
		bool isMulti = Defs.isMulti;
		bool flag = isMulti && Defs.isHunger;
		bool insideTraining = GlobalGameController.InsideTraining;
		bool flag2 = !Defs.IsSurvival && !insideTraining && !isMulti;
		string[] array = Storager.getString(Defs.WeaponsGotInCampaign, false).Split('#');
		List<string> list = new List<string>();
		string[] array2 = array;
		foreach (string item in array2)
		{
			list.Add(item);
		}
		foreach (List<GameObject> item2 in _weaponsByCat)
		{
			item2.Clear();
		}
		AddTempGunsToShopCategoryLists(filterMap, flag, insideTraining);
		if ((isMulti && !flag) || (Defs.IsSurvival && !insideTraining))
		{
			UnityEngine.Object[] array3 = weaponsInGame;
			for (int j = 0; j < array3.Length; j++)
			{
				GameObject gameObject = (GameObject)array3[j];
				WeaponSounds component = gameObject.GetComponent<WeaponSounds>();
				if (component.campaignOnly)
				{
					continue;
				}
				if (gameObject.name.Equals(AlienGunWN))
				{
					if (!list.Contains(AlienGunWN))
					{
					}
				}
				else if (gameObject.name.Equals(BugGunWN))
				{
					if (list.Contains(BugGunWN))
					{
						_weaponsByCat[component.categoryNabor - 1].Add(gameObject);
					}
				}
				else if (!ItemDb.IsTemporaryGun(gameObject.tag))
				{
					_AddWeaponToShopListsIfNeeded(gameObject);
				}
			}
			_SortShopLists();
		}
		else if (flag2)
		{
			UnityEngine.Object[] array4 = weaponsInGame;
			for (int k = 0; k < array4.Length; k++)
			{
				GameObject gameObject2 = (GameObject)array4[k];
				WeaponSounds component2 = gameObject2.GetComponent<WeaponSounds>();
				if (component2.campaignOnly || gameObject2.name.Equals(BugGunWN) || gameObject2.name.Equals(AlienGunWN) || gameObject2.name.Equals(MP5WN) || gameObject2.name.Equals(CampaignRifle_WN))
				{
					if (list.Contains(gameObject2.name))
					{
						_weaponsByCat[component2.categoryNabor - 1].Add(gameObject2);
					}
				}
				else if (!ItemDb.IsTemporaryGun(gameObject2.tag))
				{
					_AddWeaponToShopListsIfNeeded(gameObject2);
				}
			}
			_SortShopLists();
		}
		else if (flag)
		{
			UnityEngine.Object[] array5 = weaponsInGame;
			for (int l = 0; l < array5.Length; l++)
			{
				GameObject gameObject3 = (GameObject)array5[l];
				if (gameObject3.name.Equals(KnifeWN))
				{
					_AddWeaponToShopListsIfNeeded(gameObject3);
					break;
				}
			}
			_SortShopLists();
		}
		else
		{
			if (!insideTraining)
			{
				return;
			}
			UnityEngine.Object[] array6 = weaponsInGame;
			for (int m = 0; m < array6.Length; m++)
			{
				GameObject gameObject4 = (GameObject)array6[m];
				if (gameObject4.name.Equals(GrenadeLunacher_2_WN))
				{
					_weaponsByCat[gameObject4.GetComponent<WeaponSounds>().categoryNabor - 1].Add(gameObject4);
					break;
				}
			}
			_SortShopLists();
		}
	}

	private static bool OldChainThatAlwaysShownFromStart(string tg)
	{
		string value = WeaponUpgrades.TagOfFirstUpgrade(tg);
		return oldTags.Contains(value);
	}

	private static void InitFirstTagsData()
	{
		//Discarded unreachable code: IL_009a
		if (!Storager.hasKey("FirstTagsForOurTier"))
		{
			Storager.setString("FirstTagsForOurTier", "{}", false);
		}
		string @string = Storager.getString("FirstTagsForOurTier", false);
		try
		{
			Dictionary<string, object> dictionary = Json.Deserialize(@string) as Dictionary<string, object>;
			foreach (KeyValuePair<string, object> item in dictionary)
			{
				firstTagsWithRespecToOurTier.Add(item.Key, (string)item.Value);
			}
		}
		catch (Exception exception)
		{
			UnityEngine.Debug.LogException(exception);
			return;
		}
		List<string> upgrades;
		foreach (List<string> upgrade in WeaponUpgrades.upgrades)
		{
			upgrades = upgrade;
			if (upgrades.Count == 0 || firstTagsWithRespecToOurTier.ContainsKey(upgrades[0]))
			{
				continue;
			}
			if (OldChainThatAlwaysShownFromStart(upgrades[0]))
			{
				firstTagsWithRespecToOurTier.Add(upgrades[0], upgrades[0]);
				continue;
			}
			List<WeaponSounds> list = (from ws in AllWrapperPrefabs()
				where upgrades.Contains(ws.tag)
				select ws).ToList();
			bool flag = false;
			for (int i = 0; i < upgrades.Count; i++)
			{
				WeaponSounds weaponSounds = list.Find((WeaponSounds ws) => ws.tag.Equals(upgrades[i]));
				if (weaponSounds != null && weaponSounds.tier > ExpController.GetOurTier())
				{
					if (i == 0)
					{
						firstTagsWithRespecToOurTier.Add(upgrades[0], upgrades[0]);
					}
					else
					{
						firstTagsWithRespecToOurTier.Add(upgrades[0], upgrades[i - 1]);
					}
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				firstTagsWithRespecToOurTier.Add(upgrades[0], upgrades[upgrades.Count - 1]);
			}
		}
		Storager.setString("FirstTagsForOurTier", Json.Serialize(firstTagsWithRespecToOurTier), false);
	}

	public static string FirstTagForOurTier(string tg)
	{
		if (tg == null)
		{
			return null;
		}
		if (!firstTagsForTiersInitialized)
		{
			InitFirstTagsData();
			firstTagsForTiersInitialized = true;
		}
		List<string> list = WeaponUpgrades.ChainForTag(tg);
		if (list != null && list.Count > 0)
		{
			return (!firstTagsWithRespecToOurTier.ContainsKey(list[0])) ? null : firstTagsWithRespecToOurTier[list[0]];
		}
		return null;
	}

	private void _UpdateShopCategList(Weapon w)
	{
		WeaponSounds component = w.weaponPrefab.GetComponent<WeaponSounds>();
		if (tagToStoreIDMapping.ContainsKey(w.weaponPrefab.tag))
		{
			bool flag = false;
			List<string> list = null;
			foreach (List<string> upgrade in WeaponUpgrades.upgrades)
			{
				if (upgrade.Contains(w.weaponPrefab.tag))
				{
					list = upgrade;
					flag = true;
					break;
				}
			}
			if (flag)
			{
				int num = list.IndexOf(w.weaponPrefab.tag);
				int num2 = -1;
				foreach (GameObject item2 in _weaponsByCat[component.categoryNabor - 1])
				{
					if (item2.CompareTag(w.weaponPrefab.tag))
					{
						num2 = _weaponsByCat[component.categoryNabor - 1].IndexOf(item2);
						break;
					}
				}
				if (num < list.Count - 1)
				{
					GameObject item = null;
					UnityEngine.Object[] array = weaponsInGame;
					for (int i = 0; i < array.Length; i++)
					{
						GameObject gameObject = (GameObject)array[i];
						if (gameObject.CompareTag(list[num + 1]))
						{
							item = gameObject;
							break;
						}
					}
					if (num2 != -1)
					{
						string text = FirstTagForOurTier(w.weaponPrefab.tag);
						if (num > 0 && (text == null || !text.Equals(w.weaponPrefab.tag)))
						{
							_weaponsByCat[component.categoryNabor - 1].RemoveAt(num2 - 1);
						}
						_weaponsByCat[component.categoryNabor - 1].Insert(num2, item);
					}
					else
					{
						UnityEngine.Debug.LogWarning("_UpdateShopCategList: prevInd = -1   ws.categoryNabor - 1: " + (component.categoryNabor - 1));
					}
				}
				else
				{
					string text2 = FirstTagForOurTier(w.weaponPrefab.tag);
					if (text2 == null || !text2.Equals(w.weaponPrefab.tag))
					{
						_weaponsByCat[component.categoryNabor - 1].RemoveAt(num2 - 1);
					}
				}
			}
		}
		else
		{
			_weaponsByCat[component.categoryNabor - 1].Add(w.weaponPrefab);
		}
		_SortShopLists();
	}

	public void Reset(int filterMap = 0)
	{
		using (new StopwatchLogger("WeaponManager.Reset(" + filterMap + ")"))
		{
			IEnumerator enumerator = ResetCoroutine(filterMap);
			while (enumerator.MoveNext())
			{
				object current = enumerator.Current;
			}
		}
	}

	private bool ReequipItemsAfterCloudSync()
	{
		bool flag = sharedManager != null && sharedManager.myPlayerMoveC != null;
		List<ShopNGUIController.CategoryNames> list = new List<ShopNGUIController.CategoryNames>();
		ShopNGUIController.CategoryNames[] array = new ShopNGUIController.CategoryNames[4]
		{
			ShopNGUIController.CategoryNames.ArmorCategory,
			ShopNGUIController.CategoryNames.BootsCategory,
			ShopNGUIController.CategoryNames.CapesCategory,
			ShopNGUIController.CategoryNames.HatsCategory
		};
		foreach (ShopNGUIController.CategoryNames categoryNames in array)
		{
			string text = ShopNGUIController.NoneEquippedForWearCategory(categoryNames);
			string @string = Storager.getString(ShopNGUIController.SnForWearCategory(categoryNames), false);
			if (@string != null && text != null && !@string.Equals(text))
			{
				string text2 = LastBoughtTag(@string);
				if (text2 != null && text2 != @string)
				{
					ShopNGUIController.EquipWearInCategoryIfNotEquiped(text2, categoryNames, flag);
					list.Add(categoryNames);
				}
			}
		}
		bool result = false;
		string[] array2 = new string[2]
		{
			Defs.MultiplayerWSSN,
			Defs.CampaignWSSN
		};
		foreach (string sn in array2)
		{
			string text3 = LoadWeaponSet(sn);
			string[] array3 = text3.Split('#');
			for (int k = 0; k < array3.Length; k++)
			{
				string text4 = array3[k];
				if (string.IsNullOrEmpty(text4))
				{
					continue;
				}
				ItemRecord byPrefabName = ItemDb.GetByPrefabName(text4);
				if (byPrefabName == null || byPrefabName.Tag == null || !byPrefabName.CanBuy)
				{
					continue;
				}
				string text5 = LastBoughtTag(byPrefabName.Tag);
				if (text5 != null && !(text5 == byPrefabName.Tag))
				{
					ItemRecord byTag = ItemDb.GetByTag(text5);
					if (byTag != null && byTag.PrefabName != null)
					{
						SaveWeaponSet(sn, byTag.PrefabName, k);
						result = true;
					}
				}
			}
		}
		if (flag)
		{
			if (Defs.isMulti && myPlayerMoveC.mySkinName != null)
			{
				if (list.Contains(ShopNGUIController.CategoryNames.ArmorCategory))
				{
					myPlayerMoveC.mySkinName.SetArmor();
				}
				if (list.Contains(ShopNGUIController.CategoryNames.BootsCategory))
				{
					myPlayerMoveC.mySkinName.SetBoots();
				}
				if (list.Contains(ShopNGUIController.CategoryNames.CapesCategory))
				{
					myPlayerMoveC.mySkinName.SetCape();
				}
				if (list.Contains(ShopNGUIController.CategoryNames.HatsCategory))
				{
					myPlayerMoveC.mySkinName.SetHat();
				}
			}
		}
		else if (PersConfigurator.currentConfigurator != null && list.Count > 0)
		{
			PersConfigurator.currentConfigurator._AddCapeAndHat();
		}
		return result;
	}

	private void ReequipWeaponsForGuiAndRpcAndUpdateIcons()
	{
		if (!(myPlayerMoveC != null) || !(ShopNGUIController.sharedShop != null) || ShopNGUIController.sharedShop.equipAction == null)
		{
			return;
		}
		foreach (Weapon playerWeapon in playerWeapons)
		{
			if (playerWeapon != null && playerWeapon.weaponPrefab != null && playerWeapon.weaponPrefab.tag != null)
			{
				ShopNGUIController.sharedShop.equipAction(playerWeapon.weaponPrefab.tag);
			}
			if (ShopNGUIController.GuiActive)
			{
				ShopNGUIController.sharedShop.UpdateIcon((ShopNGUIController.CategoryNames)playerWeapons.IndexOf(playerWeapon));
			}
		}
	}

	public IEnumerator ResetCoroutine(int filterMap = 0)
	{
		string logMessage = string.Format("WeaponManager.ResetCoroutine({0}), resetLock = {1}", filterMap, _resetLock);
		using (new StopwatchLogger(logMessage))
		{
			if (_resetLock)
			{
				UnityEngine.Debug.Log("Simultaneous executing of WeaponManagers ResetCoroutines");
			}
			_resetLock = true;
			using (new ActionDisposable(delegate
			{
				_resetLock = false;
			}))
			{
				Storager.SynchronizeIosWithCloud();
				_currentFilterMap = filterMap;
				bool isMulti = Defs.isMulti;
				bool isHungry = Defs.isHunger;
				bool isTraining = GlobalGameController.InsideTraining;
				bool isCampaign = !Defs.IsSurvival && !isTraining && !isMulti;
				bool newWeaponsComeFromCloudInWeaponSet = ReequipItemsAfterCloudSync();
				if (!isHungry)
				{
					if (!_initialized)
					{
						yield return StartCoroutine(GetWeaponPrefabsCoroutine(filterMap));
					}
					else
					{
						GetWeaponPrefabs(filterMap);
					}
					yield return null;
				}
				yield return StartCoroutine(UpdateWeapons800To801());
				yield return StartCoroutine(FixWeaponsDueToCategoriesMoved911());
				yield return StartCoroutine(ReturnAlienGunToCampaignBack());
				allAvailablePlayerWeapons.Clear();
				CurrentWeaponIndex = 0;
				string[] _arr = Storager.getString(Defs.WeaponsGotInCampaign, false).Split('#');
				List<string> weaponsGotInCampaign = new List<string>();
				string[] array = _arr;
				foreach (string s in array)
				{
					weaponsGotInCampaign.Add(s);
				}
				UnityEngine.Object[] array2 = weaponsInGame;
				for (int l = 0; l < array2.Length; l++)
				{
					GameObject prefab = (GameObject)array2[l];
					if (_WeaponAvailable(prefab, weaponsGotInCampaign, filterMap))
					{
						Weapon pistol = new Weapon();
						pistol.weaponPrefab = prefab;
						pistol.currentAmmoInBackpack = pistol.weaponPrefab.GetComponent<WeaponSounds>().InitialAmmoWithEffectsApplied;
						pistol.currentAmmoInClip = pistol.weaponPrefab.GetComponent<WeaponSounds>().ammoInClip;
						allAvailablePlayerWeapons.Add(pistol);
					}
				}
				yield return null;
				yield return null;
				if ((isMulti && isHungry) || GlobalGameController.InsideTraining)
				{
					allAvailablePlayerWeapons.Sort(new WeaponComparer());
					SetWeaponsSet(filterMap);
					_InitShopCategoryLists(filterMap);
					CurrentWeaponIndex = 0;
					if (newWeaponsComeFromCloudInWeaponSet)
					{
						ReequipWeaponsForGuiAndRpcAndUpdateIcons();
					}
					yield break;
				}
				HashSet<string> addedWeaponTags = new HashSet<string>();
				List<List<string>> allUpgrades = WeaponUpgrades.upgrades;
				foreach (List<string> weaponUpgrades in allUpgrades)
				{
					foreach (string weaponTag2 in weaponUpgrades)
					{
						addedWeaponTags.Add(weaponTag2);
						AddWeaponIfBought(weaponTag2);
					}
					yield return null;
				}
				string[] canBuyWeaponTags = ItemDb.GetCanBuyWeaponTags(false);
				for (int i = 0; i < canBuyWeaponTags.Length; i++)
				{
					string weaponTag = canBuyWeaponTags[i];
					if (!addedWeaponTags.Contains(weaponTag))
					{
						addedWeaponTags.Add(weaponTag);
						AddWeaponIfBought(weaponTag);
					}
					if (i % 3 == 0)
					{
						yield return null;
					}
				}
				yield return null;
				allAvailablePlayerWeapons.Sort(new WeaponComparer());
				yield return null;
				SetWeaponsSet(filterMap);
				_InitShopCategoryLists(filterMap);
				CurrentWeaponIndex = 0;
				if (newWeaponsComeFromCloudInWeaponSet)
				{
					ReequipWeaponsForGuiAndRpcAndUpdateIcons();
				}
			}
		}
	}

	private void AddWeaponIfBought(string tag)
	{
		ItemRecord byTag = ItemDb.GetByTag(tag);
		if (byTag == null || string.IsNullOrEmpty(byTag.StorageId) || string.IsNullOrEmpty(byTag.PrefabName))
		{
			return;
		}
		string storageId = byTag.StorageId;
		string prefabName = byTag.PrefabName;
		if (Storager.getInt(storageId, true) <= 0)
		{
			return;
		}
		UnityEngine.Object[] array = weaponsInGame;
		for (int i = 0; i < array.Length; i++)
		{
			GameObject gameObject = (GameObject)array[i];
			if (gameObject.name.Equals(prefabName))
			{
				Weapon weapon = new Weapon();
				weapon.weaponPrefab = gameObject;
				weapon.currentAmmoInBackpack = weapon.weaponPrefab.GetComponent<WeaponSounds>().InitialAmmoWithEffectsApplied;
				weapon.currentAmmoInClip = weapon.weaponPrefab.GetComponent<WeaponSounds>().ammoInClip;
				allAvailablePlayerWeapons.Add(weapon);
				_RemovePrevVersionsOfUpgrade(gameObject.tag);
				break;
			}
		}
	}

	public bool AddWeapon(GameObject weaponPrefab, out int score)
	{
		score = 0;
		if (TempItemsController.PriceCoefs.ContainsKey(weaponPrefab.tag) && (Application.loadedLevelName.Equals("ConnectScene") || (_currentFilterMap != 0 && !weaponPrefab.GetComponent<WeaponSounds>().IsAvalibleFromFilter(_currentFilterMap)) || Defs.isHunger))
		{
			return false;
		}
		bool flag = false;
		foreach (Weapon allAvailablePlayerWeapon in allAvailablePlayerWeapons)
		{
			if (allAvailablePlayerWeapon.weaponPrefab.CompareTag(weaponPrefab.tag))
			{
				int idx = allAvailablePlayerWeapons.IndexOf(allAvailablePlayerWeapon);
				if (!AddAmmo(idx))
				{
					score += Defs.ScoreForSurplusAmmo;
				}
				if (!ItemDb.IsTemporaryGun(weaponPrefab.tag))
				{
					return false;
				}
				flag = true;
			}
		}
		Weapon weapon2 = new Weapon();
		weapon2.weaponPrefab = weaponPrefab;
		weapon2.currentAmmoInBackpack = weapon2.weaponPrefab.GetComponent<WeaponSounds>().InitialAmmoWithEffectsApplied;
		weapon2.currentAmmoInClip = weapon2.weaponPrefab.GetComponent<WeaponSounds>().ammoInClip;
		if (!flag)
		{
			allAvailablePlayerWeapons.Add(weapon2);
		}
		else
		{
			int num = -1;
			foreach (Weapon allAvailablePlayerWeapon2 in allAvailablePlayerWeapons)
			{
				if (allAvailablePlayerWeapon2.weaponPrefab.name.Equals(weaponPrefab.name))
				{
					num = allAvailablePlayerWeapons.IndexOf(allAvailablePlayerWeapon2);
					break;
				}
			}
			if (num > -1 && num < allAvailablePlayerWeapons.Count)
			{
				allAvailablePlayerWeapons[num] = weapon2;
			}
		}
		string tg = weaponPrefab.tag;
		int num2 = _RemovePrevVersionsOfUpgrade(tg);
		allAvailablePlayerWeapons.Sort(new WeaponComparer());
		bool flag2 = true;
		if ((weapon2.weaponPrefab.GetComponent<WeaponSounds>().campaignOnly || weapon2.weaponPrefab.tag.Equals("UziWeapon")) && CurrentWeaponIndex >= 0 && tagToStoreIDMapping.ContainsKey((playerWeapons[CurrentWeaponIndex] as Weapon).weaponPrefab.tag))
		{
			flag2 = false;
		}
		if (flag2)
		{
			EquipWeapon(weapon2);
		}
		_UpdateShopCategList(weapon2);
		return flag2;
	}

	private int _RemovePrevVersionsOfUpgrade(string tg)
	{
		int num = 0;
		foreach (List<string> upgrade in WeaponUpgrades.upgrades)
		{
			int num2 = upgrade.IndexOf(tg);
			if (num2 == -1)
			{
				continue;
			}
			for (int i = 0; i < num2; i++)
			{
				List<Weapon> list = new List<Weapon>();
				for (int j = 0; j < allAvailablePlayerWeapons.Count; j++)
				{
					Weapon weapon = allAvailablePlayerWeapons[j] as Weapon;
					if (weapon.weaponPrefab.tag.Equals(upgrade[i]))
					{
						list.Add(weapon);
					}
				}
				for (int k = 0; k < list.Count; k++)
				{
					allAvailablePlayerWeapons.Remove(list[k]);
				}
				num += list.Count;
			}
			return num;
		}
		return num;
	}

	public GameObject GetPrefabByTag(string weaponTag)
	{
		return weaponsInGame.OfType<GameObject>().FirstOrDefault((GameObject w) => w.tag.Equals(weaponTag));
	}

	public GameObject GetPrefabByName(string name)
	{
		return weaponsInGame.OfType<GameObject>().FirstOrDefault((GameObject w) => w.name.Equals(name));
	}

	public bool AddAmmo(int idx = -1)
	{
		if (idx == -1)
		{
			idx = allAvailablePlayerWeapons.IndexOf(playerWeapons[CurrentWeaponIndex]);
		}
		if (allAvailablePlayerWeapons[idx] == playerWeapons[CurrentWeaponIndex] && currentWeaponSounds.isMelee && !currentWeaponSounds.isShotMelee)
		{
			return false;
		}
		Weapon weapon = (Weapon)allAvailablePlayerWeapons[idx];
		WeaponSounds component = weapon.weaponPrefab.GetComponent<WeaponSounds>();
		if (weapon.currentAmmoInBackpack < component.MaxAmmoWithEffectApplied)
		{
			weapon.currentAmmoInBackpack += ((!currentWeaponSounds.isShotMelee) ? component.ammoInClip : component.ammoForBonusShotMelee);
			if (weapon.currentAmmoInBackpack > component.MaxAmmoWithEffectApplied)
			{
				weapon.currentAmmoInBackpack = component.MaxAmmoWithEffectApplied;
			}
			return true;
		}
		return false;
	}

	public void SetMaxAmmoFrAllWeapons()
	{
		foreach (Weapon allAvailablePlayerWeapon in allAvailablePlayerWeapons)
		{
			allAvailablePlayerWeapon.currentAmmoInClip = allAvailablePlayerWeapon.weaponPrefab.GetComponent<WeaponSounds>().ammoInClip;
			allAvailablePlayerWeapon.currentAmmoInBackpack = allAvailablePlayerWeapon.weaponPrefab.GetComponent<WeaponSounds>().MaxAmmoWithEffectApplied;
		}
	}

	private IEnumerator Start()
	{
		UnityEngine.Debug.Log("WeaponManager.Start()");
		_grenadeWeaponCache = InnerPrefabForWeapon("WeaponGrenade");
		_turretWeaponCache = InnerPrefabForWeapon("WeaponTurret");
		_rocketCache = Resources.Load<GameObject>("Rocket");
		_turretCache = Resources.Load<GameObject>("Turret");
		if (!Device.IsLoweMemoryDevice)
		{
			_profileAnimClips = Resources.LoadAll<AnimationClip>("ProfileAnimClips");
		}
		Defs.gameSecondFireButtonMode = (Defs.GameSecondFireButtonMode)PlayerPrefs.GetInt("GameSecondFireButtonMode", 0);
		using (new StopwatchLogger("WeaponManager.Start()"))
		{
			sharedManager = this;
			for (int j = 0; j < 5; j++)
			{
				_weaponsByCat.Add(new List<GameObject>());
			}
			string[] canBuyWeaponTags = ItemDb.GetCanBuyWeaponTags(true);
			for (int i = 0; i < canBuyWeaponTags.Length; i++)
			{
				string shopId = ItemDb.GetShopIdByTag(canBuyWeaponTags[i]);
				_purchaseActinos.Add(shopId, AddWeaponToInv);
			}
			yield return null;
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			GlobalGameController.SetMultiMode();
			using (new StopwatchLogger("Spawning coroutine for reset"))
			{
				yield return StartCoroutine(ResetCoroutine(0));
			}
		}
		_initialized = true;
	}

	public void AddWeaponToInv(string shopId, int timeForRentIndex = 0)
	{
		string tagByShopId = ItemDb.GetTagByShopId(shopId);
		if (!Defs.IsTraining)
		{
			Player_move_c.SaveWeaponInPrefs(tagByShopId, timeForRentIndex);
		}
		GameObject prefabByTag = GetPrefabByTag(tagByShopId);
		if (prefabByTag != null)
		{
			int score;
			AddWeapon(prefabByTag, out score);
		}
	}

	public void AddMinerWeapon(string id, int timeForRentIndex = 0)
	{
		if (id == null)
		{
			throw new ArgumentNullException("id");
		}
		if (_purchaseActinos.ContainsKey(id))
		{
			_purchaseActinos[id](id, timeForRentIndex);
		}
	}

	private void AddWeapon(GooglePurchase p)
	{
		try
		{
			AddMinerWeapon(p.productId);
		}
		catch (Exception message)
		{
			UnityEngine.Debug.LogError(message);
		}
	}

	private void OnDestroy()
	{
		if (Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon)
		{
			GoogleIABManager.purchaseSucceededEvent -= AddWeapon;
		}
	}

	public void ReloadAmmo()
	{
		int num = currentWeaponSounds.ammoInClip - ((Weapon)playerWeapons[CurrentWeaponIndex]).currentAmmoInClip;
		if (((Weapon)playerWeapons[CurrentWeaponIndex]).currentAmmoInBackpack >= num)
		{
			((Weapon)playerWeapons[CurrentWeaponIndex]).currentAmmoInClip += num;
			((Weapon)playerWeapons[CurrentWeaponIndex]).currentAmmoInBackpack -= num;
		}
		else
		{
			((Weapon)playerWeapons[CurrentWeaponIndex]).currentAmmoInClip += ((Weapon)playerWeapons[CurrentWeaponIndex]).currentAmmoInBackpack;
			((Weapon)playerWeapons[CurrentWeaponIndex]).currentAmmoInBackpack = 0;
		}
		if (myPlayerMoveC != null)
		{
			myPlayerMoveC.isReloading = false;
		}
	}

	public void Reload()
	{
		if (!currentWeaponSounds.isShotMelee)
		{
			currentWeaponSounds.animationObject.GetComponent<Animation>().Stop(myCAnim("Empty"));
			if (!currentWeaponSounds.isDoubleShot)
			{
				currentWeaponSounds.animationObject.GetComponent<Animation>().CrossFade(myCAnim("Shoot"));
			}
			currentWeaponSounds.animationObject.GetComponent<Animation>().Play(myCAnim("Reload"));
			currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Reload")].speed = EffectsController.ReloadAnimationSpeed[currentWeaponSounds.categoryNabor - 1];
		}
	}

	private IEnumerator ReturnAlienGunToCampaignBack()
	{
		if (!Storager.hasKey(Defs.ReturnAlienGun930))
		{
			Storager.setInt(Defs.ReturnAlienGun930, 1, false);
			string wStr = LoadWeaponSet(Defs.MultiplayerWSSN);
			string[] weaponNames = wStr.Split('#');
			if (weaponNames[1] != null && weaponNames[1].Equals(AlienGunWN))
			{
				SaveWeaponSet(Defs.MultiplayerWSSN, PistolWN, 1);
				SaveWeaponSet(Defs.CampaignWSSN, PistolWN, 1);
			}
		}
		yield break;
	}

	private IEnumerator FixWeaponsDueToCategoriesMoved911()
	{
		if (!Storager.hasKey(Defs.FixWeapons911))
		{
			Storager.setInt(Defs.FixWeapons911, 1, false);
			string wStr = LoadWeaponSet(Defs.MultiplayerWSSN);
			string[] weaponNames = wStr.Split('#');
			if (weaponNames[4] != null && (weaponNames[4].Equals("Weapon178") || weaponNames[4].Equals("Weapon186") || weaponNames[4].Equals("Weapon187")))
			{
				SaveWeaponSet(Defs.MultiplayerWSSN, string.Empty, 4);
				SaveWeaponSet(Defs.CampaignWSSN, string.Empty, 4);
			}
			if (weaponNames[3] != null && (weaponNames[3].Equals("Weapon180") || weaponNames[3].Equals("Weapon185")))
			{
				SaveWeaponSet(Defs.MultiplayerWSSN, string.Empty, 3);
				SaveWeaponSet(Defs.CampaignWSSN, string.Empty, 3);
			}
		}
		yield break;
	}

	public void RemoveTemporaryItem(string tg)
	{
		if (tg == null)
		{
			return;
		}
		ItemRecord byTag = ItemDb.GetByTag(tg);
		if (byTag == null || byTag.PrefabName == null)
		{
			return;
		}
		string text = LoadWeaponSet(Defs.MultiplayerWSSN);
		string[] array = text.Split('#');
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] == null)
			{
				array[i] = string.Empty;
			}
		}
		int num = -1;
		foreach (Weapon allAvailablePlayerWeapon in allAvailablePlayerWeapons)
		{
			if (allAvailablePlayerWeapon.weaponPrefab.tag.Equals(tg))
			{
				num = allAvailablePlayerWeapons.IndexOf(allAvailablePlayerWeapon);
				break;
			}
		}
		if (num != -1)
		{
			allAvailablePlayerWeapons.RemoveAt(num);
		}
		int num2 = Array.IndexOf(array, byTag.PrefabName);
		if (num2 != -1)
		{
			sharedManager.SaveWeaponSet(Defs.MultiplayerWSSN, TopWeaponForCat(num2), num2);
			sharedManager.SaveWeaponSet(Defs.CampaignWSSN, TopWeaponForCat(num2, true), num2);
		}
		SetWeaponsSet(_currentFilterMap);
		_InitShopCategoryLists(_currentFilterMap);
	}

	private string TopWeaponForCat(int ind, bool campaign = false)
	{
		string result = DefaultWeaponForCat[ind];
		if (campaign)
		{
			result = DefaultWeaponForCatCampaign[ind];
		}
		List<WeaponSounds> list = new List<WeaponSounds>();
		foreach (Weapon allAvailablePlayerWeapon in allAvailablePlayerWeapons)
		{
			WeaponSounds component = allAvailablePlayerWeapon.weaponPrefab.GetComponent<WeaponSounds>();
			if (component.categoryNabor - 1 == ind)
			{
				ItemRecord byTag = ItemDb.GetByTag(component.gameObject.tag);
				if (byTag != null && byTag.CanBuy)
				{
					list.Add(component);
				}
			}
		}
		list.Sort(dpsComparerWS);
		if (list.Count > 0)
		{
			result = list[list.Count - 1].gameObject.name;
		}
		return result;
	}

	private IEnumerator UpdateWeapons800To801()
	{
		if (Storager.hasKey(Defs.Weapons800to801))
		{
			yield break;
		}
		Storager.setInt(Defs.Weapons800to801, 1, false);
		string wStr2 = LoadWeaponSet(Defs.MultiplayerWSSN);
		string[] weaponNames2 = wStr2.Split('#');
		if (Storager.getInt(Defs.BarrettSN, true) > 0)
		{
			Storager.setInt(Defs.Barrett2SN, 1, true);
			for (int i27 = 0; i27 < weaponNames2.Length; i27++)
			{
				if (weaponNames2[i27] != null && weaponNames2[i27].Equals(BarrettWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Barrett_2WN, 3);
					SaveWeaponSet(Defs.CampaignWSSN, Barrett_2WN, 3);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.plazma_pistol_SN, true) > 0)
		{
			Storager.setInt(Defs.plazma_pistol_2, 1, true);
			for (int i26 = 0; i26 < weaponNames2.Length; i26++)
			{
				if (weaponNames2[i26] != null && weaponNames2[i26].Equals(plazma_pistol_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, plazma_pistol_2_WN, 1);
					SaveWeaponSet(Defs.CampaignWSSN, plazma_pistol_2_WN, 1);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.StaffSN, true) > 0)
		{
			Storager.setInt(Defs.Staff2SN, 1, true);
			for (int i25 = 0; i25 < weaponNames2.Length; i25++)
			{
				if (weaponNames2[i25] != null && weaponNames2[i25].Equals(StaffWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Staff2WN, 4);
					SaveWeaponSet(Defs.CampaignWSSN, Staff2WN, 4);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.MagicBowSett, true) > 0)
		{
			Storager.setInt(Defs.Bow_3, 1, true);
			for (int i24 = 0; i24 < weaponNames2.Length; i24++)
			{
				if (weaponNames2[i24] != null && weaponNames2[i24].Equals(MagicBowWeaponName))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Bow_3_WN, 3);
					SaveWeaponSet(Defs.CampaignWSSN, Bow_3_WN, 3);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.MaceSN, true) > 0)
		{
			Storager.setInt(Defs.Mace2SN, 1, true);
			for (int i23 = 0; i23 < weaponNames2.Length; i23++)
			{
				if (weaponNames2[i23] != null && weaponNames2[i23].Equals(MaceWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Mace2WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, Mace2WN, 2);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.ChainsawS, true) > 0)
		{
			Storager.setInt(Defs.Chainsaw2SN, 1, true);
			for (int i22 = 0; i22 < weaponNames2.Length; i22++)
			{
				if (weaponNames2[i22] != null && weaponNames2[i22].Equals(ChainsawWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Chainsaw2WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, Chainsaw2WN, 2);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.FlowePowerSN, true) > 0)
		{
			Storager.setInt(Defs.flower_3, 1, true);
			for (int i21 = 0; i21 < weaponNames2.Length; i21++)
			{
				if (weaponNames2[i21] != null && weaponNames2[i21].Equals(Flower_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, flower_3_WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, flower_3_WN, 2);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.flower_2, true) > 0)
		{
			Storager.setInt(Defs.flower_3, 1, true);
			for (int i20 = 0; i20 < weaponNames2.Length; i20++)
			{
				if (weaponNames2[i20] != null && weaponNames2[i20].Equals(flower_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, flower_3_WN, 1);
					SaveWeaponSet(Defs.CampaignWSSN, flower_3_WN, 1);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.ScytheSN, true) > 0)
		{
			Storager.setInt(Defs.scythe_3, 1, true);
			for (int i19 = 0; i19 < weaponNames2.Length; i19++)
			{
				if (weaponNames2[i19] != null && weaponNames2[i19].Equals(ScytheWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, scythe_3_WN, 1);
					SaveWeaponSet(Defs.CampaignWSSN, scythe_3_WN, 1);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.Scythe_2_SN, true) > 0)
		{
			Storager.setInt(Defs.scythe_3, 1, true);
			for (int i18 = 0; i18 < weaponNames2.Length; i18++)
			{
				if (weaponNames2[i18] != null && weaponNames2[i18].Equals(Scythe_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, scythe_3_WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, scythe_3_WN, 2);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.FlameThrowerSN, true) > 0)
		{
			Storager.setInt(Defs.Flamethrower_3, 1, true);
			for (int i17 = 0; i17 < weaponNames2.Length; i17++)
			{
				if (weaponNames2[i17] != null && weaponNames2[i17].Equals(Flamethrower_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Flamethrower_3_WN, 3);
					SaveWeaponSet(Defs.CampaignWSSN, Flamethrower_3_WN, 3);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.FlameThrower_2SN, true) > 0)
		{
			Storager.setInt(Defs.Flamethrower_3, 1, true);
			for (int i16 = 0; i16 < weaponNames2.Length; i16++)
			{
				if (weaponNames2[i16] != null && weaponNames2[i16].Equals(Flamethrower_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Flamethrower_3_WN, 3);
					SaveWeaponSet(Defs.CampaignWSSN, Flamethrower_3_WN, 3);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.RazerSN, true) > 0)
		{
			Storager.setInt(Defs.Razer_3, 1, true);
			for (int i15 = 0; i15 < weaponNames2.Length; i15++)
			{
				if (weaponNames2[i15] != null && weaponNames2[i15].Equals(Razer_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Razer_3_WN, 3);
					SaveWeaponSet(Defs.CampaignWSSN, Razer_3_WN, 3);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.Razer_2SN, true) > 0)
		{
			Storager.setInt(Defs.Razer_3, 1, true);
			for (int i14 = 0; i14 < weaponNames2.Length; i14++)
			{
				if (weaponNames2[i14] != null && weaponNames2[i14].Equals(ChainsawWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Razer_3_WN, 3);
					SaveWeaponSet(Defs.CampaignWSSN, Razer_3_WN, 3);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.Revolver2SN, true) > 0)
		{
			Storager.setInt(Defs.revolver_2_3, 1, true);
			for (int i13 = 0; i13 < weaponNames2.Length; i13++)
			{
				if (weaponNames2[i13] != null && weaponNames2[i13].Equals(Revolver2WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, revolver_2_3_WN, 1);
					SaveWeaponSet(Defs.CampaignWSSN, revolver_2_3_WN, 1);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.revolver_2_2, true) > 0)
		{
			Storager.setInt(Defs.revolver_2_3, 1, true);
			for (int i12 = 0; i12 < weaponNames2.Length; i12++)
			{
				if (weaponNames2[i12] != null && weaponNames2[i12].Equals(revolver_2_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, revolver_2_3_WN, 1);
					SaveWeaponSet(Defs.CampaignWSSN, revolver_2_3_WN, 1);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.Sword_2_SN, true) > 0)
		{
			Storager.setInt(Defs.Sword_2_3, 1, true);
			for (int i11 = 0; i11 < weaponNames2.Length; i11++)
			{
				if (weaponNames2[i11] != null && weaponNames2[i11].Equals(Sword_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Sword_2_3_WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, Sword_2_3_WN, 2);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.Sword_22SN, true) > 0)
		{
			Storager.setInt(Defs.Sword_2_3, 1, true);
			for (int i10 = 0; i10 < weaponNames2.Length; i10++)
			{
				if (weaponNames2[i10] != null && weaponNames2[i10].Equals(Sword_22WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Sword_2_3_WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, Sword_2_3_WN, 2);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.MinigunSN, true) > 0)
		{
			Storager.setInt(Defs.minigun_3, 1, true);
			for (int i9 = 0; i9 < weaponNames2.Length; i9++)
			{
				if (weaponNames2[i9] != null && weaponNames2[i9].Equals(MinigunWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, minigun_3_WN, 0);
					SaveWeaponSet(Defs.CampaignWSSN, minigun_3_WN, 0);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.RedMinigunSN, true) > 0)
		{
			Storager.setInt(Defs.minigun_3, 1, true);
			for (int i8 = 0; i8 < weaponNames2.Length; i8++)
			{
				if (weaponNames2[i8] != null && weaponNames2[i8].Equals(RedMinigunWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, minigun_3_WN, 0);
					SaveWeaponSet(Defs.CampaignWSSN, minigun_3_WN, 0);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.m79_2, true) > 0)
		{
			Storager.setInt(Defs.m79_3, 1, true);
			for (int i7 = 0; i7 < weaponNames2.Length; i7++)
			{
				if (weaponNames2[i7] != null && weaponNames2[i7].Equals(m79_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, m79_3_WN, 4);
					SaveWeaponSet(Defs.CampaignWSSN, m79_3_WN, 4);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.Bazooka_2_1, true) > 0)
		{
			Storager.setInt(Defs.Bazooka_2_3, 1, true);
			for (int i6 = 0; i6 < weaponNames2.Length; i6++)
			{
				if (weaponNames2[i6] != null && weaponNames2[i6].Equals(Bazooka_2_1_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Bazooka_2_3_WN, 4);
					SaveWeaponSet(Defs.CampaignWSSN, Bazooka_2_3_WN, 4);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.plazmaSN, true) > 0)
		{
			Storager.setInt(Defs.plazma_3, 1, true);
			for (int i5 = 0; i5 < weaponNames2.Length; i5++)
			{
				if (weaponNames2[i5] != null && weaponNames2[i5].Equals(plazma_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, plazma_3_WN, 0);
					SaveWeaponSet(Defs.CampaignWSSN, plazma_3_WN, 0);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.plazma_2, true) > 0)
		{
			Storager.setInt(Defs.plazma_3, 1, true);
			for (int i4 = 0; i4 < weaponNames2.Length; i4++)
			{
				if (weaponNames2[i4] != null && weaponNames2[i4].Equals(plazma_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, plazma_3_WN, 0);
					SaveWeaponSet(Defs.CampaignWSSN, plazma_3_WN, 0);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs._3PLShotgunSN, true) > 0)
		{
			Storager.setInt(Defs._3_shotgun_3, 1, true);
			for (int i3 = 0; i3 < weaponNames2.Length; i3++)
			{
				if (weaponNames2[i3] != null && weaponNames2[i3].Equals(_3pl_shotgunWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, _3_shotgun_3_WN, 0);
					SaveWeaponSet(Defs.CampaignWSSN, _3_shotgun_3_WN, 0);
					break;
				}
			}
		}
		if (Storager.getInt(Defs._3_shotgun_2, true) > 0)
		{
			Storager.setInt(Defs._3_shotgun_3, 1, true);
			for (int i2 = 0; i2 < weaponNames2.Length; i2++)
			{
				if (weaponNames2[i2] != null && weaponNames2[i2].Equals(_3_shotgun_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, _3_shotgun_3_WN, 0);
					SaveWeaponSet(Defs.CampaignWSSN, _3_shotgun_3_WN, 0);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.LaserRifleSN, true) > 0)
		{
			Storager.setInt(Defs.Red_Stone_3, 1, true);
			for (int n = 0; n < weaponNames2.Length; n++)
			{
				if (weaponNames2[n] != null && weaponNames2[n].Equals(LaserRifleWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Red_Stone_3_WN, 4);
					SaveWeaponSet(Defs.CampaignWSSN, Red_Stone_3_WN, 4);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.GoldenRed_StoneSN, true) > 0)
		{
			Storager.setInt(Defs.Red_Stone_3, 1, true);
			for (int m = 0; m < weaponNames2.Length; m++)
			{
				if (weaponNames2[m] != null && weaponNames2[m].Equals(GoldenRed_StoneWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, Red_Stone_3_WN, 4);
					SaveWeaponSet(Defs.CampaignWSSN, Red_Stone_3_WN, 4);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.LightSwordSN, true) > 0)
		{
			Storager.setInt(Defs.LightSword_3, 1, true);
			for (int l = 0; l < weaponNames2.Length; l++)
			{
				if (weaponNames2[l] != null && weaponNames2[l].Equals(LightSwordWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, LightSword_3_WN, 4);
					SaveWeaponSet(Defs.CampaignWSSN, LightSword_3_WN, 4);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.RedLightSaberSN, true) > 0)
		{
			Storager.setInt(Defs.LightSword_3, 1, true);
			for (int k = 0; k < weaponNames2.Length; k++)
			{
				if (weaponNames2[k] != null && weaponNames2[k].Equals(RedLightSaberWN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, LightSword_3_WN, 4);
					SaveWeaponSet(Defs.CampaignWSSN, LightSword_3_WN, 4);
					break;
				}
			}
		}
		if (!_initialized)
		{
			yield return null;
		}
		if (Storager.getInt(Defs.katana_SN, true) > 0)
		{
			Storager.setInt(Defs.katana_3_SN, 1, true);
			for (int j = 0; j < weaponNames2.Length; j++)
			{
				if (weaponNames2[j] != null && weaponNames2[j].Equals(katana_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, katana_3_WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, katana_3_WN, 2);
					break;
				}
			}
		}
		if (Storager.getInt(Defs.katana_2_SN, true) > 0)
		{
			Storager.setInt(Defs.katana_3_SN, 1, true);
			for (int i = 0; i < weaponNames2.Length; i++)
			{
				if (weaponNames2[i] != null && weaponNames2[i].Equals(katana_2_WN))
				{
					SaveWeaponSet(Defs.MultiplayerWSSN, katana_3_WN, 2);
					SaveWeaponSet(Defs.CampaignWSSN, katana_3_WN, 2);
					break;
				}
			}
		}
		wStr2 = LoadWeaponSet(Defs.MultiplayerWSSN);
		weaponNames2 = wStr2.Split('#');
		if (weaponNames2[4] != null && weaponNames2[4].Equals(Red_Stone_3_WN))
		{
			SaveWeaponSet(Defs.MultiplayerWSSN, string.Empty, 4);
			SaveWeaponSet(Defs.CampaignWSSN, string.Empty, 4);
		}
		else if (weaponNames2[4] != null && weaponNames2[4].Equals(LightSword_3_WN))
		{
			SaveWeaponSet(Defs.MultiplayerWSSN, string.Empty, 4);
			SaveWeaponSet(Defs.CampaignWSSN, string.Empty, 4);
		}
		if (weaponNames2[4] != null && weaponNames2[3].Equals(DragonGun_WN))
		{
			SaveWeaponSet(Defs.MultiplayerWSSN, string.Empty, 3);
			SaveWeaponSet(Defs.CampaignWSSN, string.Empty, 3);
		}
	}
}
