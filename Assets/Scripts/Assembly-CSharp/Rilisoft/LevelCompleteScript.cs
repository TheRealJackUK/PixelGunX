using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Prime31;
using UnityEngine;

namespace Rilisoft
{
	public sealed class LevelCompleteScript : MonoBehaviour
	{
		public GameObject premium;

		public UILabel award1LAbel;

		public UILabel award15label;

		public UILabel[] afterLevelAwardLabels;

		public Transform RentWindowPoint;

		public UILabel[] awardBoxLabels;

		public GameObject mainPanel;

		public GameObject loadingPanel;

		public GameObject quitButton;

		public GameObject menuButton;

		public GameObject retryButton;

		public GameObject nextButton;

		public GameObject shopButton;

		public GameObject brightStarPrototypeSprite;

		public GameObject darkStarPrototypeSprite;

		public GameObject award1coinSprite;

		public GameObject checkboxSpritePrototype;

		public AudioClip[] coinClips;

		public AudioClip[] starClips;

		public AudioClip shopButtonSound;

		public AudioClip awardClip;

		public GameObject survivalResults;

		public GameObject facebookButton;

		public GameObject twitterButton;

		public GameObject backgroundTexture;

		public GameObject backgroundSurvivalTexture;

		public GameObject[] statisticLabels;

		private bool showMessagTiwtter;

		public GameObject gameOverSprite;

		public UICamera uiCamera;

		private static LevelCompleteScript _instance;

		private bool _awardConferred;

		private AudioSource _awardAudioSource;

		private ExperienceController _experienceController;

		private int _oldStarCount;

		private int _starCount;

		private ShopNGUIController _shopInstance;

		private string _nextSceneName = string.Empty;

		private bool _isLastLevel;

		private int? _boxCompletionExperienceAward;

		private bool completedFirstTime;

		private bool _gameOver;

		private bool FacebookButtonSupported
		{
			get
			{
				return BuildSettings.BuildTarget != BuildTarget.WP8Player;
			}
		}

