using System;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;

internal sealed class ChooseLevel : MonoBehaviour
{
	private sealed class LevelInfo
	{
		public bool Enabled { get; set; }

		public string Name { get; set; }

		public int StarGainedCount { get; set; }
	}

	public GameObject BonusGun3Box;

	public GameObject panel;

	public GameObject[] starEnabledPrototypes;

	public GameObject[] starDisabledPrototypes;

	public GameObject gainedStarCountLabel;

	public GameObject backButton;

	public GameObject shopButton;

	public ButtonHandler nextButton;

	public GameObject[] boxOneLevelButtons;

	public GameObject[] boxTwoLevelButtons;

	public GameObject[] boxThreeLevelButtons;

	public AudioClip shopButtonSound;

	public GameObject backgroundHolder;

	public GameObject backgroundHolder_2;

	public GameObject backgroundHolder_3;

	public GameObject[] boxContents;

	public static ChooseLevel sharedChooseLevel;

	private float _timeStarted;

	private int _boxIndex;

	private GameObject[] _boxLevelButtons;

	private string _gainedStarCount = string.Empty;

	private IList<LevelInfo> _levelInfos = new List<LevelInfo>();

	public ShopNGUIController _shopInstance;

	private float _timeWhenShopWasClosed;

	private void Start()
	{
		if (StoreKitEventListener.purchaseActivityInd != null)
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(false);
		}
		if (ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.Refresh();
		}
		if (ExpController.Instance != null)
		{
			ExpController.Instance.Refresh();
		}
		StoreKitEventListener.State.PurchaseKey = "In Map";
		StoreKitEventListener.State.Parameters.Clear();
		sharedChooseLevel = this;
		_timeStarted = Time.realtimeSinceStartup;
		bool draggableLayout = false;
		_boxIndex = LevelBox.campaignBoxes.FindIndex((LevelBox b) => b.name == CurrentCampaignGame.boXName);
		if (_boxIndex == -1)
		{
			Debug.LogWarning("Box not found in list!");
			throw new InvalidOperationException("Box not found in list!");
		}
		IList<LevelInfo> levelInfos;
		if (true)
		{
			IList<LevelInfo> list = InitializeLevelInfos(draggableLayout);
			levelInfos = list;
		}
		else
		{
			levelInfos = InitializeLevelInfosWithTestData(draggableLayout);
		}
		_levelInfos = levelInfos;
		_gainedStarCount = InitializeGainStarCount(_levelInfos);
		if (CurrentCampaignGame.boXName == "Real")
		{
			_boxLevelButtons = boxOneLevelButtons;
			backgroundHolder.SetActive(true);
		}
		else if (CurrentCampaignGame.boXName == "minecraft")
		{
			_boxLevelButtons = boxTwoLevelButtons;
			backgroundHolder_2.SetActive(true);
		}
		else if (CurrentCampaignGame.boXName == "Crossed")
		{
			_boxLevelButtons = boxThreeLevelButtons;
			backgroundHolder_3.SetActive(true);
			string[] array = Storager.getString(Defs.WeaponsGotInCampaign, false).Split('#');
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] == null)
				{
					array[i] = string.Empty;
				}
			}
			BonusGun3Box.SetActive(array == null || !array.Contains(WeaponManager.BugGunWN));
		}
		else
		{
			Debug.LogWarning("Unknown box: " + CurrentCampaignGame.boXName);
		}
		InitializeLevelButtons();
		InitializeFixedDisplay();
		InitializeNextButton(_levelInfos, nextButton);
		CampaignProgress.SaveCampaignProgress();
		PlayerPrefs.Save();
	}

	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape) && _shopInstance == null)
		{
			HandleBackButton(this, EventArgs.Empty);
			Input.ResetInputAxes();
		}
	}

	private void InitializeNextButton(IList<LevelInfo> levels, ButtonHandler nextButton)
	{
		if (levels == null)
		{
			throw new ArgumentNullException("levels");
		}
		if (nextButton == null)
		{
			throw new ArgumentNullException("nextButton");
		}
		LevelInfo level = levels.LastOrDefault((LevelInfo l) => l.Enabled && l.StarGainedCount == 0);
		nextButton.gameObject.SetActive(level != null);
		if (level != null)
		{
			nextButton.Clicked += delegate
			{
				HandleLevelButton(level.Name);
			};
		}
	}

	private void InitializeFixedDisplay()
	{
		if (backButton != null)
		{
			backButton.GetComponent<ButtonHandler>().Clicked += HandleBackButton;
		}
		if (shopButton != null)
		{
			shopButton.GetComponent<ButtonHandler>().Clicked += HandleShopButton;
		}
		if (gainedStarCountLabel != null)
		{
			gainedStarCountLabel.GetComponent<UILabel>().text = _gainedStarCount;
		}
	}

	private void HandleBackButton(object sender, EventArgs args)
	{
		if (!(_shopInstance != null) && !(Time.time - _timeWhenShopWasClosed < 1f))
		{
			MenuBackgroundMusic.keepPlaying = true;
			LoadConnectScene.textureToShow = null;
			LoadConnectScene.sceneToLoad = "CampaignChooseBox";
			LoadConnectScene.noteToShow = null;
			Application.LoadLevel(Defs.PromSceneName);
		}
	}

	private void HandleShopButton(object sender, EventArgs args)
	{
		if (!(_shopInstance == null))
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
	}

	private void HandleResumeFromShop()
	{
		if (_shopInstance != null)
		{
			ShopNGUIController.GuiActive = false;
			if (ExperienceController.sharedController != null && ExpController.Instance != null)
			{
				ExperienceController.sharedController.isShowRanks = false;
				ExpController.Instance.InterfaceEnabled = false;
			}
			_shopInstance.resumeAction = delegate
			{
			};
			_shopInstance = null;
			_timeWhenShopWasClosed = Time.time;
		}
	}

	private void InitializeLevelButtons()
	{
		if (starEnabledPrototypes != null)
		{
			GameObject[] array = starEnabledPrototypes;
			foreach (GameObject gameObject in array)
			{
				if (gameObject != null)
				{
					gameObject.SetActive(false);
				}
			}
		}
		if (starDisabledPrototypes != null)
		{
			GameObject[] array2 = starDisabledPrototypes;
			foreach (GameObject gameObject2 in array2)
			{
				if (gameObject2 != null)
				{
					gameObject2.SetActive(false);
				}
			}
		}
		if (boxContents != null)
		{
			for (int k = 0; k != boxContents.Length; k++)
			{
				boxContents[k].SetActive(k == _boxIndex);
			}
			if (_boxLevelButtons == null)
			{
				throw new InvalidOperationException("Box level buttons are null.");
			}
			GameObject[] boxLevelButtons = _boxLevelButtons;
			foreach (GameObject gameObject3 in boxLevelButtons)
			{
				if (gameObject3 != null)
				{
					UIButton component = gameObject3.GetComponent<UIButton>();
					if (component != null)
					{
						component.isEnabled = false;
					}
				}
			}
			int num = Math.Min(_levelInfos.Count, _boxLevelButtons.Length);
			for (int m = 0; m != num; m++)
			{
				LevelInfo levelInfo = _levelInfos[m];
				GameObject gameObject4 = _boxLevelButtons[m];
				gameObject4.transform.parent = gameObject4.transform.parent;
				gameObject4.GetComponent<UIButton>().isEnabled = levelInfo.Enabled;
				UISprite componentInChildren = gameObject4.GetComponentInChildren<UISprite>();
				if (componentInChildren == null)
				{
					Debug.LogWarning("Could not find background of level button.");
				}
				else
				{
					UILabel componentInChildren2 = componentInChildren.GetComponentInChildren<UILabel>();
					if (componentInChildren2 == null)
					{
						Debug.LogWarning("Could not find caption of level button.");
					}
					else
					{
						componentInChildren2.applyGradient = levelInfo.Enabled;
					}
				}
				gameObject4.AddComponent<ButtonHandler>();
				string levelName = levelInfo.Name;
				gameObject4.GetComponent<ButtonHandler>().Clicked += delegate
				{
					HandleLevelButton(levelName);
				};
				gameObject4.SetActive(true);
				for (int n = 0; n != starEnabledPrototypes.Length; n++)
				{
					if (levelInfo.Enabled)
					{
						GameObject gameObject5 = starEnabledPrototypes[n];
						if (!(gameObject5 == null))
						{
							GameObject gameObject6 = UnityEngine.Object.Instantiate(gameObject5) as GameObject;
							gameObject6.transform.parent = gameObject4.transform;
							gameObject6.GetComponent<UIToggle>().value = n < levelInfo.StarGainedCount;
							gameObject6.transform.localPosition = gameObject5.transform.localPosition;
							gameObject6.transform.localScale = gameObject5.transform.localScale;
							gameObject6.SetActive(true);
						}
					}
				}
			}
			GameObject[] array3 = starEnabledPrototypes;
			foreach (GameObject gameObject7 in array3)
			{
				if (gameObject7 != null)
				{
					UnityEngine.Object.Destroy(gameObject7);
				}
			}
			GameObject[] array4 = starDisabledPrototypes;
			foreach (GameObject gameObject8 in array4)
			{
				if (gameObject8 != null)
				{
					UnityEngine.Object.Destroy(gameObject8);
				}
			}
			return;
		}
		throw new InvalidOperationException("boxContents == 0");
	}

	private void HandleLevelButton(string levelName)
	{
		if (!(_shopInstance != null) && !(Time.realtimeSinceStartup - _timeStarted < 0.15f))
		{
			CurrentCampaignGame.levelSceneName = levelName;
			WeaponManager.sharedManager.Reset(0);
			FlurryPluginWrapper.LogLevelPressed(CurrentCampaignGame.levelSceneName);
			LevelArt.endOfBox = false;
			Application.LoadLevel((!LevelArt.ShouldShowArts) ? "CampaignLoading" : "LevelArt");
		}
	}

	private static IList<LevelInfo> InitializeLevelInfosWithTestData(bool draggableLayout = false)
	{
		List<LevelInfo> list = new List<LevelInfo>();
		list.Add(new LevelInfo
		{
			Enabled = true,
			Name = "Cementery",
			StarGainedCount = 1
		});
		list.Add(new LevelInfo
		{
			Enabled = true,
			Name = "City",
			StarGainedCount = 3
		});
		list.Add(new LevelInfo
		{
			Enabled = false,
			Name = "Hospital"
		});
		return list;
	}

	private static IList<LevelInfo> InitializeLevelInfos(bool draggableLayout = false)
	{
		List<LevelInfo> list = new List<LevelInfo>();
		string boxName = CurrentCampaignGame.boXName;
		int num = LevelBox.campaignBoxes.FindIndex((LevelBox b) => b.name == boxName);
		if (num == -1)
		{
			Debug.LogWarning("Box not found in list!");
			return list;
		}
		LevelBox levelBox = LevelBox.campaignBoxes[num];
		List<CampaignLevel> levels = levelBox.levels;
		Dictionary<string, int> value;
		if (!CampaignProgress.boxesLevelsAndStars.TryGetValue(boxName, out value))
		{
			Debug.LogWarning("Box not found in dictionary: " + boxName);
			value = new Dictionary<string, int>();
		}
		for (int i = 0; i != levels.Count; i++)
		{
			string sceneName = levels[i].sceneName;
			int value2 = 0;
			value.TryGetValue(sceneName, out value2);
			LevelInfo levelInfo = new LevelInfo();
			levelInfo.Enabled = i <= value.Count;
			levelInfo.Name = sceneName;
			levelInfo.StarGainedCount = value2;
			LevelInfo item = levelInfo;
			list.Add(item);
		}
		return list;
	}

	private static string InitializeGainStarCount(IList<LevelInfo> levelInfos)
	{
		int num = 3 * levelInfos.Count;
		int num2 = 0;
		foreach (LevelInfo levelInfo in levelInfos)
		{
			num2 += levelInfo.StarGainedCount;
		}
		return string.Format("{0}/{1}", num2, num);
	}

	public static string GetGainStarsString()
	{
		IList<LevelInfo> levelInfos = InitializeLevelInfos(false);
		return InitializeGainStarCount(levelInfos);
	}

	private void OnDestroy()
	{
		sharedChooseLevel = null;
	}
}
