using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Holoville.HOTween;
using Holoville.HOTween.Core;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

public sealed class InGameGUI : MonoBehaviour
{
	public delegate float GetFloatVAlue();

	public delegate string GetString();

	public delegate int GetIntVAlue();

	private const string weaponCat = "WeaponCat_";

	public UILabel reloadLabel;

	public UISprite reloadCircularSprite;

	public UISprite fireCircularSprite;

	public UISprite fireAdditionalCrcualrSprite;

	private UISprite[] circularSprites;

	public UILabel newWave;

	public UILabel waveDone;

	public UILabel SurvivalWaveNumber;

	public GameObject deathmatchContainer;

	public GameObject teamBattleContainer;

	public GameObject timeBattleContainer;

	public GameObject deadlygamesContainer;

	public GameObject flagCaptureContainer;

	public GameObject survivalContainer;

	public GameObject CampaignContainer;

	public GameObject CapturePointContainer;

	public GameObject[] hidesPanelInTurrel;

	public GameObject turretPanel;

	public ButtonHandler runTurrelButton;

	public ButtonHandler cancelTurrelButton;

	[Range(1f, 1000f)]
	public float minLength = 300f;

	[Range(1f, 1000f)]
	public float maxLength = 550f;

	[Range(1f, 1000f)]
	public float defaultPanelLength = 486f;

	public UISprite bottomPanelSprite;

	public UISlider bottomPanelSlider;

	public Transform sideObjGearShop;

	public static InGameGUI sharedInGameGUI;

	public GameObject characterDrag;

	public GameObject cameraDrag;

	public GameObject pausePanel;

	public Transform shopPanelForTap;

	public Transform shopPanelForSwipe;

	public Transform swipeWeaponPanel;

	public Transform fastShopRightPanel;

	public static Vector3 swipeWeaponPanelPos;

	public static Vector3 shopPanelForTapPos;

	public static Vector3 shopPanelForSwipePos;

	public static Vector3 fastShopRightPanelPos;

	public GameObject blockedCollider;

	public GameObject blockedCollider2;

	public GameObject zoomButton;

	public GameObject reloadButton;

	public GameObject jumpButton;

	public GameObject fireButton;

	public GameObject fireButtonInJoystick;

	public GameObject joystick;

	public GameObject grenadeButton;

	public UISprite fireButtonSprite;

	public UISprite fireButtonSprite2;

	public GameObject aimPanel;

	public GameObject flagBlueCaptureTexture;

	public GameObject flagRedCaptureTexture;

	public GameObject message_draw;

	public GameObject message_now;

	public GameObject message_wait;

	public float timerShowNow;

	public GameObject interfacePanel;

	public UILabel timerStartHungerLabel;

	public GameObject shopButton;

	public GameObject shopButtonInPause;

	public GameObject enemiesLeftLabel;

	public GameObject duel;

	public GameObject downBloodTexture;

	public GameObject upBloodTexture;

	public GameObject leftBloodTexture;

	public GameObject rightBloodTexture;

	public GameObject aimUp;

	public GameObject aimDown;

	public GameObject aimRight;

	public GameObject aimLeft;

	public GameObject topAnchor;

	public GameObject leftAnchor;

	public GameObject rightAnchor;

	public GameObject bottomAnchor;

	public GetFloatVAlue health;

	public GetFloatVAlue armor;

	public GetIntVAlue armorType;

	public GetString killsToMaxKills;

	public GetString timeLeft;

	public UIButton gearToogle;

	public UIButton[] weaponCategoriesButtons;

	public UILabel[] ammoCategoriesLabels;

	public GameObject fonBig;

	public GameObject fonSmall;

	public GameObject settingsController;

	public UISprite[] hearts;

	public UISprite[] armorShields;

	public UISprite[] mechShields;

	public DamageTakenController[] damageTakenControllers;

	private int curDamageTakenController;

	private float timerShowPotion = -1f;

	private float timerShowPotionMax = 10f;

	public SetChatLabelController[] killLabels;

	public GameObject[] chatLabels;

	public UILabel[] messageAddScore;

	public GameObject elixir;

	public GameObject scoreLabel;

	public GameObject enemiesLabel;

	public GameObject timeLabel;

	public GameObject killsLabel;

	public GameObject scopeText;

	public GameObject joystickContainer;

	public GameObject nightVisionEffect;

	public UILabel rulesLabel;

	public Player_move_c playerMoveC;

	private ZombieCreator zombieCreator;

	public UISprite multyKillSprite;

	private bool isMulti;

	private bool isChatOn;

	private bool isInet;

	private bool isHunger;

	private bool isTraining;

	private HungerGameController hungerGameController;

	public GameObject[] upButtonsInShopPanel;

	public GameObject[] upButtonsInShopPanelSwipeRegim;

	public GameObject healthAddButton;

	public GameObject ammoAddButton;

	public UITexture[] weaponIcons;

	public GameObject fastShopPanel;

	public UIScrollView changeWeaponScroll;

	public UIWrapContent changeWeaponWrap;

	public GameObject weaponPreviewPrefab;

	public int weaponIndexInScroll;

	public int weaponIndexInScrollOld;

	public int widthWeaponScrollPreview;

	public AudioClip lowResourceBeep;

	public UIPanel joystikPanel;

	public UIPanel shopPanel;

	public UIPanel bloodPanel;

	public UILabel perfectLabels;

	public RespawnWindow respawnWindow;

	public UIPanel offGameGuiPanel;

	public ButtonHandler fastChatButton;

	public UIToggle fastChatToggle;

	public GameObject fastChatPanel;

	private IEnumerator _lowResourceBeepRoutine;

	private string[] mechShieldsSpriteName = new string[6] { "mech_armor1", "mech_armor2", "mech_armor3", "mech_armor4", "mech_armor5", "mech_armor6" };

	private string[] armSpriteName = new string[6] { "wood_armor", "armor", "gold_armor", "crystal_armor", "red_armor", "adamant_armor" };

	private float timerBlinkNoAmmo;

	private float periodBlink = 2f;

	public UILabel blinkNoAmmoLabel;

	private float timerBlinkNoHeath;

	public UILabel blinkNoHeathLabel;

	public UISprite[] blinkNoHeathFrames;

	private int oldCountHeath;

	public float timerShowScorePict;

	public float maxTimerShowScorePict = 3f;

	public string scorePictName = string.Empty;

	private bool _disabled;

	[NonSerialized]
	public bool enableInvisibilityInterface = true;

	public void ShowCircularIndicatorOnReload(float length)
	{
		StopAllCircularIndicators();
		reloadLabel.gameObject.SetActive(true);
		Invoke("ReloadAmmo", length);
		if (playerMoveC != null)
		{
			playerMoveC.isReloading = true;
		}
		RunCircularSpriteOn(reloadCircularSprite, length, delegate
		{
		});
	}

	[Obfuscation(Exclude = true)]
	private void ReloadAmmo()
	{
		reloadLabel.gameObject.SetActive(false);
		WeaponManager.sharedManager.ReloadAmmo();
	}

	public void StartFireCircularIndicators(float length)
	{
		StopAllCircularIndicators();
		RunCircularSpriteOn(fireCircularSprite, length);
		RunCircularSpriteOn(fireAdditionalCrcualrSprite, length);
	}

