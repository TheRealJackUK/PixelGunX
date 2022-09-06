using System;
using System.Collections;
using System.Reflection;
using Rilisoft;
using UnityEngine;

internal sealed class SettingsController : MonoBehaviour
{
	public const int SensitivityLowerBound = 6;

	public const int SensitivityUpperBound = 19;

	public MainMenuHeroCamera rotateCamera;

	public UIButton backButton;

	public UIButton controlsButton;

	public UIButton socialButton;

	public UIButton syncButton;

	public GameObject controlsSettings;

	public GameObject tapPanel;

	public GameObject swipePanel;

	public GameObject mainPanel;

	public GameObject socialPanel;

	public UISlider sensitivitySlider;

	public UILabel versionLabel;

	public SettingsToggleButtons chatToggleButtons;

	public SettingsToggleButtons musicToggleButtons;

	public SettingsToggleButtons soundToggleButtons;

	public SettingsToggleButtons invertCameraToggleButtons;

	public SettingsToggleButtons recToggleButtons;

	public SettingsToggleButtons leftHandedToggleButtons;

	public SettingsToggleButtons switchingWeaponsToggleButtons;

	private bool _backRequested;

	private float _cachedSensitivity;

	public static event Action ControlsClicked;

	public static void SwitchChatSetting(bool on, Action additional = null)
	{
		if (Application.isEditor)
		{
			Debug.Log("[Chat] button clicked: " + on);
		}
		bool isChatOn = Defs.IsChatOn;
		if (isChatOn != on)
		{
			Defs.IsChatOn = on;
			if (additional != null)
			{
				additional();
			}
		}
	}

	public static void ChangeLeftHandedRightHanded(bool isChecked, Action handler = null)
	{
		if (Application.isEditor)
		{
			Debug.Log("[Left Handed] button clicked: " + isChecked);
		}
		if (GlobalGameController.LeftHanded == isChecked)
		{
			return;
		}
		GlobalGameController.LeftHanded = isChecked;
		PlayerPrefs.SetInt(Defs.LeftHandedSN, isChecked ? 1 : 0);
		PlayerPrefs.Save();
		if (handler != null)
		{
			handler();
		}
		if (SettingsController.ControlsClicked != null)
		{
			SettingsController.ControlsClicked();
		}
		if (!isChecked)
		{
			FlurryPluginWrapper.LogEvent("Left-handed Layout Enabled");
			if (Debug.isDebugBuild)
			{
				Debug.Log("Left-handed Layout Enabled");
			}
		}
	}

	public static void ChangeSwitchingWeaponHanded(bool isChecked, Action handler = null)
	{
		if (Application.isEditor)
		{
			Debug.Log("[Switching Weapon button clicked: " + isChecked);
		}
		if (GlobalGameController.switchingWeaponSwipe == isChecked)
		{
			GlobalGameController.switchingWeaponSwipe = !isChecked;
			PlayerPrefs.SetInt(Defs.SwitchingWeaponsSwipeRegimSN, GlobalGameController.switchingWeaponSwipe ? 1 : 0);
			PlayerPrefs.Save();
			if (handler != null)
			{
				handler();
			}
		}
	}

