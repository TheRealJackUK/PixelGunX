using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using Holoville.HOTween;
using Holoville.HOTween.Core;
using Rilisoft;
using Rilisoft.MiniJson;
using RilisoftBot;
using UnityEngine;
using UnityEngine.UI;

public sealed class Player_move_c : MonoBehaviour
{
	public enum TypeBonuses
	{
		Ammo,
		Health,
		Armor,
		Grenade
	}

	public enum TypeKills
	{
		none,
		himself,
		headshot,
		explosion,
		zoomingshot,
		flag,
		grenade,
		grenade_hell,
		turret,
		killTurret,
		mech
	}

	public struct MessageChat
	{
		public string text;

		public float time;

		public int ID;

		public int command;

		public bool isClanMessage;

		public Texture clanLogo;

		public string clanID;

		public string clanName;

		public PhotonView IDLocal;
	}

	private const string keyKilledPlayerCharactersCount = "KilledPlayerCharactersCount";

	private const float slowdownCoefConst = 0.75f;

	public AudioClip mechActivSound;

	public AudioClip invisibleActivSound;

	public AudioClip jetpackActivSound;

	public AudioClip hitmarkerSound;
	
	public AudioClip killSound;

	public AudioClip headshotkillSound;

	public PlayerScoreController myScoreController;

	public bool isRocketJump;

	public float currArmor = 31f;

	public float timeBuyHealth = -10000f;

	public float armorSynch;

	public bool isReloading;

	public bool isPlacemarker;

	public Player_move_c placemarkerMoveC;

	public ParticleBonuse[] bonusesParticles;

	public GameObject particleBonusesPoint;

	public Transform myTransform;

	public Transform myPlayerTransform;

	public int myPlayerID;

	public PhotonView myPlayerIDLocal;

	public SkinName mySkinName;

	public GameObject mechPoint;

	public GameObject mechBody;

	public Animation mechGunAnimation;

	public Animation mechBodyAnimation;

	public WeaponSounds mechWeaponSounds;

	public bool currentlyHead;

	public ParticleSystem[] flashMech;

	public GameObject fpsPlayerBody;

	public GameObject myCurrentWeapon;

	public WeaponSounds myCurrentWeaponSounds;

	public GameObject mechExplossion;

	public AudioSource mechExplossionSound;

	public AudioClip shootMechClip;

	public SkinnedMeshRenderer playerBodyRenderer;

	public SkinnedMeshRenderer mechBodyRenderer;

	public SkinnedMeshRenderer mechHandRenderer;

	public SkinnedMeshRenderer mechGunRenderer;

	public CapsuleCollider bodyCollayder;

	public CapsuleCollider headCollayder;

	public Material[] mechGunMaterials;

	public Material[] mechBodyMaterials;
	
	public static bool canlock = true;

	private int numShootInDoubleShot = 1;

	public bool isMechActive;

	public AudioClip flagGetClip;

	public AudioClip flagLostClip;

	public AudioClip flagScoreEnemyClip;

	public AudioClip flagScoreMyCommandClip;

	public float deltaAngle;

	public GameObject playerDeadPrefab;

	public ThirdPersonNetwork1 myPersonNetwork;

	public GameObject grenadePrefab;

	public GameObject turretPrefab;

	public GameObject turretPoint;

	public GameObject currentTurret;

	public float liveMech;

	public float[] liveMechByTier;

	private GameObject currentGrenade;

	private int currentWeaponBeforeTurret;

	private int currentWeaponBeforeGrenade;

	private int countMultyFlag;

	private string[] iconShotName = new string[11]
	{
		string.Empty,
		"Chat_Death",
		"Chat_HeadShot",
		"Chat_Explode",
		"Chat_Sniper",
		"Chat_Flag",
		"Chat_grenade",
		"Chat_grenade_hell",
		"Chat_Turret",
		"Chat_Turret_Explode",
		string.Empty
	};

	public bool isImVisible;

	public bool isWeaponSet;

	public NetworkStartTableNGUIController networkStartTableNGUIController;

	public GameObject invisibleParticle;

	public bool isInvisible;

	public float maxTimeSetTimerShow = 0.5f;

	private float _koofDamageWeaponFromPotoins;

	public bool isRegenerationLiveZel;

	private float maxTimerRegenerationLiveZel = 5f;

	public bool isRegenerationLiveCape;

	private float maxTimerRegenerationLiveCape = 15f;

	private float timerRegenerationLiveZel;

	private float timerRegenerationLiveCape;

	private float timerRegenerationArmor;

	private Shader[] oldShadersInInvisible;

	private Color[] oldColorInInvisible;

	public bool isCaptureFlag;

	public GameObject myBaza;

	public Camera myCamera;

	public Camera gunCamera;

	public GameObject hatsPoint;

	public GameObject capesPoint;

	public GameObject flagPoint;

	public GameObject bootsPoint;

	public GameObject armorPoint;

	public bool isZooming;

	public AudioClip headShotSound;

	public AudioClip flagCaptureClip;

	public AudioClip flagPointClip;

	public GameObject headShotParticle;

	public GameObject healthParticle;

	public GameObject chatViewer;

	public GUISkin MySkin;

	public GameObject myTable;

	public string myCAnim(string a){
        return Defs.CAnim(_weaponManager.currentWeaponSounds.animationObject, a);
    }

	private float[] _byCatDamageModifs = new float[5];

	public int AimTextureWidth = 50;

	public int AimTextureHeight = 50;

	public Transform GunFlash;

	private bool isZachetWin;

	public bool showGUIUnlockFullVersion;

	public float timeHingerGame;

	public int BulletForce = 5000;

	public bool killed;

	public ZombiManager zombiManager;

	public NickLabelController myNickLabelController;

	public visibleObjPhoton visibleObj;

	public string textChat;

	public bool showGUI = true;

	public bool showRanks;

	public string[][] killedSpisok = new string[3][]
	{
		new string[4]
		{
			string.Empty,
			string.Empty,
			string.Empty,
			string.Empty
		},
		new string[4]
		{
			string.Empty,
			string.Empty,
			string.Empty,
			string.Empty
		},
		new string[4]
		{
			string.Empty,
			string.Empty,
			string.Empty,
			string.Empty
		}
	};

	public GUIStyle combatRifleStyle;

	public GUIStyle goldenEagleInappStyle;

	public GUIStyle magicBowInappStyle;

	public GUIStyle spasStyle;

	public GUIStyle axeStyle;

	public GUIStyle famasStyle;

	public GUIStyle glockStyle;

	public GUIStyle chainsawStyle;

	public GUIStyle scytheStyle;

	public GUIStyle shovelStyle;

	private Vector3 camPosition;

	private Quaternion camRotaion;

	public bool showChat;

	public bool showChatOld;

	public bool showRanksOld;

	private bool isDeadFrame;

	public int myCommand;

	public float timerShowUp;

	public float timerShowLeft;

	public float timerShowDown;

	public float timerShowRight;

	public string myIp = string.Empty;

	public TrainingController trainigController;

	public bool isKilled;

	public bool theEnd;

	public string nickPobeditel;

	public Texture hitTexture;

	public Texture _skin;

	public float showNoInetTimer = 5f;

	private SaltedInt _killCount = new SaltedInt(428452539);

	public int maxCountKills;

	public float _curHealth;

	private float _timeWhenPurchShown;

	private bool inAppOpenedFromPause;

	public Texture sendTek;

	public Texture sendUstanovlenii;

	public bool isMulti;

	public bool isInet;

	public bool isMine;

	public bool isCompany;

	public bool isCOOP;

	private ExperienceController expController;

	private float inGameTime;

	public int multiKill;

	private HungerGameController hungerGameController;

	private bool isHunger;

	public static float maxTimerShowMultyKill = 3f;

	public FlagController flag1;

	public FlagController flag2;

	public FlagController myFlag;

	public FlagController enemyFlag;

	private GameObject rocketToLaunch;

	public float synhHealth = -10000000f;

	public double synchTimeHealth;

	public bool isStartAngel;

	public GameObject _label;

	private float maxTimerImmortality = 3f;

	public bool isImmortality = true;

	private float timerImmortality = 3f;

	private float timerImmortalityForAlpha = 3f;

	public static bool isBlockKeybordControl;

	private KillerInfo _killerInfo = new KillerInfo();

	private List<int> myKillAssists = new List<int>();

	private List<PhotonView> myKillAssistsLocal = new List<PhotonView>();

	[NonSerialized]
	public string currentWeapon;

	[NonSerialized]
	public int mechUpgrade;

	[NonSerialized]
	public int turretUpgrade;

	private bool _weaponPopularityCacheIsDirty;

	public float healthMod = 1f;

	public float MaxHealth = MaxPlayerHealth;

	public int counterMeleeSerials;

	private float _curBaseArmor;

	public int AmmoBoxWidth = 100;

	public int AmmoBoxHeight = 100;

	public int AmmoBoxOffset = 10;

	public int ScoreBoxWidth = 100;

	public int ScoreBoxHeight = 100;

	public int ScoreBoxOffset = 10;

	public float[] timerShow = new float[3] { -1f, -1f, -1f };

	public AudioClip deadPlayerSound;

	public AudioClip damagePlayerSound;

	private float GunFlashLifetime;

	public GameObject[] zoneCreatePlayer;

	public GUIStyle ScoreBox;

	public GUIStyle AmmoBox;

	private float mySens;

	public GUIStyle sliderSensStyle;

	public GUIStyle thumbSensStyle;

	private GameObject damage;

	private bool damageShown;

	private Pauser _pauser;

	private bool _backWasPressed;

	public GameObject _player;

	public GameObject bulletPrefab;

	public GameObject bulletPrefabRed;

	public GameObject bulletPrefabFor252;

	public GameObject _bulletSpawnPoint;

	public GameObject _purchaseActivityIndicator;

	private GameObject _inAppGameObject;

	public StoreKitEventListener _listener;

	public GUIStyle puliInApp;

	public InGameGUI inGameGUI;

	public GUIStyle healthInApp;

	private Dictionary<string, Action<string>> _actionsForPurchasedItems = new Dictionary<string, Action<string>>();

	public GUIStyle crystalSwordInapp;

	public GUIStyle elixirInapp;

	public GUIStyle pulemetInApp;

	public bool _isInappWinOpen;

	private WeaponManager ___weaponManager;

	public GUIStyle armorStyle;

	private SaltedInt _countKillsCommandBlue = new SaltedInt(180068360);

	private SaltedInt _countKillsCommandRed = new SaltedInt(180068361);

	private bool canReceiveSwipes = true;

	public float slideMagnitudeX;

	public float slideMagnitudeY;

	public AudioClip ChangeWeaponClip;

	public AudioClip ChangeGrenadeClip;

	public AudioClip WeaponBonusClip;

	public PhotonView photonView;

	public AudioClip clickShop;

	public List<MessageChat> messages = new List<MessageChat>();

	public bool isTraining;

	public bool isSurvival;

	public string myTableId;

	private int oldKilledPlayerCharactersCount;

	public GameObject jetPackPoint;

	public GameObject jetPackPointMech;

	public ParticleSystem[] jetPackParticle;

	public GameObject jetPackSound;

	private int indexWeapon;

	private bool shouldSetMaxAmmoWeapon;

	private bool BonusEffectForArmorWorksInThisMatch;

	private bool ArmorBonusGiven;

	private List<float> _reloadAnimationSpeed = WeaponManager.DefaultReloadSpeeds;

	private int countMySpotEvent;

	private int countHouseKeeperEvent;

	private bool isRaiderMyPoint;

	private bool isJumpPresedOld;

	private float _chanceToIgnoreHeadshot;

	private bool roomTierInitialized;

	private int roomTier;

	private bool _escapePressed;

	private float oldAlphaImmortality = -1f;

	private float _timeOfSlowdown;

	private bool isActiveTurretPanelInPause;

	private float timeGrenadePress;

	public bool isGrenadePress;

	public float koofDamageWeaponFromPotoins
	{
		get
		{
			return _koofDamageWeaponFromPotoins;
		}
		set
		{
			_koofDamageWeaponFromPotoins = value;
		}
	}

	private float maxTimerRegenerationArmor
	{
		get
		{
			return EffectsController.RegeneratingArmorTime;
		}
	}

	public float[] byCatDamageModifs
	{
		get
		{
			return _byCatDamageModifs;
		}
	}

	public static int MaxPlayerHealth
	{
		get
		{
			return 9;
		}
	}

	public int countKills
	{
		get
		{
			return _killCount.Value;
		}
		set
		{
			_killCount.Value = value;
		}
	}

	public KillerInfo killerInfo
	{
		get
		{
			return _killerInfo;
		}
	}

	internal static bool NeedApply { get; set; }

	internal static bool AnotherNeedApply { get; set; }

	public float CurHealth
	{
		get
		{
			return _curHealth;
		}
		set
		{
			float num = _curHealth - value;
			if (value > 0.1f && num > 0f)
			{
				num *= healthMod;
			}
			_curHealth -= num;
		}
	}

	private float maxBaseArmor
	{
		get
		{
			return 9f + EffectsController.ArmorBonus;
		}
	}

	private float CurrentBaseArmor
	{
		get
		{
			return _curBaseArmor;
		}
		set
		{
			_curBaseArmor = value;
		}
	}

	public float curArmor
	{
		get
		{
			return currArmor;
		}
		set
		{
			float num = curArmor - value;
			if (num >= 0f)
			{
				if (currArmor >= num)
				{
					currArmor -= num;
					return;
				}
				num -= currArmor;
				currArmor -= num;
			}
			else if (num < 0f)
			{
				num *= -1f;
				num = ((!(WearedMaxArmor > 0f)) ? 1f : ((!(WearedMaxArmor > 5f)) ? (WearedMaxArmor - WearedCurrentArmor) : Mathf.Min(WearedMaxArmor - WearedCurrentArmor, WearedMaxArmor * 0.5f)));
				AddArmor(num);
			}
		}
	}

	public float MaxArmor
	{
		get
		{
			return maxBaseArmor + WearedMaxArmor;
		}
	}

	private float WearedMaxArmor
	{
		get
		{
			return 31f;
		}
	}

	public bool isInappWinOpen
	{
		get
		{
			return _isInappWinOpen;
		}
		set
		{
			_isInappWinOpen = value;
			ShopNGUIController.GuiActive = value;
		}
	}

	public static int FontSizeForMessages
	{
		get
		{
			return Mathf.RoundToInt((float)Screen.height * 0.03f);
		}
	}

	public WeaponManager _weaponManager
	{
		get
		{
			return ___weaponManager;
		}
		set
		{
			___weaponManager = value;
		}
	}

	public int countKillsCommandBlue
	{
		get
		{
			return _countKillsCommandBlue.Value;
		}
		set
		{
			_countKillsCommandBlue.Value = value;
		}
	}

	public int countKillsCommandRed
	{
		get
		{
			return _countKillsCommandRed.Value;
		}
		set
		{
			_countKillsCommandRed.Value = value;
		}
	}

	public bool isNeedTakePremiumAccountRewards { get; private set; }

	private float WearedCurrentArmor
	{
		get
		{
			return CurrentBodyArmor;
		}
	}

	private float CurrentBodyArmor
	{
		get
		{
			return 19f;
		}
		set
		{
		}
	}

	private float CurrentHatArmor
	{
		get
		{
			float value = 0f;
			Wear.curArmor.TryGetValue(FriendsController.sharedController.hatName ?? string.Empty, out value);
			return value;
		}
		set
		{
			if (Wear.curArmor.ContainsKey(FriendsController.sharedController.hatName ?? string.Empty))
			{
				Wear.curArmor[FriendsController.sharedController.hatName ?? string.Empty] = value;
			}
		}
	}

	public static int _ShootRaycastLayerMask
	{
		get
		{
			return -2053 & ~(1 << LayerMask.NameToLayer("DamageCollider"));
		}
	}

	private bool isNeedShowRespawnWindow
	{
		get
		{
			return !isHunger && !Defs.isRegimVidosDebug && !_killerInfo.isSuicide && Defs.isMulti && !Defs.isCOOP;
		}
	}

	public static event Action StopBlinkShop;

	public event EventHandler<EventArgs> WeaponChanged;

	public event Action<float> FreezerFired;

	public void DoMoveC_OnGUI()
	{
	}

	public void IndicateDamage()
	{
		isDeadFrame = true;
		Invoke("setisDeadFrameFalse", 1f);
	}

	public void SetHealthMod()
	{
	}

	public void hit(float dam, Vector3 posEnemy, bool damageColliderHit = false)
	{
		if (!isTraining)
		{
			if (isMechActive)
			{
				MinusMechHealth(dam);
			}
			else if (curArmor >= dam)
			{
				curArmor -= dam;
			}
			else
			{
				CurHealth -= dam - curArmor;
				curArmor = 0f;
				CurrentCampaignGame.withoutHits = false;
			}
		}
		if (!damageColliderHit)
		{
			ShowDamageDirection(posEnemy);
		}
		if (!damageShown)
		{
			StartCoroutine(FlashWhenHit());
		}
	}

	private void AddArmor(float dt)
	{
		if (WearedMaxArmor > 0f)
		{
			float num2 = 0f;
			dt -= num2;
			float num3 = 0f;
			float num4 = num3 - CurrentHatArmor;
			if (num4 < 0f)
			{
				num4 = 0f;
			}
			CurrentHatArmor += Mathf.Min(num4, dt);
		}
		else
		{
			float num5 = maxBaseArmor - CurrentBaseArmor;
			if (num5 < 0f)
			{
				num5 = 0f;
			}
			if (dt <= num5)
			{
				CurrentBaseArmor += dt;
			}
			else
			{
				CurrentBaseArmor += num5;
			}
		}
	}

	private void Awake()
	{
		canlock = true;
		myCamera.fieldOfView = Storager.getInt("camerafov", false);
		isTraining = Defs.IsTraining;
		isSurvival = Defs.IsSurvival;
		isMulti = Defs.isMulti;
		isInet = Defs.isInet;
		isCompany = Defs.isCompany;
		isCOOP = Defs.isCOOP;
		isHunger = Defs.isHunger;
		if (isHunger)
		{
			GameObject gameObject = GameObject.FindGameObjectWithTag("HungerGameController");
			if (gameObject == null)
			{
				Debug.LogError("hungerGameControllerObject == null");
			}
			else
			{
				hungerGameController = gameObject.GetComponent<HungerGameController>();
			}
		}
	}

	[PunRPC]
	private void setMySkin(string str)
	{
		byte[] data = Convert.FromBase64String(str);
		Texture2D texture2D = new Texture2D(64, 32);
		texture2D.LoadImage(data);
		texture2D.filterMode = FilterMode.Point;
		texture2D.Apply();
		sendUstanovlenii = texture2D;
	}

