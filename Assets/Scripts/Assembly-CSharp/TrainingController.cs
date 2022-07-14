using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Rilisoft;
using UnityEngine;

public sealed class TrainingController : MonoBehaviour
{
	public GameObject swipeToRotateOverlay;

	public GameObject dragToMoveOverlay;

	public GameObject pickupGunOverlay;

	public GameObject wellDoneOverlay;

	public GameObject getCoinOverlay;

	public GameObject enterShopOverlay;

	public GameObject shopArrowOverlay;

	public GameObject swipeToChangeWeaponOverlay;

	public GameObject tapToChangeWeaponOverlay;

	public GameObject shootReloadOverlay;

	public GameObject selectGrenadeOverlay;

	public GameObject buyGrenadeArrowOverlay;

	public GameObject throwGrenadeOverlay;

	public GameObject throwGrenadeArrowOverlay;

	public GameObject killZombiesOverlay;

	public GameObject overlaysRoot;

	public GameObject joystickFingerOverlay;

	public GameObject joystickShadowOverlay;

	public GameObject touchpadOverlay;

	public GameObject touchpadFingerOverlay;

	public GameObject swipeWeaponFingerOverlay;

	public GameObject tapWeaponArrowOverlay;

	private GameObject[] _overlays = new GameObject[0];

	internal static TrainingState stepTraining;

	internal static Dictionary<string, TrainingState> stepTrainingList;

	internal static TrainingState isNextStep;

	public static bool isPressSkip;

	public static bool isPause;

	private Rect animTextureRect;

	private static bool nextStepAfterSkipTraining;

	private GameObject coinsPrefab;

	private Texture2D[] animTextures;

	private static int stepAnim;

	private static int maxStepAnim;

	private static bool isCanceled;

	private float speedAnim;

	private static TrainingState setNextStepInd;

	private Texture2D shop;

	private Texture2D shop_n;

	private bool isAnimShop;

	private static TrainingState oldStepTraning;

	private UIButton shopButton;

	private static bool? _trainingCompleted;

	private ActionDisposable _weaponChangedSubscription = new ActionDisposable(delegate
	{
	});

	private int _weaponChangingCount;

	public static bool? TrainingCompleted
	{
		get
		{
			return _trainingCompleted;
		}
		set
		{
			_trainingCompleted = value;
		}
	}

	static TrainingController()
	{
		stepTraining = (TrainingState)(-1);
		stepTrainingList = new Dictionary<string, TrainingState>();
		isNextStep = (TrainingState)0;
		isPause = false;
		nextStepAfterSkipTraining = false;
		setNextStepInd = (TrainingState)0;
		stepTrainingList.Add("SwipeToRotate", TrainingState.SwipeToRotate);
		stepTrainingList.Add("TapToMove", TrainingState.TapToMove);
		stepTrainingList.Add("GetTheGun", TrainingState.GetTheGun);
		stepTrainingList.Add("WellDone", TrainingState.WellDone);
		stepTrainingList.Add("GetTheCoin", TrainingState.GetTheCoin);
		stepTrainingList.Add("WellDoneCoin", TrainingState.WellDoneCoin);
		stepTrainingList.Add("InterTheShop", TrainingState.EnterTheShop);
		stepTrainingList.Add("Shop", TrainingState.Shop);
		stepTrainingList.Add("TapToSelectWeapon", TrainingState.TapToSelectWeapon);
		stepTrainingList.Add("TapToShoot", TrainingState.TapToShoot);
		stepTrainingList.Add("TapToAddGrenade", TrainingState.TapToAddGrenade);
		stepTrainingList.Add("TapToThrowGrenade", TrainingState.TapToThrowGrenade);
		stepTrainingList.Add("KillZombi", TrainingState.KillZombie);
		stepTrainingList.Add("GoToPortal", TrainingState.GoToPortal);
	}

	public static void SkipTraining()
	{
		oldStepTraning = stepTraining;
		stepTraining = (TrainingState)0;
		isPressSkip = true;
		isCanceled = true;
		_trainingCompleted = false;
		FlurryEvents.LogTrainingProgress("Skip");
	}

	public static void CancelSkipTraining()
	{
		Debug.Log("CancelSkipTraining");
		isCanceled = false;
		isPressSkip = false;
		stepTraining = oldStepTraning;
		TrainingController component = GameObject.FindGameObjectWithTag("TrainingController").GetComponent<TrainingController>();
		if (nextStepAfterSkipTraining)
		{
			nextStepAfterSkipTraining = false;
			component.StartNextStepTraning();
		}
		if (stepAnim == 0)
		{
			component.FirstStep();
		}
		else
		{
			component.NextStepAnim();
		}
	}