		private void Start()
		{
			Screen.lockCursor = false;
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				twitterButton.transform.localPosition = new Vector3(-10000f, 0f, 0f);
			}
			if (Defs.IsSurvival)
			{
				backgroundSurvivalTexture.SetActive(true);
			}
			else
			{
				backgroundTexture.SetActive(true);
			}
			if (StoreKitEventListener.purchaseActivityInd != null)
			{
				StoreKitEventListener.purchaseActivityInd.SetActive(false);
			}
			if (PlayerPrefs.GetInt("IsGameOver", 0) == 1)
			{
				_gameOver = true;
				PlayerPrefs.SetInt("IsGameOver", 0);
			}
			if (!_gameOver && !Defs.IsSurvival)
			{
				StoreKitEventListener.State.PurchaseKey = "Level Completed";
				StoreKitEventListener.State.Parameters["Level"] = CurrentCampaignGame.levelSceneName + " Level Completed";
			}
			else if (_gameOver && !Defs.IsSurvival)
			{
				StoreKitEventListener.State.PurchaseKey = "Level Failed";
				StoreKitEventListener.State.Parameters["Level"] = CurrentCampaignGame.levelSceneName + " Level Failed";
			}
			else if (!_gameOver && Defs.IsSurvival)
			{
				StoreKitEventListener.State.PurchaseKey = "Player quit";
				StoreKitEventListener.State.Parameters["Waves"] = StoreKitEventListener.State.Parameters["Waves"].Substring(0, StoreKitEventListener.State.Parameters["Waves"].IndexOf(" In game")) + " Player quit";
			}
			else if (_gameOver && Defs.IsSurvival)
			{
				StoreKitEventListener.State.PurchaseKey = "Game over";
				StoreKitEventListener.State.Parameters["Waves"] = StoreKitEventListener.State.Parameters["Waves"].Substring(0, StoreKitEventListener.State.Parameters["Waves"].IndexOf(" In game")) + " Game over";
			}
			facebookButton.SetActive(FacebookButtonSupported);
			_experienceController = InitializeExperienceController();
			BindButtonHandler(menuButton, HandleMenuButton);
			BindButtonHandler(retryButton, HandleRetryButton);
			BindButtonHandler(nextButton, HandleNextButton);
			BindButtonHandler(shopButton, HandleShopButton);
			BindButtonHandler(quitButton, HandleQuitButton);
			BindButtonHandler(facebookButton, HandleFacebookButton);
			BindButtonHandler(twitterButton, HandleTwitterButton);
			if (!Defs.IsSurvival)
			{
				int num = -1;
				LevelBox levelBox = null;
				foreach (LevelBox campaignBox in LevelBox.campaignBoxes)
				{
					if (!campaignBox.name.Equals(CurrentCampaignGame.boXName))
					{
						continue;
					}
					levelBox = campaignBox;
					for (int i = 0; i != campaignBox.levels.Count; i++)
					{
						CampaignLevel campaignLevel = campaignBox.levels[i];
						if (campaignLevel.sceneName.Equals(CurrentCampaignGame.levelSceneName))
						{
							num = i;
							break;
						}
					}
					break;
				}
				if (levelBox != null)
				{
					_isLastLevel = num >= levelBox.levels.Count - 1;
					_nextSceneName = levelBox.levels[(!_isLastLevel) ? (num + 1) : num].sceneName;
				}
				else
				{
					Debug.LogError("Current box not found in the list of boxes!");
					_isLastLevel = true;
					_nextSceneName = Application.loadedLevelName;
				}
				_oldStarCount = 0;
				_starCount = InitializeStarCount();
				if (!_gameOver)
				{
					Dictionary<string, int> dictionary = CampaignProgress.boxesLevelsAndStars[CurrentCampaignGame.boXName];
					if (!dictionary.ContainsKey(CurrentCampaignGame.levelSceneName))
					{
						completedFirstTime = true;
						if (_isLastLevel)
						{
							_boxCompletionExperienceAward = levelBox.CompletionExperienceAward;
						}
						dictionary.Add(CurrentCampaignGame.levelSceneName, _starCount);
						CampaignProgress.SaveCampaignProgress();
						FlurryPluginWrapper.LogEventWithParameterAndValue("LevelReached", "Level_Name", CurrentCampaignGame.levelSceneName);
					}
					else
					{
						_oldStarCount = dictionary[CurrentCampaignGame.levelSceneName];
						dictionary[CurrentCampaignGame.levelSceneName] = Math.Max(_oldStarCount, _starCount);
						CampaignProgress.SaveCampaignProgress();
					}
					FlurryPluginWrapper.LogEventWithParameterAndValue("Campaign Progress", "Level Completed", CurrentCampaignGame.levelSceneName);
					CampaignProgress.OpenNewBoxIfPossible();
					CampaignProgress.SaveCampaignProgress();
				}
				_awardConferred = InitializeAwardConferred();
			}
			survivalResults.SetActive(false);
			quitButton.SetActive(false);
			if (!_gameOver)
			{
				bool flag = PremiumAccountController.Instance != null && PremiumAccountController.Instance.isAccountActive;
				premium.SetActive(flag);
				if (flag)
				{
					award1LAbel.transform.localPosition = new Vector3(award1LAbel.transform.localPosition.x, award1LAbel.transform.localPosition.y + 30f, award1LAbel.transform.localPosition.z);
					award15label.transform.localPosition = new Vector3(award15label.transform.localPosition.x, award15label.transform.localPosition.y + 30f, award15label.transform.localPosition.z);
				}
				award1coinSprite.SetActive(true);
				UILabel[] array = afterLevelAwardLabels;
				foreach (UILabel uILabel in array)
				{
					uILabel.gameObject.SetActive(!_awardConferred && _starCount > _oldStarCount && _starCount <= InitializeCoinIndexBound());
				}
				award15label.gameObject.SetActive(_awardConferred);
				if (_awardConferred)
				{
					UILabel[] array2 = awardBoxLabels;
					foreach (UILabel uILabel2 in array2)
					{
						uILabel2.text = string.Format(uILabel2.text, GemsToAddForBox());
					}
				}
				GameObject[] array3 = statisticLabels;
				foreach (GameObject gameObject in array3)
				{
					gameObject.SetActive(Defs.IsSurvival);
				}
				if (Defs.IsSurvival)
				{
					FlurryPluginWrapper.LogEventWithParameterAndValue("Survival Finished", "Quit", PlayerPrefs.GetInt(Defs.WavesSurvivedS, 0).ToString());
				}
				if (brightStarPrototypeSprite != null && darkStarPrototypeSprite != null)
				{
					StartCoroutine(DisplayLevelResult());
				}
				if (_starCount > _oldStarCount)
				{
					CoinsMessage.FireCoinsAddedEvent(false);
				}
			}
			else
			{
				award1coinSprite.SetActive(false);
				nextButton.SetActive(false);
				checkboxSpritePrototype.SetActive(false);
				if (!Defs.IsSurvival && gameOverSprite != null)
				{
					gameOverSprite.SetActive(true);
				}
				if (Defs.IsSurvival)
				{
					StartCoroutine(DisplaySurvivalResult());
					FlurryPluginWrapper.LogEventWithParameterAndValue("Survival Finished", "Game Over", PlayerPrefs.GetInt(Defs.WavesSurvivedS, 0).ToString());
				}
				GameObject[] array4 = statisticLabels;
				foreach (GameObject gameObject2 in array4)
				{
					gameObject2.SetActive(Defs.IsSurvival);
				}
				if (!Defs.IsSurvival)
				{
					float x = (retryButton.transform.position.x - menuButton.transform.position.x) / 2f;
					Vector3 vector = new Vector3(x, 0f, 0f);
					menuButton.transform.position = retryButton.transform.position - vector;
					retryButton.transform.position += vector;
					FlurryPluginWrapper.LogEventWithParameterAndValue("Campaign Progress", "Game Over", CurrentCampaignGame.levelSceneName);
				}
				menuButton.SetActive(!Defs.IsSurvival);
				if (!Defs.IsSurvival)
				{
					StartCoroutine(TryToShowExpiredBanner());
				}
			}
			if (Defs.IsSurvival)
			{
				WeaponManager sharedManager = WeaponManager.sharedManager;
				sharedManager.Reset(0);
			}
			_instance = this;
		}