	private void RunCircularSpriteOn(UISprite sprite, float length, Action onComplete = null)
	{
		sprite.fillAmount = 0f;
		HOTween.To(sprite, length, new TweenParms().Prop("fillAmount", 1f).UpdateType(UpdateType.TimeScaleIndependentUpdate).Ease(EaseType.Linear)
			.OnComplete((TweenDelegate.TweenCallback)delegate
			{
				sprite.fillAmount = 0f;
				if (onComplete != null)
				{
					onComplete();
				}
			}));
	}

	public void StopAllCircularIndicators()
	{
		CancelInvoke("ReloadAmmo");
		if (playerMoveC != null)
		{
			playerMoveC.isReloading = false;
		}
		if (circularSprites == null)
		{
			Debug.LogWarning("Circular sprites is null!");
			return;
		}
		UISprite[] array = circularSprites;
		foreach (UISprite uISprite in array)
		{
			HOTween.Kill(uISprite);
			uISprite.fillAmount = 0f;
		}
		reloadLabel.gameObject.SetActive(false);
	}

	public void PlayLowResourceBeep(int count)
	{
		StopPlayingLowResourceBeep();
		_lowResourceBeepRoutine = PlayLowResourceBeepCoroutine(count);
		StartCoroutine(_lowResourceBeepRoutine);
	}

	public void SetEnablePerfectLabel(bool enabled)
	{
		if (!(perfectLabels == null))
		{
			perfectLabels.gameObject.SetActive(enabled);
		}
	}

	public void PlayLowResourceBeepIfNotPlaying(int count)
	{
		if (_lowResourceBeepRoutine == null)
		{
			PlayLowResourceBeep(count);
		}
	}

	public void StopPlayingLowResourceBeep()
	{
		if (_lowResourceBeepRoutine != null)
		{
			StopCoroutine(_lowResourceBeepRoutine);
			_lowResourceBeepRoutine = null;
		}
	}

	private IEnumerator PlayLowResourceBeepCoroutine(int count)
	{
		for (int i = 0; i < count; i++)
		{
			if (Defs.isSoundFX)
			{
				NGUITools.PlaySound(lowResourceBeep);
			}
			yield return new WaitForSeconds(1f);
		}
		_lowResourceBeepRoutine = null;
	}

	public void PanelSlider()
	{
		float num = maxLength - minLength;
		float num2 = minLength;
		bottomPanelSprite.width = (int)(bottomPanelSlider.value * num + num2);
	}

	private void HandleChatSettUpdated()
	{
		isChatOn = Defs.IsChatOn;
	}

	private void Awake()
	{
		sharedInGameGUI = this;
		circularSprites = new UISprite[3] { reloadCircularSprite, fireCircularSprite, fireAdditionalCrcualrSprite };
		changeWeaponScroll.GetComponent<UIPanel>().baseClipRegion = new Vector4(0f, 0f, (float)widthWeaponScrollPreview * 1.3f, (float)widthWeaponScrollPreview * 1.3f);
		changeWeaponWrap.itemSize = widthWeaponScrollPreview;
		bottomPanelSprite.width = (int)defaultPanelLength;
		bottomPanelSlider.value = (defaultPanelLength - minLength) / (maxLength - minLength);
		HandleChatSettUpdated();
		PauseNGUIController.ChatSettUpdated += HandleChatSettUpdated;
		ControlsSettingsBase.ControlsChanged += AdjustToPlayerHands;
		shopPanelForTap.gameObject.SetActive(true);
		shopPanelForSwipe.gameObject.SetActive(true);
		swipeWeaponPanelPos = swipeWeaponPanel.localPosition;
		shopPanelForTapPos = shopPanelForTap.localPosition;
		shopPanelForSwipePos = shopPanelForSwipe.localPosition;
		fastShopRightPanelPos = fastShopRightPanel.localPosition;
		SetSwitchingWeaponPanel();
		isTraining = Defs.IsTraining;
		isMulti = Defs.isMulti;
		if (isTraining)
		{
			settingsController.SetActive(false);
		}
		isInet = Defs.isInet;
		isHunger = Defs.isHunger;
		if (isHunger)
		{
			HungerGameController instance = HungerGameController.Instance;
			if (instance == null)
			{
				Debug.LogError("hungerGameControllerObject == null");
			}
			else
			{
				hungerGameController = instance.GetComponent<HungerGameController>();
			}
		}
		bool flag = PlayerPrefs.GetInt(Defs.GameGUIOffMode, 0) == 1;
		offGameGuiPanel.gameObject.SetActive(flag);
	}

	public void SetSwipeWeaponPanelVisibility(bool visible)
	{
		swipeWeaponPanel.localPosition = ((!visible) ? (swipeWeaponPanelPos + new Vector3(10000f, 0f, 0f)) : swipeWeaponPanelPos);
	}

	public void SetSwitchingWeaponPanel()
	{
		if (GlobalGameController.switchingWeaponSwipe)
		{
			sharedInGameGUI.fastShopRightPanel.localPosition = new Vector3(10000f, sharedInGameGUI.fastShopRightPanel.localPosition.y, sharedInGameGUI.fastShopRightPanel.localPosition.z);
			sharedInGameGUI.swipeWeaponPanel.localPosition = swipeWeaponPanelPos;
			sharedInGameGUI.shopPanelForTap.gameObject.SetActive(false);
			sharedInGameGUI.shopPanelForSwipe.gameObject.SetActive(true);
			return;
		}
		sharedInGameGUI.swipeWeaponPanel.localPosition = new Vector3(10000f, sharedInGameGUI.swipeWeaponPanel.localPosition.y, sharedInGameGUI.swipeWeaponPanel.localPosition.z);
		sharedInGameGUI.fastShopRightPanel.localPosition = fastShopRightPanelPos;
		sharedInGameGUI.shopPanelForTap.gameObject.SetActive(true);
		sharedInGameGUI.shopPanelForSwipe.gameObject.SetActive(false);
		for (int i = 0; i < sharedInGameGUI.upButtonsInShopPanel.Length; i++)
		{
			if (!PotionsController.sharedController.PotionIsActive(sharedInGameGUI.upButtonsInShopPanel[i].GetComponent<ElexirInGameButtonController>().myPotion.name))
			{
				sharedInGameGUI.upButtonsInShopPanel[i].GetComponent<ElexirInGameButtonController>().myLabelTime.gameObject.SetActive(false);
			}
		}
	}

	public void AddDamageTaken(float alpha)
	{
		curDamageTakenController++;
		if (curDamageTakenController >= damageTakenControllers.Length)
		{
			curDamageTakenController = 0;
		}
		damageTakenControllers[curDamageTakenController].reset(alpha);
	}

	public void ResetDamageTaken()
	{
		for (int i = 0; i < damageTakenControllers.Length; i++)
		{
			damageTakenControllers[i].Remove();
		}
	}

