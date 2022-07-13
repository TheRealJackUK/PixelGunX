using UnityEngine;

internal sealed class DeveloperConsoleView : MonoBehaviour
{
	public UIInput gemsInput;

	public UIToggle set60FpsCheckbox;

	public UIToggle mouseCOntrollCheckbox;

	public UIToggle spectatorModeCheckbox;

	public UIToggle tempGunCheckbox;

	public UILabel levelLabel;

	public UILabel experienceLabel;

	public UISlider experienceSlider;

	public UILabel fovLabel;

	public UISlider fovSlider;

	public UIInput coinsInput;

	public UIInput enemyCountInSurvivalWave;

	public UIInput enemiesInCampaignInput;

	public UIToggle trainingCheckbox;

	public UIToggle downgradeResolutionCheckbox;

	public UIToggle isPayingCheckbox;

	public UIToggle isDebugGuiVisibleCheckbox;

	public UIToggle isEventX3ForcedCheckbox;

	public UIToggle adIdCheckbox;

	public UIInput marathonCurrentDay;

	public UIToggle marathonTestMode;

	public UIToggle gameGUIOffMode;

	public UILabel deviceInfo;

	public UIInput devicePushTokenInput;

	public UIInput playerIdInput;

	public UILabel starterPackLive;

	public UILabel starterPackCooldown;

	public UILabel socialUsername;

	public UIInput oneDayPreminAccount;

	public UIInput threeDayPreminAccount;

	public UIInput sevenDayPreminAccount;

	public UIInput monthDayPreminAccount;

	public string LevelLabel
	{
		set
		{
			if (!(levelLabel == null))
			{
				levelLabel.text = value;
			}
		}
	}

	public string ExperienceLabel
	{
		set
		{
			if (!(experienceLabel == null))
			{
				experienceLabel.text = value;
			}
		}
	}

		public string FovLabel
	{
		set
		{
			if (!(fovLabel == null))
			{
				fovLabel.text = value;
			}
		}
	}

	public float ExperiencePercentage
	{
		get
		{
			return (!(experienceSlider != null)) ? 0f : experienceSlider.value;
		}
		set
		{
			if (!(experienceSlider == null))
			{
				experienceSlider.value = Mathf.Clamp01(value);
			}
		}
	}

		public float FOVPercentage
	{
		get
		{
			return (!(fovSlider != null)) ? 0f : fovSlider.value;
		}
		set
		{
			if (!(fovSlider == null))
			{
				fovSlider.value = Mathf.Clamp01(value);
			}
		}
	}

	public int CoinsInput
	{
		set
		{
			if (coinsInput != null)
			{
				coinsInput.value = value.ToString();
			}
		}
	}

	public int GemsInput
	{
		set
		{
			if (gemsInput != null)
			{
				gemsInput.value = value.ToString();
			}
		}
	}

	public int EnemiesInSurvivalWaveInput
	{
		set
		{
			if (enemyCountInSurvivalWave != null)
			{
				enemyCountInSurvivalWave.value = value.ToString();
			}
		}
	}

	public int EnemiesInCampaignInput
	{
		set
		{
			if (enemiesInCampaignInput != null)
			{
				enemiesInCampaignInput.value = value.ToString();
			}
		}
	}

	public bool TrainingCompleted
	{
		set
		{
			if (trainingCheckbox != null)
			{
				trainingCheckbox.value = value;
			}
		}
	}

	public bool TempGunActive
	{
		set
		{
			if (tempGunCheckbox != null)
			{
				tempGunCheckbox.value = value;
			}
		}
	}

	public bool Set60FPSActive
	{
		set
		{
			if (set60FpsCheckbox != null)
			{
				set60FpsCheckbox.value = value;
			}
		}
	}

	public bool SetMouseControll
	{
		set
		{
			if (mouseCOntrollCheckbox != null)
			{
				mouseCOntrollCheckbox.value = value;
			}
		}
	}

	public bool SetSpectatorMode
	{
		set
		{
			if (spectatorModeCheckbox != null)
			{
				spectatorModeCheckbox.value = value;
			}
		}
	}

	public bool IsPayingUser
	{
		set
		{
			if (isPayingCheckbox != null)
			{
				isPayingCheckbox.value = value;
			}
		}
	}

	public int MarathonDayInput
	{
		set
		{
			if (marathonCurrentDay != null)
			{
				marathonCurrentDay.value = value.ToString();
			}
		}
	}

	public bool MarathonTestMode
	{
		set
		{
			if (marathonTestMode != null)
			{
				marathonTestMode.value = value;
			}
		}
	}

	public bool GameGUIOffMode
	{
		set
		{
			if (gameGUIOffMode != null)
			{
				gameGUIOffMode.value = value;
			}
		}
	}

	public string DevicePushTokenInput
	{
		set
		{
			if (devicePushTokenInput != null)
			{
				devicePushTokenInput.value = value;
			}
		}
	}

	public string PlayerIdInput
	{
		set
		{
			if (playerIdInput != null)
			{
				playerIdInput.value = value;
			}
		}
	}

	public string SocialUserName
	{
		set
		{
			if (socialUsername != null)
			{
				socialUsername.text = value;
			}
		}
	}
}