		private void OnDestroy()
		{
			_instance = null;
			if (_experienceController != null)
			{
				_experienceController.isShowRanks = false;
			}
			PlayerPrefs.Save();
		}

		private void Update()
		{
			if (_experienceController != null && BankController.Instance != null && !BankController.Instance.InterfaceEnabled && !ShopNGUIController.GuiActive)
			{
				_experienceController.isShowRanks = RentWindowPoint.childCount == 0 && !loadingPanel.activeSelf;
			}
		}

		private void LateUpdate()
		{
			if (Input.GetKeyUp(KeyCode.Escape))
			{
				Input.ResetInputAxes();
				HandleQuitButton(this, EventArgs.Empty);
			}
		}

		private static void BindButtonHandler(GameObject button, EventHandler handler)
		{
			if (button != null)
			{
				ButtonHandler component = button.GetComponent<ButtonHandler>();
				if (component != null)
				{
					component.Clicked += handler;
				}
			}
		}

		private static int CalculateExperienceAward(int score)
		{
			int num = ((!Application.isEditor) ? 1 : 100);
			if (score < 15000 / num)
			{
				return 0;
			}
			if (score < 50000 / num)
			{
				return 10;
			}
			if (score < 100000 / num)
			{
				return 35;
			}
			if (score < 150000 / num)
			{
				return 50;
			}
			return 75;
		}

