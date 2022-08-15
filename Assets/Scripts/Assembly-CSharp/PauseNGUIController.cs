using System;
using Rilisoft;
using UnityEngine;

public class PauseNGUIController : ControlsSettingsBase
{
	public SettingsToggleButtons switchingWeaponsToggleButtons;

	public SettingsToggleButtons chatToggleButtons;

	public SettingsToggleButtons musicToggleButtons;

	public SettingsToggleButtons soundToggleButtons;

	public SettingsToggleButtons invertCameraToggleButtons;

	public SettingsToggleButtons recToggleButtons;

	public SettingsToggleButtons leftHandedToggleButtons;

	public UIButton controlsButton;

	public GameObject tapPanelInSettings;

	public GameObject swipePanelInSettings;

	public UISlider sensitivitySlider;

	public UIButton resumeButton;

	public UIButton quitButton;

	public UIButton shopButton;

	private float _cachedSensitivity;

	private bool _shopOpened;

	private float _lastBackFromShopTime;

	public static event Action InvertCamUpdated;

	public static event Action ChatSettUpdated;

	public static event Action PlayerHandUpdated;

	public static event Action SwitchingWeaponsUpdated;

	public static bool RecButtonsAvailable()
	{
		return (!VideoRecordingView.IsWeakDevice && Everyplay.IsRecordingSupported()) || Application.isEditor;
	}

	private void ResumeGame()
	{
		Debug.Log((InGameGUI.sharedInGameGUI != null) + " " + (InGameGUI.sharedInGameGUI.playerMoveC != null));
		if (InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.playerMoveC != null)
		{
			InGameGUI.sharedInGameGUI.playerMoveC.SetPause(true);
		}
		else
		{
			base.gameObject.SetActive(false);
		}
	}

