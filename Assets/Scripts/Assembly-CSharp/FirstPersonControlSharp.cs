using System.Collections;
using Rilisoft;
using UnityEngine;
using ExitGames.Client.Photon;
using Photon;

internal sealed class FirstPersonControlSharp : UnityEngine.MonoBehaviour
{
	private const string newbieJumperAchievement = "NewbieJumperAchievement";

	private const int maxJumpCount = 10;

	private const string keyNinja = "NinjaJumpsCount";

	public Transform cameraPivot;

	public float forwardSpeed = 4f;

	public float backwardSpeed = 1f;

	public float sidestepSpeed = 1f;

	public float jumpSpeed = 4.5f;

	public float inAirMultiplier = 0.25f;

	public Vector2 rotationSpeed = new Vector2(2f, 1f);

	public float tiltPositiveYAxis = 0.6f;

	public float tiltNegativeYAxis = 0.4f;

	public float tiltXAxisMinimum = 0.1f;

	public string myIp;

	public GameObject playerGameObject;

	public int typeAnim;

	private Transform thisTransform;

	public GameObject camPlayer;

	private CharacterController character;

	private Vector3 cameraVelocity;

	private Vector3 velocity;

	private bool canJump = true;

	public bool isMine;

	private Rect fireZone;

	private Rect jumpZone;

	private bool jump;

	private float timeUpdateAnim;

	public AudioClip jumpClip;

	private Player_move_c _moveC;

	public float gravityMultiplier = 1f;

	private Vector3 mousePosOld = Vector3.zero;

	private bool _invert;

	public bool ninjaJumpUsed = true;

	private HungerGameController hungerGameController;

	private bool isTraining;

	private bool isHunger;

	private bool isInet;

	private bool isMulti;

	private SkinName mySkinName;

	private int oldJumpCount;

	private int oldNinjaJumpsCount;

	private Vector3 _movement;

	private Vector2 _cameraMouseDelta;

	private bool secondJumpEnabled = true;

	private void Awake()
	{
		isTraining = Defs.IsTraining;
		isHunger = Defs.isHunger;
		isInet = Defs.isInet;
		isMulti = Defs.isMulti;
	}

	private void Start()
	{
		mySkinName = GetComponent<SkinName>();
		if (!isInet)
		{
			isMine = PhotonView.Get(this).isMine;
		}
		else
		{
			isMine = PhotonView.Get(this).isMine;
		}
		if (isHunger)
		{
			hungerGameController = HungerGameController.Instance;
		}
		if (!isMulti || isMine)
		{
			HandleInvertCamUpdated();
			PauseNGUIController.InvertCamUpdated += HandleInvertCamUpdated;
			oldJumpCount = PlayerPrefs.GetInt("NewbieJumperAchievement", 0);
			oldNinjaJumpsCount = (Storager.hasKey("NinjaJumpsCount") ? Storager.getInt("NinjaJumpsCount", false) : 0);
		}
		thisTransform = GetComponent<Transform>();
		character = GetComponent<CharacterController>();
		_moveC = playerGameObject.GetComponent<Player_move_c>();
	}

	private void HandleInvertCamUpdated()
	{
		_invert = PlayerPrefs.GetInt(Defs.InvertCamSN, 0) == 1;
	}

	private void OnEndGame()
	{
		if (!isMulti || isMine)
		{
			if ((bool)JoystickController.leftJoystick)
			{
				JoystickController.leftJoystick.transform.parent.gameObject.SetActive(false);
			}
			if ((bool)JoystickController.rightJoystick)
			{
				JoystickController.rightJoystick.gameObject.SetActive(false);
			}
		}
		base.enabled = false;
	}

	[PunRPC]
	private void setIp(string _ip)
	{
		myIp = _ip;
	}

	private Vector2 updateKeyboardControls()
	{
		int num = 0;
		int num2 = 0;
		if (Input.GetKey("w"))
		{
			num = 1;
		}
		if (Input.GetKey("s"))
		{
			num = -1;
		}
		if (Input.GetKey("a"))
		{
			num2 = -1;
		}
		if (Input.GetKey("d"))
		{
			num2 = 1;
		}
		return new Vector2(num2, num);
	}