		private IEnumerator DisplaySurvivalResult()
		{
			menuButton.SetActive(false);
			retryButton.SetActive(false);
			nextButton.SetActive(false);
			shopButton.SetActive(false);
			quitButton.SetActive(false);
			facebookButton.SetActive(false);
			twitterButton.SetActive(false);
			survivalResults.SetActive(true);
			int experienceAward = CalculateExperienceAward(GlobalGameController.Score);
			if (experienceAward > 0)
			{
				_experienceController.addExperience(experienceAward * ((!(PremiumAccountController.Instance != null)) ? 1 : PremiumAccountController.Instance.RewardCoeff));
				yield return null;
			}
			while (ExpController.Instance != null && ExpController.Instance.InAddingState)
			{
				yield return null;
			}
			retryButton.SetActive(true);
			shopButton.SetActive(true);
			quitButton.SetActive(true);
			facebookButton.SetActive(FacebookButtonSupported);
			twitterButton.SetActive(true);
			StartCoroutine(TryToShowExpiredBanner());
		}

		private static int InitializeCoinIndexBound()
		{
			int diffGame = Defs.diffGame;
			return diffGame + 1;
		}

		private int GemsToAddForBox()
		{
			bool flag = CurrentCampaignGame.levelSceneName.Equals("School");
			bool flag2 = CurrentCampaignGame.levelSceneName.StartsWith("Gluk");
			bool flag3 = CurrentCampaignGame.levelSceneName.Equals("Code_campaign3");
			int result = 0;
			if (flag)
			{
				result = LevelBox.campaignBoxes[0].gems;
			}
			else if (flag2)
			{
				result = LevelBox.campaignBoxes[1].gems;
			}
			else if (flag3)
			{
				result = LevelBox.campaignBoxes[2].gems;
			}
			return result;
		}

		private int CoinsToAddForBox()
		{
			bool flag = CurrentCampaignGame.levelSceneName.Equals("School");
			bool flag2 = CurrentCampaignGame.levelSceneName.StartsWith("Gluk");
			bool flag3 = CurrentCampaignGame.levelSceneName.Equals("Code_campaign3");
			int result = 0;
			if (flag)
			{
				result = LevelBox.campaignBoxes[0].coins;
			}
			else if (flag2)
			{
				result = LevelBox.campaignBoxes[1].coins;
			}
			else if (flag3)
			{
				result = LevelBox.campaignBoxes[2].coins;
			}
			return result;
		}