	public void SetJetpackEnabled(bool _isEnabled)
	{
		Defs.isJetpackEnabled = _isEnabled;
		if (Defs.isSoundFX && _isEnabled)
		{
			base.GetComponent<AudioSource>().PlayOneShot(jetpackActivSound);
		}
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				photonView.RPC("SetJetpackEnabledRPC", PhotonTargets.Others, _isEnabled);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("SetJetpackEnabledRPC", PhotonTargets.Others, _isEnabled);
			}
		}
	}

	[PunRPC]
	public void SetJetpackEnabledRPC(bool _isEnabled)
	{
		if (Defs.isSoundFX && _isEnabled)
		{
			base.GetComponent<AudioSource>().PlayOneShot(jetpackActivSound);
		}
		jetPackPoint.SetActive(_isEnabled);
		jetPackPointMech.SetActive(_isEnabled);
		if (!_isEnabled)
		{
			for (int i = 0; i < jetPackParticle.Length; i++)
			{
				jetPackParticle[i].enableEmission = _isEnabled;
			}
		}
	}

	public void SetJetpackParticleEnabled(bool _isEnabled)
	{
		if (_isEnabled)
		{
			if (ButtonClickSound.Instance != null && Defs.isSoundFX)
			{
				jetPackSound.SetActive(true);
			}
		}
		else
		{
			jetPackSound.SetActive(false);
		}
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				photonView.RPC("SetJetpackParticleEnabledRPC", PhotonTargets.Others, _isEnabled);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("SetJetpackParticleEnabledRPC", PhotonTargets.Others, _isEnabled);
			}
		}
	}

	[PunRPC]
	public void SetJetpackParticleEnabledRPC(bool _isEnabled)
	{
		if (_isEnabled)
		{
			if (ButtonClickSound.Instance != null && Defs.isSoundFX)
			{
				jetPackSound.SetActive(true);
			}
		}
		else
		{
			jetPackSound.SetActive(false);
		}
		for (int i = 0; i < jetPackParticle.Length; i++)
		{
			jetPackParticle[i].enableEmission = _isEnabled;
		}
	}

	[Obfuscation(Exclude = true)]
	private void sendMySkin()
	{
		Texture2D texture2D = sendTek as Texture2D;
		byte[] inArray = texture2D.EncodeToPNG();
		string text = Convert.ToBase64String(inArray);
		photonView.RPC("setMySkin", PhotonTargets.AllBuffered, text);
	}

	[PunRPC]
	private void SendChatMessage(string text, bool _clanMode, string _clanLogo, string _ClanID, string _clanName)
	{
		if ((_clanMode && !_ClanID.Equals(FriendsController.sharedController.ClanID)) || _weaponManager == null || _weaponManager.myPlayer == null)
		{
			return;
		}
		SkinName component = _weaponManager.myPlayer.GetComponent<SkinName>();
		if (component == null)
		{
			Debug.LogWarning("skinName == null");
			return;
		}
		GameObject playerGameObject = component.playerGameObject;
		if (playerGameObject == null)
		{
			Debug.LogWarning("playerGo == null");
			return;
		}
		Player_move_c component2 = playerGameObject.GetComponent<Player_move_c>();
		if (component2 == null)
		{
			Debug.LogWarning("playerMoveScript == null");
		}
		else if (!isInet)
		{
			component2.AddMessage(text, Time.time, -1, myPlayerTransform.GetComponent<PhotonView>().viewID, _clanLogo);
		}
		else
		{
			component2.AddMessage(text, Time.time, myPlayerTransform.GetComponent<PhotonView>().viewID, myCommand, _clanLogo);
		}
	}

	public void SendChat(string text, bool clanMode)
	{
		text = (text.Equals("-=ATTACK!=-") ? LocalizationStore.Get("Key_1086") : (text.Equals("-=HELP!=-") ? LocalizationStore.Get("Key_1087") : (text.Equals("-=OK!=-") ? LocalizationStore.Get("Key_1088") : ((!text.Equals("-=NO!=-")) ? FilterBadWorld.FilterString(text) : LocalizationStore.Get("Key_1089")))));
		if (text != string.Empty)
		{
			if (!isInet)
			{
				base.GetComponent<PhotonView>().RPC("SendChatMessage", PhotonTargets.All, "< " + _weaponManager.myTable.GetComponent<NetworkStartTable>().NamePlayer + " > " + text, clanMode, FriendsController.sharedController.clanLogo, FriendsController.sharedController.ClanID, FriendsController.sharedController.clanName);
			}
			else
			{
				photonView.RPC("SendChatMessage", PhotonTargets.All, "< " + _weaponManager.myTable.GetComponent<NetworkStartTable>().NamePlayer + " > " + text, clanMode, FriendsController.sharedController.clanLogo, FriendsController.sharedController.ClanID, FriendsController.sharedController.clanName);
			}
		}
	}

	public void AddMessage(string text, float time, int ID, int _command, string clanLogo)
	{
		MessageChat item = default(MessageChat);
		item.text = text;
		item.time = time;
		item.ID = ID;
		item.command = _command;
		if (!string.IsNullOrEmpty(clanLogo))
		{
			byte[] data = Convert.FromBase64String(clanLogo);
			Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoWidth);
			texture2D.LoadImage(data);
			texture2D.filterMode = FilterMode.Point;
			texture2D.Apply();
			item.clanLogo = texture2D;
		}
		else
		{
			item.clanLogo = null;
		}
		messages.Add(item);
		if (messages.Count > 30)
		{
			messages.RemoveAt(0);
		}
	}

	public void WalkAnimation()
	{
		if (_singleOrMultiMine())
		{
			if (isMechActive)
			{
				mechGunAnimation.CrossFade("Walk");
			}
			if ((bool)_weaponManager && (bool)_weaponManager.currentWeaponSounds && _weaponManager.currentWeaponSounds.animationObject != null)
			{
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().CrossFade(myCAnim("Walk"));
			}
		}
	}

	public void IdleAnimation()
	{
		if (_singleOrMultiMine())
		{
			if (isMechActive)
			{
				mechGunAnimation.CrossFade("Idle");
			}
			if ((bool)___weaponManager && (bool)___weaponManager.currentWeaponSounds && ___weaponManager.currentWeaponSounds.animationObject != null)
			{
				___weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().CrossFade(myCAnim("Idle"));
			}
		}
	}

	public void ZoomPress()
	{
		if (WeaponManager.sharedManager.currentWeaponSounds.isGrenadeWeapon)
		{
			return;
		}
		isZooming = !isZooming;
		if (isZooming)
		{
			myCamera.fieldOfView = _weaponManager.currentWeaponSounds.fieldOfViewZomm;
			gunCamera.gameObject.SetActive(false);
			inGameGUI.SetScopeForWeapon(_weaponManager.currentWeaponSounds.scopeNum.ToString());
			myTransform.localPosition = new Vector3(myTransform.localPosition.x, myTransform.localPosition.y, myTransform.localPosition.z);
		}
		else
		{
			myCamera.fieldOfView = Storager.getInt("camerafov", false);
			gunCamera.fieldOfView = 75f;
			gunCamera.gameObject.SetActive(true);
			if (inGameGUI != null)
			{
				inGameGUI.ResetScope();
			}
		}
		if (isMulti && isInet)
		{
			photonView.RPC("SynhIsZoming", PhotonTargets.AllBuffered, isZooming);
		}
	}

	[PunRPC]
	private void SynhIsZoming(bool _isZoomming)
	{
		isZooming = _isZoomming;
	}

	public void hideGUI()
	{
		showGUI = false;
	}

	public void setMyTamble(GameObject _myTable)
	{
		if (myTable == null || _myTable == null)
		{
			return;
		}
		NetworkStartTable component = myTable.GetComponent<NetworkStartTable>();
		if (component == null)
		{
			return;
		}
		component.myPlayerMoveC = this;
		myTable = _myTable;
		NetworkStartTable component2 = myTable.GetComponent<NetworkStartTable>();
		if (!(component2 == null))
		{
			myCommand = myTable.GetComponent<NetworkStartTable>().myCommand;
			if (Initializer.redPlayers.Contains(this) && myCommand == 1)
			{
				Initializer.redPlayers.Remove(this);
			}
			if (Initializer.bluePlayers.Contains(this) && myCommand == 2)
			{
				Initializer.bluePlayers.Remove(this);
			}
			if (myCommand == 1 && !Initializer.bluePlayers.Contains(this))
			{
				Initializer.bluePlayers.Add(this);
			}
			if (myCommand == 2 && !Initializer.redPlayers.Contains(this))
			{
				Initializer.redPlayers.Add(this);
			}
			_skin = myTable.GetComponent<NetworkStartTable>().mySkin;
			GameObject gameObject = myPlayerTransform.gameObject;
			if (gameObject != null)
			{
				SetTextureRecursivelyFrom(gameObject, gameObject.GetComponent<SkinName>().playerMoveC._skin, GetStopObjFromPlayer(gameObject));
			}
		}
	}

	public void AddWeapon(GameObject weaponPrefab)
	{
		int score;
		if (_weaponManager.AddWeapon(weaponPrefab, out score))
		{
			ChangeWeapon(_weaponManager.CurrentWeaponIndex, false);
			return;
		}
		if (ItemDb.IsWeaponCanDrop(weaponPrefab.tag))
		{
			GlobalGameController.Score += score;
			if (Defs.isSoundFX)
			{
				if (WeaponBonusClip != null)
				{
					base.gameObject.GetComponent<AudioSource>().PlayOneShot(WeaponBonusClip);
				}
				else
				{
					base.gameObject.GetComponent<AudioSource>().PlayOneShot(ChangeWeaponClip);
				}
			}
			return;
		}
		foreach (Weapon playerWeapon in _weaponManager.playerWeapons)
		{
			if (playerWeapon.weaponPrefab == weaponPrefab)
			{
				ChangeWeapon(_weaponManager.playerWeapons.IndexOf(playerWeapon), false);
				break;
			}
		}
	}

	public bool MinusMechHealth(float _minus)
	{
		liveMech -= _minus;
		if (liveMech <= 0f)
		{
			DeactivateMech();
			return true;
		}
		return false;
	}

	public void minusLiveFromZombi(float _minusLive, Vector3 posZombi)
	{
		photonView.RPC("minusLiveFromZombiRPC", PhotonTargets.All, _minusLive, posZombi);
	}

	[PunRPC]
	public void minusLiveFromZombiRPC(float live, Vector3 posZombi)
	{
		if (photonView.isMine && !isKilled && !isImmortality)
		{
			if (isMechActive)
			{
				MinusMechHealth(live);
			}
			else
			{
				float num = live - curArmor;
				if (num < 0f)
				{
					curArmor -= live;
					num = 0f;
				}
				else
				{
					curArmor = 0f;
				}
				CurHealth -= num;
			}
			ShowDamageDirection(posZombi);
		}
		StartCoroutine(Flash(myPlayerTransform.gameObject));
	}

	public void StartFlash(GameObject _obj)
	{
		StartCoroutine(Flash(_obj));
	}

	public static void SetLayerRecursively(GameObject obj, int newLayer)
	{
		if (null == obj)
		{
			return;
		}
		obj.layer = newLayer;
		int childCount = obj.transform.childCount;
		Transform transform = obj.transform;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (!(null == child))
			{
				SetLayerRecursively(child.gameObject, newLayer);
			}
		}
	}

	public static void PerformActionRecurs(GameObject obj, Action<Transform> act)
	{
		if (act == null || null == obj)
		{
			return;
		}
		act(obj.transform);
		int childCount = obj.transform.childCount;
		Transform transform = obj.transform;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (!(null == child))
			{
				PerformActionRecurs(child.gameObject, act);
			}
		}
	}

	public void ChangeWeapon(int index, bool shouldSetMaxAmmo = true)
	{
		if (index == 1001)
		{
			currentWeaponBeforeTurret = WeaponManager.sharedManager.CurrentWeaponIndex;
		}
		indexWeapon = index;
		shouldSetMaxAmmoWeapon = shouldSetMaxAmmo;
		StopCoroutine("ChangeWeaponCorutine");
		StopCoroutine(BazookaShoot());
		StartCoroutine("ChangeWeaponCorutine");
	}

	private IEnumerator ChangeWeaponCorutine()
	{
		photonView.synchronization = ViewSynchronization.Off;
//		base.GetComponent<PhotonView>().synchronization = NetworkStateSynchronization.Off;
		if (!Defs.isTurretWeapon)
		{
			while (deltaAngle < 40f && !Defs.isTurretWeapon && !isMechActive)
			{
				deltaAngle += 65f * Time.deltaTime * 3/2;
				yield return null;
			}
		}
		else
		{
			Defs.isTurretWeapon = false;
		}
		ChangeWeaponReal(indexWeapon, shouldSetMaxAmmoWeapon);
		if (indexWeapon != 1001 && !isMechActive)
		{
			while (deltaAngle > 0f)
			{
				deltaAngle -= 65f * Time.deltaTime * 3/2;
				if (deltaAngle < 0f)
				{
					deltaAngle = -0.01f;
				}
				yield return null;
			}
		}
		photonView.synchronization = ViewSynchronization.Unreliable;
		//base.GetComponent<PhotonView>().synchronization = ViewSynchronization.Unreliable;
	}

	public void ChangeWeaponReal(int index, bool shouldSetMaxAmmo = true)
	{
		if (inGameGUI != null)
		{
			inGameGUI.StopAllCircularIndicators();
		}
		EventHandler<EventArgs> weaponChanged = this.WeaponChanged;
		if (weaponChanged != null)
		{
			weaponChanged(this, EventArgs.Empty);
		}
		if (isZooming)
		{
			ZoomPress();
		}
		photonView = PhotonView.Get(this);
		Quaternion rotation = Quaternion.identity;
		if ((bool)_player)
		{
			rotation = _player.transform.rotation;
		}
		if ((bool)_weaponManager.currentWeaponSounds)
		{
			rotation = _weaponManager.currentWeaponSounds.gameObject.transform.rotation;
			_SetGunFlashActive(false);
			_weaponManager.currentWeaponSounds.gameObject.transform.parent = null;
			UnityEngine.Object.Destroy(_weaponManager.currentWeaponSounds.gameObject);
			_weaponManager.currentWeaponSounds = null;
		}
		GameObject gameObject = null;
		GameObject weaponPrefab;
		switch (index)
		{
		case 1000:
			weaponPrefab = grenadePrefab;
			break;
		case 1001:
			weaponPrefab = turretPrefab;
			break;
		default:
			weaponPrefab = ((Weapon)_weaponManager.playerWeapons[index]).weaponPrefab;
			break;
		}
		GameObject gameObject2 = weaponPrefab;
		gameObject = (myCurrentWeapon = (GameObject)UnityEngine.Object.Instantiate(gameObject2, Vector3.zero, Quaternion.identity));
		myCurrentWeaponSounds = myCurrentWeapon.GetComponent<WeaponSounds>();
		if (myCurrentWeapon.GetComponent<WeaponSounds>().isDoubleShot)
		{
			gunCamera.transform.localPosition = Vector3.zero;
		}
		else
		{
			gunCamera.transform.localPosition = new Vector3(-0.1f, 0f, 0f);
		}
		gameObject.transform.parent = base.gameObject.transform;
		gameObject.transform.rotation = rotation;
		myCurrentWeapon.GetComponent<WeaponSounds>().animationObject.GetComponent<Animation>().cullingType = AnimationCullingType.AlwaysAnimate;
		if (isMechActive)
		{
			myCurrentWeapon.SetActive(false);
		}
		WeaponSounds component = gameObject.GetComponent<WeaponSounds>();
		if (component != null && PhotonNetwork.room != null)
		{
			Statistics.Instance.IncrementWeaponPopularity(LocalizationStore.GetByDefault(component.localizeWeaponKey), false);
			_weaponPopularityCacheIsDirty = true;
		}
		if (isMulti)
		{
			if (isInet)
			{
				photonView.RPC("SetWeaponRPC", PhotonTargets.Others, gameObject2.name, gameObject2.GetComponent<WeaponSounds>().alternativeName);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("SetWeaponRPC", PhotonTargets.OthersBuffered, gameObject2.name, gameObject2.GetComponent<WeaponSounds>().alternativeName);
			}
		}
		if (index == 1000)
		{
			WeaponSounds component2 = gameObject2.GetComponent<WeaponSounds>();
			GameObject gameObject3;
			if (isMulti)
			{
				if (!isInet)
				{
					GameObject prefab = Resources.Load("Rocket") as GameObject;
					gameObject3 = (GameObject)PhotonNetwork.Instantiate("Rocket", new Vector3(-10000f, -10000f, -10000f), base.transform.rotation, 0);
				}
				else
				{
					gameObject3 = PhotonNetwork.Instantiate("Rocket", new Vector3(-10000f, -10000f, -10000f), base.transform.rotation, 0);
				}
			}
			else
			{
				GameObject original = Resources.Load("Rocket") as GameObject;
				gameObject3 = UnityEngine.Object.Instantiate(original, new Vector3(-10000f, -10000f, -10000f), base.transform.rotation) as GameObject;
			}
			if (gameObject3 != null)
			{
				Rocket component3 = gameObject3.GetComponent<Rocket>();
				component3.rocketNum = 10;
				component3.weaponName = "WeaponGrenade";
				component3.damage = (float)component2.damage * (1f + koofDamageWeaponFromPotoins + EffectsController.GrenadeExplosionDamageIncreaseCoef);
				component3.radiusDamage = component2.bazookaExplosionRadius * EffectsController.GrenadeExplosionRadiusIncreaseCoef;
				component3.radiusDamageSelf = component2.bazookaExplosionRadiusSelf;
				component3.radiusImpulse = component2.bazookaImpulseRadius * (1f + EffectsController.ExplosionImpulseRadiusIncreaseCoef);
				component3.damageRange = component2.damageRange * (1f + koofDamageWeaponFromPotoins);
				float num = (component3.multiplayerDamage = ((ExpController.Instance != null && ExpController.Instance.OurTier < component2.damageByTier.Length) ? component2.damageByTier[TierOrRoomTier(ExpController.Instance.OurTier)] : ((component2.damageByTier.Length <= 0) ? 0f : component2.damageByTier[0])));
				gameObject3.GetComponent<Rigidbody>().useGravity = false;
				gameObject3.GetComponent<Rigidbody>().isKinematic = true;
				if (Defs.isMulti && !Defs.isInet)
				{
					component3.SendPhotonViewMyPlayer(base.transform.parent.GetComponent<PhotonView>());
				}
			}
			currentGrenade = gameObject3;
		}
		if (index == 1001)
		{
			Defs.isTurretWeapon = true;
			turretUpgrade = GearManager.CurrentNumberOfUphradesForGear(GearManager.Turret);
			if (isMulti)
			{
				if (isInet)
				{
					photonView.RPC("SyncTurretUpgrade", PhotonTargets.Others, turretUpgrade);
				}
				else
				{
					base.GetComponent<PhotonView>().RPC("SyncTurretUpgrade", PhotonTargets.Others, turretUpgrade);
				}
			}
			GameObject gameObject4;
			if (isMulti)
			{
				if (!isInet)
				{
					gameObject4 = (GameObject)PhotonNetwork.Instantiate("Turret", new Vector3(-10000f, -10000f, -10000f), base.transform.rotation, 0);
				}
				else
				{
					gameObject4 = PhotonNetwork.Instantiate("Turret", new Vector3(-10000f, -10000f, -10000f), base.transform.rotation, 0);
				}
			}
			else
			{
				GameObject original2 = Resources.Load("Turret") as GameObject;
				gameObject4 = UnityEngine.Object.Instantiate(original2, new Vector3(-10000f, -10000f, -10000f), base.transform.rotation) as GameObject;
			}
			if (gameObject4 != null)
			{
				TurretController component4 = gameObject4.GetComponent<TurretController>();
				gameObject4.GetComponent<Rigidbody>().useGravity = false;
				gameObject4.GetComponent<Rigidbody>().isKinematic = true;
				if (Defs.isMulti && !Defs.isInet)
				{
					component4.SendPhotonViewMyPlayer(base.transform.parent.GetComponent<PhotonView>());
				}
			}
			currentTurret = gameObject4;
		}
		GameObject gameObject5 = null;
		if (!gameObject.transform.GetComponent<WeaponSounds>().isMelee)
		{
			foreach (Transform item in gameObject.transform)
			{
				if (item.gameObject.name.Equals("BulletSpawnPoint") && item.childCount > 0)
				{
					gameObject5 = item.GetChild(0).gameObject;
					WeaponManager.SetGunFlashActive(gameObject5, false);
					break;
				}
			}
		}
		GameObject gameObject6 = base.transform.parent.gameObject;
		if (gameObject6 != null)
		{
			SetTextureRecursivelyFrom(gameObject6, _skin, GetStopObjFromPlayer(gameObject6));
		}
		SetLayerRecursively(gameObject, 9);
		_weaponManager.currentWeaponSounds = gameObject.GetComponent<WeaponSounds>();
		if (index < 1000)
		{
			_weaponManager.CurrentWeaponIndex = index;
			if (isMulti && !isHunger)
			{
				WeaponManager.WeaponUsedCategory = index;
			}
			if (inGameGUI != null)
			{
				if (_weaponManager.currentWeaponSounds.isMelee && !_weaponManager.currentWeaponSounds.isShotMelee && !isMechActive)
				{
					inGameGUI.fireButtonSprite.spriteName = "controls_strike";
					inGameGUI.fireButtonSprite2.spriteName = "controls_strike";
				}
				else
				{
					inGameGUI.fireButtonSprite.spriteName = "controls_fire";
					inGameGUI.fireButtonSprite2.spriteName = "controls_fire";
				}
			}
		}
		if (gameObject.transform.parent == null)
		{
			Debug.LogWarning("nw.transform.parent == null");
		}
		else if (_weaponManager.currentWeaponSounds == null)
		{
			Debug.LogWarning("_weaponManager.currentWeaponSounds == null");
		}
		else
		{
			gameObject.transform.position = gameObject.transform.parent.TransformPoint(_weaponManager.currentWeaponSounds.gunPosition);
		}
		PlayerPrefs.Save();
		TouchPadController rightJoystick = JoystickController.rightJoystick;
		if (index < 1000 && rightJoystick != null)
		{
			if (((Weapon)_weaponManager.playerWeapons[index]).currentAmmoInClip > 0 || (_weaponManager.currentWeaponSounds.isMelee && !_weaponManager.currentWeaponSounds.isShotMelee))
			{
				rightJoystick.HasAmmo();
				if (inGameGUI != null)
				{
					inGameGUI.BlinkNoAmmo(0);
				}
			}
			else
			{
				rightJoystick.NoAmmo();
				if (inGameGUI != null)
				{
					inGameGUI.BlinkNoAmmo(1);
				}
			}
		}
		if (_weaponManager.currentWeaponSounds.animationObject != null)
		{
			if (_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().GetClip(myCAnim("Reload")) != null)
			{
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Reload")].layer = 1;
			}
			if (!_weaponManager.currentWeaponSounds.isDoubleShot)
			{
				if (_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().GetClip(myCAnim("Shoot")) != null)
				{
					_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Shoot")].layer = 1;
				}
			}
			else
			{
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Shoot1")].layer = 1;
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Shoot2")].layer = 1;
				if (_weaponManager.currentWeaponSounds.numOfMaximumShootDouble == 4)
				{
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Shoot3")].layer = 1;
				}
			}
		}
		if (!_weaponManager.currentWeaponSounds.isMelee)
		{
			foreach (Transform item2 in _weaponManager.currentWeaponSounds.gameObject.transform)
			{
				if (item2.name.Equals("BulletSpawnPoint"))
				{
					_bulletSpawnPoint = item2.gameObject;
					break;
				}
			}
			GunFlash = _bulletSpawnPoint.transform.GetChild(0);
		}
		if (Defs.isSoundFX)
		{
			base.gameObject.GetComponent<AudioSource>().PlayOneShot((index != 1000) ? ChangeWeaponClip : ChangeGrenadeClip);
		}
		if (isInvisible)
		{
			SetInVisibleShaders(isInvisible);
		}
	}

	[PunRPC]
	private void SetWeaponRPC(string _nameWeapon, string _alternativeNameWeapon)
	{
		isWeaponSet = true;
		GameObject gameObject = null;
		if (_nameWeapon.Equals("WeaponGrenade"))
		{
			gameObject = grenadePrefab;
			currentWeapon = null;
		}
		else if (_nameWeapon.Equals("WeaponTurret"))
		{
			gameObject = turretPrefab;
			currentWeapon = null;
		}
		else
		{
			gameObject = Resources.Load("Weapons/" + _nameWeapon) as GameObject;
			if (gameObject != null)
			{
				currentWeapon = gameObject.gameObject.tag;
			}
		}
		if (gameObject == null)
		{
			gameObject = Resources.Load("Weapons/" + _alternativeNameWeapon) as GameObject;
			if (gameObject != null)
			{
				currentWeapon = gameObject.gameObject.tag;
			}
		}
		if (_nameWeapon.Equals("WeaponGrenade") && Defs.isSoundFX)
		{
			base.gameObject.GetComponent<AudioSource>().PlayOneShot(ChangeGrenadeClip);
		}
		if (!(gameObject != null))
		{
			return;
		}
		GameObject gameObject2 = null;
		gameObject2 = (GameObject)UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
		if (isMechActive)
		{
			gameObject2.SetActive(false);
		}
		myCurrentWeapon = gameObject2;
		myCurrentWeaponSounds = myCurrentWeapon.GetComponent<WeaponSounds>();
		Transform transform = mySkinName.armorPoint.transform;
		if (transform.childCount > 0)
		{
			WeaponSounds component = gameObject2.GetComponent<WeaponSounds>();
			ArmorRefs component2 = transform.GetChild(0).GetChild(0).GetComponent<ArmorRefs>();
			component2.leftBone.GetComponent<SetPosInArmor>().target = component.LeftArmorHand;
			component2.rightBone.GetComponent<SetPosInArmor>().target = component.RightArmorHand;
		}
		foreach (Transform item in base.transform)
		{
			UnityEngine.Object.Destroy(item.gameObject);
		}
		gameObject2.transform.parent = base.gameObject.transform;
		GameObject gameObject3 = null;
		gameObject2.transform.position = Vector3.zero;
		if (!gameObject2.transform.GetComponent<WeaponSounds>().isMelee)
		{
			foreach (Transform item2 in gameObject2.transform)
			{
				if (item2.gameObject.name.Equals("BulletSpawnPoint") && item2.childCount > 0)
				{
					gameObject3 = item2.GetChild(0).gameObject;
					WeaponManager.SetGunFlashActive(gameObject3, false);
					break;
				}
			}
		}
		if (base.transform.Find("BulletSpawnPoint") != null)
		{
			_bulletSpawnPoint = base.transform.Find("BulletSpawnPoint").gameObject;
		}
		base.transform.localPosition = new Vector3(0f, 0.4f, 0f);
		gameObject2.transform.localPosition = new Vector3(0f, -1.4f, 0f);
		gameObject2.transform.rotation = base.transform.rotation;
		GameObject gameObject4 = base.transform.parent.gameObject;
		if (gameObject4 != null)
		{
			SetTextureRecursivelyFrom(gameObject4, _skin, GetStopObjFromPlayer(gameObject4));
		}
	}

	[Obfuscation(Exclude = true)]
	public void SetStealthModifier()
	{
		if (!(_player != null))
		{
		}
	}

	public bool NeedAmmo()
	{
		int currentWeaponIndex = _weaponManager.CurrentWeaponIndex;
		Weapon weapon = (Weapon)_weaponManager.playerWeapons[currentWeaponIndex];
		return weapon.currentAmmoInBackpack < _weaponManager.currentWeaponSounds.MaxAmmoWithEffectApplied;
	}

	private void SwitchPause()
	{
		if (CurHealth > 0f)
		{
			SetPause(true);
		}
	}

	private void ShopPressed()
	{
		JoystickController.rightJoystick.jumpPressed = false;
		JoystickController.rightJoystick.Reset();
		if (Defs.IsTraining)
		{
			if (TrainingController.stepTrainingList.ContainsKey("InterTheShop"))
			{
				TrainingController.isNextStep = TrainingState.EnterTheShop;
				if (Player_move_c.StopBlinkShop != null)
				{
					Player_move_c.StopBlinkShop();
				}
			}
			else
			{
				TrainingController.isNextStep = TrainingController.stepTrainingList["TapToShoot"];
			}
		}
		if (CurHealth > 0f)
		{
			SetInApp();
			SetPause(false);
			if (Defs.isSoundFX)
			{
				NGUITools.PlaySound(clickShop);
			}
		}
	}

	public void AddButtonHandlers()
	{
		PauseTapReceiver.PauseClicked += SwitchPause;
		ShopTapReceiver.ShopClicked += ShopPressed;
		RanksTapReceiver.RanksClicked += RanksPressed;
		ChatTapReceiver.ChatClicked += ShowChat;
		if (JoystickController.leftJoystick != null)
		{
			JoystickController.leftJoystick.SetJoystickActive(true);
		}
		if (JoystickController.leftTouchPad != null)
		{
			JoystickController.leftTouchPad.SetJoystickActive(true);
		}
	}

	public void RemoveButtonHandelrs()
	{
		PauseTapReceiver.PauseClicked -= SwitchPause;
		ShopTapReceiver.ShopClicked -= ShopPressed;
		RanksTapReceiver.RanksClicked -= RanksPressed;
		ChatTapReceiver.ChatClicked -= ShowChat;
		if (JoystickController.leftJoystick != null)
		{
			JoystickController.leftJoystick.SetJoystickActive(false);
		}
		if (JoystickController.leftTouchPad != null)
		{
			JoystickController.leftTouchPad.SetJoystickActive(false);
		}
	}

	public void RanksPressed()
	{
		JoystickController.rightJoystick.jumpPressed = false;
		JoystickController.rightJoystick.Reset();
		RemoveButtonHandelrs();
		showRanks = true;
		networkStartTableNGUIController.ShowRanksTable();
		inGameGUI.gameObject.SetActive(false);
	}

	public void BackRanksPressed()
	{
		AddButtonHandlers();
		showRanks = false;
		if (inGameGUI != null && inGameGUI.interfacePanel != null)
		{
			inGameGUI.gameObject.SetActive(true);
		}
	}

	private void OnEnable()
	{
	}

	private void OnDisable()
	{
	}

	[PunRPC]
	private void setIp(string _ip)
	{
		myIp = _ip;
	}

	private void CheckTimeCondition()
	{
		CampaignLevel campaignLevel = null;
		foreach (LevelBox campaignBox in LevelBox.campaignBoxes)
		{
			if (!campaignBox.name.Equals(CurrentCampaignGame.boXName))
			{
				continue;
			}
			foreach (CampaignLevel level in campaignBox.levels)
			{
				if (level.sceneName.Equals(CurrentCampaignGame.levelSceneName))
				{
					campaignLevel = level;
					break;
				}
			}
			break;
		}
		float timeToComplete = campaignLevel.timeToComplete;
		if (inGameTime >= timeToComplete)
		{
			CurrentCampaignGame.completeInTime = false;
		}
	}

	private IEnumerator GetHardwareKeysInput()
	{
		while (true)
		{
			bool androidBackPressed2 = false;
			if (true)
			{
				if (_escapePressed)
				{
					if (Application.isEditor)
					{
						Debug.Log("ESC presed in PlayerMoveC");
					}
					_escapePressed = false;
					_backWasPressed = true;
				}
				else
				{
					if (_backWasPressed)
					{
						androidBackPressed2 = true;
					}
					_backWasPressed = false;
				}
			}
			if (androidBackPressed2 && !isInappWinOpen)
			{
				androidBackPressed2 = false;
				if (inGameGUI != null && inGameGUI.pausePanel != null && inGameGUI.pausePanel.GetComponent<PauseNGUIController>() != null)
				{
					if (inGameGUI.pausePanel.GetComponent<PauseNGUIController>().SettingsJoysticksPanel != null && !inGameGUI.pausePanel.GetComponent<PauseNGUIController>().SettingsJoysticksPanel.activeInHierarchy)
					{
						if (GlobalGameController.InsideTraining)
						{
							SwitchPause();
						}
						else
						{
							SwitchPause();
						}
					}
					else if (inGameGUI.pausePanel.GetComponent<PauseNGUIController>().settingsPanel != null)
					{
						inGameGUI.pausePanel.GetComponent<PauseNGUIController>().SettingsJoysticksPanel.SetActive(false);
						inGameGUI.pausePanel.GetComponent<PauseNGUIController>().settingsPanel.SetActive(true);
					}
				}
			}
			yield return null;
		}
	}

	private void InitiailizeIcnreaseArmorEffectFlags()
	{
		BonusEffectForArmorWorksInThisMatch = EffectsController.IcnreaseEquippedArmorPercentage > 1f;
		ArmorBonusGiven = EffectsController.ArmorBonus > 0f;
	}

	private IEnumerator Start()
	{
		_killerInfo.Reset();
		isNeedTakePremiumAccountRewards = PremiumAccountController.Instance.isAccountActive;
		InitiailizeIcnreaseArmorEffectFlags();
		if (!Initializer.players.Contains(this))
		{
			Initializer.players.Add(this);
		}
		if (!Defs.isMulti)
		{
			WeaponManager.sharedManager.myPlayerMoveC = this;
			WeaponManager.sharedManager.myPlayer = myPlayerTransform.gameObject;
		}
		AmmoBox.fontSize = Mathf.RoundToInt(18f * (float)Screen.width / 1024f);
		ScoreBox.fontSize = Mathf.RoundToInt((float)Screen.height * 0.035f);
		if (Defs.isFlag)
		{
			flag1 = GameObject.FindGameObjectWithTag("Flag1").GetComponent<FlagController>();
			flag2 = GameObject.FindGameObjectWithTag("Flag2").GetComponent<FlagController>();
		}
		timerRegenerationLiveZel = maxTimerRegenerationLiveZel;
		timerRegenerationLiveCape = maxTimerRegenerationLiveCape;
		timerRegenerationArmor = maxTimerRegenerationArmor;
		photonView = PhotonView.Get(this);
		if (isMulti)
		{
			if (!isInet)
			{
				isMine = base.GetComponent<PhotonView>().isMine;
			}
			else if (photonView == null)
			{
				Debug.Log("Player_move_c.Start():    photonView == null");
			}
			else
			{
				isMine = photonView.isMine;
			}
		}
		if (!isMulti || isMine)
		{
			EffectsController.SlowdownCoeff = 1f;
			UnityEngine.Object pref = Resources.Load("InGameGUI");
			inGameGUI = (UnityEngine.Object.Instantiate(pref, Vector3.zero, Quaternion.identity) as GameObject).GetComponent<InGameGUI>();
			SetGrenateFireEnabled();
			Defs.isJetpackEnabled = false;
			Defs.isTurretWeapon = false;
			Defs.countGrenadeInHunger = 0;
			oldKilledPlayerCharactersCount = (Storager.hasKey("KilledPlayerCharactersCount") ? Storager.getInt("KilledPlayerCharactersCount", false) : 0);
		}
		if (!isMulti)
		{
			_skin = SkinsController.currentSkinForPers;
			_skin.filterMode = FilterMode.Point;
			ShopNGUIController.sharedShop.onEquipSkinAction = delegate
			{
				UpdateSkin();
			};
		}
		if (!Defs.isMulti && GameObject.FindGameObjectWithTag("TrainingController") != null)
		{
			trainigController = GameObject.FindGameObjectWithTag("TrainingController").GetComponent<TrainingController>();
		}
		expController = ExperienceController.sharedController;
		if (isMulti && isInet)
		{
			GameObject[] tables = GameObject.FindGameObjectsWithTag("NetworkTable");
			for (int i = 0; i < tables.Length; i++)
			{
				if (tables[i].GetComponent<PhotonView>().owner == base.transform.GetComponent<PhotonView>().owner)
				{
					myTable = tables[i];
					myCommand = myTable.GetComponent<NetworkStartTable>().myCommand;
					if (Initializer.redPlayers.Contains(this) && myCommand == 1)
					{
						Initializer.redPlayers.Remove(this);
					}
					if (Initializer.bluePlayers.Contains(this) && myCommand == 2)
					{
						Initializer.bluePlayers.Remove(this);
					}
					if (myCommand == 1 && !Initializer.bluePlayers.Contains(this))
					{
						Initializer.bluePlayers.Add(this);
					}
					if (myCommand == 2 && !Initializer.redPlayers.Contains(this))
					{
						Initializer.redPlayers.Add(this);
					}
					myTable.GetComponent<NetworkStartTable>().myPlayerMoveC = this;
					break;
				}
			}
		}
		if (isMulti)
		{
			if (isInet)
			{
				myPlayerID = myPlayerTransform.GetComponent<PhotonView>().viewID;
			}
			else
			{
				myPlayerIDLocal = myPlayerTransform.GetComponent<PhotonView>();
			}
		}
		if (isMulti && !isMine)
		{
			base.transform.localPosition = new Vector3(0f, 0.4f, 0f);
		}
		if (!isMulti)
		{
			CurrentCampaignGame.ResetConditionParameters();
			CurrentCampaignGame._levelStartedAtTime = Time.time;
			ZombieCreator.BossKilled += CheckTimeCondition;
		}
		if (isMulti && isCompany && isMine)
		{
			countKillsCommandBlue = GlobalGameController.countKillsBlue;
			countKillsCommandRed = GlobalGameController.countKillsRed;
		}
		if (isMulti && isCOOP)
		{
			zombiManager = ZombiManager.sharedManager;
		}
		if (isMulti && isMine)
		{
			networkStartTableNGUIController = NetworkStartTableNGUIController.sharedController;
		}
		if (isMulti && isInet)
		{
			maxCountKills = int.Parse(PhotonNetwork.room.customProperties["MaxKill"].ToString());
		}
		else if (!PlayerPrefs.GetString("MaxKill", "8").Equals(string.Empty))
		{
			maxCountKills = int.Parse(PlayerPrefs.GetString("MaxKill", "8"));
		}
		if (!isMulti || isMine)
		{
			InitPurchaseActions();
			_purchaseActivityIndicator = StoreKitEventListener.purchaseActivityInd;
			if (_purchaseActivityIndicator == null)
			{
				Debug.LogWarning("Start(): _purchaseActivityIndicator is null.");
			}
			else
			{
				_purchaseActivityIndicator.SetActive(false);
			}
		}
		if (!Defs.isMulti || isMine)
		{
			_inAppGameObject = GameObject.FindGameObjectWithTag("InAppGameObject");
			_listener = _inAppGameObject.GetComponent<StoreKitEventListener>();
		}
		if (!isMulti)
		{
			fpsPlayerBody.SetActive(false);
		}
		HOTween.Init(true, true, true);
		HOTween.EnableOverwriteManager(true);
		if (isMulti)
		{
			if (isMine)
			{
				showGUI = true;
			}
			else
			{
				showGUI = false;
			}
		}
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAPManager.purchaseSuccessfulEvent += HandlePurchaseSuccessful;
		}
		else
		{
			GoogleIABManager.purchaseSucceededEvent += purchaseSuccessful;
		}
		if (!isMulti || isMine)
		{
			_player = myPlayerTransform.gameObject;
		}
		else
		{
			_player = null;
		}
		_weaponManager = WeaponManager.sharedManager;
		if (Defs.isMulti && ((!Defs.isInet && base.GetComponent<PhotonView>().isMine) || (Defs.isInet && photonView.isMine && PlayerPrefs.GetInt("StartAfterDisconnect") == 0)))
		{
			foreach (Weapon _w in _weaponManager.allAvailablePlayerWeapons)
			{
				_w.currentAmmoInClip = _w.weaponPrefab.GetComponent<WeaponSounds>().ammoInClip;
				_w.currentAmmoInBackpack = _w.weaponPrefab.GetComponent<WeaponSounds>().InitialAmmoWithEffectsApplied;
			}
		}
		if (!isMulti || isMine)
		{
			GameObject tmpDamage = Resources.Load("Damage") as GameObject;
			damage = (GameObject)UnityEngine.Object.Instantiate(tmpDamage);
			if (damage.GetComponent<Image>() != null)
			{
				Color rgba = damage.GetComponent<Image>().color;
				rgba.a = 0f;
				damage.GetComponent<Image>().color = rgba;
			}
		}
		if (!isMulti || isMine)
		{
			_pauser = GameObject.FindGameObjectWithTag("GameController").GetComponent<Pauser>();
			if (_pauser == null)
			{
				Debug.LogWarning("Start(): _pauser is null.");
			}
		}
		if (_singleOrMultiMine())
		{
			if (!isMulti)
			{
				ChangeWeaponReal(_weaponManager.CurrentWeaponIndex, false);
			}
			else
			{
				ChangeWeaponReal((isHunger || WeaponManager.WeaponUsedCategory < 0 || _weaponManager.playerWeapons.Count <= WeaponManager.WeaponUsedCategory) ? (_weaponManager.playerWeapons.Count - 1) : WeaponManager.WeaponUsedCategory, false);
			}
			_weaponManager.myGun = base.gameObject;
			if (_weaponManager.currentWeaponSounds != null)
			{
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Reload")].layer = 1;
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().Stop();
			}
		}
		if (isMulti && isMine)
		{
			string _nameFilter = FilterBadWorld.FilterString(Defs.GetPlayerNameOrDefault());
			if (isInet)
			{
				photonView.RPC("SetNickName", PhotonTargets.AllBuffered, _nameFilter);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("SetNickName", PhotonTargets.AllBuffered, _nameFilter);
			}
		}
		CurrentBaseArmor = 0f;
		CurHealth = MaxPlayerHealth;
		if (!isMulti || isMine)
		{
			Wear.RenewCurArmor(TierOrRoomTier((!(ExpController.Instance != null)) ? (ExpController.LevelsForTiers.Length - 1) : ExpController.Instance.OurTier));
			string armorEquipped = Storager.getString(Defs.ArmorEquppedSN, false);
			if (_actionsForPurchasedItems.ContainsKey(armorEquipped))
			{
				_actionsForPurchasedItems[armorEquipped](armorEquipped);
				Storager.setString(Defs.ArmorEquppedSN, Defs.ArmorNoneEqupped, false);
			}
			if (Storager.getInt(Defs.AmmoBoughtSN, false) == 1)
			{
				if (_actionsForPurchasedItems.ContainsKey("bigammopack"))
				{
					_actionsForPurchasedItems["bigammopack"]("bigammopack");
				}
				Storager.setInt(Defs.AmmoBoughtSN, 0, false);
			}
		}
		if (_singleOrMultiMine())
		{
			StartCoroutine(GetHardwareKeysInput());
			SetLayerRecursively(mechGunAnimation.gameObject, 9);
			if (false)
			{
				UnityEngine.Object videoRecordingPrefab = Resources.Load("VideoRecordingPanel");
				GameObject videoRecordingPanel = UnityEngine.Object.Instantiate(videoRecordingPrefab, Vector3.zero, Quaternion.identity) as GameObject;
				if (videoRecordingPrefab == null)
				{
					Debug.LogError("videoRecordingPrefab == null");
				}
				if (videoRecordingPanel != null)
				{
					videoRecordingPanel.transform.parent = inGameGUI.interfacePanel.transform;
					videoRecordingPanel.AddComponent<VideoRecordingController>();
				}
				else
				{
					Debug.LogError("videoRecordingPanel != null");
				}
			}
			inGameGUI.health = () => (!isMechActive) ? CurHealth : liveMech;
			inGameGUI.armor = () => curArmor;
			inGameGUI.killsToMaxKills = () => myScoreController.currentScore.ToString();
			inGameGUI.timeLeft = delegate
			{
				float num3;
				if (isHunger)
				{
					if (hungerGameController == null)
					{
						hungerGameController = HungerGameController.Instance;
					}
					num3 = ((!(hungerGameController != null)) ? 0f : hungerGameController.gameTimer);
				}
				else
				{
					num3 = (float)TimeGameController.sharedController.timerToEndMatch;
				}
				if (num3 < 0f)
				{
					num3 = 0f;
				}
				return Mathf.FloorToInt(num3 / 60f) + ":" + ((Mathf.FloorToInt(num3 - (float)(Mathf.FloorToInt(num3 / 60f) * 60)) >= 10) ? string.Empty : "0") + Mathf.FloorToInt(num3 - (float)(Mathf.FloorToInt(num3 / 60f) * 60));
			};
			AddButtonHandlers();
			ShopNGUIController.sharedShop.SetGearCatEnabled(!Defs.isTrainingFlag);
			ShopNGUIController.sharedShop.buyAction = PurchaseSuccessful;
			ShopNGUIController.sharedShop.equipAction = delegate
			{
				ChangeWeaponReal(_weaponManager.CurrentWeaponIndex, false);
			};
			ShopNGUIController.sharedShop.activatePotionAction = delegate(string potion)
			{
				Storager.setInt(potion, Storager.getInt(potion, false) - 1, false);
				PotionsController.sharedController.ActivatePotion(potion, this, new Dictionary<string, object>());
			};
			ShopNGUIController.sharedShop.resumeAction = delegate
			{
				if (base.gameObject != null)
				{
					SetInApp();
					if (inAppOpenedFromPause)
					{
						inAppOpenedFromPause = false;
						if (inGameGUI != null && inGameGUI.pausePanel != null)
						{
							inGameGUI.pausePanel.SetActive(true);
							PauseNGUIController component = inGameGUI.pausePanel.GetComponent<PauseNGUIController>();
							if (component != null && component.settingsPanel != null)
							{
								component.settingsPanel.SetActive(true);
							}
						}
						ExperienceController.sharedController.isShowRanks = true;
					}
					else
					{
						SetPause(true);
					}
				}
				else
				{
					ShopNGUIController.GuiActive = false;
				}
			};
			ShopNGUIController.sharedShop.wearEquipAction = delegate(ShopNGUIController.CategoryNames category, string unequippedItem, string equippedItem)
			{
				if (!BonusEffectForArmorWorksInThisMatch)
				{
					float num = Wear.MaxArmorForItem(FriendsController.sharedController.armorName ?? string.Empty, TierOrRoomTier((!(ExpController.Instance != null)) ? (ExpController.LevelsForTiers.Length - 1) : ExpController.Instance.OurTier)) * (EffectsController.IcnreaseEquippedArmorPercentage - 1f);
					float num2 = 0f;
					BonusEffectForArmorWorksInThisMatch = (double)(num + num2) > 0.001;
				}
				if (!ArmorBonusGiven)
				{
					ArmorBonusGiven = (double)EffectsController.ArmorBonus > 0.001;
					CurrentBaseArmor += EffectsController.ArmorBonus;
				}
				if (category == ShopNGUIController.CategoryNames.CapesCategory && isMulti)
				{
					mySkinName.SetCape();
				}
				if (category == ShopNGUIController.CategoryNames.HatsCategory)
				{
					if (isMulti)
					{
						mySkinName.SetHat();
					}
					if (equippedItem != null && unequippedItem != null && (!Wear.NonArmorHat(equippedItem) || !Wear.NonArmorHat(unequippedItem)))
					{
						CurrentBaseArmor = 0f;
					}
				}
				if (category == ShopNGUIController.CategoryNames.BootsCategory && isMulti)
				{
					mySkinName.SetBoots();
				}
				if (category == ShopNGUIController.CategoryNames.ArmorCategory)
				{
					if (isMulti)
					{
						mySkinName.SetArmor();
					}
					CurrentBaseArmor = 0f;
				}
				SendEffectsRpcs();
			};
			ShopNGUIController.sharedShop.wearUnequipAction = delegate(ShopNGUIController.CategoryNames category, string unequippedItem)
			{
				if (category == ShopNGUIController.CategoryNames.CapesCategory && isMulti)
				{
					mySkinName.SetCape();
				}
				if (category == ShopNGUIController.CategoryNames.HatsCategory)
				{
					if (isMulti)
					{
						mySkinName.SetHat();
					}
					if (!Wear.NonArmorHat(unequippedItem))
					{
						CurrentBaseArmor = 0f;
					}
				}
				if (category == ShopNGUIController.CategoryNames.BootsCategory && isMulti)
				{
					mySkinName.SetBoots();
				}
				if (category == ShopNGUIController.CategoryNames.ArmorCategory)
				{
					if (isMulti)
					{
						mySkinName.SetArmor();
					}
					CurrentBaseArmor = 0f;
				}
				SendEffectsRpcs();
			};
			SendEffectsRpcs();
			ShopNGUIController.ShowArmorChanged += HandleShowArmorChanged;
		}
		if (PlayerPrefs.GetInt("StartAfterDisconnect") == 1 && Defs.isMulti && Defs.isInet && photonView.isMine)
		{
			countKills = GlobalGameController.CountKills;
			myScoreController.currentScore = GlobalGameController.Score;
			if (countKills < 0)
			{
				countKills = 0;
			}
			CurHealth = GlobalGameController.healthMyPlayer;
			curArmor = GlobalGameController.armorMyPlayer;
			myPlayerTransform.position = GlobalGameController.posMyPlayer;
			myPlayerTransform.rotation = GlobalGameController.rotMyPlayer;
			PlayerPrefs.SetInt("StartAfterDisconnect", 0);
		}
		yield return null;
		if (_singleOrMultiMine())
		{
			PotionsController.sharedController.ReactivatePotions(this, new Dictionary<string, object>());
			string curHat = Storager.getString(Defs.HatEquppedSN, false);
			if (!curHat.Equals(Defs.HatNoneEqupped) && Wear.hatsMethods.ContainsKey(curHat))
			{
				Wear.hatsMethods[curHat].Key(this, new Dictionary<string, object>());
			}
			string curCape = Storager.getString(Defs.CapeEquppedSN, false);
			if (!curCape.Equals(Defs.CapeNoneEqupped) && Wear.capesMethods.ContainsKey(curCape))
			{
				Wear.capesMethods[curCape].Key(this, new Dictionary<string, object>());
			}
			string curBoots = Storager.getString(Defs.BootsEquppedSN, false);
			if (!curBoots.Equals(Defs.BootsNoneEqupped) && Wear.bootsMethods.ContainsKey(curBoots))
			{
				Wear.bootsMethods[curBoots].Key(this, new Dictionary<string, object>());
			}
			string curArmor_ = Storager.getString(Defs.ArmorNewEquppedSN, false);
			if (!curArmor_.Equals(Defs.ArmorNewNoneEqupped) && Wear.armorMethods.ContainsKey(curArmor_))
			{
				Wear.armorMethods[curArmor_].Key(this, new Dictionary<string, object>());
			}
			if (JoystickController.leftJoystick != null)
			{
				JoystickController.leftJoystick.SetJoystickActive(true);
			}
			if (JoystickController.rightJoystick != null)
			{
				JoystickController.rightJoystick.MakeActive();
			}
			if (JoystickController.leftTouchPad != null)
			{
				JoystickController.leftTouchPad.SetJoystickActive(true);
			}
		}
		if (isMulti && myTable != null)
		{
			_skin = myTable.GetComponent<NetworkStartTable>().mySkin;
			if (_skin != null)
			{
				GameObject _obj = myPlayerTransform.gameObject;
				SetTextureRecursivelyFrom(_obj, _obj.GetComponent<SkinName>().playerGameObject.GetComponent<Player_move_c>()._skin, GetStopObjFromPlayer(_obj));
			}
		}
	}

	private void HandleShowArmorChanged()
	{
		if (isMulti)
		{
			mySkinName.SetArmor();
			mySkinName.SetHat();
		}
	}

	private void SendEffectsRpcs()
	{
		if (!isMulti)
		{
			return;
		}
		string text = Json.Serialize(EffectsController.ReloadAnimationSpeed ?? WeaponManager.DefaultReloadSpeeds);
		if (!isInet)
		{
			base.GetComponent<PhotonView>().RPC("SetIgnoreHeadshotChance", PhotonTargets.OthersBuffered, EffectsController.ChanceToIgnoreHeadshot);
			if (text != null)
			{
				base.GetComponent<PhotonView>().RPC("SetRelodAnimtionSpeeds", PhotonTargets.OthersBuffered, text);
			}
		}
		else
		{
			photonView.RPC("SetIgnoreHeadshotChance", PhotonTargets.OthersBuffered, EffectsController.ChanceToIgnoreHeadshot);
			if (text != null)
			{
				photonView.RPC("SetRelodAnimtionSpeeds", PhotonTargets.OthersBuffered, text);
			}
		}
	}

	[PunRPC]
	private void SetIgnoreHeadshotChance(float _chanceToIgnoreHS)
	{
		_chanceToIgnoreHeadshot = _chanceToIgnoreHS;
	}

	[PunRPC]
	private void SetRelodAnimtionSpeeds(string reloadAnimationSpeedsJson)
	{
		object obj = Json.Deserialize(reloadAnimationSpeedsJson ?? string.Empty);
		if (obj == null)
		{
			return;
		}
		List<object> list = obj as List<object>;
		if (list == null || list.Count < 5 || _reloadAnimationSpeed == null || _reloadAnimationSpeed.Count < 5)
		{
			return;
		}
		for (int i = 0; i < 5; i++)
		{
			try
			{
				float result = 1f;
				string s = list[i].ToString();
				float.TryParse(s, out result);
				_reloadAnimationSpeed[i] = result;
			}
			catch (Exception message)
			{
				if (Application.isEditor)
				{
					Debug.Log(message);
				}
			}
		}
	}

	void playHitSound(int _typeKills, int idKiller)
	{
		if (!myKillAssists.Contains(idKiller))
		{
			GameObject.FindGameObjectWithTag("BackgroundMusic").GetComponent<AudioSource>().PlayOneShot((_typeKills != 2) ? hitmarkerSound : headShotSound, 1f);
		}
	}

	void playHitSound(int _typeKills, PhotonView idKiller)
	{
		if (!myKillAssistsLocal.Contains(idKiller))
		{
			GameObject.FindGameObjectWithTag("BackgroundMusic").GetComponent<AudioSource>().PlayOneShot((_typeKills != 2) ? hitmarkerSound : headShotSound, 1f);
		}
	}

	void playKillSound(int _typeKills, PhotonView idKiller)
	{
		if (!myKillAssistsLocal.Contains(idKiller))
		{
			GameObject.FindGameObjectWithTag("BackgroundMusic").GetComponent<AudioSource>().PlayOneShot((_typeKills != 2) ? killSound : headshotkillSound, 1f);
		}
	}

	void playKillSound(int _typeKills, int idKiller)
	{
		if (!myKillAssists.Contains(idKiller))
		{
			GameObject.FindGameObjectWithTag("BackgroundMusic").GetComponent<AudioSource>().PlayOneShot((_typeKills != 2) ? killSound : headshotkillSound, 1f);
		}
	}

	public void UpdateSkin()
	{
		if (!isMulti)
		{
			_skin = SkinsController.currentSkinForPers;
			_skin.filterMode = FilterMode.Point;
			GameObject obj = myPlayerTransform.gameObject;
			SetTextureRecursivelyFrom(obj, _skin, GetStopObjFromPlayer(obj));
		}
	}

	public void SetIDMyTable(string _id)
	{
		myTableId = _id;
		Invoke("SetIDMyTableInvoke", 0.1f);
	}

	[Obfuscation(Exclude = true)]
	private void SetIDMyTableInvoke()
	{
		base.GetComponent<PhotonView>().RPC("SetIDMyTableRPC", PhotonTargets.AllBuffered, myTableId);
	}

	[PunRPC]
	private void SetIDMyTableRPC(string _id)
	{
		myTableId = _id;
		GameObject[] array = GameObject.FindGameObjectsWithTag("NetworkTable");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (gameObject.GetComponent<PhotonView>().viewID.ToString().Equals(_id))
			{
				myTable = gameObject;
				setMyTamble(myTable);
			}
		}
	}

	[PunRPC]
	public void SetNickName(string _nickName)
	{
		photonView = PhotonView.Get(this);
		mySkinName.NickName = _nickName;
		if (!isMine && _label == null && NickLabelStack.sharedStack != null)
		{
			_label = NickLabelStack.sharedStack.GetNextCurrentLabel().gameObject;
			myNickLabelController = _label.GetComponent<NickLabelController>();
			int layer = LayerMask.NameToLayer("NickLabel");
			_label.layer = layer;
			Transform[] componentsInChildren = _label.GetComponentsInChildren<Transform>(true);
			foreach (Transform transform in componentsInChildren)
			{
				transform.gameObject.layer = layer;
			}
			myNickLabelController.target = myTransform;
			myNickLabelController.playerScript = this;
			myNickLabelController.nickLabel.text = _nickName;
			Transform transform2 = myNickLabelController.rankTexture.transform;
			transform2.localPosition = new Vector3((float)(-myNickLabelController.nickLabel.width) * 0.5f - 20f, transform2.localPosition.y, transform2.localPosition.z);
			myNickLabelController.isTurrerLabel = false;
			myNickLabelController.StartShow();
		}
	}

	public bool _singleOrMultiMine()
	{
		return !isMulti || isMine;
	}

	private void OnDestroy()
	{
		if (Initializer.players.Contains(this))
		{
			Initializer.players.Remove(this);
		}
		if (Initializer.bluePlayers.Contains(this))
		{
			Initializer.bluePlayers.Remove(this);
		}
		if (Initializer.redPlayers.Contains(this))
		{
			Initializer.redPlayers.Remove(this);
		}
		if (Defs.isCapturePoints && CapturePointController.sharedController != null)
		{
			for (int i = 0; i < CapturePointController.sharedController.basePointControllers.Length; i++)
			{
				if (CapturePointController.sharedController.basePointControllers[i].capturePlayers.Contains(this))
				{
					CapturePointController.sharedController.basePointControllers[i].capturePlayers.Remove(this);
				}
			}
		}
		if (_weaponPopularityCacheIsDirty)
		{
			Statistics.Instance.SaveWeaponPopularity();
			_weaponPopularityCacheIsDirty = false;
		}
		if (!isMulti)
		{
			ShopNGUIController.sharedShop.onEquipSkinAction = null;
		}
		if (_singleOrMultiMine())
		{
			if (ShopNGUIController.sharedShop != null)
			{
				ShopNGUIController.sharedShop.resumeAction = null;
			}
			if ((bool)inGameGUI && (bool)inGameGUI.gameObject)
			{
				if (!isHunger && !Defs.isRegimVidosDebug)
				{
					UnityEngine.Object.Destroy(inGameGUI.gameObject);
				}
				else
				{
					inGameGUI.topAnchor.SetActive(false);
					inGameGUI.leftAnchor.SetActive(false);
					inGameGUI.rightAnchor.SetActive(false);
					inGameGUI.joystickContainer.SetActive(false);
					inGameGUI.bottomAnchor.SetActive(false);
					inGameGUI.fastShopPanel.SetActive(false);
					inGameGUI.swipeWeaponPanel.gameObject.SetActive(false);
					inGameGUI.turretPanel.SetActive(false);
					for (int j = 0; j < 3; j++)
					{
						if (inGameGUI.messageAddScore[j].gameObject.activeSelf)
						{
							inGameGUI.messageAddScore[j].gameObject.SetActive(false);
						}
					}
				}
			}
			GameObject gameObject = GameObject.FindGameObjectWithTag("ChatViewer");
			if (gameObject != null)
			{
				gameObject.GetComponent<ChatViewrController>().closeChat();
			}
			if (coinsShop.thisScript != null && coinsShop.thisScript.enabled)
			{
				coinsShop.ExitFromShop(false);
			}
			coinsPlashka.hidePlashka();
		}
		if (!isMulti || isMine)
		{
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				AmazonIAPManager.purchaseSuccessfulEvent -= HandlePurchaseSuccessful;
			}
			else
			{
				GoogleIABManager.purchaseSucceededEvent -= purchaseSuccessful;
			}
		}
		if (_singleOrMultiMine() || (_weaponManager != null && _weaponManager.myPlayer == myPlayerTransform.gameObject))
		{
			if (_pauser != null && (bool)_pauser && _pauser.paused)
			{
				_pauser.paused = !_pauser.paused;
				Time.timeScale = 1f;
				AddButtonHandlers();
			}
			GameObject gameObject2 = GameObject.FindGameObjectWithTag("DamageFrame");
			if (gameObject2 != null)
			{
				UnityEngine.Object.Destroy(gameObject2);
			}
			RemoveButtonHandelrs();
			ShopNGUIController.sharedShop.buyAction = null;
			ShopNGUIController.sharedShop.equipAction = null;
			ShopNGUIController.sharedShop.activatePotionAction = null;
			ShopNGUIController.sharedShop.resumeAction = null;
			ShopNGUIController.sharedShop.wearEquipAction = null;
			ShopNGUIController.sharedShop.wearUnequipAction = null;
			ZombieCreator.BossKilled -= CheckTimeCondition;
			ShopNGUIController.ShowArmorChanged -= HandleShowArmorChanged;
		}
	}

	public bool HasFreezerFireSubscr()
	{
		return this.FreezerFired != null;
	}

	private void _SetGunFlashActive(bool state)
	{
		WeaponSounds weaponSounds = ((!isMechActive) ? _weaponManager.currentWeaponSounds : mechWeaponSounds);
		if (weaponSounds.isDoubleShot)
		{
			if (!_weaponManager.currentWeaponSounds.isMelee)
			{
			weaponSounds.gunFlashDouble[numShootInDoubleShot - 1].GetChild(0).gameObject.SetActive(state);
			}
			if (state)
			{
				return;
			}
		}
		if (state && GunFlash != null && _weaponManager.currentWeaponSounds.railgun)
		{
			WeaponManager.AddRay(GunFlash.gameObject.transform.parent.position, GunFlash.gameObject.transform.parent.parent.forward, GunFlash.gameObject.transform.parent.parent.gameObject.name.Replace("(Clone)", string.Empty));
		}
		if (GunFlash != null && !_weaponManager.currentWeaponSounds.isMelee && (!isZooming || (isZooming && !state)))
		{
			WeaponManager.SetGunFlashActive(GunFlash.gameObject, state);
		}
	}

	[PunRPC]
	private void ReloadGun()
	{
		if (myTransform.childCount != 0)
		{
			WeaponSounds component = myTransform.GetChild(0).GetComponent<WeaponSounds>();
			component.animationObject.GetComponent<Animation>().Play(myCAnim("Reload"));
			component.animationObject.GetComponent<Animation>()[myCAnim("Reload")].speed = _reloadAnimationSpeed[component.categoryNabor - 1];
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(component.reload);
			}
		}
	}

	private void Reload()
	{
		if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.currentWeaponSounds != null && inGameGUI != null)
		{
			if (WeaponManager.sharedManager.currentWeaponSounds.ammoInClip > 1)
			{
				inGameGUI.ShowCircularIndicatorOnReload(WeaponManager.sharedManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Reload")].length / EffectsController.ReloadAnimationSpeed[WeaponManager.sharedManager.currentWeaponSounds.categoryNabor - 1]);
			}
			else
			{
				WeaponManager.sharedManager.ReloadAmmo();
			}
		}
		WeaponManager.sharedManager.Reload();
	}

	[Obfuscation(Exclude = true)]
	public void ReloadPressed()
	{
		if (isGrenadePress || isReloading || (_weaponManager.currentWeaponSounds.isMelee && !_weaponManager.currentWeaponSounds.isShotMelee))
		{
			return;
		}
		if (isZooming)
		{
			ZoomPress();
		}
		if (_weaponManager.CurrentWeaponIndex < 0 || _weaponManager.CurrentWeaponIndex >= _weaponManager.playerWeapons.Count || ((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).currentAmmoInBackpack <= 0 || ((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).currentAmmoInClip == _weaponManager.currentWeaponSounds.ammoInClip)
		{
			return;
		}
		Reload();
		if (_weaponManager.currentWeaponSounds.isShotMelee)
		{
			return;
		}
		if (isMulti)
		{
			if (!isInet)
			{
				base.GetComponent<PhotonView>().RPC("ReloadGun", PhotonTargets.Others);
			}
			else
			{
				photonView.RPC("ReloadGun", PhotonTargets.Others);
			}
		}
		if (Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().PlayOneShot(_weaponManager.currentWeaponSounds.reload);
		}
		if (JoystickController.rightJoystick != null)
		{
			JoystickController.rightJoystick.HasAmmo();
			if (inGameGUI != null)
			{
				inGameGUI.BlinkNoAmmo(0);
			}
		}
		else
		{
			Debug.Log("JoystickController.rightJoystick = null");
		}
	}

	public void RunTurret()
	{
		if (Defs.isTurretWeapon)
		{
			Storager.setInt(GearManager.Turret, Storager.getInt(GearManager.Turret, false) - 1, false);
			PotionsController.sharedController.ActivatePotion(GearManager.Turret, this, new Dictionary<string, object>());
			currentTurret.transform.parent = null;
			currentTurret.GetComponent<TurretController>().StartTurret();
			ChangeWeapon(currentWeaponBeforeTurret, false);
		}
	}

	public void CancelTurret()
	{
		ChangeWeapon(currentWeaponBeforeTurret, false);
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				PhotonNetwork.Destroy(currentTurret);
				return;
			}
			PhotonNetwork.RemoveRPCs(currentTurret.GetComponent<PhotonView>());
			PhotonNetwork.Destroy(currentTurret);
		}
		else
		{
			UnityEngine.Object.Destroy(currentTurret);
		}
	}

	private int GetNumShootInDouble()
	{
		numShootInDoubleShot++;
		if (numShootInDoubleShot >= _weaponManager.currentWeaponSounds.numOfMaximumShootDouble)
		{
			numShootInDoubleShot = 1;
		}
		return numShootInDoubleShot;
	}

	public void sendImDeath(string _name)
	{
		if (!isInet)
		{
			base.GetComponent<PhotonView>().RPC("imDeath", PhotonTargets.All, _name);
		}
		else
		{
			photonView.RPC("imDeath", PhotonTargets.All, _name);
		}
		_killerInfo.isSuicide = true;
	}

	public void setInString(string nick)
	{
		if (!(_weaponManager == null) && !(_weaponManager.myPlayer == null))
		{
			_weaponManager.myPlayer.GetComponent<SkinName>().playerMoveC.AddSystemMessage(string.Format("{0} {1}", nick, LocalizationStore.Get("Key_0995")));
		}
	}

	public void setOutString(string nick)
	{
		if (!(_weaponManager == null) && !(_weaponManager.myPlayer == null))
		{
			_weaponManager.myPlayerMoveC.AddSystemMessage(string.Format("{0} {1}", nick, LocalizationStore.Get("Key_0996")));
		}
	}

	[PunRPC]
	public void imDeath(string _name)
	{
		if (!(_weaponManager == null) && !(_weaponManager.myPlayer == null))
		{
			_weaponManager.myPlayerMoveC.AddSystemMessage(_name, 1);
		}
	}

	public void AddSystemMessage(string _nick1, string _message2, string _nick2, string _message = null)
	{
		killedSpisok[2][0] = killedSpisok[1][0];
		killedSpisok[2][1] = killedSpisok[1][1];
		killedSpisok[2][2] = killedSpisok[1][2];
		killedSpisok[2][3] = killedSpisok[1][3];
		killedSpisok[1][0] = killedSpisok[0][0];
		killedSpisok[1][1] = killedSpisok[0][1];
		killedSpisok[1][2] = killedSpisok[0][2];
		killedSpisok[1][3] = killedSpisok[0][3];
		killedSpisok[0][0] = _nick1;
		killedSpisok[0][1] = _message2;
		killedSpisok[0][2] = _nick2;
		killedSpisok[0][3] = _message;
		timerShow[2] = timerShow[1];
		timerShow[1] = timerShow[0];
		timerShow[0] = 3f;
	}

	public void AddSystemMessage(string nick1, int _typeKills)
	{
		AddSystemMessage(nick1, iconShotName[_typeKills], string.Empty);
	}

	public void AddSystemMessage(string nick1, int _typeKills, string nick2, string iconWeapon = null)
	{
		AddSystemMessage(nick1, iconShotName[_typeKills], nick2, iconWeapon);
	}

	public void AddSystemMessage(string _message)
	{
		AddSystemMessage(_message, string.Empty, string.Empty);
	}

	[PunRPC]
	public void SendSystemMessegeFromFlagDroppedRPC(bool isBlueFlag, string nick)
	{
		if (WeaponManager.sharedManager.myPlayer != null)
		{
			if (isBlueFlag)
			{
				WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(string.Format("{0} {1}", nick, LocalizationStore.Get("Key_0997")));
			}
			else
			{
				WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(string.Format("{0} {1}", nick, LocalizationStore.Get("Key_0998")));
			}
		}
	}

	public void SendSystemMessegeFromFlagReturned(bool isBlueFlag)
	{
		photonView.RPC("SendSystemMessegeFromFlagReturnedRPC", PhotonTargets.All, isBlueFlag);
	}

	[PunRPC]
	public void SendSystemMessegeFromFlagReturnedRPC(bool isBlueFlag)
	{
		if (WeaponManager.sharedManager.myPlayer != null)
		{
			if (isBlueFlag)
			{
				WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(LocalizationStore.Get("Key_0999"));
			}
			else
			{
				WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(LocalizationStore.Get("Key_1000"));
			}
		}
	}

	[PunRPC]
	public void SendSystemMessegeFromFlagCaptureRPC(bool isBlueFlag, string nick)
	{
		if (!(WeaponManager.sharedManager.myPlayer != null))
		{
			return;
		}
		bool flag = WeaponManager.sharedManager.myPlayerMoveC.myCommand == 1;
		if (flag == isBlueFlag)
		{
			WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(string.Format("{0} {1}", nick, LocalizationStore.Get("Key_1001")));
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(flagLostClip);
			}
		}
		else
		{
			WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(LocalizationStore.Get("Key_1002"));
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(flagGetClip);
			}
		}
	}

	[PunRPC]
	public void SendSystemMessegeFromFlagAddScoreRPC(bool isCommandBlue, string nick)
	{
		if (WeaponManager.sharedManager.myPlayer != null)
		{
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot((isCommandBlue != (_weaponManager.myPlayerMoveC.myCommand == 1)) ? flagScoreEnemyClip : flagScoreMyCommandClip);
			}
			isCaptureFlag = false;
			WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(nick, 5);
		}
	}

	[PunRPC]
	private void CountKillsCommandSynch(int _blue, int _red)
	{
		GlobalGameController.countKillsBlue = _blue;
		GlobalGameController.countKillsRed = _red;
	}

	[PunRPC]
	private void plusCountKillsCommand(int _command)
	{
		Debug.Log("plusCountKillsCommand: " + _command);
		if (_command == 1)
		{
			if ((bool)_weaponManager && (bool)_weaponManager.myPlayer)
			{
				_weaponManager.myPlayerMoveC.countKillsCommandBlue++;
			}
			else
			{
				GlobalGameController.countKillsBlue++;
			}
		}
		if (_command == 2)
		{
			if ((bool)_weaponManager && (bool)_weaponManager.myPlayer)
			{
				_weaponManager.myPlayerMoveC.countKillsCommandRed++;
			}
			else
			{
				GlobalGameController.countKillsRed++;
			}
		}
	}

	public void SendMySpotEvent()
	{
		countMySpotEvent++;
		if (countMySpotEvent == 1)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.mySpotPoint);
		}
		if (countMySpotEvent == 2)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.unstoppablePoint);
		}
		if (countMySpotEvent >= 3)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.monopolyPoint);
		}
	}

	private void ResetMySpotEvent()
	{
		countMySpotEvent = 0;
	}

	public void SendHouseKeeperEvent()
	{
		countHouseKeeperEvent++;
		if (countHouseKeeperEvent == 1)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.houseKeeperPoint);
		}
		if (countHouseKeeperEvent == 3)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.defenderPoint);
		}
		if (countHouseKeeperEvent == 5)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.guardianPoint);
		}
		if (countHouseKeeperEvent == 10)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.oneManArmyPoint);
		}
	}

	private void ResetHouseKeeperEvent()
	{
		countHouseKeeperEvent = 0;
	}

	public void addMultyKill()
	{
		multiKill++;
		if (multiKill <= 1)
		{
			return;
		}
		PlayerEventScoreController.ScoreEvent scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill6;
		switch (multiKill)
		{
		case 2:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill2;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		case 3:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill3;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		case 4:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill4;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		case 5:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill5;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		case 6:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill6;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		case 10:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill10;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		case 20:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill20;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		case 50:
			scoreEvent = PlayerEventScoreController.ScoreEvent.multyKill50;
			myScoreController.AddScoreOnEvent(scoreEvent);
			break;
		}
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				photonView.RPC("ShowMultyKillRPC", PhotonTargets.Others, multiKill);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("ShowMultyKillRPC", PhotonTargets.Others, multiKill);
			}
		}
	}

	[PunRPC]
	public void ShowMultyKillRPC(int countMulty)
	{
		multiKill = countMulty;
		if (myNickLabelController != null)
		{
			myNickLabelController.ShowMultyKill(countMulty);
		}
	}

	public void resetMultyKill()
	{
		multiKill = 0;
		counterMeleeSerials = 0;
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				photonView.RPC("ShowMultyKillRPC", PhotonTargets.Others, 0);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("ShowMultyKillRPC", PhotonTargets.Others, 0);
			}
		}
	}

	public void ImKill(PhotonView idKiller, int _typeKill)
	{
		countKills++;
		GlobalGameController.CountKills = countKills;
		CheckRookieKillerAchievement();
		addMultyKill();
		if (isCompany)
		{
			if (myCommand == 1)
			{
				countKillsCommandBlue++;
				if (isInet)
				{
					photonView.RPC("plusCountKillsCommand", PhotonTargets.Others, 1);
				}
				else
				{
					base.GetComponent<PhotonView>().RPC("plusCountKillsCommand", PhotonTargets.Others, 1);
				}
			}
			if (myCommand == 2)
			{
				countKillsCommandRed++;
				if (isInet)
				{
					photonView.RPC("plusCountKillsCommand", PhotonTargets.Others, 2);
				}
				else
				{
					base.GetComponent<PhotonView>().RPC("plusCountKillsCommand", PhotonTargets.Others, 2);
				}
			}
		}
		_weaponManager.myTable.GetComponent<NetworkStartTable>().CountKills = countKills;
		_weaponManager.myTable.GetComponent<NetworkStartTable>().SynhCountKills();
	}

	public void ImKill(int idKiller, int _typeKill)
	{
		if (WeaponManager.sharedManager == null)
		{
			Debug.LogWarning("WeaponManager.sharedManager == null");
		}
		else
		{
			WeaponSounds currentWeaponSounds = WeaponManager.sharedManager.currentWeaponSounds;
			if (currentWeaponSounds == null)
			{
				Debug.LogWarning("ws == null");
			}
			else
			{
				Initializer initializer = UnityEngine.Object.FindObjectOfType<Initializer>();
				if (initializer == null)
				{
					Debug.LogWarning("initializer == null");
				}
				else
				{
					string weapon = ((_typeKill != 6) ? currentWeaponSounds.shopName : "GRENADE");
					initializer.IncrementKillCountForWeapon(weapon);
				}
			}
		}
		countKills++;
		GlobalGameController.CountKills = countKills;
		CheckRookieKillerAchievement();
		addMultyKill();
		if (isCompany)
		{
			if (myCommand == 1)
			{
				countKillsCommandBlue++;
				if (isInet)
				{
					photonView.RPC("plusCountKillsCommand", PhotonTargets.Others, 1);
				}
				else
				{
					base.GetComponent<PhotonView>().RPC("plusCountKillsCommand", PhotonTargets.Others, 1);
				}
			}
			if (myCommand == 2)
			{
				countKillsCommandRed++;
				if (isInet)
				{
					photonView.RPC("plusCountKillsCommand", PhotonTargets.Others, 2);
				}
				else
				{
					base.GetComponent<PhotonView>().RPC("plusCountKillsCommand", PhotonTargets.Others, 2);
				}
			}
		}
		_weaponManager.myTable.GetComponent<NetworkStartTable>().CountKills = countKills;
		_weaponManager.myTable.GetComponent<NetworkStartTable>().SynhCountKills();
		if (isHunger && GameObject.FindGameObjectsWithTag("Player").Length == 1)
		{
			if (Defs.isHunger)
			{
				int val = Storager.getInt(Defs.RatingHunger, false) + 1;
				Storager.setInt(Defs.RatingHunger, val, false);
			}
			photonView.RPC("pobedaPhoton", PhotonTargets.All, idKiller, myCommand);
			int num = Storager.getInt("Rating", false) + 1;
			Storager.setInt("Rating", num, false);
			if (FriendsController.sharedController != null)
			{
				FriendsController.sharedController.TryIncrementWinCountTimestamp();
			}
			FriendsController.sharedController.wins.Value = num;
			FriendsController.sharedController.SendOurData(false);
			_weaponManager.myTable.GetComponent<NetworkStartTable>().isIwin = true;
		}
	}

	private void CheckRookieKillerAchievement()
	{
		int num = oldKilledPlayerCharactersCount + 1;
		if (num <= 15)
		{
			Storager.setInt("KilledPlayerCharactersCount", num, false);
		}
		oldKilledPlayerCharactersCount = num;
		if (!Social.localUser.authenticated || Storager.hasKey("RookieKillerAchievmentCompleted") || num < 15)
		{
			return;
		}
		if (BuildSettings.BuildTarget == BuildTarget.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
		Storager.setInt("RookieKillerAchievmentCompleted", 1, false);
	}

	public void AddScoreDuckHunt()
	{
		if (Defs.isInet)
		{
			photonView.RPC("AddScoreDuckHuntRPC", PhotonTargets.All);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("AddScoreDuckHuntRPC", PhotonTargets.All);
		}
	}

	[PunRPC]
	public void AddScoreDuckHuntRPC()
	{
		if (isMine)
		{
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.duckHunt);
		}
	}

	[PunRPC]
	public void Killed(PhotonView idKiller, int _typeKill, int _typeWeapon, string weaponName)
	{
		ImKilled(myPlayerTransform.position, myPlayerTransform.rotation, _typeWeapon);
		if (_weaponManager == null || _weaponManager.myPlayer == null)
		{
			return;
		}
		string nick = string.Empty;
		string empty = string.Empty;
		empty = mySkinName.NickName;
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (!gameObject.GetComponent<PhotonView>().viewID.Equals(idKiller))
			{
				playKillSound(_typeKill, idKiller);
				continue;
			}
			SkinName component = gameObject.GetComponent<SkinName>();
			Player_move_c playerMoveC = component.playerMoveC;
			nick = gameObject.GetComponent<SkinName>().NickName;
			if (isMine && Defs.isJetpackEnabled && !myPlayerTransform.GetComponent<CharacterController>().isGrounded)
			{
				playerMoveC.AddScoreDuckHunt();
			}
			if ((bool)_weaponManager && gameObject == _weaponManager.myPlayer)
			{
				PlayerScoreController playerScoreController = playerMoveC.myScoreController;
				int @event;
				switch (_typeKill)
				{
				case 6:
					@event = 45;
					break;
				case 9:
					@event = 8;
					break;
				case 2:
					@event = 10;
					break;
				case 3:
					@event = 46;
					break;
				default:
					@event = 9;
					break;
				}
				playerScoreController.AddScoreOnEvent((PlayerEventScoreController.ScoreEvent)@event);
				if (Defs.isJetpackEnabled && !_weaponManager.myPlayer.GetComponent<CharacterController>().isGrounded && _typeKill != 6 && _typeKill != 8)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.deathFromAbove);
				}
				if (playerMoveC.isRocketJump && _typeKill != 6 && _typeKill != 8)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.rocketJumpKill);
				}
				if (multiKill > 1)
				{
					if (multiKill == 2)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill2);
					}
					else if (multiKill == 3)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill3);
					}
					else if (multiKill == 4)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill4);
					}
					else if (multiKill == 5)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill5);
					}
					else if (multiKill < 10)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill6);
					}
					else if (multiKill < 20)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill10);
					}
					else if (multiKill < 50)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill20);
					}
					else
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill50);
					}
				}
				if (isInvisible)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.invisibleKill);
				}
				if (isPlacemarker)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.revenge);
				}
				if (playerMoveC.myCurrentWeaponSounds.isMelee && !playerMoveC.myCurrentWeaponSounds.isShotMelee && _typeKill != 6 && _typeKill != 8)
				{
					playerMoveC.counterMeleeSerials++;
					if (playerMoveC.counterMeleeSerials == 2)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee2);
					}
					else if (playerMoveC.counterMeleeSerials == 3)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee3);
					}
					else if (playerMoveC.counterMeleeSerials == 5)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee5);
					}
					else if (playerMoveC.counterMeleeSerials == 7)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee7);
					}
					else
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee);
					}
				}
				playerMoveC.ImKill(idKiller, _typeKill);
				if (Equals(_weaponManager.myPlayerMoveC.placemarkerMoveC))
				{
					_weaponManager.myPlayerMoveC.placemarkerMoveC = null;
					isPlacemarker = false;
				}
			}
			if (isMine)
			{
				playerMoveC.isPlacemarker = true;
				placemarkerMoveC = playerMoveC;
			}
			UpdateKillerInfo(gameObject, _typeKill);
			break;
		}
		if ((bool)_weaponManager && _weaponManager.myPlayer != null)
		{
			_weaponManager.myPlayerMoveC.AddSystemMessage(nick, _typeKill, empty, weaponName);
		}
	}

	[PunRPC]
	public void KilledPhoton(int idKiller, int _typekill)
	{
		KilledPhoton(idKiller, _typekill, string.Empty);
	}

	[PunRPC]
	public void KilledPhoton(int idKiller, int _typekill, string weaponName)
	{
		KilledPhoton(idKiller, _typekill, weaponName, 0);
	}

	[PunRPC]
	public void KilledPhoton(int idKiller, int _typekill, string weaponName, int _typeWeapon)
	{
		ImKilled(myPlayerTransform.position, myPlayerTransform.rotation, _typeWeapon);
		if (_weaponManager == null || _weaponManager.myPlayer == null)
		{
			return;
		}
		string nick = string.Empty;
		string nickName = mySkinName.NickName;
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		for (int i = 0; i < array.Length; i++)
		{
			if (!(array[i].GetComponent<PhotonView>() != null) || array[i].GetComponent<PhotonView>().viewID != idKiller)
			{
				continue;
			}
			playKillSound(_typekill, idKiller);
			SkinName component = array[i].GetComponent<SkinName>();
			Player_move_c playerMoveC = component.playerMoveC;
			nick = component.NickName;
			if (isMine && Defs.isJetpackEnabled && !myPlayerTransform.GetComponent<CharacterController>().isGrounded)
			{
				playerMoveC.AddScoreDuckHunt();
			}
			if (_weaponManager != null && array[i] == _weaponManager.myPlayer)
			{
				if (isRaiderMyPoint)
				{
					WeaponManager.sharedManager.myPlayerMoveC.SendHouseKeeperEvent();
					isRaiderMyPoint = false;
				}
				if (Defs.isJetpackEnabled && !_weaponManager.myPlayer.GetComponent<CharacterController>().isGrounded && _typekill != 6 && _typekill != 8)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.deathFromAbove);
				}
				if (playerMoveC.isRocketJump && _typekill != 6 && _typekill != 8)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.rocketJumpKill);
				}
				if (playerMoveC.myCurrentWeaponSounds.isMelee && !playerMoveC.myCurrentWeaponSounds.isShotMelee && _typekill != 6 && _typekill != 8)
				{
					playerMoveC.counterMeleeSerials++;
					if (playerMoveC.counterMeleeSerials == 2)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee2);
					}
					else if (playerMoveC.counterMeleeSerials == 3)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee3);
					}
					else if (playerMoveC.counterMeleeSerials == 5)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee5);
					}
					else if (playerMoveC.counterMeleeSerials == 7)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee7);
					}
					else
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.melee);
					}
				}
				if (multiKill > 1)
				{
					if (multiKill == 2)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill2);
					}
					else if (multiKill == 3)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill3);
					}
					else if (multiKill == 4)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill4);
					}
					else if (multiKill == 5)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill5);
					}
					else if (multiKill < 10)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill6);
					}
					else if (multiKill < 20)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill10);
					}
					else if (multiKill < 50)
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill20);
					}
					else
					{
						playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killMultyKill50);
					}
				}
				if (!Defs.isFlag)
				{
					playerMoveC.ImKill(idKiller, _typekill);
				}
				PlayerScoreController playerScoreController = playerMoveC.myScoreController;
				int @event;
				switch (_typekill)
				{
				case 6:
					@event = 45;
					break;
				case 9:
					@event = 8;
					break;
				case 2:
					@event = 10;
					break;
				case 3:
					@event = 46;
					break;
				default:
					@event = 9;
					break;
				}
				playerScoreController.AddScoreOnEvent((PlayerEventScoreController.ScoreEvent)@event);
				if (isInvisible)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.invisibleKill);
				}
				if (isPlacemarker)
				{
					playerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.revenge);
				}
				if (Equals(_weaponManager.myPlayerMoveC.placemarkerMoveC))
				{
					_weaponManager.myPlayerMoveC.placemarkerMoveC = null;
					isPlacemarker = false;
				}
			}
			if (isMine)
			{
				playerMoveC.isPlacemarker = true;
				placemarkerMoveC = playerMoveC;
			}
			UpdateKillerInfo(array[i], _typekill);
			break;
		}
		if ((bool)_weaponManager && _weaponManager.myPlayerMoveC != null)
		{
			_weaponManager.myPlayerMoveC.AddSystemMessage(nick, _typekill, nickName, weaponName);
		}
	}

	private void UpdateKillerInfo(GameObject killer, int killType)
	{
		_killerInfo.isGrenade = killType == 6;
		_killerInfo.isMech = killType == 10;
		_killerInfo.isTurret = killType == 8;
		SkinName component = killer.GetComponent<SkinName>();
		Player_move_c playerMoveC = component.playerMoveC;
		_killerInfo.nickname = component.NickName;
		if (playerMoveC.myTable != null)
		{
			NetworkStartTable component2 = playerMoveC.myTable.GetComponent<NetworkStartTable>();
			int myRanks = component2.myRanks;
			if (myRanks > 0 && myRanks < expController.marks.Length)
			{
				_killerInfo.rankTex = ExperienceController.sharedController.marks[myRanks];
			}
			if (component2.myClanTexture != null)
			{
				_killerInfo.clanLogoTex = component2.myClanTexture;
			}
			_killerInfo.clanName = component2.myClanName;
		}
		_killerInfo.weapon = playerMoveC.currentWeapon;
		_killerInfo.skinTex = playerMoveC._skin;
		_killerInfo.hat = component.currentHat;
		_killerInfo.armor = component.currentArmor;
		_killerInfo.cape = component.currentCape;
		_killerInfo.capeTex = component.currentCapeTex;
		_killerInfo.boots = component.currentBoots;
		_killerInfo.mechUpgrade = playerMoveC.mechUpgrade;
		_killerInfo.turretUpgrade = playerMoveC.turretUpgrade;
		_killerInfo.killerTransform = playerMoveC.myPlayerTransform;
		_killerInfo.healthValue = (_killerInfo.isMech ? ((int)playerMoveC.liveMech) : (((int)playerMoveC.CurHealth - (int)playerMoveC.armorSynch <= 0) ? 1 : ((int)playerMoveC.CurHealth - (int)playerMoveC.armorSynch)));
		_killerInfo.armorValue = (int)playerMoveC.armorSynch;
	}

	[PunRPC]
	public void pobeda(PhotonView idKiller)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (idKiller.Equals(gameObject.GetComponent<PhotonView>().viewID))
			{
				nickPobeditel = gameObject.GetComponent<SkinName>().NickName;
			}
		}
		if ((bool)_weaponManager && (bool)_weaponManager.myTable)
		{
			_weaponManager.myTable.GetComponent<NetworkStartTable>().win(nickPobeditel);
		}
	}

	[PunRPC]
	public void pobedaPhoton(int idKiller, int _command)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (idKiller == gameObject.GetComponent<PhotonView>().viewID)
			{
				nickPobeditel = gameObject.GetComponent<SkinName>().NickName;
			}
		}
		if (_weaponManager != null && _weaponManager.myTable != null)
		{
			_weaponManager.myTable.GetComponent<NetworkStartTable>().win(nickPobeditel, _command);
		}
		else
		{
			Debug.Log("_weaponManager.myTable==null");
		}
	}

	public void ShowBonuseParticle(TypeBonuses _type)
	{
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				photonView.RPC("ShowBonuseParticleRPC", PhotonTargets.Others, (int)_type);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("ShowBonuseParticleRPC", PhotonTargets.Others, (int)_type);
			}
		}
	}

	[PunRPC]
	public void ShowBonuseParticleRPC(int _type)
	{
		Debug.Log("ShowBonuseParticleRPC " + _type);
		if (bonusesParticles.Length >= _type)
		{
			bonusesParticles[_type].ShowParticle();
		}
	}

	[PunRPC]
	public void MinusLiveRPC(PhotonView idKiller, float minus, int _typeKills, int _typeWeapon, PhotonView idTurret, string weaponName)
	{
		if (_typeKills == 2 && !isMine)
		{
			HitParticle currentParticle = HeadShotStackController.sharedController.GetCurrentParticle(false);
			if (currentParticle != null)
			{
				currentParticle.StartShowParticle(myPlayerTransform.position, myPlayerTransform.rotation, false);
			}
		}
		else if (!isMine)
		{
			HitParticle currentParticle2 = HitStackController.sharedController.GetCurrentParticle(false);
			if (currentParticle2 != null)
			{
				currentParticle2.StartShowParticle(myPlayerTransform.position, myPlayerTransform.rotation, false);
			}
		}
		if (Defs.isSoundFX)
		{
			playHitSound(_typeKills, idKiller);
		}
		if (isMine && !isKilled && !isImmortality)
		{
			float num = 0f;
			if (isMechActive)
			{
				MinusMechHealth(minus);
			}
			else
			{
				num = minus - curArmor;
				if (num < 0f)
				{
					curArmor -= minus;
					num = 0f;
				}
				else
				{
					curArmor = 0f;
				}
			}
			if (CurHealth > 0f)
			{
				CurHealth -= num;
				if (CurHealth <= 0f)
				{
					if (myKillAssistsLocal.Contains(idKiller))
					{
						myKillAssistsLocal.Remove(idKiller);
					}
					if (placemarkerMoveC != null)
					{
						placemarkerMoveC.isPlacemarker = false;
					}
					base.GetComponent<PhotonView>().RPC("Killed", PhotonTargets.All, idKiller, _typeKills, _typeWeapon, weaponName);
				}
				else if (!myKillAssistsLocal.Contains(idKiller))
				{
					myKillAssistsLocal.Add(idKiller);
				}
				SendSynhHealth(false);
				Vector3 zero = Vector3.zero;
				if (_typeKills != 8)
				{
					GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
					GameObject[] array2 = array;
					foreach (GameObject gameObject in array2)
					{
						if (gameObject.GetComponent<PhotonView>() != null && gameObject.GetComponent<PhotonView>().viewID.Equals(idKiller))
						{
							zero = gameObject.transform.position;
							ShowDamageDirection(zero);
							break;
						}
					}
				}
				else
				{
					GameObject[] array3 = GameObject.FindGameObjectsWithTag("Turret");
					GameObject[] array4 = array3;
					foreach (GameObject gameObject2 in array4)
					{
						if (gameObject2.GetComponent<PhotonView>() != null && gameObject2.GetComponent<PhotonView>().viewID.Equals(idTurret))
						{
							zero = gameObject2.transform.position;
							ShowDamageDirection(zero);
							break;
						}
					}
				}
			}
		}
		StartCoroutine(Flash(myPlayerTransform.gameObject));
	}

	public void MinusLive(int idKiller, float minus, TypeKills _typeKills, int _typeWeapon = 0, string weaponName = "", int idTurret = 0)
	{
		if (isImmortality)
		{
			return;
		}
		if (isMechActive)
		{
			if (MinusMechHealth(minus))
			{
				WeaponManager.sharedManager.myPlayerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.deadMech);
				minus = 1000f;
			}
		}
		else if (synhHealth > 0f)
		{
			synhHealth -= minus;
			if (synhHealth < 0f)
			{
				minus = 10000f;
				if (isCaptureFlag)
				{
					WeaponManager.sharedManager.myPlayerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.deadWithFlag);
				}
				if (Defs.isCapturePoints && WeaponManager.sharedManager.myPlayerMoveC != null)
				{
					for (int i = 0; i < CapturePointController.sharedController.basePointControllers.Length; i++)
					{
						if (CapturePointController.sharedController.basePointControllers[i].captureConmmand == (BasePointController.TypeCapture)WeaponManager.sharedManager.myPlayerMoveC.myCommand && CapturePointController.sharedController.basePointControllers[i].capturePlayers.Contains(this))
						{
							isRaiderMyPoint = true;
							break;
						}
					}
				}
				ImKilled(myPlayerTransform.position, myPlayerTransform.rotation, _typeWeapon);
				myPersonNetwork.StartAngel();
				if (Defs.isFlag && isCaptureFlag)
				{
					FlagController flagController = null;
					if (flag1.targetTrasform == flagPoint.transform)
					{
						flagController = flag1;
					}
					if (flag2.targetTrasform == flagPoint.transform)
					{
						flagController = flag2;
					}
					if (flagController != null)
					{
						flagController.SetNOCaptureRPC(myPlayerTransform.position, myPlayerTransform.rotation);
					}
				}
			}
		}
		photonView.RPC("MinusLiveRPCPhoton", PhotonTargets.All, idKiller, minus, (int)_typeKills, _typeWeapon, idTurret, weaponName);
	}

	public void MinusLive(PhotonView idKiller, float minus, TypeKills _typeKills, int _typeWeapon, string nameWeapon = "")
	{
		base.GetComponent<PhotonView>().RPC("MinusLiveRPC", PhotonTargets.All, idKiller, minus, (int)_typeKills, _typeWeapon, nameWeapon);
	}

	[PunRPC]
	public void MinusLiveRPCWithTurretPhoton(int idKiller, float minus, int _typeKills, int idTurret)
	{
		MinusLiveRPCPhoton(idKiller, minus, _typeKills, 0, idTurret, null);
	}

	[PunRPC]
	public void MinusLiveRPCWithTurretPhoton(int idKiller, float minus, int _typeKills, int idTurret, string weaponName)
	{
		MinusLiveRPCPhoton(idKiller, minus, _typeKills, 0, idTurret, null);
	}

	[PunRPC]
	public void MinusLiveRPCPhoton(int idKiller, float minus, int _typeKills, int _typeWeapon, int idTurret, string weaponName)
	{
		if (_typeKills == 2 && !isMine)
		{
			HitParticle currentParticle = HeadShotStackController.sharedController.GetCurrentParticle(false);
			if (currentParticle != null)
			{
				currentParticle.StartShowParticle(myPlayerTransform.position, myPlayerTransform.rotation, false);
			}
		}
		else if (!isMine)
		{
			HitParticle currentParticle2 = HitStackController.sharedController.GetCurrentParticle(false);
			if (currentParticle2 != null)
			{
				currentParticle2.StartShowParticle(myPlayerTransform.position, myPlayerTransform.rotation, false);
			}
		}
		if (Defs.isSoundFX)
		{
			playHitSound(_typeKills, idKiller);
		}
		if (isMine && !isKilled && !isImmortality)
		{
			float num = 0f;
			if (isMechActive)
			{
				MinusMechHealth(minus);
			}
			else
			{
				num = minus - curArmor;
				if (num < 0f)
				{
					curArmor -= minus;
					num = 0f;
				}
				else
				{
					curArmor = 0f;
				}
			}
			if (CurHealth > 0f)
			{
				CurHealth -= num;
				if (CurHealth <= 0f)
				{
					if (myKillAssists.Contains(idKiller))
					{
						myKillAssists.Remove(idKiller);
					}
					if (placemarkerMoveC != null)
					{
						placemarkerMoveC.isPlacemarker = false;
					}
					photonView.RPC("KilledPhoton", PhotonTargets.All, idKiller, _typeKills, weaponName, _typeWeapon);
				}
				else if (!myKillAssists.Contains(idKiller))
				{
					myKillAssists.Add(idKiller);
				}
				SendSynhHealth(false);
			}
			if (_typeKills != 8)
			{
				GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
				Vector3 zero = Vector3.zero;
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i].GetComponent<PhotonView>() != null && array[i].GetComponent<PhotonView>().viewID == idKiller)
					{
						zero = array[i].transform.position;
						ShowDamageDirection(zero);
						break;
					}
				}
			}
			else
			{
				GameObject[] array2 = GameObject.FindGameObjectsWithTag("Turret");
				Vector3 zero2 = Vector3.zero;
				for (int j = 0; j < array2.Length; j++)
				{
					if (array2[j].GetComponent<PhotonView>() != null && array2[j].GetComponent<PhotonView>().viewID == idTurret)
					{
						zero2 = array2[j].transform.position;
						ShowDamageDirection(zero2);
						break;
					}
				}
			}
		}
		StartCoroutine(Flash(myPlayerTransform.gameObject));
	}

	public void SendSynhHealth(bool isUp)
	{
		if (Defs.isInet)
		{
			photonView.RPC("SynhHealthRPC", PhotonTargets.All, CurHealth + curArmor, curArmor, isUp);
		}
		else
		{
			base.GetComponent<PhotonView>().RPC("SynhHealthRPC", PhotonTargets.All, CurHealth + curArmor, curArmor, isUp);
		}
	}

	[PunRPC]
	private void SynhHealth(float _synhHealth, bool isUp)
	{
		SynhHealthRPC(_synhHealth, (!(_synhHealth > 9f)) ? 0f : (_synhHealth - 9f), isUp);
	}

	[PunRPC]
	private void SynhHealthRPC(float _synhHealth, float _synchArmor, bool isUp)
	{
		if (isMine)
		{
			synhHealth = _synhHealth;
		}
		else
		{
			armorSynch = _synchArmor;
			if (!isUp)
			{
				if (_synhHealth < synhHealth)
				{
					synhHealth = _synhHealth;
				}
			}
			else
			{
				synhHealth = _synhHealth;
				isRaiderMyPoint = false;
			}
		}
		if (synhHealth > 0f)
		{
			isStartAngel = false;
			myPersonNetwork.isStartAngel = false;
		}
	}

	private void ShowDamageDirection(Vector3 posDamage)
	{
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		Vector3 vector = posDamage - myPlayerTransform.position;
		float num = Mathf.Atan(vector.z / vector.x);
		num = num * 180f / (float)Math.PI;
		if (vector.x > 0f)
		{
			num = 90f - num;
		}
		if (vector.x < 0f)
		{
			num = 270f - num;
		}
		float y = myPlayerTransform.rotation.eulerAngles.y;
		float num2 = num - y;
		if (num2 > 180f)
		{
			num2 -= 360f;
		}
		if (num2 < -180f)
		{
			num2 += 360f;
		}
		if (inGameGUI != null)
		{
			inGameGUI.AddDamageTaken(num);
		}
		if (num2 > -45f && num2 <= 45f)
		{
			flag3 = true;
		}
		if (num2 < -45f && num2 >= -135f)
		{
			flag = true;
		}
		if (num2 > 45f && num2 <= 135f)
		{
			flag2 = true;
		}
		if (num2 < -135f || num2 >= 135f)
		{
			flag4 = true;
		}
		if (flag3)
		{
			timerShowUp = maxTimeSetTimerShow;
		}
		if (flag4)
		{
			timerShowDown = maxTimeSetTimerShow;
		}
		if (flag)
		{
			timerShowLeft = maxTimeSetTimerShow;
		}
		if (flag2)
		{
			timerShowRight = maxTimeSetTimerShow;
		}
	}

	public static void SetTextureRecursivelyFrom(GameObject obj, Texture txt, GameObject[] stopObjs)
	{
		Transform transform = obj.transform;
		int childCount = obj.transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = transform.GetChild(i);
			bool flag = false;
			foreach (GameObject o in stopObjs)
			{
				if (child.gameObject.Equals(o))
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				continue;
			}
			if ((bool)child.gameObject.GetComponent<Renderer>() && (bool)child.gameObject.GetComponent<Renderer>().material && child.gameObject.tag != "donotchange")
			{
				child.gameObject.GetComponent<Renderer>().material.mainTexture = txt;
			}
			flag = false;
			foreach (GameObject o2 in stopObjs)
			{
				if (child.gameObject.Equals(o2))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				SetTextureRecursivelyFrom(child.gameObject, txt, stopObjs);
			}
		}
	}

	private IEnumerator Flash(GameObject _obj)
	{
		SetTextureRecursivelyFrom(_obj, hitTexture, GetStopObjFromPlayer(_obj));
		mechBodyRenderer.material.SetColor("_ColorRili", new Color(1f, 0f, 0f, 1f));
		mechHandRenderer.material.SetColor("_ColorRili", new Color(1f, 0f, 0f, 1f));
		yield return new WaitForSeconds(0.125f);
		SetTextureRecursivelyFrom(_obj, _obj.GetComponent<SkinName>().playerGameObject.GetComponent<Player_move_c>()._skin, GetStopObjFromPlayer(_obj));
		mechBodyRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
		mechHandRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
	}

	public static GameObject[] GetStopObjFromPlayer(GameObject _obj)
	{
		List<GameObject> list = new List<GameObject>();
		Transform transform = _obj.transform;
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (!child.gameObject.name.Equals("GameObject") || child.transform.childCount <= 0)
			{
				continue;
			}
			for (int j = 0; j < child.transform.childCount; j++)
			{
				GameObject gameObject = null;
				GameObject gameObject2 = null;
				WeaponSounds component = child.transform.GetChild(j).gameObject.GetComponent<WeaponSounds>();
				gameObject = component.bonusPrefab;
				if (!component.isMelee)
				{
					gameObject2 = child.transform.GetChild(j).Find("BulletSpawnPoint").transform.GetChild(0).gameObject;
				}
				if (component.noFillObjects != null && component.noFillObjects.Length > 0)
				{
					for (int k = 0; k < component.noFillObjects.Length; k++)
					{
						list.Add(component.noFillObjects[k]);
					}
				}
				if (gameObject != null)
				{
					list.Add(gameObject);
				}
				if (gameObject2 != null)
				{
					list.Add(gameObject2);
				}
				if (component.LeftArmorHand != null)
				{
					list.Add(component.LeftArmorHand.gameObject);
				}
				if (component.RightArmorHand != null)
				{
					list.Add(component.RightArmorHand.gameObject);
				}
				if (component.grenatePoint != null)
				{
					list.Add(component.grenatePoint.gameObject);
				}
				if (component.animationObject != null && component.animationObject.GetComponent<InnerWeaponPars>() != null && component.animationObject.GetComponent<InnerWeaponPars>().particlePoint != null)
				{
					list.Add(component.animationObject.GetComponent<InnerWeaponPars>().particlePoint);
				}
			}
			break;
		}
		if (_obj != null && _obj.GetComponent<SkinName>() != null)
		{
			SkinName component2 = _obj.GetComponent<SkinName>();
			list.Add(component2.capesPoint);
			list.Add(component2.hatsPoint);
			list.Add(component2.bootsPoint);
			list.Add(component2.armorPoint);
			if (component2.playerMoveC != null)
			{
				list.Add(component2.playerMoveC.flagPoint);
				list.Add(component2.playerMoveC.invisibleParticle);
				list.Add(component2.playerMoveC.jetPackPoint);
				list.Add(component2.playerMoveC.jetPackPointMech);
				list.Add(component2.playerMoveC.turretPoint);
				list.Add(component2.playerMoveC.mechPoint);
				list.Add(component2.playerMoveC.mechExplossion);
				list.Add(component2.playerMoveC.particleBonusesPoint);
			}
		}
		else
		{
			Debug.Log("Condition failed: “_obj != null && _obj.GetComponent<SkinName>() != null”");
		}
		return list.ToArray();
	}

	private IEnumerator RunOnGroundEffectCoroutine(string name, float tm)
	{
		yield return new WaitForSeconds(tm);
		RunOnGroundEffect(name);
	}

	private static float TimeOfMeleeAttack(WeaponSounds ws)
	{
		return ws.animationObject.GetComponent<Animation>()["Shoot"].length * ws.meleeAttackTimeModifier;
	}


	[PunRPC]
	private void fireFlash(bool isFlash, int numFlash)
	{
		WeaponSounds weaponSounds = (isMechActive ? mechWeaponSounds : ((!(myCurrentWeapon != null)) ? null : myCurrentWeapon.GetComponent<WeaponSounds>()));
		if (weaponSounds == null)
		{
			return;
		}
		if (isFlash)
		{
			if (numFlash == 0 && !_weaponManager.currentWeaponSounds.isWaitWeapon)
			{
				weaponSounds.GetComponent<FlashFire>().fire();
			}
			else if (weaponSounds.gunFlashDouble.Length > numFlash - 1 && !_weaponManager.currentWeaponSounds.isWaitWeapon)
			{
				weaponSounds.gunFlashDouble[numFlash - 1].GetComponent<FlashFire>().fire();
			}
		}
		if (weaponSounds.isRoundMelee)
		{
			float tm = TimeOfMeleeAttack(weaponSounds);
			StartCoroutine(RunOnGroundEffectCoroutine(weaponSounds.gameObject.name.Replace("(Clone)", string.Empty), tm));
		}
		string text = (weaponSounds.isDoubleShot ? (myCAnim("Shoot") + numFlash) : myCAnim("Shoot"));
		if (isMechActive)
		{
			mechGunAnimation.Play(text);
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(shootMechClip);
			}
		}
		else
		{
			weaponSounds.animationObject.GetComponent<Animation>().Play(text);
		}
		if (Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().Stop();
			base.GetComponent<AudioSource>().PlayOneShot(weaponSounds.shoot);
		}
	}

	[PunRPC]
	public void HoleRPC(bool _isBloodParticle, Vector3 _pos, Quaternion _rot)
	{
		if (_isBloodParticle)
		{
			WallBloodParticle currentParticle = BloodParticleStackController.sharedController.GetCurrentParticle(false);
			if (currentParticle != null)
			{
				currentParticle.StartShowParticle(_pos, _rot, false);
			}
			return;
		}
		HoleScript currentHole = HoleBulletStackController.sharedController.GetCurrentHole(false);
		if (currentHole != null)
		{
			currentHole.StartShowHole(_pos, _rot, false);
		}
		WallBloodParticle currentParticle2 = WallParticleStackController.sharedController.GetCurrentParticle(false);
		if (currentParticle2 != null)
		{
			currentParticle2.StartShowParticle(_pos, _rot, false);
		}
	}

	private void FixedUpdate()
	{
		if (isMulti && !isMine && myNickLabelController != null)
		{
			bool isVisible = (isImVisible = false);
			myNickLabelController.isVisible = isVisible;
		}
		ShopNGUIController.sharedShop.SetGearCatEnabled(true);
		if (rocketToLaunch != null)
		{
			rocketToLaunch.GetComponent<Rigidbody>().AddForce(190f * rocketToLaunch.transform.forward);
			rocketToLaunch = null;
		}
		if (!isMulti || isMine)
		{
			if (JoystickController.rightJoystick.jumpPressed != isJumpPresedOld)
			{
				SetJetpackParticleEnabled(JoystickController.rightJoystick.jumpPressed);
			}
			isJumpPresedOld = JoystickController.rightJoystick.jumpPressed;
		}
		if (!isMulti || !isMine || Camera.main == null)
		{
			return;
		}
		Ray ray = Camera.main.ScreenPointToRay(new Vector3((float)Screen.width * 0.5f, (float)Screen.height * 0.5f, 0f));
		RaycastHit hitInfo;
		if (!Physics.Raycast(ray, out hitInfo, 50f, _ShootRaycastLayerMask))
		{
			return;
		}
		if (hitInfo.collider.gameObject.transform.parent != null && hitInfo.collider.gameObject.transform.parent.CompareTag("Player"))
		{
			GameObject label = hitInfo.collider.gameObject.transform.parent.GetComponent<SkinName>().playerMoveC._label;
			if (label != null)
			{
				label.GetComponent<NickLabelController>().ResetTimeShow();
			}
		}
		if (hitInfo.collider.gameObject.CompareTag("Turret"))
		{
			NickLabelController myLabel = hitInfo.collider.gameObject.GetComponent<TurretController>().myLabel;
			if (myLabel != null)
			{
				myLabel.ResetTimeShow();
			}
		}
	}

	private void _FireFlash(int numFlash = 0)
	{
		if (isMulti)
		{
			if (isInet)
			{
				photonView.RPC("fireFlash", PhotonTargets.Others, true, numFlash);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("fireFlash", PhotonTargets.Others, true, numFlash);
			}
		}
	}

	private void _HitEnemies(List<GameObject> hittedEnemies)
	{
		for (int i = 0; i < hittedEnemies.Count; i++)
		{
			switch (hittedEnemies[i].tag)
			{
			case "Enemy":
				_HitZombie(hittedEnemies[i].transform.GetChild(0).gameObject);
				break;
			case "Player":
				_HitPlayer(hittedEnemies[i], null);
				break;
			case "Chest":
				_HitChest(hittedEnemies[i]);
				break;
			case "Turret":
				_HitTurret(hittedEnemies[i]);
				break;
			}
		}
	}

	private float GetMultyDamage()
	{
		WeaponSounds weaponSounds = ((!isMechActive) ? _weaponManager.currentWeaponSounds : mechWeaponSounds);
		if (isMechActive)
		{
			return weaponSounds.damageByTier[TierOrRoomTier(GearManager.CurrentNumberOfUphradesForGear(GearManager.Mech))];
		}
		return (ExpController.Instance != null && ExpController.Instance.OurTier < _weaponManager.currentWeaponSounds.damageByTier.Length) ? _weaponManager.currentWeaponSounds.damageByTier[TierOrRoomTier(ExpController.Instance.OurTier)] : ((_weaponManager.currentWeaponSounds.damageByTier.Length <= 0) ? 0f : _weaponManager.currentWeaponSounds.damageByTier[0]);
	}

	public static int TierOfCurrentRoom()
	{
		int result = ExpController.LevelsForTiers.Length - 1;
		if (PhotonNetwork.room != null)
		{
			int lev = 1;
			for (int i = 1; i <= ExperienceController.maxLevel; i++)
			{
				if (PhotonNetwork.room.customProperties["Level_" + i].Equals(1))
				{
					lev = i;
					break;
				}
			}
			result = ExpController.TierForLevel(lev);
		}
		return result;
	}

	private int TierOrRoomTier(int tier)
	{
		if (!roomTierInitialized)
		{
			roomTierInitialized = true;
			roomTier = TierOfCurrentRoom();
		}
		return Math.Min(tier, roomTier);
	}

	[PunRPC]
	public void AddFreezerRayWithLength(float len)
	{
		Transform gunFlash = GunFlash;
		if (gunFlash == null && myTransform.childCount > 0)
		{
			Transform child = myTransform.GetChild(0);
			FlashFire component = child.GetComponent<FlashFire>();
			if (component != null && component.gunFlashObj != null)
			{
				gunFlash = component.gunFlashObj.transform;
			}
		}
		if (!(gunFlash != null))
		{
			return;
		}
		if (this.FreezerFired != null)
		{
			this.FreezerFired(len);
			return;
		}
		GameObject gameObject = WeaponManager.AddRay(gunFlash.gameObject.transform.parent.position, gunFlash.gameObject.transform.parent.parent.forward, gunFlash.gameObject.transform.parent.parent.gameObject.name.Replace("(Clone)", string.Empty));
		if (gameObject != null)
		{
			FreezerRay component2 = gameObject.GetComponent<FreezerRay>();
			if (component2 != null)
			{
				component2.SetParentMoveC(this);
				component2.Length = len;
			}
		}
	}

	private IEnumerator Fade(float start, float end, float length, GameObject currentObject)
	{
		for (float i = 0f; i < 1f; i += Time.deltaTime / length)
		{
			Color rgba = currentObject.GetComponent<Image>().color;
			rgba.a = Mathf.Lerp(start, end, i);
			currentObject.GetComponent<Image>().color = rgba;
			yield return 0;
			Color rgba_ = currentObject.GetComponent<Image>().color;
			rgba_.a = end;
			currentObject.GetComponent<Image>().color = rgba_;
		}
	}

	public void SendImKilled()
	{
		if (Defs.isInet)
		{
			photonView.RPC("ImKilled", PhotonTargets.All, myTransform.position, myTransform.rotation, 0);
			SendSynhHealth(false);
		}
	}

	[PunRPC]
	private void ImKilled(Vector3 pos, Quaternion rot)
	{
		ImKilled(pos, rot, 0);
	}

	[PunRPC]
	private void ImKilled(Vector3 pos, Quaternion rot, int _typeDead = 0)
	{
		if (!isStartAngel || Defs.isCOOP)
		{
			isStartAngel = true;
			PlayerDeadController currentParticle = PlayerDeadStackController.sharedController.GetCurrentParticle(false);
			if (currentParticle != null)
			{
				currentParticle.StartShow(pos, rot, _typeDead, false, _skin);
			}
			if (Defs.isSoundFX)
			{
				base.gameObject.GetComponent<AudioSource>().PlayOneShot(deadPlayerSound);
			}
		}
	}

	private IEnumerator FlashWhenHit()
	{
		damageShown = true;
		Color rgba = damage.GetComponent<Image>().color;
		rgba.a = 0f;
		damage.GetComponent<Image>().color = rgba;
		float danageTime = 0.15f;
		yield return StartCoroutine(Fade(0f, 1f, danageTime, damage));
		yield return new WaitForSeconds(0.01f);
		yield return StartCoroutine(Fade(1f, 0f, danageTime, damage));
		damageShown = false;
	}

	private IEnumerator FlashWhenDead()
	{
		damageShown = true;
//		Color rgba = damage.GetComponent<Image>().color;
//		rgba.a = 0f;
//		damage.GetComponent<Image>().color = rgba;
		float danageTime = 0.15f;
		yield return StartCoroutine(Fade(0f, 1f, danageTime, damage));
		while (isDeadFrame)
		{
			yield return null;
		}
		yield return StartCoroutine(Fade(1f, 0f, danageTime / 3f, damage));
		damageShown = false;
	}

	private IEnumerator SetCanReceiveSwipes()
	{
		yield return new WaitForSeconds(0.1f);
		canReceiveSwipes = true;
	}

	[Obfuscation(Exclude = true)]
	private void setisDeadFrameFalse()
	{
		isDeadFrame = false;
	}

	private void UpdateImmortalityAlpColor(float _alpha)
	{
		if (Mathf.Abs(_alpha - oldAlphaImmortality) < 0.001f)
		{
			return;
		}
		oldAlphaImmortality = _alpha;
		if (myCurrentWeaponSounds != null)
		{
			playerBodyRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, _alpha));
			Shader shader = Shader.Find("Mobile/Diffuse-Color");
			if (shader != null && myCurrentWeaponSounds.bonusPrefab != null && myCurrentWeaponSounds.bonusPrefab.transform.parent != null)
			{
				myCurrentWeaponSounds.bonusPrefab.transform.parent.GetComponent<Renderer>().material.shader = shader;
				myCurrentWeaponSounds.bonusPrefab.transform.parent.GetComponent<Renderer>().material.SetColor("_ColorRili", new Color(1f, 1f, 1f, _alpha));
			}
		}
	}

	private void Update()
	{
		if (Defs.isMouseControl)
		{
			if (inGameGUI != null) 
			{
				if (inGameGUI.pausePanel.active)
				{
					Cursor.lockState = CursorLockMode.None;
					Cursor.visible = true;
				}
				else if (!inGameGUI.isActiveAndEnabled && CurHealth > 0) 
				{
					Cursor.lockState = CursorLockMode.None;
					Cursor.visible = true;
				} 
				else if (Cursor.visible == true && Cursor.lockState == CursorLockMode.None && canlock)
				{
					Cursor.visible = false;
					Cursor.lockState = CursorLockMode.Locked;
				}
			}
		}
		if ((!isMulti || isMine) && _timeOfSlowdown > 0f)
		{
			_timeOfSlowdown -= Time.deltaTime;
			if (_timeOfSlowdown <= 0f)
			{
				EffectsController.SlowdownCoeff = 1f;
			}
		}
		if (isMulti && isMine && CurHealth + curArmor - synhHealth > 0.1f)
		{
			SendSynhHealth(true);
		}
		if (!isMulti || isMine)
		{
			Defs.isZooming = isZooming;
		}
		if (!isKilled && timerImmortality > 0f)
		{
			timerImmortality -= Time.deltaTime;
			if (timerImmortality <= 0f)
			{
				isImmortality = false;
			}
		}
		if (!isInvisible)
		{
			if (isImmortality)
			{
				float num = 1f;
				timerImmortalityForAlpha += Time.deltaTime;
				float num2 = 2f * (timerImmortalityForAlpha - Mathf.Floor(timerImmortalityForAlpha / num) * num) / num;
				if (num2 > 1f)
				{
					num2 = 2f - num2;
				}
				UpdateImmortalityAlpColor(0.5f + num2 * 0.4f);
			}
			else
			{
				UpdateImmortalityAlpColor(1f);
			}
		}
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			if (!Cursor.visible)
			{
				_escapePressed = true;
				Input.ResetInputAxes();
				Cursor.lockState = CursorLockMode.None;
				Cursor.visible = true;
			}
			else if (!showRanks)
			{
				GameObject gameObject = GameObject.FindGameObjectWithTag("ChatViewer");
				if (gameObject != null)
				{
					if (Application.isEditor)
					{
						Debug.Log("Escape handling. Closing chat");
					}
					gameObject.GetComponent<ChatViewrController>().closeChat();
					Input.ResetInputAxes();
				}
				else if (!isInappWinOpen && !Screen.lockCursor)
				{
					if (Application.isEditor)
					{
						Debug.Log("Escape handling. !isInappWinOpen && !Screen.lockCursor");
					}
					_escapePressed = true;
					Input.ResetInputAxes();
				}
			}
		}
		if (isMulti && isMine)
		{
			if ((isCompany || Defs.isFlag) && myCommand == 0 && myTable != null)
			{
				myCommand = myTable.GetComponent<NetworkStartTable>().myCommand;
			}
			if (Defs.isFlag && myBaza == null && myCommand != 0)
			{
				if (myCommand == 1)
				{
					myBaza = GameObject.FindGameObjectWithTag("BazaZoneCommand1");
				}
				else
				{
					myBaza = GameObject.FindGameObjectWithTag("BazaZoneCommand2");
				}
			}
			if (Defs.isFlag && (myFlag == null || enemyFlag == null) && myCommand != 0)
			{
				myFlag = ((myCommand != 1) ? flag2 : flag1);
				enemyFlag = ((myCommand != 1) ? flag1 : flag2);
			}
			if (Defs.isFlag && myFlag != null && enemyFlag != null)
			{
				if (!myFlag.isCapture && !myFlag.isBaza && Vector3.SqrMagnitude(myPlayerTransform.position - myFlag.transform.position) < 2.25f)
				{
					photonView.RPC("SendSystemMessegeFromFlagReturnedRPC", PhotonTargets.All, myFlag.isBlue);
					myFlag.GoBaza();
				}
				if (!enemyFlag.isCapture && !isKilled && enemyFlag.GetComponent<FlagController>().flagModel.activeSelf && Vector3.SqrMagnitude(myPlayerTransform.position - enemyFlag.transform.position) < 2.25f)
				{
					enemyFlag.SetCapture(photonView.ownerId);
					isCaptureFlag = true;
					photonView.RPC("SendSystemMessegeFromFlagCaptureRPC", PhotonTargets.All, enemyFlag.isBlue, mySkinName.NickName);
				}
			}
			if (isCaptureFlag && Vector3.SqrMagnitude(myPlayerTransform.position - myBaza.transform.position) < 2.25f)
			{
				if (Defs.isSoundFX)
				{
					base.GetComponent<AudioSource>().PlayOneShot(flagScoreMyCommandClip);
				}
				if (myTable != null)
				{
					myTable.GetComponent<NetworkStartTable>().AddScore();
				}
				countMultyFlag++;
				myScoreController.AddScoreOnEvent((countMultyFlag == 3) ? PlayerEventScoreController.ScoreEvent.flagTouchDownTriple : ((countMultyFlag != 2) ? PlayerEventScoreController.ScoreEvent.flagTouchDown : PlayerEventScoreController.ScoreEvent.flagTouchDouble));
				isCaptureFlag = false;
				photonView.RPC("SendSystemMessegeFromFlagAddScoreRPC", PhotonTargets.Others, !enemyFlag.isBlue, mySkinName.NickName);
				AddSystemMessage(LocalizationStore.Get("Key_1003"));
				enemyFlag.GoBaza();
			}
			if (Defs.isFlag && inGameGUI != null)
			{
				if (isCaptureFlag)
				{
					if (enemyFlag.isBlue && !inGameGUI.flagBlueCaptureTexture.activeSelf)
					{
						inGameGUI.flagBlueCaptureTexture.SetActive(true);
					}
					if (!enemyFlag.isBlue && !inGameGUI.flagRedCaptureTexture.activeSelf)
					{
						inGameGUI.flagRedCaptureTexture.SetActive(true);
					}
				}
				else
				{
					if (enemyFlag.isBlue && inGameGUI.flagBlueCaptureTexture.activeSelf)
					{
						inGameGUI.flagBlueCaptureTexture.SetActive(false);
					}
					if (!enemyFlag.isBlue && inGameGUI.flagRedCaptureTexture.activeSelf)
					{
						inGameGUI.flagRedCaptureTexture.SetActive(false);
					}
				}
			}
		}
		if (!isMulti || isMine)
		{
			if (!isRegenerationLiveCape)
			{
				timerRegenerationLiveCape = maxTimerRegenerationLiveCape;
			}
			if (isRegenerationLiveCape)
			{
				if (timerRegenerationLiveCape > 0f)
				{
					timerRegenerationLiveCape -= Time.deltaTime;
				}
				else
				{
					timerRegenerationLiveCape = maxTimerRegenerationLiveCape;
					if (CurHealth < MaxHealth)
					{
						CurHealth += 1f;
					}
				}
			}
			if (!EffectsController.IsRegeneratingArmor)
			{
				timerRegenerationArmor = maxTimerRegenerationArmor;
			}
			if (EffectsController.IsRegeneratingArmor)
			{
				if (timerRegenerationArmor > 0f)
				{
					timerRegenerationArmor -= Time.deltaTime;
				}
				else
				{
					timerRegenerationArmor = maxTimerRegenerationArmor;
					if (curArmor < MaxArmor)
					{
						AddArmor(1f);
					}
				}
			}
			if (!isRegenerationLiveZel)
			{
				timerRegenerationLiveZel = maxTimerRegenerationLiveZel;
			}
			if (isRegenerationLiveZel)
			{
				if (timerRegenerationLiveZel > 0f)
				{
					timerRegenerationLiveZel -= Time.deltaTime;
				}
				else
				{
					timerRegenerationLiveZel = maxTimerRegenerationLiveZel;
					if (CurHealth < MaxHealth)
					{
						CurHealth += 1f;
					}
				}
			}
			if (timerShowUp > 0f)
			{
				timerShowUp -= Time.deltaTime;
			}
			if (timerShowDown > 0f)
			{
				timerShowDown -= Time.deltaTime;
			}
			if (timerShowLeft > 0f)
			{
				timerShowLeft -= Time.deltaTime;
			}
			if (timerShowRight > 0f)
			{
				timerShowRight -= Time.deltaTime;
			}
		}
		if (!isMulti || isMine)
		{
			if (((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).currentAmmoInClip == 0 && ((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).currentAmmoInBackpack > 0 && !_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().IsPlaying(myCAnim("Shoot")) && !isReloading)
			{
				ReloadPressed();
			}
			if (!isHunger || hungerGameController.isGo)
			{
				PotionsController.sharedController.Step(Time.deltaTime, this);
			}
		}
		if (isHunger && isMine)
		{
			timeHingerGame += Time.deltaTime;
			if (GameObject.FindGameObjectsWithTag("Player").Length == 1 && hungerGameController.isGo && timeHingerGame > 10f && !isZachetWin)
			{
				isZachetWin = true;
				int val = Storager.getInt(Defs.RatingHunger, false) + 1;
				Storager.setInt(Defs.RatingHunger, val, false);
				val = Storager.getInt("Rating", false) + 1;
				Storager.setInt("Rating", val, false);
				if (FriendsController.sharedController != null)
				{
					FriendsController.sharedController.TryIncrementWinCountTimestamp();
				}
				FriendsController.sharedController.wins.Value = val;
				FriendsController.sharedController.SendOurData(false);
				myTable.GetComponent<NetworkStartTable>().WinInHunger();
			}
		}
		if (!isMulti)
		{
			inGameTime += Time.deltaTime;
		}
		if ((isCompany || Defs.isFlag) && myCommand == 0 && myTable != null)
		{
			myCommand = myTable.GetComponent<NetworkStartTable>().myCommand;
		}
		if (isMulti && isMine && _weaponManager.myPlayer != null)
		{
			GlobalGameController.posMyPlayer = _weaponManager.myPlayer.transform.position;
			GlobalGameController.rotMyPlayer = _weaponManager.myPlayer.transform.rotation;
			GlobalGameController.healthMyPlayer = CurHealth;
			GlobalGameController.armorMyPlayer = curArmor;
		}
		if (!isMulti || isMine)
		{
			if (timerShow[0] > 0f)
			{
				timerShow[0] -= Time.deltaTime;
			}
			if (timerShow[1] > 0f)
			{
				timerShow[1] -= Time.deltaTime;
			}
			if (timerShow[2] > 0f)
			{
				timerShow[2] -= Time.deltaTime;
			}
		}
		if (!isMulti || isMine)
		{
			Func<bool> func = () => _pauser != null && _pauser.paused;
			if (!func() && canReceiveSwipes && isInappWinOpen)
			{
			}
		}
		if (GunFlashLifetime > 0f)
		{
			GunFlashLifetime -= Time.deltaTime;
			if (GunFlashLifetime <= 0f)
			{
				_SetGunFlashActive(false);
			}
		}
		if ((isMulti && !isMine) || !(CurHealth <= 0f) || isKilled || showRanks || showChat || ShopNGUIController.GuiActive || BankController.Instance.uiRoot.gameObject.activeInHierarchy || (!(_pauser == null) && (!(_pauser != null) || _pauser.paused)))
		{
			return;
		}
		countMultyFlag = 0;
		ResetMySpotEvent();
		ResetHouseKeeperEvent();
		if (Defs.isMulti && !Defs.isCOOP)
		{
			if (!Defs.isInet)
			{
				if (myKillAssistsLocal.Count > 0)
				{
					
					base.GetComponent<PhotonView>().RPC("AddScoreKillAssisitLocal", PhotonTargets.Others, (myKillAssistsLocal.Count <= 0) ? default(PhotonView) : myKillAssistsLocal[0], (myKillAssistsLocal.Count <= 1) ? default(PhotonView) : myKillAssistsLocal[1], (myKillAssistsLocal.Count <= 2) ? default(PhotonView) : myKillAssistsLocal[2], (myKillAssistsLocal.Count <= 3) ? default(PhotonView) : myKillAssistsLocal[3], (myKillAssistsLocal.Count <= 4) ? default(PhotonView) : myKillAssistsLocal[4], (myKillAssistsLocal.Count <= 5) ? default(PhotonView) : myKillAssistsLocal[5], (myKillAssistsLocal.Count <= 6) ? default(PhotonView) : myKillAssistsLocal[6], (myKillAssistsLocal.Count <= 7) ? default(PhotonView) : myKillAssistsLocal[7]);
				}
				myKillAssistsLocal.Clear();
			}
			else
			{
				if (myKillAssists.Count > 0)
				{
					photonView.RPC("AddScoreKillAssisit", PhotonTargets.Others, (myKillAssists.Count > 0) ? myKillAssists[0] : 0, (myKillAssists.Count > 1) ? myKillAssists[1] : 0, (myKillAssists.Count > 2) ? myKillAssists[2] : 0, (myKillAssists.Count > 3) ? myKillAssists[3] : 0, (myKillAssists.Count > 4) ? myKillAssists[4] : 0, (myKillAssists.Count > 5) ? myKillAssists[5] : 0, (myKillAssists.Count > 6) ? myKillAssists[6] : 0, (myKillAssists.Count > 7) ? myKillAssists[7] : 0);
				}
				myKillAssists.Clear();
			}
		}
		if (Mathf.Abs(Time.time - timeBuyHealth) < 1.5f)
		{
			BankController.AddCoins(Defs.healthInGamePanelPrice);
			timeBuyHealth = -10000f;
		}
		if (Defs.isCOOP)
		{
			SendImKilled();
			SendSynhHealth(false);
		}
		inGameGUI.ResetDamageTaken();
		if (Defs.isTurretWeapon)
		{
			CancelTurret();
			InGameGUI.sharedInGameGUI.HideTurretInterface();
			Defs.isTurretWeapon = false;
		}
		if (isGrenadePress)
		{
			ChangeWeapon(currentWeaponBeforeGrenade, false);
			isGrenadePress = false;
		}
		if (isZooming)
		{
			ZoomPress();
		}
		if (isMulti)
		{
			if ((!isMulti || isMine) && _player != null && (bool)_player)
			{
				ImpactReceiverTrampoline component = _player.GetComponent<ImpactReceiverTrampoline>();
				if (component != null)
				{
					UnityEngine.Object.Destroy(component);
				}
			}
			if (Defs.isFlag && isCaptureFlag)
			{
				isCaptureFlag = false;
				photonView.RPC("SendSystemMessegeFromFlagDroppedRPC", PhotonTargets.All, enemyFlag.isBlue, mySkinName.NickName);
				enemyFlag.SetNOCapture(flagPoint.transform.position, flagPoint.transform.rotation);
			}
			resetMultyKill();
			isKilled = true;
			if (Defs.isMulti && isMine && !Defs.isHunger && UnityEngine.Random.Range(0, 100) < 50)
			{
				BonusController.sharedController.AddBonusAfterKillPlayer(new Vector3(myPlayerTransform.position.x, myPlayerTransform.position.y - 1f, myPlayerTransform.position.z));
			}
			if (isHunger && !((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).weaponPrefab.tag.Equals("Knife"))
			{
				GameObject.FindGameObjectWithTag("BonusController").GetComponent<BonusController>().AddWeaponAfterKillPlayer(((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).weaponPrefab.name, myPlayerTransform.position);
			}
			if (Defs.isSoundFX)
			{
				base.gameObject.GetComponent<AudioSource>().PlayOneShot(deadPlayerSound);
			}
			if (isCOOP)
			{
				_weaponManager.myNetworkStartTable.score -= 1000;
				if (_weaponManager.myNetworkStartTable.score < 0)
				{
					_weaponManager.myNetworkStartTable.score = 0;
				}
				GlobalGameController.Score = _weaponManager.myNetworkStartTable.score;
				_weaponManager.myNetworkStartTable.SynhScore();
			}
			isDeadFrame = true;
			AutoFade.fadeKilled(0.5f, (!isNeedShowRespawnWindow || Defs.inRespawnWindow) ? 1.5f : 0.5f, 0.5f, Color.white);
			Invoke("setisDeadFrameFalse", 1f);
			StartCoroutine(FlashWhenDead());
			if (JoystickController.leftJoystick != null)
			{
				JoystickController.leftJoystick.transform.parent.gameObject.SetActive(false);
				JoystickController.leftJoystick.SetJoystickActive(false);
			}
			if (JoystickController.leftTouchPad != null)
			{
				JoystickController.leftTouchPad.SetJoystickActive(false);
			}
			if (JoystickController.rightJoystick != null)
			{
				JoystickController.rightJoystick.gameObject.SetActive(false);
				JoystickController.rightJoystick.MakeInactive();
			}
			if (Defs.inRespawnWindow)
			{
				currArmor = 31f;
				Defs.inRespawnWindow = false;
				RespawnPlayer();
				return;
			}
			Vector3 localPosition = myPlayerTransform.localPosition;
			TweenParms p_parms = new TweenParms().Prop("localPosition", new Vector3(localPosition.x, 100f, localPosition.z)).Ease(EaseType.EaseInCubic).OnComplete((TweenDelegate.TweenCallback)delegate
			{
				myPlayerTransform.localPosition = new Vector3(0f, -1000f, 0f);
				if (isNeedShowRespawnWindow && !Defs.inRespawnWindow)
				{
					SetMapCameraActive(true);
					StartCoroutine(KillCam());
				}
				else
				{
					Defs.inRespawnWindow = false;
					RespawnPlayer();
				}
			});
			HOTween.To(myPlayerTransform, (!isNeedShowRespawnWindow) ? 2f : 0.75f, p_parms);
			return;
		}
		if (Defs.IsSurvival)
		{
			if (GlobalGameController.Score > PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0))
			{
				PlayerPrefs.SetInt(Defs.SurvivalScoreSett, GlobalGameController.Score);
				PlayerPrefs.Save();
				FriendsController.sharedController.survivalScore = GlobalGameController.Score;
				FriendsController.sharedController.SendOurData(false);
			}
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				AGSLeaderboardsClient.SubmitScore("best_survival_scores", GlobalGameController.Score);
			}
			else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite && Social.localUser.authenticated)
			{
				Social.ReportScore(GlobalGameController.Score, "CgkIr8rGkPIJEAIQCg", delegate(bool success)
				{
					Debug.Log("Player_move_c.Update(): " + ((!success) ? "Failed to report score." : "Reported score successfully."));
				});
			}
		}
		else if (GlobalGameController.Score > PlayerPrefs.GetInt(Defs.BestScoreSett, 0))
		{
			PlayerPrefs.SetInt(Defs.BestScoreSett, GlobalGameController.Score);
			PlayerPrefs.Save();
		}
		PlayerPrefs.SetInt("IsGameOver", 1);
		LevelCompleteLoader.action = null;
		LevelCompleteLoader.sceneName = "LevelComplete";
		Application.LoadLevel("LevelToCompleteProm");
	}

	private IEnumerator KillCam()
	{
		CameraSceneController.sharedController.killCamController.lastDistance = 1f;
		CameraSceneController.sharedController.SetTargetKillCam(_killerInfo.killerTransform);
		InGameGUI.sharedInGameGUI.respawnWindow.Show(_killerInfo);
		InGameGUI.sharedInGameGUI.characterDrag.SetActive(false);
		InGameGUI.sharedInGameGUI.cameraDrag.SetActive(true);
		float _timerKillCam = 0f;
		Defs.inRespawnWindow = true;
		while (Defs.inRespawnWindow && _killerInfo.killerTransform != null && !_killerInfo.killerTransform.GetComponent<SkinName>().playerMoveC.isKilled)
		{
			if (_killerInfo.killerTransform.GetComponent<SkinName>().playerMoveC.myNickLabelController != null)
			{
				_killerInfo.killerTransform.GetComponent<SkinName>().playerMoveC.myNickLabelController.ResetTimeShow();
			}
			yield return null;
			_timerKillCam += Time.deltaTime;
		}
		InGameGUI.sharedInGameGUI.characterDrag.SetActive(true);
		InGameGUI.sharedInGameGUI.cameraDrag.SetActive(false);
		if (Defs.inRespawnWindow)
		{
			RespawnWindow.Instance.ShowCharacter(killerInfo);
		}
		CameraSceneController.sharedController.SetTargetKillCam(null);
	}

	private void SetMapCameraActive(bool active)
	{
		InGameGUI.sharedInGameGUI.SetInterfaceVisible(!active);
		Camera component = Initializer.Instance.tc.GetComponent<Camera>();
		Camera camera = myCamera;
		component.gameObject.SetActive(active);
		camera.gameObject.SetActive(!active);
		Camera camera2 = (NickLabelController.currentCamera = ((!active) ? camera : component));
	}

	public void RespawnPlayer()
	{
		currArmor = 31f;
		SetMapCameraActive(false);
		_killerInfo.Reset();
		Func<bool> func = () => _pauser != null && _pauser.paused;
		if (base.transform.parent == null)
		{
			Debug.Log("transform.parent == null");
			return;
		}
		myPlayerTransform.localScale = new Vector3(1f, 1f, 1f);
		myTransform.rotation = Quaternion.Euler(new Vector3(0f, 90f, 0f));
		if (isHunger || Defs.isRegimVidosDebug)
		{
			myTable.GetComponent<NetworkStartTable>().ImDeadInHungerGames();
			PhotonNetwork.Destroy(myPlayerTransform.gameObject);
			return;
		}
		InitiailizeIcnreaseArmorEffectFlags();
		isDeadFrame = false;
		isImmortality = true;
		timerImmortality = maxTimerImmortality;
		SetNoKilled();
		if (_weaponManager.myPlayer == null)
		{
			Debug.Log("_weaponManager.myPlayer == null");
			return;
		}
		_weaponManager.myPlayer.GetComponent<SkinName>().camPlayer.transform.parent = _weaponManager.myPlayer.transform;
		if (!func() && !Defs.isMouseControl)
		{
			if (JoystickController.leftJoystick != null)
			{
				JoystickController.leftJoystick.transform.parent.gameObject.SetActive(true);
			}
			if (JoystickController.rightJoystick != null)
			{
				JoystickController.rightJoystick.gameObject.SetActive(true);
				JoystickController.rightJoystick._isFirstFrame = false;
			}
		}
		if (JoystickController.leftJoystick != null)
		{
			JoystickController.leftJoystick.SetJoystickActive(true);
		}
		if (JoystickController.rightJoystick != null)
		{
			JoystickController.rightJoystick.MakeActive();
		}
		if (JoystickController.leftTouchPad != null)
		{
			JoystickController.leftTouchPad.SetJoystickActive(true);
		}
		if (JoystickController.rightJoystick != null)
		{
			if (inGameGUI != null)
			{
				inGameGUI.BlinkNoAmmo(0);
			}
			JoystickController.rightJoystick.HasAmmo();
		}
		else
		{
			Debug.Log("JoystickController.rightJoystick = null");
		}
		CurHealth = MaxHealth;
		Wear.RenewCurArmor(TierOrRoomTier((!(ExpController.Instance != null)) ? (ExpController.LevelsForTiers.Length - 1) : ExpController.Instance.OurTier));
		CurrentBaseArmor = 0f;
		zoneCreatePlayer = GameObject.FindGameObjectsWithTag(isCOOP ? "MultyPlayerCreateZoneCOOP" : (isCompany ? ("MultyPlayerCreateZoneCommand" + myCommand) : (Defs.isFlag ? ("MultyPlayerCreateZoneFlagCommand" + myCommand) : ((!Defs.isCapturePoints) ? "MultyPlayerCreateZone" : ("MultyPlayerCreateZonePointZone" + myCommand)))));
		GameObject gameObject = zoneCreatePlayer[UnityEngine.Random.Range(0, zoneCreatePlayer.Length - 1)];
		BoxCollider component = gameObject.GetComponent<BoxCollider>();
		Vector2 vector = new Vector2(component.size.x * gameObject.transform.localScale.x, component.size.z * gameObject.transform.localScale.z);
		Rect rect = new Rect(gameObject.transform.position.x - vector.x / 2f, gameObject.transform.position.z - vector.y / 2f, vector.x, vector.y);
		Vector3 position = new Vector3(rect.x + UnityEngine.Random.Range(0f, rect.width), gameObject.transform.position.y + 2f, rect.y + UnityEngine.Random.Range(0f, rect.height));
		Quaternion rotation = gameObject.transform.rotation;
		myPlayerTransform.position = position;
		myPlayerTransform.rotation = rotation;
		Vector3 eulerAngles = myCamera.transform.rotation.eulerAngles;
		myCamera.transform.rotation = Quaternion.Euler(0f, eulerAngles.y, eulerAngles.z);
		Invoke("ChangePositionAfterRespawn", 0.01f);
		foreach (Weapon allAvailablePlayerWeapon in _weaponManager.allAvailablePlayerWeapons)
		{
			if (allAvailablePlayerWeapon.weaponPrefab.name.Equals(WeaponManager.PistolWN) || allAvailablePlayerWeapon.weaponPrefab.name.Equals(WeaponManager.ShotgunWN) || allAvailablePlayerWeapon.weaponPrefab.name.Equals(WeaponManager.MP5WN) || allAvailablePlayerWeapon.weaponPrefab.name.Equals(WeaponManager.CampaignRifle_WN) || allAvailablePlayerWeapon.weaponPrefab.name.Equals(WeaponManager.Rocketnitza_WN))
			{
				allAvailablePlayerWeapon.currentAmmoInClip = allAvailablePlayerWeapon.weaponPrefab.GetComponent<WeaponSounds>().ammoInClip;
				allAvailablePlayerWeapon.currentAmmoInBackpack = allAvailablePlayerWeapon.weaponPrefab.GetComponent<WeaponSounds>().InitialAmmoWithEffectsApplied;
			}
		}
		EffectsController.SlowdownCoeff = 1f;
		RefillAmmo();
	}

	public void RefillAmmo()
	{
		for (int i = 0; i < WeaponManager.sharedManager.playerWeapons.Count; i++)
		{
			Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[i];
			WeaponSounds component = weapon.weaponPrefab.GetComponent<WeaponSounds>();
			weapon.currentAmmoInBackpack = component.MaxAmmoWithEffectApplied / 2;
			weapon.currentAmmoInClip = weapon.weaponPrefab.GetComponent<WeaponSounds>().ammoInClip;
		}
	}

	[Obfuscation(Exclude = true)]
	private void SetNoKilled()
	{
		isKilled = false;
		resetMultyKill();
	}

	[Obfuscation(Exclude = true)]
	private void ChangePositionAfterRespawn()
	{
		myPlayerTransform.position += Vector3.forward * 0.01f;
	}

	[PunRPC]
	private void AddScoreKillAssisit(int assist1, int assist2, int assist3, int assist4, int assist5, int assist6, int assist7, int assist8)
	{
		if (!(WeaponManager.sharedManager.myPlayerMoveC == null) && (assist1 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID || assist2 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID || assist3 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID || assist4 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID || assist5 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID || assist6 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID || assist7 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID || assist8 == WeaponManager.sharedManager.myPlayerMoveC.myPlayerID))
		{
			WeaponManager.sharedManager.myPlayerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killAssist);
		}
	}

	[PunRPC]
	private void AddScoreKillAssisitLocal(PhotonView assist1, PhotonView assist2, PhotonView assist3, PhotonView assist4, PhotonView assist5, PhotonView assist6, PhotonView assist7, PhotonView assist8)
	{
		if (!(WeaponManager.sharedManager.myPlayerMoveC == null) && (assist1.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal) || assist2.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal) || assist3.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal) || assist4.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal) || assist5.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal) || assist6.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal) || assist7.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal) || assist8.Equals(WeaponManager.sharedManager.myPlayerMoveC.myPlayerIDLocal)))
		{
			WeaponManager.sharedManager.myPlayerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.killAssist);
		}
	}

	public static Rect SuccessMessageRect()
	{
		return new Rect((float)(Screen.width / 2) - (float)Screen.height * 0.5f, (float)Screen.height * 0.5f - (float)Screen.height * 0.0525f, Screen.height, (float)Screen.height * 0.105f);
	}

	public void showUnlockGUI()
	{
	}

	public void GoToShopFromPause()
	{
		SetInApp();
		inAppOpenedFromPause = true;
	}

	public void QuitGame()
	{
		Time.timeScale = 1f;
		Time.timeScale = 1f;
		if (Defs.IsTraining)
		{
			LevelCompleteLoader.action = null;
			LevelCompleteLoader.sceneName = Defs.MainMenuScene;
			Application.LoadLevel("LevelToCompleteProm");
		}
		else if (isMulti)
		{
			if (EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Paused || EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Recording)
			{
				EveryplayWrapper.Instance.Stop();
			}
			if (!isInet)
			{
				if (PlayerPrefs.GetString("TypeGame").Equals("server"))
				{
					PhotonNetwork.Disconnect();
					GameObject.FindGameObjectWithTag("NetworkTable").GetComponent<LANBroadcastService>().StopBroadCasting();
				}
				/*else if (PhotonNetwork.conne == 1)
				{
					PhotonNetwork.CloseConnection(PhotonNetwork.connections[0], true);
				}*/
				if (_purchaseActivityIndicator == null)
				{
					Debug.LogWarning("_purchaseActivityIndicator == null");
				}
				else
				{
					_purchaseActivityIndicator.SetActive(false);
				}
				coinsShop.hideCoinsShop();
				coinsPlashka.hidePlashka();
				ConnectSceneNGUIController.Local();
			}
			else
			{
				coinsShop.hideCoinsShop();
				coinsPlashka.hidePlashka();
				Defs.typeDisconnectGame = Defs.DisconectGameType.Exit;
				PhotonNetwork.LeaveRoom();
			}
		}
		else if (Defs.IsSurvival)
		{
			if (GlobalGameController.Score > PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0))
			{
				PlayerPrefs.SetInt(Defs.SurvivalScoreSett, GlobalGameController.Score);
				PlayerPrefs.Save();
				FriendsController.sharedController.survivalScore = GlobalGameController.Score;
				FriendsController.sharedController.SendOurData(false);
			}
			Debug.Log("Player_move_c.QuitGame(): Trying to report survival score: " + GlobalGameController.Score);
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				AGSLeaderboardsClient.SubmitScore("best_survival_scores", GlobalGameController.Score);
			}
			else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite && Social.localUser.authenticated)
			{
				Social.ReportScore(GlobalGameController.Score, "CgkIr8rGkPIJEAIQCg", delegate(bool success)
				{
					Debug.Log("Player_move_c.QuitGame(): " + ((!success) ? "Failed to report score." : "Reported score successfully."));
				});
			}
			PlayerPrefs.SetInt("IsGameOver", 1);
			LevelCompleteLoader.action = null;
			LevelCompleteLoader.sceneName = "LevelComplete";
			Application.LoadLevel("LevelToCompleteProm");
		}
		else
		{
			LevelCompleteLoader.action = null;
			LevelCompleteLoader.sceneName = "ChooseLevel";
			bool flag = !isMulti;
			if (!flag)
			{
				FlurryPluginWrapper.LogEvent("Back to Main Menu");
			}
			Application.LoadLevel((!flag) ? Defs.MainMenuScene : "LevelToCompleteProm");
		}
	}

	public void SetPause(bool showGUI = true)
	{
		JoystickController.rightJoystick.jumpPressed = false;
		JoystickController.rightJoystick.Reset();
		if (_pauser == null)
		{
			Debug.LogWarning("SetPause(): _pauser is null.");
			return;
		}
		_pauser.paused = !_pauser.paused;
		if (_pauser.paused)
		{
			isActiveTurretPanelInPause = InGameGUI.sharedInGameGUI.turretPanel.activeSelf;
			InGameGUI.sharedInGameGUI.turretPanel.SetActive(false);
		}
		else
		{
			InGameGUI.sharedInGameGUI.turretPanel.SetActive(isActiveTurretPanelInPause);
		}
		if (showGUI && inGameGUI != null && inGameGUI.pausePanel != null)
		{
			inGameGUI.pausePanel.SetActive(_pauser.paused);
			inGameGUI.fastShopPanel.SetActive(!_pauser.paused);
			if (ExperienceController.sharedController != null && ExpController.Instance != null)
			{
				ExperienceController.sharedController.isShowRanks = _pauser.paused;
				ExpController.Instance.InterfaceEnabled = _pauser.paused;
			}
		}
		if (_pauser.paused)
		{
			if (!isMulti)
			{
				Time.timeScale = 0f;
				if (Defs.IsTraining)
				{
					TrainingController.isPause = true;
				}
			}
		}
		else
		{
			Time.timeScale = 1f;
			TrainingController.isPause = false;
		}
		if (_pauser.paused)
		{
			RemoveButtonHandelrs();
		}
		else
		{
			AddButtonHandlers();
		}
	}

	public void WinFromTimer()
	{
		if (Defs.isCompany)
		{
			int commandWin = 0;
			if (countKillsCommandBlue > countKillsCommandRed)
			{
				commandWin = 1;
			}
			if (countKillsCommandRed > countKillsCommandBlue)
			{
				commandWin = 2;
			}
			if (WeaponManager.sharedManager.myTable != null)
			{
				WeaponManager.sharedManager.myNetworkStartTable.win(string.Empty, commandWin, countKillsCommandBlue, countKillsCommandRed);
			}
		}
		else if (Defs.isCOOP)
		{
			ZombiManager.sharedManager.EndMatch();
		}
		else if (WeaponManager.sharedManager.myTable != null)
		{
			WeaponManager.sharedManager.myNetworkStartTable.win(string.Empty);
		}
	}

	private void SetInApp()
	{
		isInappWinOpen = !isInappWinOpen;
		if (isInappWinOpen)
		{
			if (StoreKitEventListener.restoreInProcess)
			{
				_purchaseActivityIndicator.SetActive(true);
			}
			if (!isMulti)
			{
				Time.timeScale = 0f;
			}
			return;
		}
		if (InGameGUI.sharedInGameGUI.shopPanelForSwipe.gameObject.activeSelf)
		{
			InGameGUI.sharedInGameGUI.shopPanelForSwipe.gameObject.SetActive(false);
			InGameGUI.sharedInGameGUI.shopPanelForSwipe.gameObject.SetActive(!isTraining);
		}
		if (InGameGUI.sharedInGameGUI.shopPanelForTap.gameObject.activeSelf)
		{
			InGameGUI.sharedInGameGUI.shopPanelForTap.gameObject.SetActive(false);
			InGameGUI.sharedInGameGUI.shopPanelForTap.gameObject.SetActive(true);
		}
		if (_purchaseActivityIndicator == null)
		{
			Debug.LogWarning("SetInApp(): _purchaseActivityIndicator is null.");
		}
		else
		{
			_purchaseActivityIndicator.SetActive(false);
		}
		if (_pauser == null)
		{
			Debug.LogWarning("SetInApp(): _pauser is null.");
		}
		else if (!_pauser.paused)
		{
			Time.timeScale = 1f;
		}
	}

	private void providePotion(string inShopId)
	{
	}

	private void ProvideAmmo(string inShopId)
	{
		_listener.ProvideContent();
		_weaponManager.SetMaxAmmoFrAllWeapons();
		if (JoystickController.rightJoystick != null)
		{
			if (inGameGUI != null)
			{
				inGameGUI.BlinkNoAmmo(0);
			}
			JoystickController.rightJoystick.HasAmmo();
		}
		else
		{
			Debug.Log("JoystickController.rightJoystick = null");
		}
	}

	private void ProvideHealth(string inShopId)
	{
		CurHealth = MaxHealth;
		CurrentCampaignGame.withoutHits = true;
	}

	public void PurchaseSuccessful(string id)
	{
		if (_actionsForPurchasedItems.ContainsKey(id))
		{
			_actionsForPurchasedItems[id](id);
		}
		_timeWhenPurchShown = Time.realtimeSinceStartup;
	}

	private void purchaseSuccessful(GooglePurchase purchase)
	{
		try
		{
			if (purchase == null)
			{
				throw new ArgumentNullException("purchase");
			}
			PurchaseSuccessful(purchase.productId);
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	private void HandlePurchaseSuccessful(AmazonReceipt receipt)
	{
		PurchaseSuccessful(receipt.sku);
	}

	private void OnPlayerConnected(PhotonPlayer player)
	{
		if (isMine)
		{
			base.GetComponent<PhotonView>().RPC("SetInvisibleRPC", PhotonTargets.Others, isInvisible);
			base.GetComponent<PhotonView>().RPC("CountKillsCommandSynch", PhotonTargets.Others, countKillsCommandBlue, countKillsCommandRed);
			base.GetComponent<PhotonView>().RPC("SetWeaponRPC", PhotonTargets.Others, ((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).weaponPrefab.name, ((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().alternativeName);
			SendSynhHealth(false);
			if (Defs.isJetpackEnabled)
			{
				base.GetComponent<PhotonView>().RPC("SetJetpackEnabledRPC", PhotonTargets.Others, Defs.isJetpackEnabled);
			}
			if (isMechActive)
			{
				base.GetComponent<PhotonView>().RPC("ActivateMechRPC", PhotonTargets.Others, mechUpgrade);
			}
		}
	}

	public void OnPhotonPlayerConnected(PhotonPlayer player)
	{
		if ((bool)photonView && photonView.isMine)
		{
			photonView.RPC("CountKillsCommandSynch", PhotonTargets.Others, countKillsCommandBlue, countKillsCommandRed);
			photonView.RPC("SetInvisibleRPC", PhotonTargets.Others, isInvisible);
			photonView.RPC("SetWeaponRPC", PhotonTargets.Others, ((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).weaponPrefab.name, ((Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().alternativeName);
			SendSynhHealth(false);
			if (Defs.isJetpackEnabled)
			{
				photonView.RPC("SetJetpackEnabledRPC", PhotonTargets.Others, Defs.isJetpackEnabled);
			}
			if (isMechActive)
			{
				photonView.RPC("ActivateMechRPC", PhotonTargets.Others, mechUpgrade);
			}
		}
	}

	public void ShowChat()
	{
		if (!isKilled)
		{
			JoystickController.rightJoystick.jumpPressed = false;
			JoystickController.rightJoystick.Reset();
			RemoveButtonHandelrs();
			showChat = true;
			inGameGUI.gameObject.SetActive(false);
			_weaponManager.currentWeaponSounds.gameObject.SetActive(false);
			mechPoint.SetActive(false);
			GameObject gameObject = (GameObject)UnityEngine.Object.Instantiate(chatViewer);
			gameObject.GetComponent<ChatViewrController>().PlayerObject = base.gameObject;
		}
	}

	public void SetInvisible(bool _isInvisible)
	{
		if (isMulti)
		{
			if (!isInet)
			{
				base.GetComponent<PhotonView>().RPC("SetInvisibleRPC", PhotonTargets.All, _isInvisible);
			}
			else
			{
				photonView.RPC("SetInvisibleRPC", PhotonTargets.All, _isInvisible);
			}
		}
		else
		{
			SetInvisibleRPC(_isInvisible);
		}
	}

	[PunRPC]
	private void SetInvisibleRPC(bool _isInvisible)
	{
		if (Defs.isSoundFX && _isInvisible)
		{
			base.GetComponent<AudioSource>().PlayOneShot(invisibleActivSound);
		}
		isInvisible = _isInvisible;
		if (!isMulti || isMine)
		{
			SetInVisibleShaders(isInvisible);
		}
		else if (!isInvisible)
		{
			invisibleParticle.SetActive(false);
			if (isMechActive)
			{
				mechPoint.SetActive(true);
			}
			else
			{
				mySkinName.FPSplayerObject.SetActive(true);
			}
		}
		else
		{
			invisibleParticle.SetActive(true);
			mySkinName.FPSplayerObject.SetActive(false);
			mechPoint.SetActive(false);
		}
	}

	private void SetInVisibleShaders(bool _isInvisible)
	{
		if (isGrenadePress || WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab == null)
		{
			return;
		}
		if (_isInvisible)
		{
			oldShadersInInvisible = new Shader[WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.transform.parent.GetComponent<Renderer>().materials.Length + ((WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>() != null) ? WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials.Length : 0)];
			oldColorInInvisible = new Color[oldShadersInInvisible.Length];
			oldShadersInInvisible[0] = WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.transform.parent.GetComponent<Renderer>().material.shader;
			WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.transform.parent.GetComponent<Renderer>().material.shader = Shader.Find("Mobile/Diffuse-Color");
			WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.transform.parent.GetComponent<Renderer>().material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
			if (WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>() != null)
			{
				for (int i = 0; i < WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials.Length; i++)
				{
					oldShadersInInvisible[i + 1] = WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials[i].shader;
					oldColorInInvisible[i + 1] = WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials[i].color;
					WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials[i].shader = Shader.Find("Mobile/Diffuse-Color");
					WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials[i].SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
				}
			}
			mechBodyRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
			mechHandRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
			mechGunRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
			return;
		}
		WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.transform.parent.GetComponent<Renderer>().material.shader = oldShadersInInvisible[0];
		if (WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>() != null)
		{
			for (int j = 0; j < WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials.Length; j++)
			{
				WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials[j].shader = oldShadersInInvisible[j + 1];
				WeaponManager.sharedManager.currentWeaponSounds.bonusPrefab.GetComponent<Renderer>().materials[j].color = oldColorInInvisible[j + 1];
			}
		}
		mechBodyRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
		mechHandRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
		mechGunRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
	}

	public void GrenadePress()
	{
		if (indexWeapon != 1001)
		{
			GrenadePressInvoke();
		}
	}

	[Obfuscation(Exclude = true)]
	public void GrenadePressInvoke()
	{
		isGrenadePress = true;
		currentWeaponBeforeGrenade = WeaponManager.sharedManager.CurrentWeaponIndex;
		ChangeWeapon(1000, false);
		timeGrenadePress = Time.realtimeSinceStartup;
		if (inGameGUI != null && inGameGUI.blockedCollider != null)
		{
			inGameGUI.blockedCollider.SetActive(true);
		}
		if (inGameGUI != null && inGameGUI.blockedCollider2 != null)
		{
			inGameGUI.blockedCollider2.SetActive(true);
		}
	}

	public void GrenadeFire()
	{
		if (isGrenadePress)
		{
			float num = Time.realtimeSinceStartup - timeGrenadePress;
			if (isTraining && TrainingController.stepTraining == TrainingController.stepTrainingList["TapToThrowGrenade"])
			{
				TrainingController.isNextStep = TrainingController.stepTrainingList["TapToThrowGrenade"];
			}
			Defs.isGrenateFireEnable = false;
			if (num - 0.4f > 0f)
			{
				GrenadeStartFire();
			}
			else
			{
				Invoke("GrenadeStartFire", 0.4f - num);
			}
		}
	}

	[Obfuscation(Exclude = true)]
	public void GrenadeStartFire()
	{
		if (isMulti)
		{
			if (!isInet)
			{
				base.GetComponent<PhotonView>().RPC("fireFlash", PhotonTargets.All, false, 0);
			}
			else
			{
				photonView.RPC("fireFlash", PhotonTargets.All, false, 0);
			}
		}
		else
		{
			fireFlash(false, 0);
		}
		if (Defs.isHunger)
		{
			Defs.countGrenadeInHunger--;
		}
		else
		{
			Storager.setInt("GrenadeID", Storager.getInt("GrenadeID", false) - 1, false);
		}
		Invoke("RunGrenade", 0.2667f);
		Invoke("SetGrenateFireEnabled", 1f);
	}

	[Obfuscation(Exclude = true)]
	private void SetGrenateFireEnabled()
	{
		Defs.isGrenateFireEnable = true;
	}

	[Obfuscation(Exclude = true)]
	private void RunGrenade()
	{
		if ((bool)currentGrenade)
		{
			currentGrenade.GetComponent<Rigidbody>().isKinematic = false;
			currentGrenade.GetComponent<Rigidbody>().AddForce(150f * myTransform.forward);
			currentGrenade.GetComponent<Rigidbody>().useGravity = true;
			currentGrenade.GetComponent<Rocket>().StartRocket();
		}
		Invoke("ReturnWeaponAfterGrenade", 0.5f);
		isGrenadePress = false;
	}

	[Obfuscation(Exclude = true)]
	private void ReturnWeaponAfterGrenade()
	{
		ChangeWeapon(currentWeaponBeforeGrenade, false);
		if (inGameGUI != null && inGameGUI.blockedCollider != null)
		{
			inGameGUI.blockedCollider.SetActive(false);
		}
		if (inGameGUI != null && inGameGUI.blockedCollider2 != null)
		{
			inGameGUI.blockedCollider2.SetActive(false);
		}
	}

	[PunRPC]
	public void ActivateMechRPC(int num)
	{
		ActivateMech(num);
	}

	[PunRPC]
	public void ActivateMechRPC()
	{
		ActivateMech(0);
	}

	[PunRPC]
	public void DeactivateMechRPC()
	{
		DeactivateMech();
	}

	public void ActivateMech(int num = 0)
	{
		if (isMechActive)
		{
			return;
		}
		if ((!Defs.isMulti || isMine) && isZooming)
		{
			ZoomPress();
		}
		deltaAngle = 0f;
		mechUpgrade = num;
		if (Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().PlayOneShot(mechActivSound);
		}
		isMechActive = true;
		fpsPlayerBody.SetActive(false);
		if (myCurrentWeapon != null)
		{
			myCurrentWeapon.SetActive(false);
		}
		if (isMine || (!isMine && !isInvisible) || !isMulti)
		{
			mechPoint.SetActive(true);
		}
		mechPoint.GetComponent<DisableObjectFromTimer>().timer = -1f;
		myCamera.transform.localPosition = new Vector3(0.12f, 1.34f, -0.3f);
		if (!isMulti || isMine)
		{
			num = GearManager.CurrentNumberOfUphradesForGear(GearManager.Mech);
			mechBody.SetActive(false);
			gunCamera.fieldOfView = 45f;
			if (inGameGUI != null)
			{
				inGameGUI.fireButtonSprite.spriteName = "controls_fire";
				inGameGUI.fireButtonSprite2.spriteName = "controls_fire";
			}
		}
		else
		{
			bodyCollayder.height = 2.07f;
			bodyCollayder.center = new Vector3(0f, 0.19f, 0f);
			headCollayder.center = new Vector3(0f, 0.54f, 0f);
		}
		liveMech = liveMechByTier[num];
		mechBodyRenderer.material = mechBodyMaterials[num];
		mechHandRenderer.material = mechBodyMaterials[num];
		mechGunRenderer.material = mechGunMaterials[num];
		if (isInvisible && (!isMulti || isMine))
		{
			mechBodyRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
			mechHandRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
			mechGunRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 0.5f));
		}
		else
		{
			mechBodyRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
			mechHandRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
		}
		if (isMulti && isMine)
		{
			if (Defs.isInet)
			{
				photonView.RPC("ActivateMechRPC", PhotonTargets.Others, num);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("ActivateMechRPC", PhotonTargets.Others, num);
			}
		}
		for (int i = 0; i < mechWeaponSounds.gunFlashDouble.Length; i++)
		{
			mechWeaponSounds.gunFlashDouble[i].GetChild(0).gameObject.SetActive(false);
		}
	}

	public void DeactivateMech()
	{
		if (!isMechActive)
		{
			return;
		}
		isMechActive = false;
		if (myCurrentWeapon != null)
		{
			myCurrentWeapon.SetActive(true);
		}
		myCamera.transform.localPosition = new Vector3(0f, 0.7f, 0f);
		if (isMulti && !isMine)
		{
			if (!isInvisible)
			{
				fpsPlayerBody.SetActive(true);
			}
			bodyCollayder.height = 1.51f;
			bodyCollayder.center = Vector3.zero;
			headCollayder.center = Vector3.zero;
			mechExplossion.SetActive(true);
			mechExplossionSound.enabled = Defs.isSoundFX;
			mechExplossion.GetComponent<DisableObjectFromTimer>().timer = 1f;
			mechBodyAnimation.Play("Dead");
			mechGunAnimation.Play("Dead");
			mechPoint.GetComponent<DisableObjectFromTimer>().timer = 0.46f;
		}
		else
		{
			mechPoint.SetActive(false);
			gunCamera.fieldOfView = 75f;
			if (inGameGUI != null)
			{
				if (_weaponManager.currentWeaponSounds.isMelee && !_weaponManager.currentWeaponSounds.isShotMelee)
				{
					inGameGUI.fireButtonSprite.spriteName = "controls_strike";
					inGameGUI.fireButtonSprite2.spriteName = "controls_strike";
				}
				else
				{
					inGameGUI.fireButtonSprite.spriteName = "controls_fire";
					inGameGUI.fireButtonSprite2.spriteName = "controls_fire";
				}
			}
		}
		if (!isMulti || isMine)
		{
			PotionsController.sharedController.DeActivePotion(GearManager.Mech, this);
		}
		if (isMulti && isMine)
		{
			if (Defs.isInet)
			{
				photonView.RPC("DeactivateMechRPC", PhotonTargets.Others);
			}
			else
			{
				base.GetComponent<PhotonView>().RPC("DeactivateMechRPC", PhotonTargets.Others);
			}
		}
	}

	[PunRPC]
	private void SyncTurretUpgrade(int turretUpgrade)
	{
		this.turretUpgrade = turretUpgrade;
	}

	public void ShotPressed()
	{
		/*
		#if UNITY_EDITOR
			Weapon zeweapon = (Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex];
			zeweapon.currentAmmoInClip = 9999;
		#endif
		#if !UNITY_EDITOR
			if (deltaAngle > 10f)
			{
				return;
			}
		#endif*/
		if (deltaAngle > 10f)
		{
			return;
		}
		if (isTraining && TrainingController.stepTraining == TrainingController.stepTrainingList["TapToShoot"])
		{
			TrainingController.isNextStep = TrainingController.stepTrainingList["TapToShoot"];
		}
		if ((isMulti && isInet && (bool)photonView && !photonView.isMine) || _weaponManager == null || _weaponManager.currentWeaponSounds == null || _weaponManager.currentWeaponSounds.animationObject == null)
		{
			return;
		}
		Animation animation = ((!isMechActive) ? _weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>() : mechGunAnimation);
		if (animation.IsPlaying(myCAnim("Shoot1")) || animation.IsPlaying(myCAnim("Shoot2")) || animation.IsPlaying(myCAnim("Shoot3")) || animation.IsPlaying(myCAnim("Shoot")) || animation.IsPlaying(myCAnim("Shoot1")) || animation.IsPlaying(myCAnim("Shoot2")) || animation.IsPlaying(myCAnim("Shoot3")) || animation.IsPlaying(myCAnim("Reload")) || animation.IsPlaying(myCAnim("Empty")))
		{
			return;
		}
		animation.Stop();
		if (Defs.isTurretWeapon)
		{
			return;
		}
		if (_weaponManager.currentWeaponSounds.isMelee && !_weaponManager.currentWeaponSounds.isShotMelee && !isMechActive)
		{
			_Shot();
			return;
		}
		Weapon weapon = (Weapon)_weaponManager.playerWeapons[_weaponManager.CurrentWeaponIndex];
		if (weapon.currentAmmoInClip > 0 || isMechActive)
		{
			if (!isMechActive)
			{
				weapon.currentAmmoInClip--;
				if (weapon.currentAmmoInClip == 0)
				{
					if (weapon.currentAmmoInBackpack > 0)
					{
						if (_weaponManager.currentWeaponSounds.isShotMelee)
						{
							Reload();
						}
					}
					else
					{
						TouchPadController rightJoystick = JoystickController.rightJoystick;
						if ((bool)rightJoystick)
						{
							rightJoystick.NoAmmo();
						}
						if (inGameGUI != null)
						{
							inGameGUI.BlinkNoAmmo(3);
							inGameGUI.PlayLowResourceBeep(3);
						}
					}
				}
			}
			_Shot();
			if (!_weaponManager.currentWeaponSounds.isShotMelee || isMechActive)
			{
				if (!_weaponManager.currentWeaponSounds.isWaitWeapon)
				{
				_SetGunFlashActive(true);
				GunFlashLifetime = ((!isMechActive) ? _weaponManager.currentWeaponSounds.gameObject.GetComponent<FlashFire>().timeFireAction : 0.15f);
				}
				else
				{
					StartCoroutine(waitFlash());
				}
			}
			return;
		}
		if (inGameGUI != null)
		{
			inGameGUI.BlinkNoAmmo(1);
			if (weapon.currentAmmoInBackpack == 0)
			{
				inGameGUI.PlayLowResourceBeepIfNotPlaying(1);
			}
		}
		if (!_weaponManager.currentWeaponSounds.isMelee)
		{
			_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().Play(myCAnim("Empty"));
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(_weaponManager.currentWeaponSounds.empty);
			}
		}
	}

	public IEnumerator waitFlash()
	{
		yield return new WaitForSeconds(_weaponManager.currentWeaponSounds.waitTime);
		_SetGunFlashActive(true);
				GunFlashLifetime = ((!isMechActive) ? _weaponManager.currentWeaponSounds.gameObject.GetComponent<FlashFire>().timeFireAction : 0.15f);
	}

	private void _Shot()
	{
		if (isGrenadePress || showChat)
		{
			return;
		}
		float num = 0f;
		if (isMechActive)
		{
			int numShootInDouble = GetNumShootInDouble();
			mechGunAnimation.Play("Shoot" + numShootInDouble);
			num = mechGunAnimation["Shoot" + numShootInDouble].length;
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(shootMechClip);
			}
		}
		else
		{
			if (!_weaponManager.currentWeaponSounds.isDoubleShot)
			{
				foreach (AnimationState ac in _weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()){
					string nm = ac.name.ToString();
//					Debug.Log("found anim: " + nm);
				}
//				Debug.Log(myCAnim("Shoot"));
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().Play(myCAnim("Shoot"));
				num = _weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Shoot")].length;
			}
			else
			{
				int numShootInDouble2 = GetNumShootInDouble();
				_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>().Play("Shoot" + numShootInDouble2);
				num = _weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()["Shoot" + numShootInDouble2].length;
			}
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(_weaponManager.currentWeaponSounds.shoot);
			}
		}
		if (inGameGUI != null)
		{
			inGameGUI.StartFireCircularIndicators(num);
		}
		if (_weaponManager.currentWeaponSounds.isWaitWeapon)
		{
			StartCoroutine(waitShoot());
			return;
		}
		shootS();
	}

	public IEnumerator waitShoot()
	{
		yield return new WaitForSeconds(_weaponManager.currentWeaponSounds.waitTime);
		shootS();
	}

	public IEnumerator waitBazooka()
	{
		yield return new WaitForSeconds(_weaponManager.currentWeaponSounds.waitTime);
		StartCoroutine(BazookaShoot());
	}

	public void shootS()
	{
		if (isGrenadePress)
		{
			return;
		}
		if (!_weaponManager.currentWeaponSounds.isMelee || isMechActive)
		{
			if (_weaponManager.currentWeaponSounds.flamethrower && !isMechActive)
			{
				GameObject[] array = ((!isMulti || isCOOP) ? GameObject.FindGameObjectsWithTag("Enemy") : GameObject.FindGameObjectsWithTag("Player"));
				GameObject[] array2 = GameObject.FindGameObjectsWithTag("Chest");
				GameObject[] array3 = GameObject.FindGameObjectsWithTag("Turret");
				GameObject[] array4 = new GameObject[array.Length + array2.Length + array3.Length];
				Array.Copy(array, array4, array.Length);
				Array.Copy(array2, 0, array4, array.Length, array2.Length);
				Array.Copy(array3, 0, array4, array.Length + array2.Length, array3.Length);
				List<GameObject> list = new List<GameObject>();
				for (int i = 0; i < array4.Length; i++)
				{
					if (!array4[i].transform.position.Equals(_player.transform.position))
					{
						Vector3 to = array4[i].transform.position - _player.transform.position;
						if (to.sqrMagnitude < _weaponManager.currentWeaponSounds.range * _weaponManager.currentWeaponSounds.range && ((Vector3.Angle(base.gameObject.transform.forward, to) < _weaponManager.currentWeaponSounds.meleeAngle) ? true : false))
						{
							list.Add(array4[i]);
						}
					}
				}
				Ray ray = Camera.main.ScreenPointToRay(new Vector3((float)Screen.width * 0.5f, (float)Screen.height * 0.5f, 0f));
				RaycastHit hitInfo;
				if (Physics.Raycast(ray, out hitInfo, _weaponManager.currentWeaponSounds.range, _ShootRaycastLayerMask) && hitInfo.collider.gameObject != null && list != null && !list.Contains(hitInfo.collider.gameObject))
				{
					_DoHit(hitInfo);
				}
				if (!_weaponManager.currentWeaponSounds.isWaitWeapon)
				{
				_FireFlash(0);
				}
				else
				{
				}
				_HitEnemies(list);
				return;
			}
			if (_weaponManager.currentWeaponSounds.bazooka && !isMechActive && !_weaponManager.currentWeaponSounds.isWaitWeapon)
			{
				StartCoroutine(BazookaShoot());
				return;
			}
			else if (_weaponManager.currentWeaponSounds.bazooka && !isMechActive && _weaponManager.currentWeaponSounds.isWaitWeapon)
			{
				StartCoroutine(waitBazooka());
				return;
			}
			
			if ((_weaponManager.currentWeaponSounds.railgun || _weaponManager.currentWeaponSounds.freezer) && !isMechActive)
			{
				Ray ray2 = Camera.main.ScreenPointToRay(new Vector3((float)Screen.width * 0.5f - _weaponManager.currentWeaponSounds.startZone.x * _weaponManager.currentWeaponSounds.tekKoof * Defs.Coef * 0.5f + (float)UnityEngine.Random.Range(0, Mathf.RoundToInt(_weaponManager.currentWeaponSounds.startZone.x * _weaponManager.currentWeaponSounds.tekKoof * Defs.Coef)), (float)Screen.height * 0.5f - _weaponManager.currentWeaponSounds.startZone.y * _weaponManager.currentWeaponSounds.tekKoof * Defs.Coef * 0.5f + (float)UnityEngine.Random.Range(0, Mathf.RoundToInt(_weaponManager.currentWeaponSounds.startZone.y * _weaponManager.currentWeaponSounds.tekKoof * Defs.Coef)), 0f));
				_weaponManager.currentWeaponSounds.fire();
				_FireFlash(0);
				RaycastHit[] array5 = Physics.RaycastAll(ray2, 150f, _ShootRaycastLayerMask);
				if (_weaponManager.currentWeaponSounds.freezer)
				{
					if (array5 == null)
					{
						array5 = new RaycastHit[0];
					}
					Array.Sort(array5, delegate(RaycastHit hit1, RaycastHit hit2)
					{
						float num5 = (hit1.point - GunFlash.position).sqrMagnitude - (hit2.point - GunFlash.position).sqrMagnitude;
						return (num5 > 0f) ? 1 : ((num5 != 0f) ? (-1) : 0);
					});
					bool flag = false;
					RaycastHit raycastHit = default(RaycastHit);
					List<RaycastHit> list2 = new List<RaycastHit>();
					RaycastHit[] array6 = array5;
					for (int j = 0; j < array6.Length; j++)
					{
						RaycastHit raycastHit2 = array6[j];
						if (isHunger && raycastHit2.collider.gameObject != null && raycastHit2.collider.gameObject.CompareTag("Chest"))
						{
							list2.Add(raycastHit2);
							continue;
						}
						if (raycastHit2.collider.gameObject.transform.parent != null && raycastHit2.collider.gameObject.transform.parent.CompareTag("Enemy"))
						{
							list2.Add(raycastHit2);
							continue;
						}
						if (raycastHit2.collider.gameObject.transform.parent != null && raycastHit2.collider.gameObject.transform.parent.CompareTag("Player"))
						{
							list2.Add(raycastHit2);
							continue;
						}
						if (raycastHit2.collider.gameObject != null && raycastHit2.collider.gameObject.CompareTag("Turret"))
						{
							list2.Add(raycastHit2);
							continue;
						}
						flag = true;
						raycastHit = raycastHit2;
						break;
					}
					foreach (RaycastHit item in list2)
					{
						_DoHit(item, true);
					}
					if (!flag)
					{
						return;
					}
					float magnitude = (raycastHit.point - GunFlash.position).magnitude;
					AddFreezerRayWithLength(magnitude);
					if (isMulti)
					{
						if (isInet)
						{
							photonView.RPC("AddFreezerRayWithLength", PhotonTargets.Others, magnitude);
						}
						else
						{
							base.GetComponent<PhotonView>().RPC("AddFreezerRayWithLength", PhotonTargets.Others, magnitude);
						}
					}
				}
				else
				{
					RaycastHit[] array7 = array5;
					foreach (RaycastHit raycastHit3 in array7)
					{
						_DoHit(raycastHit3);
					}
				}
				return;
			}
			WeaponSounds weaponSounds = ((!isMechActive) ? _weaponManager.currentWeaponSounds : mechWeaponSounds);
			int num = ((!weaponSounds.isShotGun || isMechActive) ? 1 : weaponSounds.countShots);
			float distance = ((!weaponSounds.isShotGun) ? 100f : 30f);
			if (weaponSounds.bulletExplode)
			{
				distance = 250f;
			}
			for (int l = 0; l < num; l++)
			{
				Ray ray3 = Camera.main.ScreenPointToRay(new Vector3((float)Screen.width * 0.5f - weaponSounds.startZone.x * weaponSounds.tekKoof * Defs.Coef * 0.5f + (float)UnityEngine.Random.Range(0, Mathf.RoundToInt(weaponSounds.startZone.x * weaponSounds.tekKoof * Defs.Coef)), (float)Screen.height * 0.5f - weaponSounds.startZone.y * weaponSounds.tekKoof * Defs.Coef * 0.5f + (float)UnityEngine.Random.Range(0, Mathf.RoundToInt(weaponSounds.startZone.y * weaponSounds.tekKoof * Defs.Coef)), 0f));
				GameObject gameObject = ((!isMechActive && (weaponSounds.animationObject.name.Equals("Weapon148_Inner(Clone)") || weaponSounds.animationObject.name.Equals("Weapon189_Inner(Clone)") || weaponSounds.animationObject.name.Equals("Weapon190_Inner(Clone)") || weaponSounds.animationObject.name.Equals("Weapon141_Inner(Clone)") || weaponSounds.animationObject.name.Equals("Weapon232_Inner(Clone)") || weaponSounds.animationObject.name.Equals("Weapon191_Inner(Clone)"))) ? (UnityEngine.Object.Instantiate(bulletPrefabRed, (!weaponSounds.isDoubleShot) ? GunFlash.position : weaponSounds.gunFlashDouble[numShootInDoubleShot - 1].position, myTransform.rotation) as GameObject) : ((isMechActive || (!weaponSounds.animationObject.name.Equals("Weapon252_Inner(Clone)") && !weaponSounds.animationObject.name.Equals("Weapon262_Inner(Clone)") && !weaponSounds.animationObject.name.Equals("Weapon267_Inner(Clone)"))) ? BulletStackController.sharedController.GetCurrentBullet() : (UnityEngine.Object.Instantiate(bulletPrefabFor252, GunFlash.position, myTransform.rotation) as GameObject)));
				gameObject.transform.rotation = myTransform.rotation;
				Bullet component = gameObject.GetComponent<Bullet>();
				component.endPos = ray3.GetPoint(200f);
				component.startPos = ((!weaponSounds.isDoubleShot) ? GunFlash.position : weaponSounds.gunFlashDouble[numShootInDoubleShot - 1].position);
				component.StartBullet();
				weaponSounds.fire();
				_FireFlash(weaponSounds.isDoubleShot ? numShootInDoubleShot : 0);
				RaycastHit hitInfo2;
				if (!Physics.Raycast(ray3, out hitInfo2, distance, _ShootRaycastLayerMask))
				{
					continue;
				}
				if ((!weaponSounds.flamethrower && !weaponSounds.bulletExplode) || isMechActive)
				{
					bool flag2;
					if (hitInfo2.collider.gameObject.transform.parent != null && !hitInfo2.collider.gameObject.transform.parent.CompareTag("Enemy") && !hitInfo2.collider.gameObject.transform.parent.CompareTag("Player"))
					{
						Vector3 pos = hitInfo2.point + hitInfo2.normal * 0.001f;
						Quaternion rot = Quaternion.FromToRotation(Vector3.up, hitInfo2.normal);
						HoleScript currentHole = HoleBulletStackController.sharedController.GetCurrentHole(true);
						if (currentHole != null)
						{
							currentHole.StartShowHole(pos, rot, true);
						}
						WallBloodParticle currentParticle = WallParticleStackController.sharedController.GetCurrentParticle(true);
						if (currentParticle != null)
						{
							currentParticle.StartShowParticle(pos, rot, true);
						}
						flag2 = false;
					}
					else
					{
						Vector3 pos2 = hitInfo2.point + hitInfo2.normal * 0.001f;
						Quaternion rot2 = Quaternion.FromToRotation(Vector3.up, hitInfo2.normal);
						WallBloodParticle currentParticle2 = BloodParticleStackController.sharedController.GetCurrentParticle(true);
						if (currentParticle2 != null)
						{
							currentParticle2.StartShowParticle(pos2, rot2, true);
						}
						flag2 = true;
					}
					if (isMulti)
					{
						if (!isInet)
						{
							base.GetComponent<PhotonView>().RPC("HoleRPC", PhotonTargets.Others, flag2, hitInfo2.point + hitInfo2.normal * 0.001f, Quaternion.FromToRotation(Vector3.up, hitInfo2.normal));
						}
						else
						{
							photonView.RPC("HoleRPC", PhotonTargets.Others, flag2, hitInfo2.point + hitInfo2.normal * 0.001f, Quaternion.FromToRotation(Vector3.up, hitInfo2.normal));
						}
					}
				}
				if (weaponSounds.bulletExplode)
				{
					Rocket rocket = CreateRocket(hitInfo2.point, Quaternion.identity, koofDamageWeaponFromPotoins, isMulti, isInet, TierOrRoomTier((!(ExpController.Instance != null)) ? (ExpController.LevelsForTiers.Length - 1) : ExpController.Instance.OurTier));
					rocket.dontExecStart = true;
					rocket.SetRocketActiveSendRPC();
					rocket.KillRocket(hitInfo2.collider.gameObject);
				}
				else
				{
					_DoHit(hitInfo2);
				}
			}
			return;
		}
		if (isMulti)
		{
			if (!isInet)
			{
				base.GetComponent<PhotonView>().RPC("fireFlash", PhotonTargets.Others, false, 0);
			}
			else
			{
				photonView.RPC("fireFlash", PhotonTargets.Others, false, 0);
			}
		}
		if (_weaponManager.currentWeaponSounds.isRoundMelee)
		{
			StartCoroutine(HitRoundMelee());
			return;
		}
		if (!_weaponManager.currentWeaponSounds.isMagic)
		{
			Ray ray4 = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0f));
			RaycastHit hitInfo3;
			if (Physics.Raycast(ray4, out hitInfo3, 300f, _ShootRaycastLayerMask) && ((hitInfo3.collider.gameObject.transform.parent == null && !hitInfo3.collider.gameObject.transform.CompareTag("Player") && !hitInfo3.collider.gameObject.CompareTag("Chest") && !hitInfo3.collider.gameObject.CompareTag("Turret")) || (hitInfo3.collider.gameObject.transform.parent != null && !hitInfo3.collider.gameObject.transform.parent.CompareTag("Enemy") && !hitInfo3.collider.gameObject.transform.parent.CompareTag("Player"))))
			{
				return;
			}
		}
		if (isHunger)
		{
			GameObject[] array8 = GameObject.FindGameObjectsWithTag("Chest");
			GameObject gameObject2 = null;
			if (array8 != null)
			{
				if (gameObject2 == null)
				{
					Ray ray5 = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0f));
					RaycastHit hitInfo4;
					if (Physics.Raycast(ray5, out hitInfo4, _weaponManager.currentWeaponSounds.range, _ShootRaycastLayerMask) && (bool)hitInfo4.collider.gameObject && hitInfo4.collider.gameObject.CompareTag("Chest"))
					{
						gameObject2 = hitInfo4.collider.gameObject;
					}
				}
				if (!_weaponManager.currentWeaponSounds.isShotMelee && gameObject2 == null)
				{
					float num2 = float.PositiveInfinity;
					for (int m = 0; m < array8.Length; m++)
					{
						Vector3 to2 = array8[m].transform.position - _player.transform.position;
						float sqrMagnitude = to2.sqrMagnitude;
						if (sqrMagnitude < num2 && ((sqrMagnitude < _weaponManager.currentWeaponSounds.range * _weaponManager.currentWeaponSounds.range && Vector3.Angle(base.gameObject.transform.forward, to2) < _weaponManager.currentWeaponSounds.meleeAngle) || sqrMagnitude < 2.25f))
						{
							num2 = sqrMagnitude;
							gameObject2 = array8[m];
						}
					}
				}
				if ((bool)gameObject2)
				{
					float num3 = ((ExpController.Instance != null && ExpController.Instance.OurTier < _weaponManager.currentWeaponSounds.damageByTier.Length) ? _weaponManager.currentWeaponSounds.damageByTier[TierOrRoomTier(ExpController.Instance.OurTier)] : ((_weaponManager.currentWeaponSounds.damageByTier.Length <= 0) ? 0f : _weaponManager.currentWeaponSounds.damageByTier[0]));
					gameObject2.GetComponent<ChestController>().MinusLive(num3 * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1)));
				}
			}
		}
		GameObject[] array9 = ((!isMulti || isCOOP) ? GameObject.FindGameObjectsWithTag("Enemy") : GameObject.FindGameObjectsWithTag("Player"));
		GameObject gameObject3 = null;
		GameObject hittedPart = null;
		if (gameObject3 == null)
		{
			Ray ray6 = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0f));
			RaycastHit hitInfo5;
			if (Physics.Raycast(ray6, out hitInfo5, _weaponManager.currentWeaponSounds.range, _ShootRaycastLayerMask))
			{
				if ((bool)hitInfo5.collider.gameObject.transform.parent && hitInfo5.collider.gameObject.transform.parent.CompareTag("Player"))
				{
					gameObject3 = hitInfo5.collider.gameObject.transform.parent.gameObject;
					hittedPart = hitInfo5.collider.gameObject;
				}
				else if ((bool)hitInfo5.collider.gameObject.transform.parent && hitInfo5.collider.gameObject.transform.parent.CompareTag("Enemy"))
				{
					gameObject3 = hitInfo5.collider.gameObject.transform.parent.gameObject;
				}
				else if ((bool)hitInfo5.collider.gameObject && hitInfo5.collider.gameObject.CompareTag("Turret"))
				{
					gameObject3 = hitInfo5.collider.gameObject;
				}
			}
		}
		if (!_weaponManager.currentWeaponSounds.isShotMelee && gameObject3 == null)
		{
			float num4 = float.PositiveInfinity;
			GameObject[] array10 = array9;
			foreach (GameObject gameObject4 in array10)
			{
				if (!gameObject4.transform.position.Equals(_player.transform.position))
				{
					Vector3 to3 = gameObject4.transform.position - _player.transform.position;
					float sqrMagnitude2 = to3.sqrMagnitude;
					if (sqrMagnitude2 < num4 && ((sqrMagnitude2 < _weaponManager.currentWeaponSounds.range * _weaponManager.currentWeaponSounds.range && Vector3.Angle(base.gameObject.transform.forward, to3) < _weaponManager.currentWeaponSounds.meleeAngle) || sqrMagnitude2 < 2.25f))
					{
						num4 = sqrMagnitude2;
						gameObject3 = gameObject4;
					}
				}
			}
		}
		if ((bool)gameObject3)
		{
			StartCoroutine(HitByMelee(gameObject3, hittedPart));
		}
	}

	public static Rocket CreateRocket(Vector3 pos, Quaternion rot, float customDamageAdd, bool isMulti, bool isInet, int tierOrRoomTier)
	{
		GameObject gameObject = null;
		gameObject = ((!isMulti) ? (UnityEngine.Object.Instantiate(Resources.Load("Rocket") as GameObject, pos, rot) as GameObject) : (isInet ? PhotonNetwork.Instantiate("Rocket", pos, rot, 0) : ((GameObject)PhotonNetwork.Instantiate("Rocket", pos, rot, 0))));
		Rocket component = gameObject.GetComponent<Rocket>();
		component.rocketNum = WeaponManager.sharedManager.currentWeaponSounds.rocketNum;
		component.weaponName = WeaponManager.sharedManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty);
		component.damage = (float)WeaponManager.sharedManager.currentWeaponSounds.damage * (1f + customDamageAdd + EffectsController.DamageModifsByCats(WeaponManager.sharedManager.currentWeaponSounds.categoryNabor - 1));
		component.radiusDamage = WeaponManager.sharedManager.currentWeaponSounds.bazookaExplosionRadius;
		component.radiusDamageSelf = WeaponManager.sharedManager.currentWeaponSounds.bazookaExplosionRadiusSelf;
		component.radiusImpulse = WeaponManager.sharedManager.currentWeaponSounds.bazookaImpulseRadius * (1f + EffectsController.ExplosionImpulseRadiusIncreaseCoef);
		component.damageRange = WeaponManager.sharedManager.currentWeaponSounds.damageRange * (1f + customDamageAdd + EffectsController.DamageModifsByCats(WeaponManager.sharedManager.currentWeaponSounds.categoryNabor - 1));
		component.isSlowdown = WeaponManager.sharedManager.currentWeaponSounds.isSlowdown;
		component.slowdownCoeff = WeaponManager.sharedManager.currentWeaponSounds.slowdownCoeff;
		component.slowdownTime = WeaponManager.sharedManager.currentWeaponSounds.slowdownTime;
		float num = (component.multiplayerDamage = ((ExpController.Instance != null && ExpController.Instance.OurTier < WeaponManager.sharedManager.currentWeaponSounds.damageByTier.Length) ? WeaponManager.sharedManager.currentWeaponSounds.damageByTier[tierOrRoomTier] : ((WeaponManager.sharedManager.currentWeaponSounds.damageByTier.Length <= 0) ? 0f : WeaponManager.sharedManager.currentWeaponSounds.damageByTier[0])));
		gameObject.GetComponent<Rigidbody>().useGravity = WeaponManager.sharedManager.currentWeaponSounds.grenadeLauncher;
		return component;
	}

	private IEnumerator BazookaShoot()
	{
		for (int i = 0; i < _weaponManager.currentWeaponSounds.countInSeriaBazooka; i++)
		{
			_weaponManager.currentWeaponSounds.fire();
			_FireFlash(0);
			float rangeFromUs = 0.2f;
			Rocket rocketScript = CreateRocket(myTransform.position + myTransform.forward * rangeFromUs, myTransform.rotation, koofDamageWeaponFromPotoins, isMulti, isInet, TierOrRoomTier((!(ExpController.Instance != null)) ? (ExpController.LevelsForTiers.Length - 1) : ExpController.Instance.OurTier));
			rocketToLaunch = rocketScript.gameObject;
			if (i != _weaponManager.currentWeaponSounds.countInSeriaBazooka - 1)
			{
				yield return new WaitForSeconds(_weaponManager.currentWeaponSounds.stepTimeInSeriaBazooka);
			}
		}
	}

	private void RunOnGroundEffect(string name)
	{
		if (name != null && !(mySkinName == null))
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(Resources.Load<GameObject>("OnGroundWeaponEffects/" + name + "_OnGroundEffect")) as GameObject;
			PerformActionRecurs(gameObject, delegate(Transform t)
			{
				t.gameObject.SetActive(false);
			});
			gameObject.transform.parent = mySkinName.onGroundEffectsPoint;
			gameObject.transform.localPosition = Vector3.zero;
			PerformActionRecurs(gameObject, delegate(Transform t)
			{
				t.gameObject.SetActive(true);
			});
			ParticleSystem component = gameObject.GetComponent<ParticleSystem>();
			if (component != null)
			{
				component.Play();
			}
			if (gameObject.transform.childCount > 0)
			{
				Transform child = gameObject.transform.GetChild(0);
			}
		}
	}

	private IEnumerator HitRoundMelee()
	{
		yield return new WaitForSeconds(TimeOfMeleeAttack(_weaponManager.currentWeaponSounds));
		RunOnGroundEffect(_weaponManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty));
		float radiusDamageSQR = _weaponManager.currentWeaponSounds.radiusRoundMelee * _weaponManager.currentWeaponSounds.radiusRoundMelee;
		Vector3 point = myPlayerTransform.position + new Vector3(0f, 1.8f, 0f);
		if (!Defs.isMulti || Defs.isCOOP)
		{
			GameObject[] enemies = GameObject.FindGameObjectsWithTag("Enemy");
			for (int i = 0; i < enemies.Length; i++)
			{
				bool _isHit2 = false;
				float distanceSqr2 = (enemies[i].transform.position - point).sqrMagnitude;
				if (distanceSqr2 < radiusDamageSQR)
				{
					_isHit2 = true;
				}
				if (_isHit2)
				{
					float dmMin = (float)_weaponManager.currentWeaponSounds.damage + WeaponManager.sharedManager.currentWeaponSounds.damageRange.x;
					float dmMax = (float)_weaponManager.currentWeaponSounds.damage + WeaponManager.sharedManager.currentWeaponSounds.damageRange.y;
					float num = dmMin;
					float damage = (dmMin + num * (1f - distanceSqr2 / radiusDamageSQR)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1));
					BaseBot baseBot = BaseBot.GetBotScriptForObject(enemies[i].transform);
					if (!isMulti)
					{
						baseBot.GetDamage(0f - damage, myPlayerTransform);
					}
					else if (!baseBot.IsDeath)
					{
						baseBot.GetDamageForMultiplayer(0f - damage, null);
						_weaponManager.myNetworkStartTable.score = GlobalGameController.Score;
						_weaponManager.myNetworkStartTable.SynhScore();
					}
				}
			}
		}
		if (Defs.isMulti)
		{
			GameObject[] turrets = GameObject.FindGameObjectsWithTag("Turret");
			for (int j = 0; j < turrets.Length; j++)
			{
				TurretController _turretScript = turrets[j].GetComponent<TurretController>();
				bool _isHit = false;
				if (!_turretScript.isEnemyTurret)
				{
					continue;
				}
				float distanceSqr = (turrets[j].transform.position - point).sqrMagnitude;
				if (distanceSqr < radiusDamageSQR)
				{
					_isHit = true;
				}
				if (_isHit)
				{
					float dmMin2 = (float)_weaponManager.currentWeaponSounds.damage + WeaponManager.sharedManager.currentWeaponSounds.damageRange.x;
					float dmMax2 = (float)_weaponManager.currentWeaponSounds.damage + WeaponManager.sharedManager.currentWeaponSounds.damageRange.y;
					float num = dmMin2;
					float damage2 = (dmMin2 + num * (1f - distanceSqr / radiusDamageSQR)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1));
					if (Defs.isInet)
					{
						_turretScript.MinusLive(damage2, WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID);
					}
					else
					{
						_turretScript.MinusLive(damage2, Convert.ToInt32(WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID));
					}
				}
			}
		}
		if (!isMulti)
		{
			yield break;
		}
		GameObject[] players = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array = players;
		foreach (GameObject plr in array)
		{
			bool isMinePlayers = false;
			isMinePlayers = (isInet ? plr.GetComponent<PhotonView>().isMine : plr.GetComponent<PhotonView>().isMine);
			Player_move_c playerMoveC = plr.GetComponent<SkinName>().playerMoveC;
			if (isCOOP || isMinePlayers || ((isCompany || Defs.isFlag || Defs.isCapturePoints) && ((!isCompany && !Defs.isFlag && !Defs.isCapturePoints) || playerMoveC.myCommand == _weaponManager.myTable.GetComponent<NetworkStartTable>().myCommand)))
			{
				continue;
			}
			bool _isHit3 = false;
			bool _isHeadShot = false;
			float distanceSqr3 = (plr.transform.position - point).sqrMagnitude;
			if (distanceSqr3 < radiusDamageSQR)
			{
				_isHit3 = true;
			}
			if (_isHit3)
			{
				GameObject _objLabelPlayer = playerMoveC._label;
				if (_objLabelPlayer != null)
				{
					_objLabelPlayer.GetComponent<NickLabelController>().ResetTimeShow();
				}
				float dm = ((ExpController.Instance != null && ExpController.Instance.OurTier < _weaponManager.currentWeaponSounds.damageByTier.Length) ? _weaponManager.currentWeaponSounds.damageByTier[TierOrRoomTier(ExpController.Instance.OurTier)] : ((_weaponManager.currentWeaponSounds.damageByTier.Length <= 0) ? 0f : _weaponManager.currentWeaponSounds.damageByTier[0]));
				float dmMin3 = dm * 0.7f;
				float dmMax3 = dm;
				float num = dmMin3;
				float damage3 = (dmMin3 + num * (1f - distanceSqr3 / radiusDamageSQR)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1));
				if (!isInet)
				{
					playerMoveC.MinusLive(_weaponManager.myPlayer.GetComponent<PhotonView>().viewID, damage3, TypeKills.none, (int)_weaponManager.currentWeaponSounds.typeDead, _weaponManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty));
				}
				else
				{
					playerMoveC.MinusLive(_weaponManager.myPlayer.GetComponent<PhotonView>().viewID, damage3, TypeKills.none, (int)_weaponManager.currentWeaponSounds.typeDead, _weaponManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty));
				}
			}
		}
	}

	private IEnumerator HitByMelee(GameObject enemyToHit, GameObject hittedPart = null)
	{
		yield return new WaitForSeconds(_weaponManager.currentWeaponSounds.animationObject.GetComponent<Animation>()[myCAnim("Shoot")].length * _weaponManager.currentWeaponSounds.meleeAttackTimeModifier);
		if (!(enemyToHit != null))
		{
			yield break;
		}
		if (enemyToHit.CompareTag("Turret"))
		{
			if (enemyToHit.GetComponent<TurretController>().isEnemyTurret)
			{
				float dm = ((ExpController.Instance != null && ExpController.Instance.OurTier < _weaponManager.currentWeaponSounds.damageByTier.Length) ? _weaponManager.currentWeaponSounds.damageByTier[TierOrRoomTier(ExpController.Instance.OurTier)] : ((_weaponManager.currentWeaponSounds.damageByTier.Length <= 0) ? 0f : _weaponManager.currentWeaponSounds.damageByTier[0]));
				if (Defs.isInet)
				{
					enemyToHit.GetComponent<TurretController>().MinusLive(dm, myPlayerTransform.GetComponent<PhotonView>().viewID);
				}
				else
				{
					enemyToHit.GetComponent<TurretController>().MinusLive(dm, Convert.ToInt32(myPlayerTransform.GetComponent<PhotonView>().viewID));
				}
			}
			yield break;
		}
		if (isMulti && !isCOOP)
		{
			if (((isCompany || Defs.isFlag || Defs.isCapturePoints) && ((!isCompany && !Defs.isFlag && !Defs.isCapturePoints) || myCommand == enemyToHit.GetComponent<SkinName>().playerGameObject.GetComponent<Player_move_c>().myCommand)) || !isMulti)
			{
				yield break;
			}
			float koofMinus = 1f;
			bool isHeadShot = false;
			if (hittedPart != null)
			{
				isHeadShot = hittedPart.CompareTag("HeadCollider") && !_weaponManager.currentWeaponSounds.flamethrower;
				if (isHeadShot)
				{
					float val = UnityEngine.Random.Range(0f, 1f);
					isHeadShot = val >= enemyToHit.GetComponent<SkinName>().playerMoveC._chanceToIgnoreHeadshot;
				}
				if (isHeadShot && !_weaponManager.currentWeaponSounds.flamethrower)
				{
					koofMinus = 2f + EffectsController.AddingForHeadshot(_weaponManager.currentWeaponSounds.categoryNabor - 1);
				}
			}
			GameObject _objLabelPlayer = enemyToHit.GetComponent<SkinName>().playerMoveC._label;
			if (_objLabelPlayer != null)
			{
				_objLabelPlayer.GetComponent<NickLabelController>().ResetTimeShow();
			}
			float dm2 = ((ExpController.Instance != null && ExpController.Instance.OurTier < _weaponManager.currentWeaponSounds.damageByTier.Length) ? _weaponManager.currentWeaponSounds.damageByTier[TierOrRoomTier(ExpController.Instance.OurTier)] : ((_weaponManager.currentWeaponSounds.damageByTier.Length <= 0) ? 0f : _weaponManager.currentWeaponSounds.damageByTier[0]));
			if (!isInet)
			{
				enemyToHit.GetComponent<SkinName>().playerMoveC.MinusLive(myPlayerTransform.GetComponent<PhotonView>().viewID, dm2 * koofMinus * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1)), isHeadShot ? TypeKills.headshot : TypeKills.none, (int)((!isMechActive) ? _weaponManager.currentWeaponSounds.typeDead : WeaponSounds.TypeDead.angel), _weaponManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty));
			}
			else
			{
				enemyToHit.GetComponent<SkinName>().playerMoveC.MinusLive(myPlayerTransform.GetComponent<PhotonView>().viewID, dm2 * koofMinus * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1)), isHeadShot ? TypeKills.headshot : TypeKills.none, (int)((!isMechActive) ? _weaponManager.currentWeaponSounds.typeDead : WeaponSounds.TypeDead.angel), _weaponManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty));
			}
			yield break;
		}
		BaseBot baseBot = BaseBot.GetBotScriptForObject(enemyToHit.transform);
		if (isMulti && isCOOP)
		{
			if (!baseBot.IsDeath)
			{
				float damage2 = ((float)_weaponManager.currentWeaponSounds.damage + UnityEngine.Random.Range(_weaponManager.currentWeaponSounds.damageRange.x, _weaponManager.currentWeaponSounds.damageRange.y)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1));
				baseBot.GetDamageForMultiplayer(0f - damage2, null);
				_weaponManager.myNetworkStartTable.score = GlobalGameController.Score;
				_weaponManager.myNetworkStartTable.SynhScore();
			}
		}
		else if (baseBot != null && !baseBot.IsDeath)
		{
			WeaponSounds weaponSettings = _weaponManager.currentWeaponSounds;
			float damage = ((float)(-weaponSettings.damage) + UnityEngine.Random.Range(weaponSettings.damageRange.x, weaponSettings.damageRange.y)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(weaponSettings.categoryNabor - 1));
			baseBot.GetDamage(damage, myPlayerTransform);
		}
	}

	private void _DoHit(RaycastHit _hit, bool slowdown = false)
	{
		if (isHunger && (bool)_hit.collider.gameObject && _hit.collider.gameObject.CompareTag("Chest"))
		{
			_HitChest(_hit.collider.gameObject);
		}
		if ((bool)_hit.collider.gameObject && _hit.collider.gameObject.CompareTag("Turret"))
		{
			_HitTurret(_hit.collider.gameObject);
		}
		if ((bool)_hit.collider.gameObject.transform.parent && _hit.collider.gameObject.transform.parent.CompareTag("Enemy"))
		{
			_HitZombie(_hit.collider.gameObject);
		}
		if ((bool)_hit.collider.gameObject.transform.parent && _hit.collider.gameObject.transform.parent.CompareTag("Player"))
		{
			_HitPlayer(_hit.collider.gameObject.transform.parent.gameObject, _hit.collider.gameObject);
			if (!slowdown)
			{
			}
		}
	}

	[PunRPC]
	public void SlowdownRPC(float coef, float time)
	{
		if (isMine || !isMulti)
		{
			EffectsController.SlowdownCoeff = coef;
			_timeOfSlowdown = time;
		}
	}

	private void _HitChest(GameObject go)
	{
		Debug.LogError("hit registered on chest");
		WeaponSounds weaponSounds = ((!isMechActive) ? _weaponManager.currentWeaponSounds : mechWeaponSounds);
		go.GetComponent<ChestController>().MinusLive(((float)weaponSounds.damage + UnityEngine.Random.Range(weaponSounds.damageRange.x, weaponSounds.damageRange.y)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(weaponSounds.categoryNabor - 1)));
	}

	private void _HitZombie(GameObject zmb)
	{
		Debug.LogError("hit registered on zombie");
		WeaponSounds weaponSounds = ((!isMechActive) ? _weaponManager.currentWeaponSounds : mechWeaponSounds);
		BaseBot botScriptForObject = BaseBot.GetBotScriptForObject(zmb.transform.parent);
		if (!isMulti)
		{
			float num = ((float)(-weaponSounds.damage) + UnityEngine.Random.Range(weaponSounds.damageRange.x, weaponSounds.damageRange.y)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(weaponSounds.categoryNabor - 1));
			botScriptForObject.GetDamage(num, myPlayerTransform);
		}
		else if (isCOOP && !botScriptForObject.IsDeath)
		{
			float num2 = ((float)weaponSounds.damage + UnityEngine.Random.Range(weaponSounds.damageRange.x, weaponSounds.damageRange.y)) * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(weaponSounds.categoryNabor - 1));
			botScriptForObject.GetDamageForMultiplayer(0f - num2, null);
			_weaponManager.myTable.GetComponent<NetworkStartTable>().score = GlobalGameController.Score;
			_weaponManager.myNetworkStartTable.SynhScore();
		}
	}

	private void _HitTurret(GameObject _turret)
	{
		Debug.LogError("hit registered on turret");
		if (_turret.GetComponent<TurretController>().isEnemyTurret)
		{
			float num = GetMultyDamage() * (1f + koofDamageWeaponFromPotoins);
			myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.damageTurret, num);
			if (Defs.isInet)
			{
				_turret.GetComponent<TurretController>().MinusLive(num, myPlayerTransform.GetComponent<PhotonView>().viewID);
			}
			else
			{
				_turret.GetComponent<TurretController>().MinusLive(num, Convert.ToInt32(myPlayerTransform.GetComponent<PhotonView>().viewID));
			}
		}
	}

	private void _HitPlayer(GameObject plr, GameObject hitGameObject)
	{
		Debug.LogError("hit registered on player");
		GameObject label = plr.GetComponent<SkinName>().playerMoveC._label;
		if (label != null)
		{
			label.GetComponent<NickLabelController>().ResetTimeShow();
		}
		float num = 1f;
		bool flag = false;
		if (hitGameObject != null)
		{
			flag = hitGameObject.CompareTag("HeadCollider") && !_weaponManager.currentWeaponSounds.flamethrower;
			if (flag)
			{
				float num2 = UnityEngine.Random.Range(0f, 1f);
				flag = num2 >= plr.GetComponent<SkinName>().playerMoveC._chanceToIgnoreHeadshot;
			}
			if (flag && !_weaponManager.currentWeaponSounds.flamethrower)
			{
				num = 2f + EffectsController.AddingForHeadshot(_weaponManager.currentWeaponSounds.categoryNabor - 1);
			}
		}
		if ((isMulti && !isCOOP && !isCompany && !Defs.isFlag && !Defs.isCapturePoints) || ((isCompany || Defs.isFlag || Defs.isCapturePoints) && myCommand != plr.GetComponent<SkinName>().playerMoveC.myCommand))
		{
			TypeKills typeKills = (isMechActive ? TypeKills.mech : (flag ? TypeKills.headshot : (isZooming ? TypeKills.zoomingshot : TypeKills.none)));
			float num3 = GetMultyDamage() * num * (1f + koofDamageWeaponFromPotoins + EffectsController.DamageModifsByCats(_weaponManager.currentWeaponSounds.categoryNabor - 1));
			myScoreController.AddScoreOnEvent(plr.GetComponent<SkinName>().playerMoveC.isMechActive ? ((!flag) ? PlayerEventScoreController.ScoreEvent.damageMechBody : PlayerEventScoreController.ScoreEvent.damageMechHead) : (flag ? PlayerEventScoreController.ScoreEvent.damageHead : PlayerEventScoreController.ScoreEvent.damageBody), num3);
			if (!isInet)
			{
				plr.GetComponent<SkinName>().playerMoveC.MinusLive(myPlayerIDLocal, num3, typeKills, (int)((!isMechActive) ? _weaponManager.currentWeaponSounds.typeDead : WeaponSounds.TypeDead.angel), (!isMechActive) ? _weaponManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty) : "Chat_Mech");
			}
			else
			{
				plr.GetComponent<SkinName>().playerMoveC.MinusLive(myPlayerID, num3, typeKills, (int)((!isMechActive) ? _weaponManager.currentWeaponSounds.typeDead : WeaponSounds.TypeDead.angel), (!isMechActive) ? _weaponManager.currentWeaponSounds.gameObject.name.Replace("(Clone)", string.Empty) : "Chat_Mech");
			}
		}
	}

	private void InitPurchaseActions()
	{
		_actionsForPurchasedItems.Add("bigammopack", ProvideAmmo);
		_actionsForPurchasedItems.Add("Fullhealth", ProvideHealth);
		_actionsForPurchasedItems.Add(StoreKitEventListener.elixirID, delegate
		{
			Defs.NumberOfElixirs++;
		});
		_actionsForPurchasedItems.Add(StoreKitEventListener.armor, delegate
		{
		});
		_actionsForPurchasedItems.Add(StoreKitEventListener.armor2, delegate
		{
		});
		_actionsForPurchasedItems.Add(StoreKitEventListener.armor3, delegate
		{
		});
		string[] potions = PotionsController.potions;
		foreach (string key in potions)
		{
			_actionsForPurchasedItems.Add(key, providePotion);
		}
		string[] canBuyWeaponTags = ItemDb.GetCanBuyWeaponTags(true);
		for (int j = 0; j < canBuyWeaponTags.Length; j++)
		{
			string shopIdByTag = ItemDb.GetShopIdByTag(canBuyWeaponTags[j]);
			_actionsForPurchasedItems.Add(shopIdByTag, AddWeaponToInv);
		}
	}

	private void AddWeaponToInv(string shopId)
	{
		string tagByShopId = ItemDb.GetTagByShopId(shopId);
		ItemRecord byTag = ItemDb.GetByTag(tagByShopId);
		if (tagByShopId == WeaponTags.Red_StoneTag || tagByShopId == WeaponTags.GoldenRed_StoneTag || tagByShopId == WeaponTags.grenade_launcher_3_Tag || tagByShopId == WeaponTags.GrenadeLuancher_2Tag)
		{
			if (!Defs.IsTraining && byTag != null && !byTag.TemporaryGun)
			{
				SaveWeaponInPrefs(tagByShopId);
			}
		}
		else if (!Defs.IsTraining && byTag != null && !byTag.TemporaryGun)
		{
			SaveWeaponInPrefs(tagByShopId);
		}
		GameObject prefabByTag = _weaponManager.GetPrefabByTag(tagByShopId);
		AddWeapon(prefabByTag);
	}

	public static void SaveWeaponInPrefs(string weaponTag, int timeForRentIndex = 0)
	{
		string storageIdByTag = ItemDb.GetStorageIdByTag(weaponTag);
		if (storageIdByTag == null)
		{
			int tm = TempItemsController.RentTimeForIndex(timeForRentIndex);
			TempItemsController.sharedController.AddTemporaryItem(weaponTag, tm);
		}
		else
		{
			Storager.setInt(storageIdByTag, 1, true);
			PlayerPrefs.Save();
		}
	}
}