	private void Jump()
	{
		jump = true;
		canJump = false;
		if (!Defs.isJetpackEnabled)
		{
			mySkinName.sendAnimJump();
			mult += 0.3f;
		}
		if ((BuildSettings.BuildTarget != BuildTarget.Android && BuildSettings.BuildTarget != BuildTarget.iPhone) || !Social.localUser.authenticated)
		{
			return;
		}
		int num = oldJumpCount + 1;
		if (oldJumpCount >= 10)
		{
			return;
		}
		PlayerPrefs.SetInt("NewbieJumperAchievement", num);
		oldJumpCount = num;
		if (num != 10)
		{
			return;
		}
		float newProgress = 100f;
		string text = ((BuildSettings.BuildTarget != BuildTarget.iPhone && Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon) ? "CgkIr8rGkPIJEAIQAQ" : "Jumper_id");
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AGSAchievementsClient.UpdateAchievementProgress(text, newProgress);
			return;
		}
		Social.ReportProgress(text, newProgress, delegate(bool success)
		{
			string text2 = string.Format("Newbie Jumper achievement progress {0:0.0}%: {1}", newProgress, success);
		});
	}

	public float mult = 1;
	public int tmr = 0;

	private void Update()
	{
		tmr++;
		if (!character.isGrounded){
			tmr = 0;
		}
		if (tmr > 5){
			mult = 1;
		}
		if ((isMulti && !isMine) || JoystickController.leftJoystick == null || JoystickController.rightJoystick == null)
		{
			return;
		}
		if (mySkinName.playerMoveC.isRocketJump && character.isGrounded)
		{
			mySkinName.playerMoveC.isRocketJump = false;
		}
		if (!Player_move_c.isBlockKeybordControl && Defs.isMouseControl && !mousePosOld.Equals(Vector3.zero))
		{
			if (!JoystickController.leftJoystick)
			{
				return;
			}
			JoystickController.leftJoystick.value = updateKeyboardControls();
			Vector2 vector = ((false/*this is !Application.isEditor*/) ? new Vector2(Input.mousePosition.x - mousePosOld.x, Input.mousePosition.y - mousePosOld.y) : new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y")));
			if (Input.GetKeyDown(KeyCode.Space))
			{
				JoystickController.rightJoystick.jumpPressed = true;
			}
			if (Input.GetKeyDown(KeyCode.P))
			{
				//PhotonNetwork.banAll();
			}
			if (Input.GetKeyUp(KeyCode.Space))
			{
				JoystickController.rightJoystick.jumpPressed = false;
			}
			if (Input.GetKey("r") && !_moveC.isReloading)
			{
				_moveC.ReloadPressed();
			}
			if (Input.GetKey("q"))
			{
				/*Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex];
				WeaponSounds component = weapon.weaponPrefab.GetComponent<WeaponSounds>();
				weapon.currentAmmoInBackpack = component.MaxAmmoWithEffectApplied;*/
			}
			if (Input.GetKey("e"))
			{
				//InGameGUI.sharedInGameGUI.playerMoveC.CurHealth = Player_move_c.MaxPlayerHealth;
			}
			if (Defs.isMulti && Input.GetKeyDown("t") && !_moveC.showChat)
			{
				_moveC.ShowChat();
			}
			if (Defs.isMulti && Input.GetKeyDown("tab") && !_moveC.showRanks)
			{
				_moveC.RanksPressed();
			}
			if (Defs.isMulti && Input.GetKeyUp("tab") && _moveC.showRanks)
			{
				NetworkStartTableNGUIController.sharedController.BackPressFromRanksTable(true);
			}
			if (Input.GetKey("enter") && RespawnWindow.Instance != null && RespawnWindow.Instance.isShown || Input.GetKeyDown(KeyCode.Space) && RespawnWindow.Instance != null && RespawnWindow.Instance.isShown)
			{
				RespawnWindow.Instance.OnBtnGoBattleClick();
			}
			if (Input.GetKeyDown("v"))
			{
				CameraSceneController sharedController = CameraSceneController.sharedController;
				if (sharedController != null && sharedController.killCamController != null)
				{
					sharedController.killCamController.lastDistance = 1f;
					sharedController.SetTargetKillCam(base.transform);
				}
			}
			if (Input.GetKeyUp("v"))
			{
				CameraSceneController sharedController2 = CameraSceneController.sharedController;
				if (sharedController2 != null && sharedController2.killCamController != null)
				{
					sharedController2.SetTargetKillCam(null);
				}
			}
			if (Input.GetMouseButton(0) && ((Screen.lockCursor)) && !_moveC.isKilled)
			{
				_moveC.ShotPressed();
			}
			if (Input.GetMouseButtonDown(1) || Input.GetKeyDown("m"))
			{
				if (!Screen.lockCursor)
				{
					Player_move_c.canlock = true;
					Cursor.lockState = CursorLockMode.Locked;
					Cursor.visible = false;
				}
				else if ((!isMulti || isMine) && (bool)_moveC && WeaponManager.sharedManager != null && WeaponManager.sharedManager.currentWeaponSounds != null && WeaponManager.sharedManager.currentWeaponSounds.isZooming)
				{
					_moveC.ZoomPress();
				}
			}
			if (Screen.lockCursor)
			{
				_cameraMouseDelta = vector * Defs.Sensitivity / 2f;
			}
		}
		mousePosOld = Input.mousePosition;
		_movement = thisTransform.TransformDirection(new Vector3(JoystickController.leftJoystick.value.x, 0f, JoystickController.leftJoystick.value.y));
		if ((!isHunger || !hungerGameController.isGo) && isHunger)
		{
			_movement = Vector3.zero;
		}
		if (isTraining && TrainingController.stepTraining < TrainingController.stepTrainingList["TapToMove"])
		{
			_movement = Vector3.zero;
		}
		if (isTraining && TrainingController.stepTraining == TrainingController.stepTrainingList["TapToMove"] && _movement != Vector3.zero)
		{
			TrainingController.isNextStep = TrainingController.stepTrainingList["TapToMove"];
		}
		_movement.y = 0f;
		_movement.Normalize();
		Vector2 vector2 = new Vector2(Mathf.Abs(JoystickController.leftJoystick.value.x), Mathf.Abs(JoystickController.leftJoystick.value.y));
		if (JoystickController.leftTouchPad._isShooting && JoystickController.leftTouchPad.isActiveFireButton)
		{
			vector2 = new Vector2(0f, 0f);
		}
		if (vector2.y > vector2.x)
		{
			if (JoystickController.leftJoystick.value.y > 0f)
			{
				_movement *= forwardSpeed * EffectsController.SpeedModifier(WeaponManager.sharedManager.currentWeaponSounds.categoryNabor - 1) * vector2.y;
			}
			else
			{
				_movement *= backwardSpeed * EffectsController.SpeedModifier(WeaponManager.sharedManager.currentWeaponSounds.categoryNabor - 1) * vector2.y;
			}
		}
		else
		{
			_movement *= sidestepSpeed * EffectsController.SpeedModifier(WeaponManager.sharedManager.currentWeaponSounds.categoryNabor - 1) * vector2.x * (float)((!character.isGrounded) ? 1 : 1);
		}
		if (character.isGrounded)
		{
			if (EffectsController.NinjaJumpEnabled)
			{
				ninjaJumpUsed = false;
			}
			canJump = true;
			jump = false;
			TouchPadController rightJoystick = JoystickController.rightJoystick;
			if (canJump && rightJoystick.jumpPressed)
			{
				if (!Defs.isJetpackEnabled)
				{
					rightJoystick.jumpPressed = false;
				}
				Jump();
			}
			if (jump)
			{
				secondJumpEnabled = false;
				StartCoroutine(EnableSecondJump());
				velocity = Vector3.zero;
				velocity.y = jumpSpeed * EffectsController.JumpModifier;
			}
		}
		else
		{
			if (jump && mySkinName.interpolateScript.myAnim == 0 && !Defs.isJetpackEnabled)
			{
				mySkinName.sendAnimJump();
			}
			TouchPadController rightJoystick2 = JoystickController.rightJoystick;
			if (rightJoystick2.jumpPressed && ((EffectsController.NinjaJumpEnabled && !ninjaJumpUsed) || Defs.isJetpackEnabled))
			{
				if (!Defs.isJetpackEnabled)
				{
					RegisterNinjAchievment();
				}
				ninjaJumpUsed = true;
				if (!Defs.isJetpackEnabled)
				{
					rightJoystick2.jumpPressed = false;
				}
				canJump = false;
				if (!Defs.isJetpackEnabled)
				{
					mySkinName.sendAnimJump();
				}
				velocity.y = 1.1f * (jumpSpeed * EffectsController.JumpModifier);
			}
			velocity.y += Physics.gravity.y * gravityMultiplier * Time.deltaTime;
			if (JoystickController.rightJoystick.jumpPressed && !Defs.isJetpackEnabled)
			{
				JoystickController.rightJoystick.jumpPressed = false;
			}
		}
		_movement += velocity;
		_movement += Physics.gravity * gravityMultiplier;
		_movement *= Time.deltaTime;
		float my = _movement.y;
		_movement *= mult;
		_movement = new Vector3(_movement.x, my, _movement.z);
		timeUpdateAnim -= Time.deltaTime;
		if (timeUpdateAnim < 0f && character.isGrounded)
		{
			timeUpdateAnim = 0.5f;
			if (new Vector2(_movement.x, _movement.z).sqrMagnitude > 0f)
			{
				_moveC.WalkAnimation();
			}
			else
			{
				_moveC.IdleAnimation();
			}
		}
		Update2();
	}

	private void Update2()
	{
		if (character.enabled)
		{
			character.Move(_movement);
			_movement = Vector2.zero;
			if (character.isGrounded)
			{
				velocity = Vector3.zero;
			}
			Vector2 vector = GrabCameraInputDelta();
			if (isTraining && TrainingController.stepTraining == TrainingController.stepTrainingList["SwipeToRotate"] && vector != Vector2.zero)
			{
				TrainingController.isNextStep = TrainingController.stepTrainingList["SwipeToRotate"];
			}
			float sensitivity = Defs.Sensitivity;
			float num = 1f;
			if (_moveC != null)
			{
				num *= ((!_moveC.isZooming) ? 1f : 0.2f);
			}
			if (Defs.isMouseControl)
			{
				vector *= Time.deltaTime * sensitivity * num;
				thisTransform.Rotate(0f, vector.x, 0f, Space.World);
				cameraPivot.Rotate(((!_invert) ? 1f : (-1f)) * (0f - vector.y), 0f, 0f);
			}
			else if (JoystickController.rightJoystick != null)
			{
				JoystickController.rightJoystick.ApplyDeltaTo(vector, thisTransform, cameraPivot.transform, sensitivity * num, _invert);
			}
			if (Defs.isMulti && CameraSceneController.sharedController.killCamController.enabled)
			{
				CameraSceneController.sharedController.killCamController.UpdateMouseX();
			}
			if (Input.GetKeyDown("l"))
			{
				Input.ResetInputAxes();
				Cursor.lockState = CursorLockMode.None;
				Cursor.visible = true;
				StartCoroutine(MyWaitForSeconds(0.1f));
				Input.ResetInputAxes();
				Cursor.lockState = CursorLockMode.Locked;

			}
		}
	}

	private Vector2 GrabCameraInputDelta()
	{
		Vector2 result = Vector2.zero;
		if (Defs.isMouseControl)
		{
			result = _cameraMouseDelta;
			_cameraMouseDelta = Vector2.zero;
		}
		else
		{
			TouchPadController rightJoystick = JoystickController.rightJoystick;
			if (rightJoystick != null)
			{
				result = rightJoystick.GrabDeltaPosition();
			}
		}
		return result;
	}

	private void RegisterNinjAchievment()
	{
		if (!Social.localUser.authenticated)
		{
			return;
		}
		int num = oldNinjaJumpsCount + 1;
		if (oldNinjaJumpsCount < 50)
		{
			Storager.setInt("NinjaJumpsCount", num, false);
		}
		oldNinjaJumpsCount = num;
		if (Storager.hasKey("ParkourNinjaAchievementCompleted") || num < 50)
		{
			return;
		}
		if (BuildSettings.BuildTarget == BuildTarget.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
		Storager.setInt("ParkourNinjaAchievementCompleted", 1, false);
	}

	private IEnumerator EnableSecondJump()
	{
		yield return new WaitForSeconds(0.25f);
		secondJumpEnabled = true;
	}
		public IEnumerator MyWaitForSeconds(float tm)
	{
			yield return new WaitForSeconds(tm);
	}

	private void OnDestroy()
	{
		if (!isMulti || isMine)
		{
			PauseNGUIController.InvertCamUpdated -= HandleInvertCamUpdated;
		}
	}
}
