using System;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

internal sealed class ChooseBox : MonoBehaviour
{
	public static ChooseBox instance;

	private Vector2 pressPoint;

	private Vector2 startPoint;

	private Vector2 pointMap;

	private bool isVozvratMap;

	private Vector2 sizeMap = new Vector2(823f, 736f);

	private bool isMoveMap;

	private bool isSetMap;

	private List<Texture> boxPreviews = new List<Texture>();

	private List<Texture> closedBoxPreviews = new List<Texture>();

	public ChooseBoxNGUIController nguiController;

	public Transform gridTransform;

	private bool _escapePressed;

	private void LoadBoxPreviews()
	{
		for (int i = 0; i < LevelBox.campaignBoxes.Count; i++)
		{
			Texture item = Resources.Load(ResPath.Combine("Boxes", LevelBox.campaignBoxes[i].PreviewNAme)) as Texture;
			boxPreviews.Add(item);
			Texture item2 = Resources.Load(ResPath.Combine("Boxes", LevelBox.campaignBoxes[i].PreviewNAme + "_closed")) as Texture;
			closedBoxPreviews.Add(item2);
		}
	}

	private void UnloadBoxPreviews()
	{
		boxPreviews.Clear();
		Resources.UnloadUnusedAssets();
	}

	private void Start()
	{
		instance = this;
		if (nguiController.startButton != null)
		{
			ButtonHandler component = nguiController.startButton.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += HandleStartClicked;
			}
		}
		if (nguiController.backButton != null)
		{
			ButtonHandler component2 = nguiController.backButton.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += HandleBackClicked;
			}
		}
		StoreKitEventListener.State.Mode = "Campaign";
		StoreKitEventListener.State.Parameters.Clear();
		Debug.Log("start choosbox");
		if (Application.platform == RuntimePlatform.Android && Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
		{
		}
		pointMap = new Vector2((float)Screen.width / 2f, (float)Screen.height / 2f);
		int num = Math.Min(LevelBox.campaignBoxes.Count, gridTransform.childCount);
		for (int i = 0; i < num; i++)
		{
			bool flag = CalculateStarsLeftToOpenTheBox(i) <= 0 && IsCompliteAllLevelsToOpenTheBox(i);
			Texture mainTexture = ((!flag) ? (Resources.Load<Texture>(ResPath.Combine("Boxes", LevelBox.campaignBoxes[i].PreviewNAme + "_closed")) ?? Resources.Load<Texture>(ResPath.Combine("Boxes", LevelBox.campaignBoxes[i].PreviewNAme))) : Resources.Load<Texture>(ResPath.Combine("Boxes", LevelBox.campaignBoxes[i].PreviewNAme)));
			Transform child = gridTransform.GetChild(i);
			child.GetComponent<UITexture>().mainTexture = mainTexture;
			Transform transform = child.Find("NeedMoreStarsLabel");
			if (transform != null)
			{
				if (!flag && i < LevelBox.campaignBoxes.Count - 1)
				{
					transform.gameObject.SetActive(true);
					int num2 = CalculateStarsLeftToOpenTheBox(i);
					string text = ((!IsCompliteAllLevelsToOpenTheBox(i) && num2 > 0) ? string.Format(LocalizationStore.Get("Key_0241"), num2) : ((num2 <= 0) ? LocalizationStore.Get("Key_1366") : string.Format(LocalizationStore.Get("Key_1367"), num2)));
					transform.GetComponent<UILabel>().text = text;
				}
				else
				{
					transform.gameObject.SetActive(false);
				}
			}
			else
			{
				Debug.LogWarning("Could not find “NeedMoreStarsLabel”.");
			}
			Transform transform2 = child.Find("CaptionLabel");
			if (transform2 != null)
			{
				transform2.gameObject.SetActive(flag || i == LevelBox.campaignBoxes.Count - 1);
			}
			else
			{
				Debug.LogWarning("Could not find “CaptionLabel”.");
			}
		}
	}

	private void HandleStartClicked(object sender, EventArgs e)
	{
		StartNBox(nguiController.selectIndexMap);
	}

	public void StartNameBox(string _nameBox)
	{
		if (_nameBox.Equals("Box_1"))
		{
			StartNBox(0);
		}
		else if (_nameBox.Equals("Box_2"))
		{
			if (CalculateStarsLeftToOpenTheBox(1) <= 0 && IsCompliteAllLevelsToOpenTheBox(1))
			{
				StartNBox(1);
			}
		}
		else if (_nameBox.Equals("Box_3") && CalculateStarsLeftToOpenTheBox(2) <= 0 && IsCompliteAllLevelsToOpenTheBox(2))
		{
			StartNBox(2);
		}
	}

	public void StartNBox(int n)
	{
		ButtonClickSound.Instance.PlayClick();
		CurrentCampaignGame.boXName = LevelBox.campaignBoxes[n].name;
		MenuBackgroundMusic.keepPlaying = true;
		LoadConnectScene.textureToShow = null;
		LoadConnectScene.sceneToLoad = "ChooseLevel";
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}

	private void HandleBackClicked(object sender, EventArgs e)
	{
		_escapePressed = true;
	}

	private void OnDestroy()
	{
		instance = null;
		CampaignProgress.SaveCampaignProgress();
		PlayerPrefs.Save();
		UnloadBoxPreviews();
	}

	private void Update()
	{
		if (_escapePressed)
		{
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogEvent("Back to Main Menu");
			Resources.UnloadUnusedAssets();
			MenuBackgroundMusic.keepPlaying = true;
			LoadConnectScene.textureToShow = null;
			LoadConnectScene.noteToShow = null;
			LoadConnectScene.sceneToLoad = Defs.MainMenuScene;
			Application.LoadLevel(Defs.PromSceneName);
			_escapePressed = false;
		}
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_escapePressed = true;
		}
		if (nguiController.startButton != null)
		{
			nguiController.startButton.gameObject.SetActive(nguiController.selectIndexMap == 0 || (CalculateStarsLeftToOpenTheBox(nguiController.selectIndexMap) <= 0 && IsCompliteAllLevelsToOpenTheBox(nguiController.selectIndexMap)));
		}
	}

	private bool IsCompliteAllLevelsToOpenTheBox(int boxIndex)
	{
		if (boxIndex == 0)
		{
			return true;
		}
		bool result = false;
		LevelBox levelBox = LevelBox.campaignBoxes[boxIndex - 1];
		Dictionary<string, int> value;
		if (CampaignProgress.boxesLevelsAndStars.TryGetValue(levelBox.name, out value))
		{
			if (boxIndex == 1 && value.Count >= 9)
			{
				result = true;
			}
			if (boxIndex == 2 && value.Count >= 6)
			{
				result = true;
			}
			if (boxIndex == 3 && value.Count >= 5)
			{
				result = true;
			}
		}
		return result;
	}

	private int CalculateStarsLeftToOpenTheBox(int boxIndex)
	{
		if (boxIndex >= LevelBox.campaignBoxes.Count)
		{
			throw new ArgumentOutOfRangeException("boxIndex");
		}
		int num = 0;
		for (int i = 0; i < boxIndex; i++)
		{
			LevelBox levelBox = LevelBox.campaignBoxes[i];
			Dictionary<string, int> value;
			if (!CampaignProgress.boxesLevelsAndStars.TryGetValue(levelBox.name, out value))
			{
				continue;
			}
			foreach (CampaignLevel level in levelBox.levels)
			{
				int value2 = 0;
				if (value.TryGetValue(level.sceneName, out value2))
				{
					num += value2;
				}
			}
		}
		int starsToOpen = LevelBox.campaignBoxes[boxIndex].starsToOpen;
		return starsToOpen - num;
	}
}