	private void Start()
	{
		string text = Assembly.GetExecutingAssembly().GetName().Version.ToString();
		if (versionLabel != null)
		{
			versionLabel.text = text;
		}
		else
		{
			Debug.LogWarning("versionLabel == null");
		}
		if (backButton != null)
		{
			ButtonHandler component = backButton.GetComponent<ButtonHandler>();
			component.Clicked += HandleBackFromSettings;
		}
		if (controlsButton != null)
		{
			ButtonHandler component2 = controlsButton.GetComponent<ButtonHandler>();
			component2.Clicked += HandleControlsClicked;
		}
		if (socialButton != null)
		{
			ButtonHandler component3 = socialButton.GetComponent<ButtonHandler>();
			component3.Clicked += HandleSocialButton;
		}
		if (syncButton != null)
		{
			ButtonHandler component4 = syncButton.GetComponent<ButtonHandler>();
			UILabel uILabel = null;
			Transform transform = syncButton.transform.Find("Label");
			if (transform != null)
			{
				uILabel = transform.gameObject.GetComponent<UILabel>();
			}
			if (Application.platform == RuntimePlatform.IPhonePlayer)
			{
				syncButton.gameObject.SetActive(true);
				component4.Clicked += HandleRestoreClicked;
				if (uILabel != null)
				{
					uILabel.text = LocalizationStore.Get("Key_0080");
				}
			}
			else if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				syncButton.gameObject.SetActive(true);
				component4.Clicked += HandleSyncClicked;
				if (uILabel != null)
				{
					uILabel.text = LocalizationStore.Get("Key_0935");
				}
			}
			else if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				bool flag = false;
				syncButton.gameObject.SetActive(flag);
				component4.Clicked += HandleSyncClicked;
			}
		}
		if (sensitivitySlider != null)
		{
			float sensitivity = Defs.Sensitivity;
			float num = Mathf.Clamp(sensitivity, 6f, 19f);
			float num2 = num - 6f;
			sensitivitySlider.value = num2 / 13f;
			_cachedSensitivity = num;
		}
		else
		{
			Debug.LogWarning("sensitivitySlider == null");
		}
		musicToggleButtons.IsChecked = Defs.isSoundMusic;
		musicToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			if (Application.isEditor)
			{
				Debug.Log("[Music] button clicked: " + e.IsChecked);
			}
			GameObject gameObject = GameObject.FindGameObjectWithTag("MenuBackgroundMusic");
			MenuBackgroundMusic menuBackgroundMusic = ((!(gameObject != null)) ? null : gameObject.GetComponent<MenuBackgroundMusic>());
			if (Defs.isSoundMusic != e.IsChecked)
			{
				Defs.isSoundMusic = e.IsChecked;
				PlayerPrefsX.SetBool(PlayerPrefsX.SoundMusicSetting, Defs.isSoundMusic);
				PlayerPrefs.Save();
				if (menuBackgroundMusic != null)
				{
					if (e.IsChecked)
					{
						menuBackgroundMusic.Play();
					}
					else
					{
						menuBackgroundMusic.Stop();
					}
				}
				else
				{
					Debug.LogWarning("menuBackgroundMusic == null");
				}
			}
		};
		soundToggleButtons.IsChecked = Defs.isSoundFX;
		soundToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			if (Application.isEditor)
			{
				Debug.Log("[Sound] button clicked: " + e.IsChecked);
			}
			if (Defs.isSoundFX != e.IsChecked)
			{
				Defs.isSoundFX = e.IsChecked;
				PlayerPrefsX.SetBool(PlayerPrefsX.SoundFXSetting, Defs.isSoundFX);
				PlayerPrefs.Save();
			}
		};
		chatToggleButtons.IsChecked = Defs.IsChatOn;
		chatToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			SwitchChatSetting(e.IsChecked);
		};
		invertCameraToggleButtons.IsChecked = PlayerPrefs.GetInt(Defs.InvertCamSN, 0) == 1;
		invertCameraToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			if (Application.isEditor)
			{
				Debug.Log("[Invert Camera] button clicked: " + e.IsChecked);
			}
			bool flag2 = PlayerPrefs.GetInt(Defs.InvertCamSN, 0) == 1;
			if (flag2 != e.IsChecked)
			{
				PlayerPrefs.SetInt(Defs.InvertCamSN, Convert.ToInt32(e.IsChecked));
				PlayerPrefs.Save();
			}
		};
		if (leftHandedToggleButtons != null)
		{
			leftHandedToggleButtons.IsChecked = GlobalGameController.LeftHanded;
			leftHandedToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
			{
				ChangeLeftHandedRightHanded(e.IsChecked);
			};
		}
		if (switchingWeaponsToggleButtons != null)
		{
			switchingWeaponsToggleButtons.IsChecked = !GlobalGameController.switchingWeaponSwipe;
			switchingWeaponsToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
			{
				ChangeSwitchingWeaponHanded(e.IsChecked);
			};
		}
		recToggleButtons.gameObject.SetActive(PauseNGUIController.RecButtonsAvailable());
		recToggleButtons.IsChecked = GlobalGameController.ShowRec;
		recToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			if (Application.isEditor)
			{
				Debug.Log("[Rec. Buttons] button clicked: " + e.IsChecked);
			}
			if (GlobalGameController.ShowRec != e.IsChecked)
			{
				GlobalGameController.ShowRec = e.IsChecked;
				PlayerPrefs.SetInt(Defs.ShowRecSN, e.IsChecked ? 1 : 0);
				PlayerPrefs.Save();
			}
		};
	}

	private void Update()
	{
		if (_backRequested && !ShopIsActive())
		{
			_backRequested = false;
			mainPanel.SetActive(true);
			base.gameObject.SetActive(false);
			rotateCamera.OnMainMenuCloseOptions();
			return;
		}
		float num = sensitivitySlider.value;
		float num2 = Mathf.Clamp(num + 6f, 6f, 19f);
		if (_cachedSensitivity != num2)
		{
			if (Application.isEditor)
			{
				Debug.Log("New sensitivity: " + num2);
			}
			Defs.Sensitivity = num2;
			_cachedSensitivity = num2;
		}
	}

	private void LateUpdate()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_backRequested = true;
		}
	}

	private void HandleBackFromSettings(object sender, EventArgs e)
	{
		_backRequested = true;
	}

	private void HandleControlsClicked(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("[Controls] button clicked.");
		}
		if (!ShopIsActive())
		{
			controlsSettings.SetActive(true);
			tapPanel.SetActive(!GlobalGameController.switchingWeaponSwipe);
			swipePanel.SetActive(GlobalGameController.switchingWeaponSwipe);
			base.gameObject.SetActive(false);
			if (SettingsController.ControlsClicked != null)
			{
				SettingsController.ControlsClicked();
			}
		}
	}

	private void HandleSocialButton(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("[Social] button clicked.");
		}
		if (!ShopIsActive())
		{
			socialPanel.SetActive(true);
			base.gameObject.SetActive(false);
		}
	}

	private void HandleRestoreClicked(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("[Restore] button clicked.");
		}
		if (ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.Refresh();
		}
		if (ExpController.Instance != null)
		{
			ExpController.Instance.Refresh();
		}
	}

	private void HandleSyncClicked(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("[Sync] button clicked.");
		}
		if (BuildSettings.BuildTarget == BuildTarget.Android)
		{
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				PurchasesSynchronizer.Instance.SynchronizeAmazonPurchases();
				if (WeaponManager.sharedManager != null)
				{
					WeaponManager.sharedManager.Reset(0);
				}
				StarterPackController.Get.RestoreStarterPackForAmazon();
				return;
			}
			Action afterAuth = delegate
			{
				PurchasesSynchronizer.Instance.SynchronizeIfAuthenticated(delegate(bool succeeded)
				{
					if (succeeded && WeaponManager.sharedManager != null)
					{
						WeaponManager.sharedManager.Reset(0);
					}
					StoreKitEventListener.purchaseInProcess = false;
					PlayerPrefs.DeleteKey("PendingGooglePlayGamesSync");
				});
				GoogleIAB.queryInventory(StoreKitEventListener.starterPackIds);
			};
			StoreKitEventListener.purchaseInProcess = true;
			StartCoroutine(RestoreProgressIndicator(5f));
			Debug.LogWarning("SettingsController: Exception occured while authenticating with Google Play Games. See next exception message for details.");
			return;
			string message = string.Format("Already authenticated: {0}, {1}, {2}", Social.localUser.id, Social.localUser.userName, Social.localUser.state);
			Debug.Log(message);
			afterAuth();
		}
		else if (BuildSettings.BuildTarget != BuildTarget.WP8Player)
		{
		}
	}

	private IEnumerator RestoreProgressIndicator(float delayTime)
	{
		yield return new WaitForSeconds(delayTime);
		StoreKitEventListener.purchaseInProcess = false;
	}

	private bool ShopIsActive()
	{
		return false;
	}
}