	private void AdjustShootReloadLabel()
	{
		bool flag = PlayerPrefs.GetInt(Defs.SwitchingWeaponsSwipeRegimSN, 0) == 1;
		if (shootReloadOverlay != null && flag)
		{
			shootReloadOverlay.transform.localPosition = shootReloadOverlay.transform.localPosition - new Vector3(120f, 0f, 0f);
		}
	}

	private void AdjustJoystickAreaAndFinger()
	{
		float num = (GlobalGameController.LeftHanded ? 1 : (-1));
		Vector3 vector = new Vector3((float)Defs.JoyStickX * num, Defs.JoyStickY, 0f);
		if (dragToMoveOverlay != null)
		{
			dragToMoveOverlay.transform.localPosition = vector + new Vector3(30f, 120f, 0f);
		}
		Vector3[] array = Load.LoadVector3Array(ControlsSettingsBase.JoystickSett);
		if (array != null && array.Length > 4)
		{
			vector = array[4];
		}
		if (joystickShadowOverlay != null)
		{
			joystickShadowOverlay.GetComponent<RectTransform>().anchoredPosition = vector;
		}
		TrainingFinger trainingFinger = ((!(joystickFingerOverlay == null)) ? joystickFingerOverlay.GetComponent<TrainingFinger>() : null);
		if (trainingFinger != null)
		{
			trainingFinger.GetComponent<RectTransform>().anchoredPosition = vector + new Vector3(20f, 20f, 0f);
		}
	}

	private void AdjustGrenadeLabelAndArrow()
	{
		Vector3 zero = Vector3.zero;
		Vector3[] array = Load.LoadVector3Array(ControlsSettingsBase.JoystickSett);
		if (array == null || array.Length < 6)
		{
			float num = (GlobalGameController.LeftHanded ? 1 : (-1));
			zero = new Vector3((float)Defs.GrenadeX * num, Defs.GrenadeY, 0f);
		}
		else
		{
			zero = array[5];
		}
		TrainingArrow trainingArrow = ((!(buyGrenadeArrowOverlay == null)) ? buyGrenadeArrowOverlay.GetComponent<TrainingArrow>() : null);
		if (trainingArrow != null)
		{
			trainingArrow.SetAnchoredPosition(zero - new Vector3(64f, 0f, 0f));
		}
		TrainingArrow trainingArrow2 = ((!(throwGrenadeArrowOverlay == null)) ? throwGrenadeArrowOverlay.GetComponent<TrainingArrow>() : null);
		if (trainingArrow2 != null)
		{
			trainingArrow2.SetAnchoredPosition(zero - new Vector3(90f, -60f, 0f));
		}
		if (selectGrenadeOverlay != null)
		{
			selectGrenadeOverlay.transform.localPosition = zero - new Vector3(120f, 0f, 0f);
		}
		if (throwGrenadeOverlay != null)
		{
			throwGrenadeOverlay.transform.localPosition = zero - new Vector3(400f, -120f, 0f);
		}
	}

	private IEnumerator Start()
	{
		_overlays = new GameObject[10] { swipeToRotateOverlay, dragToMoveOverlay, pickupGunOverlay, wellDoneOverlay, getCoinOverlay, enterShopOverlay, shootReloadOverlay, selectGrenadeOverlay, throwGrenadeOverlay, killZombiesOverlay };
		isPause = false;
		animTextures = new Texture2D[3];
		stepTraining = (TrainingState)0;
		isNextStep = (TrainingState)0;
		setNextStepInd = (TrainingState)0;
		StartNextStepTraning();
		coinsPrefab = GameObject.FindGameObjectWithTag("CoinBonus");
		if (coinsPrefab != null)
		{
			coinsPrefab.SetActive(false);
		}
		PlayerPrefs.SetInt("LogCountMatch", 1);
		if (ShopNGUIController.sharedShop != null)
		{
			ShopNGUIController.sharedShop.ResetTrainingState();
		}
		while (GameObject.FindGameObjectWithTag("InGameGUI") == null)
		{
			yield return null;
		}
		shopButton = GameObject.FindGameObjectWithTag("InGameGUI").GetComponent<InGameGUI>().shopButton.GetComponent<UIButton>();
		Storager.setInt("GrenadeID", 0, false);
		InGameGUI.sharedInGameGUI.SetSwipeWeaponPanelVisibility(false);
	}