	private new void Start()
	{
		base.Start();
		if (Defs.IsTraining)
		{
			shopButton.gameObject.SetActive(false);
		}
		resumeButton.GetComponent<ButtonHandler>().Clicked += delegate
		{
			if (!InPauseShop())
			{
				ButtonClickSound.Instance.PlayClick();
				ResumeGame();
				ExperienceController.sharedController.isShowRanks = false;
				ExpController.Instance.InterfaceEnabled = false;
			}
		};
		quitButton.GetComponent<ButtonHandler>().Clicked += delegate
		{
			if (!InPauseShop() && !(Time.realtimeSinceStartup < _lastBackFromShopTime + 0.5f))
			{
				ButtonClickSound.Instance.PlayClick();
				if (InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.playerMoveC != null)
				{
					InGameGUI.sharedInGameGUI.playerMoveC.QuitGame();
				}
				else if (PhotonNetwork.room != null)
				{
					coinsShop.hideCoinsShop();
					coinsPlashka.hidePlashka();
					Defs.typeDisconnectGame = Defs.DisconectGameType.Exit;
					PhotonNetwork.LeaveRoom();
				}
			}
		};
		shopButton.GetComponent<ButtonHandler>().Clicked += delegate
		{
			if (!InPauseShop())
			{
				ButtonClickSound.Instance.PlayClick();
				ExperienceController.sharedController.isShowRanks = false;
				if (InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.playerMoveC != null)
				{
					InGameGUI.sharedInGameGUI.playerMoveC.GoToShopFromPause();
				}
			}
		};
		musicToggleButtons.IsChecked = Defs.isSoundMusic;
		musicToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			bool isSoundMusic = Defs.isSoundMusic;
			Defs.isSoundMusic = e.IsChecked;
			PlayerPrefsX.SetBool(PlayerPrefsX.SoundMusicSetting, Defs.isSoundMusic);
			PlayerPrefs.Save();
			if (isSoundMusic != Defs.isSoundMusic && isSoundMusic != Defs.isSoundMusic)
			{
				if (Defs.isSoundMusic)
				{
					GameObject gameObject = GameObject.FindGameObjectWithTag("BackgroundMusic");
					if (MenuBackgroundMusic.sharedMusic != null && gameObject != null)
					{
						AudioSource audioSource = gameObject.GetComponent<AudioSource>();
						if (audioSource != null)
						{
							MenuBackgroundMusic.sharedMusic.PlayMusic(audioSource);
						}
					}
				}
				else
				{
					GameObject gameObject2 = GameObject.FindGameObjectWithTag("BackgroundMusic");
					if (MenuBackgroundMusic.sharedMusic != null && gameObject2 != null)
					{
						AudioSource audioSource2 = gameObject2.GetComponent<AudioSource>();
						if (audioSource2 != null)
						{
							MenuBackgroundMusic.sharedMusic.StopMusic(audioSource2);
						}
					}
				}
			}
		};
		soundToggleButtons.IsChecked = Defs.isSoundFX;
		soundToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			Defs.isSoundFX = e.IsChecked;
			PlayerPrefsX.SetBool(PlayerPrefsX.SoundFXSetting, Defs.isSoundFX);
			PlayerPrefs.Save();
		};
		chatToggleButtons.IsChecked = Defs.IsChatOn;
		chatToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			SettingsController.SwitchChatSetting(e.IsChecked, delegate
			{
				Action chatSettUpdated = PauseNGUIController.ChatSettUpdated;
				if (chatSettUpdated != null)
				{
					chatSettUpdated();
				}
			});
		};
		invertCameraToggleButtons.IsChecked = PlayerPrefs.GetInt(Defs.InvertCamSN, 0) == 1;
		invertCameraToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			if (Application.isEditor)
			{
				Debug.Log("[Invert Camera] button clicked: " + e.IsChecked);
			}
			bool flag = PlayerPrefs.GetInt(Defs.InvertCamSN, 0) == 1;
			if (flag != e.IsChecked)
			{
				PlayerPrefs.SetInt(Defs.InvertCamSN, Convert.ToInt32(e.IsChecked));
				PlayerPrefs.Save();
				Action invertCamUpdated = PauseNGUIController.InvertCamUpdated;
				if (invertCamUpdated != null)
				{
					invertCamUpdated();
				}
			}
		};
		recToggleButtons.gameObject.SetActive(RecButtonsAvailable());
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
		if (leftHandedToggleButtons != null)
		{
			leftHandedToggleButtons.IsChecked = GlobalGameController.LeftHanded;
			leftHandedToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
			{
				SettingsController.ChangeLeftHandedRightHanded(e.IsChecked, delegate
				{
					Action playerHandUpdated = PauseNGUIController.PlayerHandUpdated;
					if (playerHandUpdated != null)
					{
						playerHandUpdated();
					}
				});
			};
		}
		switchingWeaponsToggleButtons.IsChecked = !GlobalGameController.switchingWeaponSwipe;
		switchingWeaponsToggleButtons.Clicked += delegate(object sender, ToggleButtonEventArgs e)
		{
			SettingsController.ChangeSwitchingWeaponHanded(e.IsChecked, delegate
			{
				Action switchingWeaponsUpdated = PauseNGUIController.SwitchingWeaponsUpdated;
				if (switchingWeaponsUpdated != null)
				{
					switchingWeaponsUpdated();
				}
			});
		};
		if (!(controlsButton != null))
		{
			return;
		}
		controlsButton.GetComponent<ButtonHandler>().Clicked += delegate
		{
			if (!InPauseShop())
			{
				ButtonClickSound.Instance.PlayClick();
				settingsPanel.SetActive(false);
				SettingsJoysticksPanel.SetActive(true);
				swipePanelInSettings.SetActive(GlobalGameController.switchingWeaponSwipe);
				tapPanelInSettings.SetActive(!GlobalGameController.switchingWeaponSwipe);
				ExperienceController.sharedController.isShowRanks = false;
				ExpController.Instance.InterfaceEnabled = false;
				HandleControlsClicked();
			}
		};
	}

	private bool InPauseShop()
	{
		return InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.playerMoveC != null && InGameGUI.sharedInGameGUI.playerMoveC.isInappWinOpen;
	}

	private void Update()
	{
		if (_isCancellationRequested)
		{
			if (SettingsJoysticksPanel.activeInHierarchy)
			{
				ExperienceController.sharedController.isShowRanks = true;
				ExpController.Instance.InterfaceEnabled = true;
			}
			else if (!InPauseShop())
			{
				ExperienceController.sharedController.isShowRanks = false;
				_isCancellationRequested = false;
				return;
			}
			_isCancellationRequested = false;
		}
		if (Input.GetKeyUp(KeyCode.Escape) && !InPauseShop())
		{
			Input.ResetInputAxes();
			_isCancellationRequested = true;
			return;
		}
		float num = sensitivitySlider.value * 13f;
		float num2 = Mathf.Clamp(num + 10f, 10f, 30f);
		if (_cachedSensitivity != num2)
		{
			if (Application.isEditor)
			{
				Debug.Log("New sensitivity: " + num2);
			}
			Defs.Sensitivity = num2;
			_cachedSensitivity = num2;
		}
		if (!InPauseShop())
		{
			if (_shopOpened)
			{
				_lastBackFromShopTime = Time.realtimeSinceStartup;
			}
			_shopOpened = false;
		}
		else
		{
			_shopOpened = true;
			_lastBackFromShopTime = float.PositiveInfinity;
		}
	}

	private void ShowInvisibilityInterface(bool enable)
	{
		InGameGUI sharedInGameGUI = InGameGUI.sharedInGameGUI;
		if (sharedInGameGUI != null && !sharedInGameGUI.enableInvisibilityInterface)
		{
			float alpha = ((!enable) ? 0.01f : 1f);
			sharedInGameGUI.interfacePanel.GetComponent<UIPanel>().alpha = alpha;
		}
	}

	private new void OnEnable()
	{
		base.OnEnable();
		if (!InPauseShop())
		{
			ExperienceController.sharedController.isShowRanks = true;
			ExperienceController.sharedController.posRanks = NetworkStartTable.ExperiencePosRanks;
		}
		ShowInvisibilityInterface(true);
	}

	private void OnDisable()
	{
		if (!InPauseShop())
		{
			ExperienceController.sharedController.isShowRanks = false;
		}
		ShowInvisibilityInterface(false);
	}

	protected override void HandleSavePosJoystikClicked(object sender, EventArgs e)
	{
		base.HandleSavePosJoystikClicked(sender, e);
		ExperienceController.sharedController.isShowRanks = true;
		ExpController.Instance.InterfaceEnabled = true;
	}

	protected override void HandleCancelPosJoystikClicked(object sender, EventArgs e)
	{
		SettingsJoysticksPanel.SetActive(false);
		settingsPanel.SetActive(true);
		ExperienceController.sharedController.isShowRanks = true;
		ExpController.Instance.InterfaceEnabled = true;
	}
}