		private IEnumerator DisplayLevelResult()
		{
			menuButton.SetActive(false);
			retryButton.SetActive(false);
			nextButton.SetActive(false);
			shopButton.SetActive(false);
			facebookButton.SetActive(false);
			twitterButton.SetActive(false);
			int coinIndexBound = InitializeCoinIndexBound();
			List<GameObject> stars = new List<GameObject>(3);
			for (int i = 0; i != 3; i++)
			{
				float x = -140f + (float)i * 140f;
				GameObject star = UnityEngine.Object.Instantiate(darkStarPrototypeSprite) as GameObject;
				star.transform.parent = darkStarPrototypeSprite.transform.parent;
				star.transform.localPosition = new Vector3(x, darkStarPrototypeSprite.transform.localPosition.y, 0f);
				star.transform.localScale = darkStarPrototypeSprite.transform.localScale;
				star.SetActive(true);
				stars.Add(star);
			}
			int currentStarIndex = 0;
			int gainedSomeCoinsCount = 0;
			for (int checkboxIndex = 0; checkboxIndex < 3; checkboxIndex++)
			{
				if ((checkboxIndex == 1 && !CurrentCampaignGame.completeInTime) || (checkboxIndex == 2 && !CurrentCampaignGame.withoutHits))
				{
					continue;
				}
				yield return new WaitForSeconds(0.4f);
				GameObject star2 = UnityEngine.Object.Instantiate(brightStarPrototypeSprite) as GameObject;
				star2.transform.parent = brightStarPrototypeSprite.transform.parent;
				star2.transform.localPosition = stars[currentStarIndex].transform.localPosition;
				star2.transform.localScale = stars[currentStarIndex].transform.localScale;
				star2.SetActive(true);
				UnityEngine.Object.Destroy(stars[currentStarIndex]);
				GameObject checkbox = UnityEngine.Object.Instantiate(checkboxSpritePrototype) as GameObject;
				checkbox.transform.parent = checkboxSpritePrototype.transform.parent;
				checkbox.transform.localPosition = new Vector3(checkboxSpritePrototype.transform.localPosition.x, checkboxSpritePrototype.transform.localPosition.y - 50f * (float)checkboxIndex, checkboxSpritePrototype.transform.localPosition.z);
				checkbox.transform.localScale = checkboxSpritePrototype.transform.localScale;
				checkbox.SetActive(true);
				if (starClips != null && currentStarIndex < starClips.Length && starClips[currentStarIndex] != null && Defs.isSoundFX)
				{
					NGUITools.PlaySound(starClips[currentStarIndex]);
				}
				yield return new WaitForSeconds(0.3f);
				bool newResultIsBetterThanPrevious = _starCount > _oldStarCount;
				if (currentStarIndex < coinIndexBound && newResultIsBetterThanPrevious)
				{
					int oldCoinCount = Storager.getInt("Coins", false);
					Storager.setInt("Coins", oldCoinCount + 1 * ((!(PremiumAccountController.Instance != null)) ? 1 : PremiumAccountController.Instance.RewardCoeff), false);
					gainedSomeCoinsCount++;
					if (coinClips != null && currentStarIndex < coinClips.Length && coinClips[currentStarIndex] != null && Defs.isSoundFX)
					{
						NGUITools.PlaySound(coinClips[currentStarIndex]);
					}
					FlurryPluginWrapper.LogCoinEarned();
				}
				currentStarIndex++;
			}
			if (gainedSomeCoinsCount > 0)
			{
				FlurryEvents.LogCoinsGained("Campaign", gainedSomeCoinsCount);
			}
			int gainedStarCount = currentStarIndex;
			if (_awardConferred)
			{
				yield return new WaitForSeconds(0.4f);
				int addGemsCount = GemsToAddForBox();
				int oldGemsCount = Storager.getInt("GemsCurrency", false);
				Storager.setInt("GemsCurrency", oldGemsCount + addGemsCount, false);
				FlurryEvents.LogGemsGained("Campaign", addGemsCount);
				int addCoinCount = CoinsToAddForBox();
				int oldCoinCount2 = Storager.getInt("Coins", false);
				Storager.setInt("Coins", oldCoinCount2 + addCoinCount, false);
				if (awardClip != null && Defs.isSoundFX)
				{
					_awardAudioSource = NGUITools.PlaySound(awardClip);
				}
				FlurryEvents.LogCoinsGained("Campaign", addCoinCount);
				string achievementId = string.Empty;
				string achievementName = string.Empty;
				bool box1Completed = CurrentCampaignGame.levelSceneName.Equals("School");
				bool box2Completed = CurrentCampaignGame.levelSceneName.StartsWith("Gluk");
				if (box1Completed)
				{
					achievementId = ((BuildSettings.BuildTarget != BuildTarget.iPhone) ? "CgkIr8rGkPIJEAIQCA" : "block_world_id");
					if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
					{
						achievementId = "Block_Survivor_id";
					}
					achievementName = "Block World Survivor";
				}
				else if (box2Completed)
				{
					achievementId = "CgkIr8rGkPIJEAIQCQ";
					achievementName = "Dragon Slayer";
				}
				if (string.IsNullOrEmpty(achievementId))
				{
					Debug.LogWarning("Achievement Box Completed: id is null. Scene: " + CurrentCampaignGame.levelSceneName);
				}
				else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					AGSAchievementsClient.UpdateAchievementProgress(achievementId, 100f);
					Debug.Log(string.Format("Achievement {0} completed.", achievementName));
				}
				else
				{
					Social.ReportProgress(achievementId, 100.0, delegate(bool success)
					{
						Debug.Log(string.Format("Achievement {0} completed: {1}", achievementName, success));
					});
				}
			}
			UnityEngine.Object.Destroy(brightStarPrototypeSprite);
			UnityEngine.Object.Destroy(darkStarPrototypeSprite);
			if (_experienceController != null)
			{
				if (_awardConferred && awardClip != null)
				{
					yield return new WaitForSeconds(awardClip.length);
				}
				yield return new WaitForSeconds(1f);
				int experience = 0;
				if (gainedStarCount == 3)
				{
					experience += 5;
				}
				if (_boxCompletionExperienceAward.HasValue)
				{
					experience += _boxCompletionExperienceAward.Value;
				}
				if (experience != 0)
				{
					_experienceController.addExperience(experience * ((!(PremiumAccountController.Instance != null)) ? 1 : PremiumAccountController.Instance.RewardCoeff));
				}
				while (ExpController.Instance != null && ExpController.Instance.InAddingState)
				{
					yield return null;
				}
			}
			menuButton.SetActive(true);
			retryButton.SetActive(true);
			nextButton.SetActive(true);
			shopButton.SetActive(true);
			facebookButton.SetActive(FacebookButtonSupported);
			twitterButton.SetActive(true);
			if (_awardConferred)
			{
				yield return null;
				CoinsMessage.FireCoinsAddedEvent(false);
				CoinsMessage.FireCoinsAddedEvent(true);
			}
			StartCoroutine(TryToShowExpiredBanner());
		}

		private IEnumerator TryToShowExpiredBanner()
		{
			while (FriendsController.sharedController == null || TempItemsController.sharedController == null)
			{
				yield return null;
			}
			while (true)
			{
				yield return StartCoroutine(FriendsController.sharedController.MyWaitForSeconds(1f));
				try
				{
					if (!ShopNGUIController.GuiActive && (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled) && (!(ExpController.Instance != null) || !ExpController.Instance.WaitingForLevelUpView) && (!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !loadingPanel.activeInHierarchy && RentWindowPoint.childCount == 0 && (Storager.getInt(Defs.PremiumEnabledFromServer, false) != 1 || !ShopNGUIController.ShowPremimAccountExpiredIfPossible(RentWindowPoint, "Default", string.Empty)))
					{
						ShopNGUIController.ShowTempItemExpiredIfPossible(RentWindowPoint, "Default");
					}
				}
				catch (Exception e)
				{
					Debug.LogWarning("exception in LevelComplete  TryToShowExpiredBanner: " + e);
				}
			}
		}

		private void HandleMenuButton(object sender, EventArgs args)
		{
			if (!(_shopInstance != null))
			{
				if (Defs.IsSurvival)
				{
					FlurryPluginWrapper.LogEvent("Back to Main Menu");
				}
				Application.LoadLevel((!Defs.IsSurvival) ? "ChooseLevel" : Defs.MainMenuScene);
			}
		}

		private void HandleQuitButton(object sender, EventArgs args)
		{
			ActivityIndicator.sharedActivityIndicator.SetActive(true);
			loadingPanel.SetActive(true);
			mainPanel.SetActive(false);
			ExperienceController.sharedController.isShowRanks = false;
			Invoke("QuitLevel", 0.1f);
		}

		[Obfuscation(Exclude = true)]
		private void QuitLevel()
		{
			FlurryPluginWrapper.LogEvent("Back to Main Menu");
			Application.LoadLevelAsync(Defs.MainMenuScene);
		}

		private static void SetInitialAmmoForAllGuns()
		{
			foreach (Weapon allAvailablePlayerWeapon in WeaponManager.sharedManager.allAvailablePlayerWeapons)
			{
				WeaponSounds component = allAvailablePlayerWeapon.weaponPrefab.GetComponent<WeaponSounds>();
				if (allAvailablePlayerWeapon.currentAmmoInClip + allAvailablePlayerWeapon.currentAmmoInBackpack < component.InitialAmmoWithEffectsApplied + component.ammoInClip)
				{
					allAvailablePlayerWeapon.currentAmmoInClip = component.ammoInClip;
					allAvailablePlayerWeapon.currentAmmoInBackpack = component.InitialAmmoWithEffectsApplied;
				}
			}
		}

		private void HandleRetryButton(object sender, EventArgs args)
		{
			if (!(_shopInstance != null))
			{
				if (!Defs.IsSurvival)
				{
					SetInitialAmmoForAllGuns();
				}
				else
				{
					WeaponManager.sharedManager.Reset(0);
				}
				GlobalGameController.Score = 0;
				if (Defs.IsSurvival)
				{
					Defs.CurrentSurvMapIndex = UnityEngine.Random.Range(0, Defs.SurvivalMaps.Length);
				}
				Application.LoadLevel("CampaignLoading");
			}
		}

		private void HandleFacebookButton(object sender, EventArgs args)
		{
			if (!(_shopInstance != null))
			{
				_SocialMessage();
				FlurryPluginWrapper.LogFacebook();
				FacebookController.ShowPostDialog();
			}
		}

		private void HandleTwitterButton(object sender, EventArgs args)
		{
			if (!(_shopInstance != null))
			{
				FlurryPluginWrapper.LogTwitter();
				InitTwitter();
			}
		}

		private void HandleNextButton(object sender, EventArgs args)
		{
			if (!(_shopInstance != null))
			{
				if (!_isLastLevel)
				{
					CurrentCampaignGame.levelSceneName = _nextSceneName;
					SetInitialAmmoForAllGuns();
					LevelArt.endOfBox = false;
					Application.LoadLevel((!LevelArt.ShouldShowArts) ? "CampaignLoading" : "LevelArt");
				}
				else
				{
					LevelArt.endOfBox = true;
					Application.LoadLevel((!LevelArt.ShouldShowArts) ? "ChooseLevel" : "LevelArt");
				}
			}
		}

		[Obfuscation(Exclude = true)]
		private void GoToChooseLevel()
		{
			Application.LoadLevel("ChooseLevel");
		}

		private void HandleShopButton(object sender, EventArgs args)
		{
			if (_shopInstance != null)
			{
				return;
			}
			_shopInstance = ShopNGUIController.sharedShop;
			if (_shopInstance != null)
			{
				_shopInstance.SetGearCatEnabled(false);
				ShopNGUIController.GuiActive = true;
				if (shopButtonSound != null && Defs.isSoundFX)
				{
					NGUITools.PlaySound(shopButtonSound);
				}
				_shopInstance.resumeAction = HandleResumeFromShop;
			}
			quitButton.SetActive(false);
		}

		private void HandleResumeFromShop()
		{
			if (!(_shopInstance == null))
			{
				ShopNGUIController.GuiActive = false;
				_shopInstance.resumeAction = delegate
				{
				};
				_shopInstance = null;
				if (coinsPlashka.thisScript != null)
				{
					coinsPlashka.thisScript.enabled = false;
				}
				quitButton.SetActive(Defs.IsSurvival);
				if (_experienceController != null)
				{
					_experienceController.isShowRanks = true;
				}
			}
		}

		private static ExperienceController InitializeExperienceController()
		{
			ExperienceController experienceController = null;
			GameObject gameObject = GameObject.FindGameObjectWithTag("ExperienceController");
			if (gameObject != null)
			{
				experienceController = gameObject.GetComponent<ExperienceController>();
			}
			if (experienceController == null)
			{
				Debug.LogError("Cannot find experience controller.");
			}
			else
			{
				experienceController.posRanks = new Vector2(21f * Defs.Coef, 21f * Defs.Coef);
				experienceController.isShowRanks = true;
				if (ExpController.Instance != null)
				{
					ExpController.Instance.InterfaceEnabled = true;
				}
			}
			return experienceController;
		}

		private static int InitializeStarCount()
		{
			int num = 1;
			if (CurrentCampaignGame.completeInTime)
			{
				num++;
			}
			if (CurrentCampaignGame.withoutHits)
			{
				num++;
			}
			return num;
		}

		private bool InitializeAwardConferred()
		{
			return _isLastLevel && completedFirstTime;
		}

		private string _SocialMessage()
		{
			if (Defs.IsSurvival)
			{
				string text = string.Format("I've played Pixel Gun 3D and passed {0} waves, killed {1} monsters, and got {2} points!", PlayerPrefs.GetInt(Defs.WavesSurvivedS, 0), PlayerPrefs.GetInt(Defs.KilledZombiesSett, 0), GlobalGameController.Score);
				Debug.Log(text);
				return text;
			}
			if (!_gameOver)
			{
				string text2 = string.Format("I've played {0} level in Pixel Gun 3D and got {1} stars!", Defs2.mapNamesForUser[CurrentCampaignGame.levelSceneName], _starCount);
				Debug.Log(text2);
				return text2;
			}
			string text3 = string.Format("I've played Pixel Gun 3D and almost passed level {0}!", Defs2.mapNamesForUser[CurrentCampaignGame.levelSceneName]);
			Debug.Log(text3);
			return text3;
		}

		private void InitTwitter()
		{
			string empty = string.Empty;
			string empty2 = string.Empty;
			if (GlobalGameController.isFullVersion)
			{
				empty = "cuMbTHM8izr9Mb3bIfcTxA";
				empty2 = "mpTLWIku4kIaQq7sTTi91wRLlvAxADhalhlEresnuI";
			}
			else
			{
				empty = "Jb7CwCaMgCQQiMViQRNHw";
				empty2 = "zGVrax4vqgs3CYf04O7glsoRbNT3vhIafte6lfm8w";
			}
			ServiceLocator.TwitterFacade.Init(empty, empty2);
			if (!ServiceLocator.TwitterFacade.IsLoggedIn())
			{
				TwitterLogin();
			}
			else
			{
				TwitterPost();
			}
		}

		private void TwitterLogin()
		{
			TwitterManager.loginSucceededEvent += OnTwitterLogin;
			TwitterManager.loginFailedEvent += OnTwitterLoginFailed;
			ServiceLocator.TwitterFacade.ShowLoginDialog();
		}

		private void OnTwitterLogin(string s)
		{
			TwitterManager.loginSucceededEvent -= OnTwitterLogin;
			TwitterManager.loginFailedEvent -= OnTwitterLoginFailed;
			TwitterPost();
		}

		private void OnTwitterLoginFailed(string _error)
		{
			TwitterManager.loginSucceededEvent -= OnTwitterLogin;
			TwitterManager.loginFailedEvent -= OnTwitterLoginFailed;
		}

		private void TwitterPost()
		{
			TwitterManager.requestDidFinishEvent += OnTwitterPost;
			ServiceLocator.TwitterFacade.PostStatusUpdate(_SocialMessage());
		}

		private void OnTwitterPost(object result)
		{
			if (result != null)
			{
				TwitterManager.requestDidFinishEvent -= OnTwitterPost;
				showMessagTiwtter = true;
				Invoke("hideMessagTwitter", 3f);
			}
		}

		private void OnTwitterPostFailed(string _error)
		{
			TwitterManager.requestDidFinishEvent -= OnTwitterPost;
		}

		[Obfuscation(Exclude = true)]
		[Obfuscation(Exclude = true)]
		private void hideMessagTwitter()
		{
			showMessagTiwtter = false;
		}

		public static void SetInputEnabled(bool enabled)
		{
			if (_instance != null)
			{
				_instance.uiCamera.enabled = enabled;
			}
		}
	}
}