	private void OnApplicationQuit()
	{
		FlurryEvents.LogTrainingProgress("Exit");
	}

	private void OnApplicationPause(bool pause)
	{
		FlurryEvents.LogTrainingProgress("Pause");
	}

	private void OnDestroy()
	{
		_weaponChangedSubscription.Dispose();
	}

	private void HandleWeaponChanged(object sender, EventArgs e)
	{
		Debug.Log("Weapon changed count: " + _weaponChangingCount);
		if (_weaponChangingCount > 0 && stepTraining == TrainingState.TapToSelectWeapon)
		{
			isNextStep = TrainingState.TapToSelectWeapon;
		}
		_weaponChangingCount++;
	}

	[Obfuscation(Exclude = true)]
	public void StartNextStepTraning()
	{
		if (isPressSkip)
		{
			nextStepAfterSkipTraining = true;
			return;
		}
		stepTraining++;
		Debug.Log("Start traning step: " + stepTraining);
		Vector2 vector = Vector2.zero;
		if (stepTraining == stepTrainingList["SwipeToRotate"])
		{
			AdjustJoystickAreaAndFinger();
			isCanceled = true;
			maxStepAnim = 13;
			speedAnim = 0.5f;
			stepAnim = 0;
			for (int i = 0; i != animTextures.Length; i++)
			{
				animTextures[i] = null;
			}
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width - (float)animTextures[0].width * Defs.Coef, (float)Screen.height - (float)animTextures[0].height * Defs.Coef);
			}
		}
		if (stepTraining == TrainingState.TapToMove)
		{
			isCanceled = true;
			maxStepAnim = 19;
			speedAnim = 0.5f;
			stepAnim = 0;
			for (int j = 0; j != animTextures.Length; j++)
			{
				animTextures[j] = null;
			}
			if (animTextures[0] != null)
			{
				vector = new Vector2(-10f * Defs.Coef, (float)Screen.height - ((float)animTextures[0].height - 51f) * Defs.Coef);
			}
		}
		if (stepTraining == stepTrainingList["GetTheGun"])
		{
			isCanceled = true;
			maxStepAnim = 2;
			speedAnim = 0.2f;
			stepAnim = 0;
			animTextures[0] = null;
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width * 0.5f - (float)animTextures[0].width * 0.5f * Defs.Coef, (float)Screen.height * 0.25f - (float)animTextures[0].height * 0.5f * Defs.Coef);
			}
			BonusCreator._CreateBonus(pos: new Vector3(1.05f, 0.25f, -6.79f), _weaponName: WeaponManager.ShotgunWN);
		}
		if (stepTraining == stepTrainingList["WellDone"] || stepTraining == stepTrainingList["WellDoneCoin"])
		{
			isCanceled = true;
			maxStepAnim = 2;
			speedAnim = 3f;
			stepAnim = 0;
			animTextures[0] = null;
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width * 0.5f - (float)animTextures[0].width * 0.5f * Defs.Coef, (float)Screen.height * 0.25f - (float)animTextures[0].height * 0.5f * Defs.Coef);
			}
		}
		if (stepTraining == stepTrainingList["GetTheCoin"])
		{
			if (coinsPrefab != null)
			{
				coinsPrefab.SetActive(true);
				coinsPrefab.GetComponent<CoinBonus>().SetPlayer();
			}
			isCanceled = true;
			maxStepAnim = 2;
			speedAnim = 3f;
			stepAnim = 0;
			animTextures[0] = null;
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width * 0.5f - (float)animTextures[0].width * 0.5f * Defs.Coef, (float)Screen.height * 0.25f - (float)animTextures[0].height * 0.5f * Defs.Coef);
			}
		}
		if (stepTraining == TrainingState.EnterTheShop)
		{
			isAnimShop = false;
			AnimShop();
			isCanceled = true;
			maxStepAnim = 13;
			speedAnim = 0.3f;
			stepAnim = 0;
			for (int k = 0; k != animTextures.Length; k++)
			{
				animTextures[k] = null;
			}
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width - ((float)animTextures[0].width + 200f) * Defs.Coef, 100f * Defs.Coef);
			}
			if (true)
			{
				Screen.lockCursor = false;
			}
		}
		if (stepTraining == TrainingState.TapToSelectWeapon)
		{
			InGameGUI.sharedInGameGUI.SetSwipeWeaponPanelVisibility(PlayerPrefs.GetInt(Defs.SwitchingWeaponsSwipeRegimSN, 0) == 1);
			Player_move_c playerMove = GameObject.FindGameObjectWithTag("PlayerGun").GetComponent<Player_move_c>();
			if (playerMove != null)
			{
				playerMove.WeaponChanged += HandleWeaponChanged;
				_weaponChangedSubscription = new ActionDisposable(delegate
				{
					playerMove.WeaponChanged -= HandleWeaponChanged;
					_weaponChangingCount = 0;
				});
			}
		}
		else
		{
			_weaponChangedSubscription.Dispose();
		}
		if (stepTraining == stepTrainingList["TapToShoot"])
		{
			AdjustShootReloadLabel();
			isCanceled = true;
			maxStepAnim = 2;
			speedAnim = 3f;
			stepAnim = 0;
			animTextures[0] = null;
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width * 0.5f - (float)animTextures[0].width * 0.5f * Defs.Coef, (float)Screen.height * 0.3f - (float)animTextures[0].height * 0.5f * Defs.Coef);
			}
			if (true)
			{
				Screen.lockCursor = true;
			}
		}
		TrainingState value;
		if (stepTrainingList.TryGetValue("SwipeWeapon", out value) && value == stepTraining)
		{
			isCanceled = true;
			maxStepAnim = 13;
			speedAnim = 0.3f;
			stepAnim = 0;
			for (int l = 0; l != animTextures.Length; l++)
			{
				animTextures[l] = null;
			}
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width - (float)animTextures[0].width * Defs.Coef, 0f);
			}
		}
		if (stepTraining == stepTrainingList["KillZombi"])
		{
			GameObject.FindGameObjectWithTag("GameController").transform.GetComponent<ZombieCreator>().BeganCreateEnemies();
			isCanceled = true;
			maxStepAnim = 2;
			speedAnim = 3f;
			stepAnim = 0;
			animTextures[0] = null;
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width * 0.5f - (float)animTextures[0].width * 0.5f * Defs.Coef, (float)Screen.height * 0.25f - (float)animTextures[0].height * 0.5f * Defs.Coef);
			}
			if (true)
			{
				Screen.lockCursor = true;
			}
		}
		if (stepTraining == stepTrainingList["TapToSelectWeapon"])
		{
			isCanceled = true;
			maxStepAnim = 19;
			speedAnim = 0.5f;
			stepAnim = 0;
			animTextures[0] = Resources.Load<Texture2D>("Training/ob_change_0");
			animTextures[1] = Resources.Load<Texture2D>("Training/ob_change_1");
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width * 0.5f - 164f * Defs.Coef - (float)animTextures[0].width * 0.5f * Defs.Coef, (float)Screen.height - (112f + (float)animTextures[0].height) * Defs.Coef);
			}
		}
		if (stepTraining == stepTrainingList["TapToAddGrenade"])
		{
			AdjustGrenadeLabelAndArrow();
			isCanceled = true;
			maxStepAnim = 19;
			speedAnim = 0.5f;
			stepAnim = 0;
			for (int m = 0; m != animTextures.Length; m++)
			{
				animTextures[m] = null;
			}
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width - 100f * Defs.Coef - (float)animTextures[0].width * Defs.Coef, (312f - (float)animTextures[0].height * 0.5f) * Defs.Coef);
			}
			if (true)
			{
				Screen.lockCursor = false;
			}
		}
		if (stepTraining == stepTrainingList["TapToThrowGrenade"])
		{
			isCanceled = true;
			maxStepAnim = 19;
			speedAnim = 0.5f;
			stepAnim = 0;
			for (int n = 0; n != animTextures.Length; n++)
			{
				animTextures[n] = null;
			}
			Defs.InitCoordsIphone();
			if (animTextures[0] != null)
			{
				vector = new Vector2((float)Screen.width - ((float)(-Defs.GrenadeX + animTextures[0].width) + 80f) * Defs.Coef, (float)Screen.height - ((float)(Defs.GrenadeY + animTextures[0].height) - 80f) * Defs.Coef);
			}
		}
		if (animTextures[0] != null)
		{
			animTextureRect = new Rect(vector.x, vector.y, (float)animTextures[0].width * Defs.Coef, (float)animTextures[0].height * Defs.Coef);
		}
		Invoke("FirstStep", 1f);
	}

	[Obfuscation(Exclude = true)]
	private void AnimShop()
	{
		isAnimShop = !isAnimShop;
		bool flag = stepTraining == TrainingState.EnterTheShop;
		string normalSprite = shopButton.normalSprite;
		string pressedSprite = shopButton.pressedSprite;
		shopButton.pressedSprite = normalSprite;
		shopButton.normalSprite = pressedSprite;
		if (flag)
		{
			Invoke("AnimShop", 0.3f);
		}
	}

	[Obfuscation(Exclude = true)]
	private void FirstStep()
	{
		isCanceled = false;
		stepAnim = 0;
		NextStepAnim();
	}

	[Obfuscation(Exclude = true)]
	private void NextStepAnim()
	{
		CancelInvoke("NextStepAnim");
		if (!isCanceled)
		{
			stepAnim++;
			if (stepTraining == stepTrainingList["WellDone"] && stepAnim >= maxStepAnim)
			{
				isNextStep = stepTrainingList["WellDone"];
			}
			else if (stepTraining == stepTrainingList["WellDoneCoin"] && stepAnim >= maxStepAnim)
			{
				isNextStep = stepTrainingList["WellDoneCoin"];
			}
			else
			{
				Invoke("NextStepAnim", speedAnim);
			}
		}
	}

	private void Update()
	{
		if (coinsPrefab == null && stepTraining < stepTrainingList["GetTheCoin"])
		{
			coinsPrefab = GameObject.FindGameObjectWithTag("CoinBonus");
			if (coinsPrefab != null)
			{
				coinsPrefab.SetActive(false);
			}
		}
		if (isNextStep > setNextStepInd)
		{
			setNextStepInd = isNextStep;
			if (stepTraining == stepTrainingList["SwipeToRotate"] || stepTraining == stepTrainingList["TapToMove"])
			{
				Invoke("StartNextStepTraning", 1.5f);
			}
			else if (stepTraining == stepTrainingList["TapToShoot"])
			{
				Invoke("StartNextStepTraning", 3f);
			}
			else
			{
				StartNextStepTraning();
			}
		}
		if (ShopNGUIController.GuiActive || isPause)
		{
			if (shopArrowOverlay != null)
			{
				shopArrowOverlay.SetActive(false);
			}
			if (buyGrenadeArrowOverlay != null)
			{
				buyGrenadeArrowOverlay.SetActive(false);
			}
			if (throwGrenadeArrowOverlay != null)
			{
				throwGrenadeArrowOverlay.SetActive(false);
			}
			if (joystickFingerOverlay != null)
			{
				joystickFingerOverlay.SetActive(false);
			}
			if (joystickShadowOverlay != null)
			{
				joystickShadowOverlay.SetActive(false);
			}
			if (touchpadOverlay != null)
			{
				touchpadOverlay.SetActive(false);
			}
			if (touchpadFingerOverlay != null)
			{
				touchpadFingerOverlay.SetActive(false);
			}
			if (swipeWeaponFingerOverlay != null)
			{
				swipeWeaponFingerOverlay.SetActive(false);
			}
			if (tapWeaponArrowOverlay != null)
			{
				tapWeaponArrowOverlay.SetActive(false);
			}
		}
	}

	private void LateUpdate()
	{
		RefreshOverlays();
	}

	private void RefreshOverlays()
	{
		if (isPause)
		{
			return;
		}
		GameObject objA = null;
		if (stepTraining == stepTrainingList["SwipeToRotate"])
		{
			objA = swipeToRotateOverlay;
		}
		else if (stepTraining == stepTrainingList["TapToMove"])
		{
			objA = dragToMoveOverlay;
		}
		else if (stepTraining == stepTrainingList["GetTheGun"])
		{
			objA = pickupGunOverlay;
		}
		else if (stepTraining == stepTrainingList["WellDone"] || stepTraining == stepTrainingList["WellDoneCoin"])
		{
			objA = wellDoneOverlay;
		}
		else if (stepTraining == stepTrainingList["GetTheCoin"])
		{
			objA = getCoinOverlay;
		}
		else if (stepTraining == stepTrainingList["InterTheShop"])
		{
			objA = enterShopOverlay;
		}
		else if (stepTraining == stepTrainingList["TapToShoot"])
		{
			objA = shootReloadOverlay;
		}
		else if (stepTraining == stepTrainingList["TapToAddGrenade"])
		{
			objA = selectGrenadeOverlay;
		}
		else if (stepTraining == stepTrainingList["TapToThrowGrenade"])
		{
			objA = throwGrenadeOverlay;
		}
		else if (stepTraining == stepTrainingList["KillZombi"])
		{
			objA = killZombiesOverlay;
		}
		foreach (GameObject item in _overlays.Where((GameObject o) => null != o))
		{
			item.SetActive(object.ReferenceEquals(objA, item));
		}
		bool flag = PlayerPrefs.GetInt(Defs.SwitchingWeaponsSwipeRegimSN, 0) == 1;
		if (swipeToChangeWeaponOverlay != null)
		{
			swipeToChangeWeaponOverlay.SetActive(stepTraining == TrainingState.TapToSelectWeapon && flag);
		}
		if (tapToChangeWeaponOverlay != null)
		{
			tapToChangeWeaponOverlay.SetActive(stepTraining == TrainingState.TapToSelectWeapon && !flag);
		}
		if (shopArrowOverlay != null)
		{
			shopArrowOverlay.SetActive(stepTraining == stepTrainingList["InterTheShop"]);
		}
		if (buyGrenadeArrowOverlay != null)
		{
			buyGrenadeArrowOverlay.SetActive(stepTraining == stepTrainingList["TapToAddGrenade"]);
		}
		if (throwGrenadeArrowOverlay != null)
		{
			throwGrenadeArrowOverlay.SetActive(stepTraining == stepTrainingList["TapToThrowGrenade"]);
		}
		if (joystickFingerOverlay != null)
		{
			joystickFingerOverlay.SetActive(stepTraining == stepTrainingList["TapToMove"]);
		}
		if (joystickShadowOverlay != null)
		{
			joystickShadowOverlay.SetActive(stepTraining == stepTrainingList["TapToMove"]);
		}
		if (touchpadOverlay != null)
		{
			touchpadOverlay.SetActive(stepTraining == stepTrainingList["SwipeToRotate"]);
		}
		if (touchpadFingerOverlay != null)
		{
			touchpadFingerOverlay.SetActive(stepTraining == stepTrainingList["SwipeToRotate"]);
		}
		if (swipeWeaponFingerOverlay != null)
		{
			swipeWeaponFingerOverlay.SetActive(stepTraining == TrainingState.TapToSelectWeapon && flag);
		}
		if (tapWeaponArrowOverlay != null)
		{
			tapWeaponArrowOverlay.SetActive(stepTraining == TrainingState.TapToSelectWeapon && !flag);
		}
	}

	private void OnGUI()
	{
		if (isPause)
		{
			return;
		}
		bool flag = stepTraining == TrainingState.EnterTheShop;
		TrainingState value;
		bool flag2 = stepTrainingList.TryGetValue("SwipeWeapon", out value) && value == stepTraining;
		if (stepTraining == stepTrainingList["SwipeToRotate"] || flag || flag2 || stepTraining == stepTrainingList["TapToSelectWeapon"] || stepTraining == stepTrainingList["TapToAddGrenade"] || stepTraining == stepTrainingList["TapToThrowGrenade"])
		{
			if (stepAnim / 2 * 2 - stepAnim == -1 && animTextures[0] != null)
			{
				GUI.DrawTexture(animTextureRect, animTextures[0]);
			}
			if (stepAnim != 0 && stepAnim / 2 * 2 - stepAnim == 0 && animTextures[1] != null)
			{
				GUI.DrawTexture(animTextureRect, animTextures[1]);
			}
		}
		if (stepTraining == stepTrainingList["TapToMove"])
		{
			if (stepAnim / 3 * 3 - stepAnim == -1 && animTextures[0] != null)
			{
				GUI.DrawTexture(animTextureRect, animTextures[0]);
			}
			if (stepAnim / 3 * 3 - stepAnim == -2 && animTextures[1] != null)
			{
				GUI.DrawTexture(animTextureRect, animTextures[1]);
			}
			if (stepAnim != 0 && stepAnim / 3 * 3 - stepAnim == 0 && animTextures[2] != null)
			{
				GUI.DrawTexture(animTextureRect, animTextures[2]);
			}
		}
		if ((stepTraining == stepTrainingList["WellDone"] || stepTraining == stepTrainingList["WellDoneCoin"] || stepTraining == stepTrainingList["TapToShoot"] || stepTraining == stepTrainingList["GetTheGun"] || stepTraining == stepTrainingList["GetTheCoin"] || stepTraining == stepTrainingList["KillZombi"]) && stepAnim > 0 && animTextures[0] != null)
		{
			GUI.DrawTexture(animTextureRect, animTextures[0]);
		}
	}
}