	private void AdjustToPlayerHands()
	{
		float num = (GlobalGameController.LeftHanded ? 1 : (-1));
		Vector3[] array = Load.LoadVector3Array(ControlsSettingsBase.JoystickSett);
		if (array == null || array.Length < 7)
		{
			Defs.InitCoordsIphone();
			zoomButton.transform.localPosition = new Vector3((float)Defs.ZoomButtonX * num, Defs.ZoomButtonY, zoomButton.transform.localPosition.z);
			reloadButton.transform.localPosition = new Vector3((float)Defs.ReloadButtonX * num, Defs.ReloadButtonY, reloadButton.transform.localPosition.z);
			jumpButton.transform.localPosition = new Vector3((float)Defs.JumpButtonX * num, Defs.JumpButtonY, jumpButton.transform.localPosition.z);
			fireButton.transform.localPosition = new Vector3((float)Defs.FireButtonX * num, Defs.FireButtonY, fireButton.transform.localPosition.z);
			joystick.transform.localPosition = new Vector3((float)Defs.JoyStickX * num, Defs.JoyStickY, joystick.transform.localPosition.z);
			grenadeButton.transform.localPosition = new Vector3((float)Defs.GrenadeX * num, Defs.GrenadeY, grenadeButton.transform.localPosition.z);
			fireButtonInJoystick.transform.localPosition = new Vector3((float)Defs.FireButton2X * num, Defs.FireButton2Y, fireButtonInJoystick.transform.localPosition.z);
		}
		else
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i].x *= num;
			}
			zoomButton.transform.localPosition = array[0];
			reloadButton.transform.localPosition = array[1];
			jumpButton.transform.localPosition = array[2];
			fireButton.transform.localPosition = array[3];
			joystick.transform.localPosition = array[4];
			grenadeButton.transform.localPosition = array[5];
			fireButtonInJoystick.transform.localPosition = array[6];
		}
		UISprite[] array2 = new GameObject[9] { zoomButton, reloadButton, jumpButton, fireButton, joystick, grenadeButton, fireButtonInJoystick, bottomPanelSprite.gameObject, fastShopRightPanel.gameObject }.Select((GameObject go) => go.GetComponent<UISprite>()).ToArray();
		object obj = Json.Deserialize(PlayerPrefs.GetString("Controls.Size", "[]"));
		List<object> list = obj as List<object>;
		if (list == null)
		{
			list = new List<object>(array2.Length);
			Debug.LogWarning(list.GetType().FullName);
		}
		int num2 = Math.Min(list.Count, array2.Length);
		for (int j = 0; j != num2; j++)
		{
			int num3 = Convert.ToInt32(list[j]);
			if (num3 <= 0)
			{
				continue;
			}
			UISprite uISprite = array2[j];
			if (uISprite == null)
			{
				continue;
			}
			array2[j].keepAspectRatio = UIWidget.AspectRatioSource.BasedOnWidth;
			array2[j].width = num3;
			if (uISprite.gameObject == joystick)
			{
				UIJoystick component = uISprite.GetComponent<UIJoystick>();
				if (!(component == null))
				{
					float radius = component.radius;
					float num4 = radius / 144f;
					component.ActualRadius = num4 * (float)num3;
				}
			}
		}
	}

	private void Start()
	{
		HOTween.Init(true, true, true);
		HOTween.EnableOverwriteManager(true);
		if (!Defs.isMulti && !Defs.IsSurvival)
		{
			CampaignContainer.SetActive(true);
		}
		if (!Defs.isMulti && Defs.IsSurvival)
		{
			survivalContainer.SetActive(true);
		}
		if (Defs.isMulti && ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.Deathmatch)
		{
			deathmatchContainer.SetActive(true);
		}
		if (Defs.isMulti && ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TimeBattle)
		{
			timeBattleContainer.SetActive(true);
		}
		if (Defs.isMulti && ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight)
		{
			teamBattleContainer.SetActive(true);
		}
		if (Defs.isMulti && ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture)
		{
			flagCaptureContainer.SetActive(true);
		}
		if (Defs.isMulti && ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.DeadlyGames)
		{
			deadlygamesContainer.SetActive(true);
		}
		if (Defs.isMulti && ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			CapturePointContainer.SetActive(true);
		}
		turretPanel.SetActive(false);
		if (runTurrelButton != null)
		{
			runTurrelButton.Clicked += RunTurret;
		}
		if (cancelTurrelButton != null)
		{
			cancelTurrelButton.Clicked += CancelTurret;
		}
		if (isMulti)
		{
			enemiesLeftLabel.SetActive(false);
		}
		else
		{
			zombieCreator = ZombieCreator.sharedCreator;
		}
		AdjustToPlayerHands();
		PauseNGUIController.PlayerHandUpdated += AdjustToPlayerHands;
		PauseNGUIController.SwitchingWeaponsUpdated += SetSwitchingWeaponPanel;
		WeaponManager.WeaponEquipped += HandleWeaponEquipped;
		HandleWeaponEquipped(((Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1);
		if (((Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1 < changeWeaponWrap.transform.childCount)
		{
			changeWeaponWrap.GetComponent<MyCenterOnChild>().springStrength = 1E+11f;
			changeWeaponWrap.GetComponent<MyCenterOnChild>().CenterOn(changeWeaponWrap.transform.GetChild(((Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1));
			changeWeaponWrap.GetComponent<MyCenterOnChild>().springStrength = 8f;
		}
		else
		{
			Debug.LogError("InGameGUI: not weapon icon with index " + (((Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1));
		}
		if (gearToogle != null)
		{
			gearToogle.gameObject.GetComponent<ButtonHandler>().Clicked += HandleGearToogleClicked;
		}
		if (weaponCategoriesButtons[1] != null)
		{
			weaponCategoriesButtons[1].gameObject.GetComponent<ButtonHandler>().Clicked += HandleBackupToogleClicked;
		}
		if (weaponCategoriesButtons[0] != null)
		{
			weaponCategoriesButtons[0].gameObject.GetComponent<ButtonHandler>().Clicked += HandlePrimaryToogleClicked;
		}
		if (weaponCategoriesButtons[2] != null)
		{
			weaponCategoriesButtons[2].gameObject.GetComponent<ButtonHandler>().Clicked += HandleMeleeToogleClicked;
		}
		if (weaponCategoriesButtons[3] != null)
		{
			weaponCategoriesButtons[3].gameObject.GetComponent<ButtonHandler>().Clicked += HandleSpecialToogleClicked;
		}
		if (weaponCategoriesButtons[4] != null)
		{
			weaponCategoriesButtons[4].gameObject.GetComponent<ButtonHandler>().Clicked += HandlePremiumToogleClicked;
		}
		fastChatPanel.SetActive(false);
		if (Defs.isMulti)
		{
			fastChatButton.Clicked += FastChatClick;
		}
		else
		{
			fastChatButton.gameObject.SetActive(false);
		}
		if (Defs.IsTraining)
		{
			gearToogle.GetComponent<UIToggle>().value = false;
			HandleGearToogleClicked(null, null);
		}
		for (int i = 0; i < upButtonsInShopPanel.Length; i++)
		{
			StartUpdatePotionButton(upButtonsInShopPanel[i]);
		}
		for (int j = 0; j < upButtonsInShopPanelSwipeRegim.Length; j++)
		{
			StartUpdatePotionButton(upButtonsInShopPanelSwipeRegim[j]);
		}
		if (isTraining)
		{
			fastShopPanel.transform.localPosition = new Vector3(-1000f, -1000f, -1f);
			sideObjGearShop.transform.localPosition = new Vector3(-100000f, sideObjGearShop.localPosition.y, sideObjGearShop.localPosition.z);
			gearToogle.isEnabled = false;
		}
		SetNGUITouchDragThreshold(1f);
	}

	public void ShowTurretInterface()
	{
		swipeWeaponPanel.gameObject.SetActive(false);
		shopPanelForSwipe.gameObject.SetActive(false);
		shopPanelForTap.gameObject.SetActive(false);
		turretPanel.SetActive(true);
		if (playerMoveC != null)
		{
			playerMoveC.ChangeWeapon(1001, false);
		}
		shopButtonInPause.GetComponent<UIButton>().isEnabled = false;
	}

	public void HideTurretInterface()
	{
		if (GlobalGameController.switchingWeaponSwipe)
		{
			shopPanelForSwipe.gameObject.SetActive(true);
		}
		else
		{
			shopPanelForTap.gameObject.SetActive(true);
		}
		swipeWeaponPanel.gameObject.SetActive(true);
		turretPanel.SetActive(false);
		shopButtonInPause.GetComponent<UIButton>().isEnabled = true;
	}

	private void FastChatClick(object sender, EventArgs e)
	{
		SetVisibleFactChatPanel(fastChatToggle.value);
	}

	public void SetVisibleFactChatPanel(bool _visible)
	{
		fastChatPanel.SetActive(_visible);
	}

	private void RunTurret(object sender, EventArgs e)
	{
		if (playerMoveC != null)
		{
			playerMoveC.RunTurret();
		}
		HideTurretInterface();
	}

	private void CancelTurret(object sender, EventArgs e)
	{
		if (playerMoveC != null)
		{
			playerMoveC.CancelTurret();
		}
		HideTurretInterface();
	}

	private void StartUpdatePotionButton(GameObject potionButton)
	{
		if (potionButton != null)
		{
			potionButton.gameObject.GetComponent<ButtonHandler>().Clicked += HandlePotionClicked;
			ElexirInGameButtonController component = potionButton.GetComponent<ElexirInGameButtonController>();
			string text = component.myPotion.name;
			if (PotionsController.sharedController.PotionIsActive(text))
			{
				UIButton component2 = potionButton.GetComponent<UIButton>();
				component.isActivePotion = true;
				component.myLabelTime.gameObject.SetActive(true);
				component.myLabelTime.enabled = true;
				component.priceLabel.SetActive(false);
				component.myLabelCount.gameObject.SetActive(true);
				component.plusSprite.SetActive(false);
				component.myLabelCount.text = Storager.getInt(text, false).ToString();
				component2.isEnabled = false;
			}
		}
	}

	public void HandleBuyGrenadeClicked(object sender, EventArgs e)
	{
		if (ButtonClickSound.Instance != null)
		{
			ButtonClickSound.Instance.PlayClick();
		}
		if (isTraining)
		{
			int @int = Storager.getInt("GrenadeID", false);
			int num = 1;
			Storager.setInt("GrenadeID", @int + num, false);
			if (isTraining && TrainingController.stepTraining == TrainingController.stepTrainingList["TapToAddGrenade"])
			{
				TrainingController.isNextStep = TrainingController.stepTrainingList["TapToAddGrenade"];
			}
			return;
		}
		string parameterValue = GearManager.AnalyticsIDForOneItemOfGear(GearManager.Grenade, true);
		ItemPrice priceByShopId = ItemDb.GetPriceByShopId(GearManager.OneItemIDForGear("GrenadeID", GearManager.CurrentNumberOfUphradesForGear("GrenadeID")));
		ItemPrice price = new ItemPrice(priceByShopId.Price * 1, priceByShopId.Currency);
		ShopNGUIController.TryToBuy(base.gameObject, price, delegate
		{
			int int2 = Storager.getInt("GrenadeID", false);
			int num2 = 1;
			Storager.setInt("GrenadeID", int2 + num2, false);
			Dictionary<string, string> parameters2 = new Dictionary<string, string> { { "Succeeded", parameterValue } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Fast Purchase", parameters2);
			FlurryPluginWrapper.LogFastPurchase(parameterValue);
		}, delegate
		{
			JoystickController.leftJoystick.Reset();
			Dictionary<string, string> parameters = new Dictionary<string, string> { { "Failed", parameterValue } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Fast Purchase", parameters);
		});
	}

	private void ClickPotionButton(int index)
	{
		timerShowPotion = timerShowPotionMax;
		ElexirInGameButtonController myController = upButtonsInShopPanel[index].GetComponent<ElexirInGameButtonController>();
		ElexirInGameButtonController myController2 = upButtonsInShopPanelSwipeRegim[index].GetComponent<ElexirInGameButtonController>();
		UIButton myButton = upButtonsInShopPanel[index].GetComponent<UIButton>();
		UIButton myButton2 = upButtonsInShopPanelSwipeRegim[index].GetComponent<UIButton>();
		string myKey = myController.myPotion.name;
		int @int = Storager.getInt(myKey, false);
		if (@int > 0)
		{
			if (myKey.Equals(GearManager.Turret))
			{
				ShowTurretInterface();
			}
			else
			{
				Storager.setInt(myKey, Storager.getInt(myKey, false) - 1, false);
				PotionsController.sharedController.ActivatePotion(myKey, playerMoveC, new Dictionary<string, object>());
			}
			string text = Storager.getInt(myKey, false).ToString();
			myController.myLabelCount.gameObject.SetActive(true);
			myController.plusSprite.SetActive(false);
			myController.myLabelCount.text = text;
			myController.isActivePotion = true;
			myButton.isEnabled = false;
			myController.myLabelTime.enabled = true;
			myController.myLabelTime.gameObject.SetActive(true);
			myController2.myLabelCount.gameObject.SetActive(true);
			myController2.plusSprite.SetActive(false);
			myController2.myLabelCount.text = text;
			myController2.isActivePotion = true;
			myButton2.isEnabled = false;
			myController2.myLabelTime.enabled = true;
			myController2.myLabelTime.gameObject.SetActive(true);
			return;
		}
		string parameterValue = GearManager.AnalyticsIDForOneItemOfGear(myKey ?? "Potion", true);
		ItemPrice priceByShopId = ItemDb.GetPriceByShopId(GearManager.OneItemIDForGear(myKey, GearManager.CurrentNumberOfUphradesForGear(myKey)));
		ShopNGUIController.TryToBuy(base.gameObject, priceByShopId, delegate
		{
			Storager.setInt(myKey, Storager.getInt(myKey, false) + 1, false);
			myButton.normalSprite = "game_clear";
			myButton.pressedSprite = "game_clear_n";
			myController.myLabelCount.gameObject.SetActive(true);
			myController.plusSprite.SetActive(false);
			myController.priceLabel.SetActive(false);
			myController.myLabelCount.text = Storager.getInt(myKey, false).ToString();
			myButton2.normalSprite = "game_clear";
			myButton2.pressedSprite = "game_clear_n";
			myController2.myLabelCount.gameObject.SetActive(true);
			myController2.plusSprite.SetActive(false);
			myController2.priceLabel.SetActive(false);
			myController2.myLabelCount.text = Storager.getInt(myKey, false).ToString();
			Dictionary<string, string> parameters2 = new Dictionary<string, string> { { "Succeeded", parameterValue } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Fast Purchase", parameters2);
			FlurryPluginWrapper.LogFastPurchase(parameterValue);
		}, delegate
		{
			JoystickController.leftJoystick.Reset();
			Dictionary<string, string> parameters = new Dictionary<string, string> { { "Failed", parameterValue } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Fast Purchase", parameters);
		});
	}

	private void HandlePotionClicked(object sender, EventArgs e)
	{
		int index = 0;
		for (int i = 0; i < upButtonsInShopPanel.Length; i++)
		{
			if (upButtonsInShopPanel[i].name.Equals(((ButtonHandler)sender).gameObject.name))
			{
				index = i;
				break;
			}
		}
		ClickPotionButton(index);
	}

	private void HandleGearToogleClicked(object sender, EventArgs e)
	{
		bool value = gearToogle.GetComponent<UIToggle>().value;
		fonBig.SetActive(value);
		if (value)
		{
			timerShowPotion = timerShowPotionMax;
		}
		else
		{
			timerShowPotion = -1f;
		}
		for (int i = 0; i < upButtonsInShopPanel.Length; i++)
		{
			upButtonsInShopPanel[i].SetActive(value);
		}
	}

	private void HandlePrimaryToogleClicked(object sender, EventArgs e)
	{
		SelectWeaponFromCategory(1);
	}

	private void HandleBackupToogleClicked(object sender, EventArgs e)
	{
		SelectWeaponFromCategory(2);
	}

	private void HandleMeleeToogleClicked(object sender, EventArgs e)
	{
		SelectWeaponFromCategory(3);
	}

	private void HandleSpecialToogleClicked(object sender, EventArgs e)
	{
		SelectWeaponFromCategory(4);
	}

	private void HandlePremiumToogleClicked(object sender, EventArgs e)
	{
		SelectWeaponFromCategory(5);
	}

	private void SelectWeaponFromCategory(int category, bool isUpdateSwipe = true)
	{
		for (int i = 0; i < WeaponManager.sharedManager.playerWeapons.Count; i++)
		{
			Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[i];
			if (weapon.weaponPrefab.GetComponent<WeaponSounds>().categoryNabor == category)
			{
				SelectWeaponFromIndex(i, isUpdateSwipe);
				break;
			}
		}
	}

	private void SelectWeaponFromIndex(int _index, bool updateSwipe = true)
	{
		bool[] array = new bool[5];
		int num = 0;
		foreach (Weapon playerWeapon in WeaponManager.sharedManager.playerWeapons)
		{
			int num2 = playerWeapon.weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1;
			array[num2] = true;
			num++;
		}
		for (int i = 0; i < weaponCategoriesButtons.Length; i++)
		{
			weaponCategoriesButtons[i].isEnabled = array[i];
			if (i == ((Weapon)WeaponManager.sharedManager.playerWeapons[_index]).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1)
			{
				weaponCategoriesButtons[i].GetComponent<UIToggle>().value = true;
			}
			else
			{
				weaponCategoriesButtons[i].GetComponent<UIToggle>().value = false;
			}
		}
		SetChangeWeapon(_index, updateSwipe);
	}

	private void SetChangeWeapon(int index, bool isUpdateSwipe)
	{
		if (isUpdateSwipe)
		{
			if (index < changeWeaponWrap.transform.childCount)
			{
				changeWeaponWrap.GetComponent<MyCenterOnChild>().springStrength = 1E+11f;
				changeWeaponWrap.GetComponent<MyCenterOnChild>().CenterOn(changeWeaponWrap.transform.GetChild(index));
				changeWeaponWrap.GetComponent<MyCenterOnChild>().springStrength = 8f;
			}
			else
			{
				Debug.LogError("InGameGUI: not weapon icon with index " + index);
			}
		}
		if (WeaponManager.sharedManager.CurrentWeaponIndex != index || !sharedInGameGUI.shopPanelForTap.gameObject.activeSelf)
		{
			WeaponManager.sharedManager.CurrentWeaponIndex = index;
			if (playerMoveC != null)
			{
				playerMoveC.ChangeWeapon(index, false);
			}
		}
	}

	[Obfuscation(Exclude = true)]
	private void GenerateMiganie()
	{
		CoinsMessage.FireCoinsAddedEvent(false);
	}

	private void CheckWeaponScrollChanged()
	{
		if (!_disabled)
		{
			if (changeWeaponScroll.transform.localPosition.x > 0f)
			{
				weaponIndexInScroll = Mathf.RoundToInt((changeWeaponScroll.transform.localPosition.x - (float)(Mathf.FloorToInt(changeWeaponScroll.transform.localPosition.x / (float)widthWeaponScrollPreview / (float)changeWeaponWrap.transform.childCount) * widthWeaponScrollPreview * changeWeaponWrap.transform.childCount)) / (float)widthWeaponScrollPreview);
				weaponIndexInScroll = changeWeaponWrap.transform.childCount - weaponIndexInScroll;
			}
			else
			{
				weaponIndexInScroll = -1 * Mathf.RoundToInt((changeWeaponScroll.transform.localPosition.x - (float)(Mathf.CeilToInt(changeWeaponScroll.transform.localPosition.x / (float)widthWeaponScrollPreview / (float)changeWeaponWrap.transform.childCount) * widthWeaponScrollPreview * changeWeaponWrap.transform.childCount)) / (float)widthWeaponScrollPreview);
			}
			if (weaponIndexInScroll == changeWeaponWrap.transform.childCount)
			{
				weaponIndexInScroll = 0;
			}
			if (weaponIndexInScroll != weaponIndexInScrollOld)
			{
				SelectWeaponFromCategory(((Weapon)WeaponManager.sharedManager.playerWeapons[weaponIndexInScroll]).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor, false);
			}
			weaponIndexInScrollOld = weaponIndexInScroll;
		}
	}

	public IEnumerator _DisableSwiping(float tm)
	{
		MyCenterOnChild _center = changeWeaponWrap.GetComponent<MyCenterOnChild>();
		int bef;
		if (_center == null || _center.centeredObject == null || !int.TryParse(_center.centeredObject.name.Replace("WeaponCat_", string.Empty), out bef))
		{
			yield break;
		}
		_disabled = true;
		yield return new WaitForSeconds(tm);
		_disabled = false;
		if (_center.centeredObject == null || _center.centeredObject.name.Equals("WeaponCat_" + bef))
		{
			yield break;
		}
		Transform goToCent = null;
		foreach (Transform t in _center.transform)
		{
			if (t.gameObject.name.Equals("WeaponCat_" + bef))
			{
				goToCent = t;
				break;
			}
		}
		if (goToCent != null)
		{
			_center.CenterOn(goToCent);
		}
	}

	private void Update()
	{
		CheckWeaponScrollChanged();
		if (isTraining && TrainingController.stepTraining == TrainingController.stepTrainingList["TapToSelectWeapon"])
		{
			fastShopPanel.transform.localPosition = new Vector3(0f, 0f, -1f);
		}
		if (isTraining && TrainingController.stepTraining == TrainingController.stepTrainingList["TapToAddGrenade"])
		{
			fastShopPanel.transform.localPosition = new Vector3(0f, 0f, -1f);
			sideObjGearShop.transform.localPosition = new Vector3(0f, sideObjGearShop.localPosition.y, sideObjGearShop.localPosition.z);
		}
		if (timerBlinkNoAmmo > 0f)
		{
			timerBlinkNoAmmo -= Time.deltaTime;
		}
		if (timerBlinkNoAmmo > 0f && playerMoveC != null && !playerMoveC.isMechActive)
		{
			blinkNoAmmoLabel.gameObject.SetActive(true);
			float num = timerBlinkNoAmmo % periodBlink / periodBlink;
			blinkNoAmmoLabel.color = new Color(blinkNoAmmoLabel.color.r, blinkNoAmmoLabel.color.g, blinkNoAmmoLabel.color.b, (!(num < 0.5f)) ? ((1f - num) * 2f) : (num * 2f));
		}
		if ((timerBlinkNoAmmo < 0f || (playerMoveC != null && playerMoveC.isMechActive)) && blinkNoAmmoLabel.gameObject.activeSelf)
		{
			blinkNoAmmoLabel.gameObject.SetActive(false);
		}
		if (playerMoveC != null)
		{
			int num2 = Mathf.FloorToInt(playerMoveC.CurHealth);
			if (num2 < oldCountHeath && timerBlinkNoHeath < 0f && num2 < 3)
			{
				timerBlinkNoHeath = periodBlink * 3f;
			}
			if (num2 > 2)
			{
				timerBlinkNoHeath = -1f;
			}
			oldCountHeath = num2;
			if (timerBlinkNoHeath > 0f)
			{
				timerBlinkNoHeath -= Time.deltaTime;
			}
			if (timerBlinkNoHeath > 0f && !playerMoveC.isMechActive)
			{
				if (num2 > 0)
				{
					PlayLowResourceBeepIfNotPlaying(1);
				}
				blinkNoHeathLabel.gameObject.SetActive(true);
				float num3 = timerBlinkNoHeath % periodBlink / periodBlink;
				float a = ((!(num3 < 0.5f)) ? ((1f - num3) * 2f) : (num3 * 2f));
				blinkNoHeathLabel.color = new Color(blinkNoHeathLabel.color.r, blinkNoHeathLabel.color.g, blinkNoHeathLabel.color.b, a);
				for (int i = 0; i < blinkNoHeathFrames.Length; i++)
				{
					blinkNoHeathFrames[i].gameObject.SetActive(true);
					blinkNoHeathFrames[i].color = new Color(1f, 1f, 1f, a);
				}
			}
		}
		if ((timerBlinkNoHeath < 0f || playerMoveC == null || (playerMoveC != null && playerMoveC.isMechActive)) && blinkNoHeathLabel.gameObject.activeSelf)
		{
			blinkNoHeathLabel.gameObject.SetActive(false);
			for (int j = 0; j < blinkNoHeathFrames.Length; j++)
			{
				blinkNoHeathFrames[j].gameObject.SetActive(false);
			}
		}
		for (int k = 0; k < ammoCategoriesLabels.Length; k++)
		{
			if (!(ammoCategoriesLabels[k] != null))
			{
				continue;
			}
			bool flag = false;
			if (weaponCategoriesButtons[k].isEnabled)
			{
				for (int l = 0; l < WeaponManager.sharedManager.playerWeapons.Count; l++)
				{
					Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[l];
					if ((!weapon.weaponPrefab.GetComponent<WeaponSounds>().isMelee || weapon.weaponPrefab.GetComponent<WeaponSounds>().isShotMelee) && weapon.weaponPrefab.GetComponent<WeaponSounds>().categoryNabor == k + 1)
					{
						ammoCategoriesLabels[k].text = ((!weapon.weaponPrefab.GetComponent<WeaponSounds>().isShotMelee) ? (weapon.currentAmmoInClip + "/" + weapon.currentAmmoInBackpack) : (weapon.currentAmmoInClip + weapon.currentAmmoInBackpack).ToString());
						flag = true;
						break;
					}
				}
			}
			if (!flag)
			{
				ammoCategoriesLabels[k].text = string.Empty;
			}
		}
		if (timerShowNow > 0f)
		{
			timerShowNow -= Time.deltaTime;
			if (!message_now.activeSelf)
			{
				message_now.SetActive(true);
			}
		}
		else if (message_now.activeSelf)
		{
			message_now.SetActive(false);
		}
		if (isMulti && playerMoveC == null && WeaponManager.sharedManager.myPlayer != null)
		{
			playerMoveC = WeaponManager.sharedManager.myPlayer.GetComponent<SkinName>().playerMoveC;
		}
		if (!isMulti && playerMoveC == null && GameObject.FindGameObjectWithTag("Player") != null)
		{
			playerMoveC = GameObject.FindGameObjectWithTag("Player").GetComponent<SkinName>().playerMoveC;
		}
		if (isMulti && playerMoveC != null)
		{
			for (int m = 0; m < 3; m++)
			{
				float num4 = 0.3f;
				float num5 = 0.2f;
				if (m == 0)
				{
					float num6 = 1f;
					if (playerMoveC.myScoreController.maxTimerSumMessage - playerMoveC.myScoreController.timerAddScoreShow[m] < num4)
					{
						num6 = 1f + num5 * (playerMoveC.myScoreController.maxTimerSumMessage - playerMoveC.myScoreController.timerAddScoreShow[m]) / num4;
					}
					if (playerMoveC.myScoreController.maxTimerSumMessage - playerMoveC.myScoreController.timerAddScoreShow[m] - num4 < num4)
					{
						num6 = 1f + num5 * (1f - (playerMoveC.myScoreController.maxTimerSumMessage - playerMoveC.myScoreController.timerAddScoreShow[m] - num4) / num4);
					}
					messageAddScore[m].transform.localScale = new Vector3(num6, num6, num6);
				}
				if (playerMoveC.timerShow[m] > 0f)
				{
					killLabels[m].gameObject.SetActive(true);
					killLabels[m].SetChatLabelText(playerMoveC.killedSpisok[m][0], playerMoveC.killedSpisok[m][1], playerMoveC.killedSpisok[m][2], playerMoveC.killedSpisok[m][3]);
				}
				else
				{
					killLabels[m].gameObject.SetActive(false);
				}
				if (playerMoveC.myScoreController.timerAddScoreShow[m] > 0f)
				{
					if (!messageAddScore[m].gameObject.activeSelf)
					{
						messageAddScore[m].gameObject.SetActive(true);
					}
					messageAddScore[m].text = playerMoveC.myScoreController.addScoreString[m];
					messageAddScore[m].color = new Color(1f, 1f, 1f, (!(playerMoveC.myScoreController.timerAddScoreShow[m] > 1f)) ? playerMoveC.myScoreController.timerAddScoreShow[m] : 1f);
				}
				else if (messageAddScore[m].gameObject.activeSelf)
				{
					messageAddScore[m].gameObject.SetActive(false);
				}
			}
			if (isChatOn)
			{
				int num7 = 0;
				int num8 = playerMoveC.messages.Count - 1;
				while (num8 >= 0 && playerMoveC.messages.Count - num8 - 1 < 3)
				{
					if (Time.time - playerMoveC.messages[num8].time < 10f)
					{
						if ((!isInet && playerMoveC.messages[num8].IDLocal == WeaponManager.sharedManager.myPlayer.GetComponent<NetworkView>().viewID) || (isInet && playerMoveC.messages[num8].ID == WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID))
						{
							chatLabels[num7].GetComponent<UILabel>().color = new Color(0f, 1f, 0.15f, 1f);
						}
						else
						{
							if (playerMoveC.messages[num8].command == 0)
							{
								chatLabels[num7].GetComponent<UILabel>().color = new Color(1f, 1f, 0.15f, 1f);
							}
							if (playerMoveC.messages[num8].command == 1)
							{
								chatLabels[num7].GetComponent<UILabel>().color = new Color(0f, 0f, 0.9f, 1f);
							}
							if (playerMoveC.messages[num8].command == 2)
							{
								chatLabels[num7].GetComponent<UILabel>().color = new Color(1f, 0f, 0f, 1f);
							}
						}
						chatLabels[num7].GetComponent<UILabel>().text = playerMoveC.messages[num8].text;
						chatLabels[num7].SetActive(true);
						chatLabels[num7].transform.GetChild(0).GetComponent<UITexture>().mainTexture = playerMoveC.messages[num8].clanLogo;
					}
					else
					{
						chatLabels[num7].SetActive(false);
					}
					num7++;
					num8--;
				}
				for (int n = num7; n < 3; n++)
				{
					chatLabels[num7].SetActive(false);
				}
			}
			if (timerShowScorePict > 0f)
			{
				timerShowScorePict -= Time.deltaTime;
			}
			if (isHunger && GameObject.FindGameObjectsWithTag("Player").Length == 2 && hungerGameController.isGo && playerMoveC.timeHingerGame > 10f)
			{
				duel.SetActive(true);
				multyKillSprite.gameObject.SetActive(false);
			}
			else
			{
				if (duel.activeSelf)
				{
					duel.SetActive(false);
				}
				if (timerShowScorePict > 0f)
				{
					multyKillSprite.spriteName = scorePictName;
					multyKillSprite.gameObject.SetActive(true);
					float num9 = 1f;
					float num10 = 0.5f;
					if (timerShowScorePict > maxTimerShowScorePict - num10)
					{
						num9 = (maxTimerShowScorePict - timerShowScorePict) / num10;
					}
					if (timerShowScorePict < num10)
					{
						num9 = timerShowScorePict / num10;
					}
					multyKillSprite.transform.localScale = new Vector3(num9, num9, num9);
				}
				else if (multyKillSprite.gameObject.activeSelf)
				{
					multyKillSprite.gameObject.SetActive(false);
				}
			}
			if (isHunger && !hungerGameController.isGo)
			{
				timerStartHungerLabel.gameObject.SetActive(true);
				int num11 = Mathf.FloorToInt(hungerGameController.goTimer);
				string text;
				if (num11 == 0)
				{
					text = "GO!";
					timerStartHungerLabel.color = new Color(0f, 1f, 0f, 1f);
				}
				else
				{
					text = string.Empty + num11;
					timerStartHungerLabel.color = new Color(1f, 0f, 0f, 1f);
				}
				timerStartHungerLabel.text = text;
			}
			else if (isHunger && hungerGameController.isGo && hungerGameController.isShowGo)
			{
				timerStartHungerLabel.gameObject.SetActive(true);
				timerStartHungerLabel.text = "GO!";
			}
			else
			{
				timerStartHungerLabel.gameObject.SetActive(false);
			}
		}
		if (playerMoveC != null)
		{
			if (playerMoveC.timerShowDown > 0f && playerMoveC.timerShowDown < playerMoveC.maxTimeSetTimerShow - 0.03f)
			{
				downBloodTexture.SetActive(true);
			}
			else
			{
				downBloodTexture.SetActive(false);
			}
			if (playerMoveC.timerShowUp > 0f && playerMoveC.timerShowUp < playerMoveC.maxTimeSetTimerShow - 0.03f)
			{
				upBloodTexture.SetActive(true);
			}
			else
			{
				upBloodTexture.SetActive(false);
			}
			if (playerMoveC.timerShowLeft > 0f && playerMoveC.timerShowLeft < playerMoveC.maxTimeSetTimerShow - 0.03f)
			{
				leftBloodTexture.SetActive(true);
			}
			else
			{
				leftBloodTexture.SetActive(false);
			}
			if (playerMoveC.timerShowRight > 0f && playerMoveC.timerShowRight < playerMoveC.maxTimeSetTimerShow - 0.03f)
			{
				rightBloodTexture.SetActive(true);
			}
			else
			{
				rightBloodTexture.SetActive(false);
			}
			if (!playerMoveC.isZooming && (!isTraining || !TrainingController.isPressSkip))
			{
				if (!aimUp.activeSelf)
				{
					aimUp.SetActive(true);
				}
				if (!aimDown.activeSelf)
				{
					aimDown.SetActive(true);
				}
				if (!aimRight.activeSelf)
				{
					aimRight.SetActive(true);
				}
				if (!aimLeft.activeSelf)
				{
					aimLeft.SetActive(true);
				}
				aimUp.transform.localPosition = new Vector3(0f, 8f + WeaponManager.sharedManager.currentWeaponSounds.tekKoof * WeaponManager.sharedManager.currentWeaponSounds.startZone.y * 0.5f, 0f);
				aimDown.transform.localPosition = new Vector3(0f, -8f - WeaponManager.sharedManager.currentWeaponSounds.tekKoof * WeaponManager.sharedManager.currentWeaponSounds.startZone.y * 0.5f, 0f);
				aimRight.transform.localPosition = new Vector3(8f + WeaponManager.sharedManager.currentWeaponSounds.tekKoof * WeaponManager.sharedManager.currentWeaponSounds.startZone.y * 0.5f, 0f, 0f);
				aimLeft.transform.localPosition = new Vector3(-8f - WeaponManager.sharedManager.currentWeaponSounds.tekKoof * WeaponManager.sharedManager.currentWeaponSounds.startZone.y * 0.5f, 0f, 0f);
			}
			else
			{
				if (aimUp.activeSelf)
				{
					aimUp.SetActive(false);
				}
				if (aimDown.activeSelf)
				{
					aimDown.SetActive(false);
				}
				if (aimRight.activeSelf)
				{
					aimRight.SetActive(false);
				}
				if (aimLeft.activeSelf)
				{
					aimLeft.SetActive(false);
				}
			}
		}
		bool flag2 = true;
		if (isTraining && TrainingController.stepTraining != TrainingState.EnterTheShop)
		{
			flag2 = false;
		}
		shopButton.GetComponent<UIButton>().isEnabled = flag2 && !turretPanel.activeSelf;
		if (!isMulti && zombieCreator != null)
		{
			int num12 = GlobalGameController.EnemiesToKill - zombieCreator.NumOfDeadZombies;
			if (!Defs.IsSurvival && num12 == 0)
			{
				string text2 = ((!LevelBox.weaponsFromBosses.ContainsKey(Application.loadedLevelName)) ? LocalizationStore.Get("Key_0854") : LocalizationStore.Get("Key_0192"));
				if (zombieCreator.bossShowm)
				{
					text2 = LocalizationStore.Get("Key_0855");
				}
				enemiesLeftLabel.SetActive(perfectLabels == null || !perfectLabels.gameObject.activeInHierarchy);
				enemiesLeftLabel.GetComponent<UILabel>().text = text2;
			}
			else
			{
				enemiesLeftLabel.SetActive(false);
			}
		}
		if (playerMoveC != null && playerMoveC.isMechActive)
		{
			for (int num13 = 0; num13 < mechShields.Length; num13++)
			{
				mechShields[num13].gameObject.SetActive((float)num13 < playerMoveC.liveMech);
				if (!((float)num13 < playerMoveC.liveMech))
				{
					continue;
				}
				for (int num14 = armSpriteName.Length - 1; num14 >= 0; num14--)
				{
					if (playerMoveC.liveMech - (float)(mechShields.Length * num14) - (float)num13 > 0f)
					{
						mechShields[num13].spriteName = mechShieldsSpriteName[num14];
						break;
					}
				}
			}
			return;
		}
		for (int num15 = 0; num15 < Player_move_c.MaxPlayerHealth; num15++)
		{
			hearts[num15].gameObject.SetActive((float)num15 < health());
			hearts[num15].spriteName = "heart";
		}
		if (!isTraining || TrainingController.stepTraining >= TrainingController.stepTrainingList["Shop"])
		{
			for (int num16 = 0; num16 < Player_move_c.MaxPlayerHealth; num16++)
			{
				armorShields[num16].gameObject.SetActive((float)num16 < armor());
				if (!((float)num16 < armor()))
				{
					continue;
				}
				for (int num17 = armSpriteName.Length - 1; num17 >= 0; num17--)
				{
					if (armor() - (float)(armorShields.Length * num17) - (float)num16 > 0f)
					{
						armorShields[num16].spriteName = armSpriteName[num17];
						break;
					}
				}
			}
			return;
		}
		for (int num18 = 0; num18 < Player_move_c.MaxPlayerHealth; num18++)
		{
			if (TrainingController.stepTraining > TrainingController.stepTrainingList["Shop"])
			{
				armorShields[num18].gameObject.SetActive(num18 < 2);
				armorShields[num18].spriteName = armSpriteName[0];
			}
			else
			{
				armorShields[num18].gameObject.SetActive(false);
			}
		}
	}

	public void SetScopeForWeapon(string num)
	{
		scopeText.SetActive(true);
		string path = ((!Device.isWeakDevice) ? ResPath.Combine("Scopes", "Scope_" + num) : ResPath.Combine("Scopes", "Scope_" + num + "_small"));
		scopeText.GetComponent<UITexture>().mainTexture = Resources.Load(path) as Texture;
	}

	public void ResetScope()
	{
		scopeText.GetComponent<UITexture>().mainTexture = null;
		scopeText.SetActive(false);
	}

	public void HandleWeaponEquipped(int catNabor)
	{
		bool[] array = new bool[5];
		int num = 0;
		foreach (Weapon playerWeapon in WeaponManager.sharedManager.playerWeapons)
		{
			int num2 = playerWeapon.weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1;
			array[num2] = true;
			num++;
		}
		int childCount = changeWeaponWrap.transform.childCount;
		for (int i = childCount; i < num; i++)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(weaponPreviewPrefab) as GameObject;
			gameObject.name = "WeaponCat_" + i;
			gameObject.transform.parent = changeWeaponWrap.transform;
			gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
			gameObject.GetComponent<UITexture>().width = Mathf.RoundToInt((float)widthWeaponScrollPreview * 0.8f);
			gameObject.GetComponent<UITexture>().height = Mathf.RoundToInt((float)widthWeaponScrollPreview * 0.8f);
			gameObject.GetComponent<BoxCollider>().size = new Vector3((float)widthWeaponScrollPreview * 1.3f, (float)widthWeaponScrollPreview * 1.3f, 1f);
		}
		changeWeaponWrap.SortAlphabetically();
		changeWeaponWrap.GetComponent<MyCenterOnChild>().enabled = false;
		changeWeaponWrap.GetComponent<MyCenterOnChild>().enabled = true;
		int num3 = 0;
		for (int j = 0; j < 5; j++)
		{
			Texture texture = ShopNGUIController.TextureForCat(j);
			if (!(texture != null))
			{
				continue;
			}
			weaponIcons[j].mainTexture = texture;
			foreach (Transform item in changeWeaponWrap.transform)
			{
				if (item.name.Equals("WeaponCat_" + num3))
				{
					item.GetComponent<UITexture>().mainTexture = texture;
					break;
				}
			}
			num3++;
		}
		for (int k = 0; k < WeaponManager.sharedManager.playerWeapons.Count; k++)
		{
			changeWeaponWrap.transform.GetChild(k).GetComponent<WeaponIconController>().myWeaponSounds = ((Weapon)WeaponManager.sharedManager.playerWeapons[k]).weaponPrefab.GetComponent<WeaponSounds>();
		}
		SelectWeaponFromCategory(catNabor + 1);
	}

	public void BlinkNoAmmo(int count)
	{
		if (count == 0)
		{
			StopPlayingLowResourceBeep();
		}
		timerBlinkNoAmmo = (float)count * periodBlink;
		blinkNoAmmoLabel.color = new Color(blinkNoAmmoLabel.color.r, blinkNoAmmoLabel.color.g, blinkNoAmmoLabel.color.b, 0f);
	}

	public static void SetLayerRecursively(GameObject go, int layerNumber)
	{
		Transform[] componentsInChildren = go.GetComponentsInChildren<Transform>(true);
		foreach (Transform transform in componentsInChildren)
		{
			transform.gameObject.layer = layerNumber;
		}
	}

	private void OnDestroy()
	{
		SetNGUITouchDragThreshold(40f);
		sharedInGameGUI = null;
		WeaponManager.WeaponEquipped -= HandleWeaponEquipped;
		PauseNGUIController.ChatSettUpdated -= HandleChatSettUpdated;
		PauseNGUIController.PlayerHandUpdated -= AdjustToPlayerHands;
		ControlsSettingsBase.ControlsChanged -= AdjustToPlayerHands;
		PauseNGUIController.SwitchingWeaponsUpdated -= SetSwitchingWeaponPanel;
	}

	public void SetInterfaceVisible(bool visible)
	{
		interfacePanel.GetComponent<UIPanel>().gameObject.SetActive(visible);
		joystikPanel.gameObject.SetActive(visible);
		shopPanel.gameObject.SetActive(visible);
		bloodPanel.gameObject.SetActive(visible);
	}

	public void SetInterfaceInvisibility(bool enable)
	{
		float alpha = ((!enable) ? 1f : 0.01f);
		interfacePanel.GetComponent<UIPanel>().alpha = alpha;
		joystikPanel.alpha = alpha;
		shopPanel.alpha = alpha;
		bloodPanel.alpha = alpha;
		offGameGuiPanel.alpha = alpha;
		NetworkStartTableNGUIController sharedController = NetworkStartTableNGUIController.sharedController;
		if (sharedController != null)
		{
			sharedController.endInterfacePanel.GetComponent<UIPanel>().alpha = alpha;
			sharedController.allInterfacePanel.GetComponent<UIPanel>().alpha = alpha;
			sharedController.shopAnchor.GetComponent<UIPanel>().alpha = alpha;
		}
		enableInvisibilityInterface = !enable;
	}

	public void OffGameGuiButtonClick()
	{
		SetInterfaceInvisibility(enableInvisibilityInterface);
	}

	private void SetNGUITouchDragThreshold(float newValue)
	{
		if (UICamera.mainCamera != null && UICamera.mainCamera.GetComponent<UICamera>() != null)
		{
			UICamera.mainCamera.GetComponent<UICamera>().touchDragThreshold = newValue;
		}
		else
		{
			Debug.LogWarning("UICamera.mainCamera is null");
		}
	}

	public void ShowControlSchemeConfigurator()
	{
		CameraTouchControlSchemeConfigurator.Show();
	}
}
