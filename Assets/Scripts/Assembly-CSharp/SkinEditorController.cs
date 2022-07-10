using System;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public class SkinEditorController : MonoBehaviour
{
	public enum ModeEditor
	{
		SkinPers,
		Cape,
		LogoClan
	}

	public enum BrashMode
	{
		Pencil,
		Brash,
		Eraser,
		Fill,
		Pipette
	}

	public static Color colorForPaint = new Color(0f, 1f, 0f, 1f);

	public static BrashMode brashMode = BrashMode.Pencil;

	public GameObject topPart;

	public GameObject downPart;

	public GameObject leftPart;

	public GameObject frontPart;

	public GameObject rigthPart;

	public GameObject backPart;

	public static ModeEditor modeEditor = ModeEditor.SkinPers;

	public static SkinEditorController sharedController = null;

	public ButtonHandler saveButton;

	public ButtonHandler backButton;

	public ButtonHandler fillButton;

	public ButtonHandler eraserButton;

	public ButtonHandler brashButton;

	public ButtonHandler pencilButton;

	public ButtonHandler pipetteButton;

	public ButtonHandler colorButton;

	public ButtonHandler okColorInPalitraButton;

	public ButtonHandler setColorButton;

	public ButtonHandler saveChangesButton;

	public ButtonHandler cancelInSaveChangesButton;

	public ButtonHandler okInSaveSkin;

	public ButtonHandler cancelInSaveSkin;

	public ButtonHandler yesInLeaveSave;

	public ButtonHandler noInLeaveSave;

	public ButtonHandler prevHistoryButton;

	public ButtonHandler nextHistoryButton;

	public ButtonHandler yesSaveButtonInEdit;

	public ButtonHandler noSaveButtonInEdit;

	public GameObject previewPers;

	public GameObject previewPersShadow;

	public GameObject skinPreviewPanel;

	public GameObject partPreviewPanel;

	public GameObject editorPanel;

	public GameObject colorPanel;

	public GameObject saveChangesPanel;

	public GameObject saveSkinPanel;

	public GameObject leavePanel;

	public GameObject savePanelInEditorTexture;

	public string selectedPartName;

	public GameObject selectedSide;

	public static Texture2D currentSkin = null;

	public static string currentSkinName = null;

	public static Dictionary<string, Dictionary<string, Rect>> rectsPartsInSkin = new Dictionary<string, Dictionary<string, Rect>>();

	public static Dictionary<string, Dictionary<string, Texture2D>> texturesParts = new Dictionary<string, Dictionary<string, Texture2D>>();

	public UILabel pensilLabel;

	public UILabel brashLabel;

	public UILabel eraserLabel;

	public UILabel fillLabel;

	public UILabel pipetteLabel;

	public UITexture editorTexture;

	public UISprite oldColor;

	public UISprite newColor;

	public UIInput skinNameInput;

	public static bool isEditingPartSkin = false;

	public static bool isEditingSkin = false;

	public bool isSaveAndExit;

	private List<GameObject> currentPreviewsSkin = new List<GameObject>();

	private string newNameSkin;

	public UISprite[] colorOnBrashSprites;

	public static event Action<string> ExitFromSkinEditor;

	static SkinEditorController()
	{
		SkinEditorController.ExitFromSkinEditor = null;
	}

	private void Start()
	{
		brashMode = BrashMode.Pencil;
		isEditingSkin = false;
		isEditingPartSkin = false;
		sharedController = this;
		MenuBackgroundMusic.sharedMusic.PlayCustomMusicFrom(base.gameObject);
		if (ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.isShowRanks = false;
		}
		colorForPaint = new Color(PlayerPrefs.GetFloat("ColorForPaintR", 0f), PlayerPrefs.GetFloat("ColorForPaintG", 1f), PlayerPrefs.GetFloat("ColorForPaintB", 0f), 1f);
		colorButton.gameObject.GetComponent<UIButton>().defaultColor = colorForPaint;
		colorButton.gameObject.GetComponent<UIButton>().pressed = colorForPaint;
		colorButton.gameObject.GetComponent<UIButton>().hover = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().defaultColor = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().pressed = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().hover = colorForPaint;
		for (int i = 0; i < colorOnBrashSprites.Length; i++)
		{
			colorOnBrashSprites[i].color = colorForPaint;
		}
		if (modeEditor == ModeEditor.SkinPers)
		{
			if (currentSkinName == null)
			{
				currentSkin = Resources.Load("Clear_Skin") as Texture2D;
				currentSkin.filterMode = FilterMode.Point;
				currentSkin.Apply();
				skinNameInput.value = string.Empty;
			}
			else
			{
				currentSkin = SkinsController.skinsForPers[currentSkinName];
				if (SkinsController.skinsNamesForPers.ContainsKey(currentSkinName))
				{
					skinNameInput.value = SkinsController.skinsNamesForPers[currentSkinName];
				}
			}
			Debug.Log("modeEditor== ModeEditor.SkinPers");
			partPreviewPanel.SetActive(false);
			skinPreviewPanel.SetActive(true);
			editorPanel.SetActive(false);
			currentPreviewsSkin.Add(previewPers);
			currentPreviewsSkin.Add(previewPersShadow);
			ShowPreviewSkin();
		}
		if (modeEditor == ModeEditor.Cape || modeEditor == ModeEditor.LogoClan)
		{
			Texture2D texture2D = null;
			if (modeEditor == ModeEditor.Cape)
			{
				texture2D = SkinsController.capeUserTexture;
				if (texture2D == null)
				{
					texture2D = Resources.Load("cape_CustomTexture") as Texture2D;
				}
			}
			else
			{
				texture2D = SkinsController.logoClanUserTexture;
				if (texture2D == null)
				{
					texture2D = Resources.Load("Clan_Previews/icon_clan_001") as Texture2D;
				}
			}
			currentSkin = EditorTextures.CreateCopyTexture(texture2D);
			partPreviewPanel.SetActive(false);
			skinPreviewPanel.SetActive(false);
			editorPanel.SetActive(true);
			editorTexture.gameObject.GetComponent<EditorTextures>().SetStartCanvas(currentSkin);
		}
		savePanelInEditorTexture.SetActive(false);
		SkinsController.SetTextureRecursivelyFrom(previewPers, currentSkin);
		SetPartsRect();
		UpdateTexturesPartsInDictionary();
		colorPanel.SetActive(false);
		saveChangesPanel.SetActive(false);
		saveSkinPanel.SetActive(false);
		leavePanel.SetActive(false);
		if (topPart != null)
		{
			ButtonHandler component = topPart.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += HandleSideClicked;
			}
		}
		if (downPart != null)
		{
			ButtonHandler component2 = downPart.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += HandleSideClicked;
			}
		}
		if (leftPart != null)
		{
			ButtonHandler component3 = leftPart.GetComponent<ButtonHandler>();
			if (component3 != null)
			{
				component3.Clicked += HandleSideClicked;
			}
		}
		if (frontPart != null)
		{
			ButtonHandler component4 = frontPart.GetComponent<ButtonHandler>();
			if (component4 != null)
			{
				component4.Clicked += HandleSideClicked;
			}
		}
		if (rigthPart != null)
		{
			ButtonHandler component5 = rigthPart.GetComponent<ButtonHandler>();
			if (component5 != null)
			{
				component5.Clicked += HandleSideClicked;
			}
		}
		if (backPart != null)
		{
			ButtonHandler component6 = backPart.GetComponent<ButtonHandler>();
			if (component6 != null)
			{
				component6.Clicked += HandleSideClicked;
			}
		}
		if (saveButton != null)
		{
			saveButton.Clicked += HandleSaveButtonClicked;
		}
		if (backButton != null)
		{
			backButton.Clicked += HandleBackButtonClicked;
		}
		if (fillButton != null)
		{
			fillButton.Clicked += HandleSelectBrashClicked;
		}
		if (brashButton != null)
		{
			brashButton.Clicked += HandleSelectBrashClicked;
		}
		if (pencilButton != null)
		{
			pencilButton.Clicked += HandleSelectBrashClicked;
		}
		if (pipetteButton != null)
		{
			pipetteButton.Clicked += HandleSelectBrashClicked;
		}
		if (eraserButton != null)
		{
			eraserButton.Clicked += HandleSelectBrashClicked;
		}
		if (colorButton != null)
		{
			colorButton.Clicked += HandleSelectColorClicked;
		}
		if (setColorButton != null)
		{
			setColorButton.Clicked += HandleSetColorClicked;
		}
		if (saveChangesButton != null)
		{
			saveChangesButton.Clicked += HandleSaveChangesButtonClicked;
		}
		if (cancelInSaveChangesButton != null)
		{
			cancelInSaveChangesButton.Clicked += HandleCancelInSaveChangesButtonClicked;
		}
		if (okInSaveSkin != null)
		{
			okInSaveSkin.Clicked += HandleOkInSaveSkinClicked;
		}
		if (cancelInSaveSkin != null)
		{
			cancelInSaveSkin.Clicked += HandleCancelInSaveSkinClicked;
		}
		if (yesInLeaveSave != null)
		{
			yesInLeaveSave.Clicked += HandleYesInLeaveSaveClicked;
		}
		if (noInLeaveSave != null)
		{
			noInLeaveSave.Clicked += HandleNoInLeaveSaveClicked;
		}
		if (yesSaveButtonInEdit != null)
		{
			yesSaveButtonInEdit.Clicked += HandleYesSaveButtonInEditClicked;
		}
		if (noSaveButtonInEdit != null)
		{
			noSaveButtonInEdit.Clicked += HandleNoSaveButtonInEditClicked;
		}
	}

	private void HandleYesSaveButtonInEditClicked(object sender, EventArgs e)
	{
		if (modeEditor == ModeEditor.LogoClan)
		{
			Debug.Log("modeEditor==ModeEditor.LogoClan");
			SkinsController.logoClanUserTexture = EditorTextures.CreateCopyTexture((Texture2D)editorTexture.mainTexture);
		}
		if (modeEditor == ModeEditor.Cape)
		{
			SkinsController.capeUserTexture = EditorTextures.CreateCopyTexture((Texture2D)editorTexture.mainTexture);
			PlayerPrefs.SetString("User Cape Skin", SkinsController.StringFromTexture(SkinsController.capeUserTexture));
		}
		isEditingPartSkin = false;
		HandleBackButtonClicked(null, null);
	}

	private void HandleNoSaveButtonInEditClicked(object sender, EventArgs e)
	{
		isEditingPartSkin = false;
		HandleBackButtonClicked(null, null);
	}

	private void HandleOkInSaveSkinClicked(object sender, EventArgs e)
	{
		ShowPreviewSkin();
		newNameSkin = SkinsController.AddUserSkin(skinNameInput.value, currentSkin, currentSkinName);
		SkinsController.SetCurrentSkin(newNameSkin);
		isEditingSkin = false;
		saveSkinPanel.SetActive(false);
		HandleBackButtonClicked(null, null);
	}

	private void HandleCancelInSaveSkinClicked(object sender, EventArgs e)
	{
		if (isSaveAndExit)
		{
			saveSkinPanel.SetActive(false);
			leavePanel.SetActive(true);
		}
		else
		{
			ShowPreviewSkin();
			saveSkinPanel.SetActive(false);
		}
	}

	private void HandleYesInLeaveSaveClicked(object sender, EventArgs e)
	{
		leavePanel.SetActive(false);
		saveSkinPanel.SetActive(true);
		isSaveAndExit = true;
	}

	private void HandleNoInLeaveSaveClicked(object sender, EventArgs e)
	{
		isEditingSkin = false;
		ShowPreviewSkin();
		leavePanel.SetActive(false);
		HandleBackButtonClicked(null, null);
	}

	private void ShowPreviewSkin()
	{
		foreach (GameObject item in currentPreviewsSkin)
		{
			item.SetActive(true);
		}
		backButton.gameObject.GetComponent<UIButton>().isEnabled = true;
		saveButton.gameObject.GetComponent<UIButton>().isEnabled = true;
	}

	private void HidePreviewSkin()
	{
		foreach (GameObject item in currentPreviewsSkin)
		{
			item.SetActive(false);
		}
		backButton.gameObject.GetComponent<UIButton>().isEnabled = false;
		saveButton.gameObject.GetComponent<UIButton>().isEnabled = false;
	}

	private void HandleSaveChangesButtonClicked(object sender, EventArgs e)
	{
		isEditingPartSkin = false;
		isEditingSkin = true;
		saveChangesPanel.SetActive(false);
		SavePartInTexturesParts(selectedPartName);
		currentSkin = BuildSkin(texturesParts);
		SkinsController.SetTextureRecursivelyFrom(previewPers, currentSkin);
		UpdateTexturesPartsInDictionary();
		HandleBackButtonClicked(null, null);
	}

	private void HandleCancelInSaveChangesButtonClicked(object sender, EventArgs e)
	{
		isEditingPartSkin = false;
		saveChangesPanel.SetActive(false);
		HandleBackButtonClicked(null, null);
	}

	private void HandleSelectColorClicked(object sender, EventArgs e)
	{
		editorPanel.SetActive(false);
		colorPanel.SetActive(true);
		oldColor.color = colorForPaint;
		newColor.color = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().defaultColor = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().pressed = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().hover = colorForPaint;
		if (brashMode == BrashMode.Pipette)
		{
			brashMode = BrashMode.Pencil;
			pencilButton.gameObject.GetComponent<UIToggle>().value = true;
			pipetteButton.gameObject.GetComponent<UIToggle>().value = false;
			pipetteButton.gameObject.GetComponent<UIButton>().state = UIButtonColor.State.Normal;
			pipetteButton.transform.Find("Checkmark").GetComponent<UISprite>().color = new Color(1f, 1f, 1f, 0f);
			HandleSelectBrashClicked(pencilButton, null);
		}
	}

	public void HandleSetColorClicked(object sender, EventArgs e)
	{
		editorPanel.SetActive(true);
		colorPanel.SetActive(false);
		colorForPaint = newColor.color;
		colorButton.gameObject.GetComponent<UIButton>().defaultColor = colorForPaint;
		colorButton.gameObject.GetComponent<UIButton>().pressed = colorForPaint;
		colorButton.gameObject.GetComponent<UIButton>().hover = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().defaultColor = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().pressed = colorForPaint;
		okColorInPalitraButton.gameObject.GetComponent<UIButton>().hover = colorForPaint;
		PlayerPrefs.SetFloat("ColorForPaintR", colorForPaint.r);
		PlayerPrefs.SetFloat("ColorForPaintG", colorForPaint.g);
		PlayerPrefs.SetFloat("ColorForPaintB", colorForPaint.b);
		for (int i = 0; i < colorOnBrashSprites.Length; i++)
		{
			colorOnBrashSprites[i].color = colorForPaint;
		}
	}

	private void HandleSelectBrashClicked(object sender, EventArgs e)
	{
		GameObject gameObject = (sender as MonoBehaviour).gameObject;
		string text = gameObject.name;
		Debug.Log(text);
		if (text.Equals("Fill"))
		{
			brashMode = BrashMode.Fill;
		}
		if (text.Equals("Brash"))
		{
			brashMode = BrashMode.Brash;
		}
		if (text.Equals("Pencil"))
		{
			brashMode = BrashMode.Pencil;
		}
		if (text.Equals("Eraser"))
		{
			brashMode = BrashMode.Eraser;
		}
		if (text.Equals("Pipette"))
		{
			brashMode = BrashMode.Pipette;
		}
	}

	private void HandleSideClicked(object sender, EventArgs e)
	{
		selectedSide = (sender as MonoBehaviour).gameObject;
		Debug.Log(selectedSide.name);
		editorPanel.SetActive(true);
		partPreviewPanel.SetActive(false);
		editorTexture.gameObject.GetComponent<EditorTextures>().SetStartCanvas((Texture2D)selectedSide.transform.GetChild(0).GetComponent<UITexture>().mainTexture);
	}

	private void HandleSaveButtonClicked(object sender, EventArgs e)
	{
		isSaveAndExit = false;
		saveSkinPanel.SetActive(true);
		HidePreviewSkin();
	}

	private void HandleBackButtonClicked(object sender, EventArgs e)
	{
		if (partPreviewPanel.activeSelf)
		{
			if (isEditingPartSkin)
			{
				saveChangesPanel.SetActive(true);
				backButton.gameObject.GetComponent<UIButton>().isEnabled = false;
				topPart.GetComponent<UIButton>().isEnabled = false;
				downPart.GetComponent<UIButton>().isEnabled = false;
				leftPart.GetComponent<UIButton>().isEnabled = false;
				frontPart.GetComponent<UIButton>().isEnabled = false;
				rigthPart.GetComponent<UIButton>().isEnabled = false;
				backPart.GetComponent<UIButton>().isEnabled = false;
			}
			else
			{
				partPreviewPanel.SetActive(false);
				skinPreviewPanel.SetActive(true);
				backButton.gameObject.GetComponent<UIButton>().isEnabled = true;
				topPart.GetComponent<UIButton>().isEnabled = true;
				downPart.GetComponent<UIButton>().isEnabled = true;
				leftPart.GetComponent<UIButton>().isEnabled = true;
				frontPart.GetComponent<UIButton>().isEnabled = true;
				rigthPart.GetComponent<UIButton>().isEnabled = true;
				backPart.GetComponent<UIButton>().isEnabled = true;
			}
		}
		else if (editorPanel.activeSelf)
		{
			if (modeEditor == ModeEditor.SkinPers)
			{
				editorPanel.SetActive(false);
				partPreviewPanel.SetActive(true);
				selectedSide.transform.GetChild(0).GetComponent<UITexture>().mainTexture = EditorTextures.CreateCopyTexture((Texture2D)editorTexture.mainTexture);
			}
			else if (modeEditor == ModeEditor.Cape || modeEditor == ModeEditor.LogoClan)
			{
				if (isEditingPartSkin)
				{
					savePanelInEditorTexture.SetActive(true);
				}
				else
				{
					ExitFromScene();
				}
			}
		}
		else if (colorPanel.activeSelf)
		{
			editorPanel.SetActive(true);
			colorPanel.SetActive(false);
		}
		else if (skinPreviewPanel.activeSelf)
		{
			if (isEditingSkin)
			{
				leavePanel.SetActive(true);
				HidePreviewSkin();
			}
			else
			{
				ExitFromScene();
			}
		}
	}

	private void SavePartInTexturesParts(string _partName)
	{
		Dictionary<string, Texture2D> dictionary = new Dictionary<string, Texture2D>();
		foreach (KeyValuePair<string, Texture2D> item in texturesParts[_partName])
		{
			if (item.Key.Equals("Top"))
			{
				dictionary.Add(item.Key, EditorTextures.CreateCopyTexture((Texture2D)topPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture));
			}
			if (item.Key.Equals("Down"))
			{
				dictionary.Add(item.Key, EditorTextures.CreateCopyTexture((Texture2D)downPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture));
			}
			if (item.Key.Equals("Left"))
			{
				dictionary.Add(item.Key, EditorTextures.CreateCopyTexture((Texture2D)leftPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture));
			}
			if (item.Key.Equals("Front"))
			{
				dictionary.Add(item.Key, EditorTextures.CreateCopyTexture((Texture2D)frontPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture));
			}
			if (item.Key.Equals("Right"))
			{
				dictionary.Add(item.Key, EditorTextures.CreateCopyTexture((Texture2D)rigthPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture));
			}
			if (item.Key.Equals("Back"))
			{
				dictionary.Add(item.Key, EditorTextures.CreateCopyTexture((Texture2D)backPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture));
			}
		}
		if (_partName.Equals("Arm_right") || _partName.Equals("Arm_left"))
		{
			texturesParts.Remove("Arm_right");
			texturesParts.Add("Arm_right", dictionary);
			texturesParts.Remove("Arm_left");
			texturesParts.Add("Arm_left", dictionary);
		}
		if (_partName.Equals("Foot_right") || _partName.Equals("Foot_left"))
		{
			texturesParts.Remove("Foot_right");
			texturesParts.Add("Foot_right", dictionary);
			texturesParts.Remove("Foot_left");
			texturesParts.Add("Foot_left", dictionary);
		}
		texturesParts.Remove(_partName);
		texturesParts.Add(_partName, dictionary);
	}

	private void SetPartsRect()
	{
		Dictionary<string, Rect> dictionary = new Dictionary<string, Rect>();
		rectsPartsInSkin.Clear();
		if (modeEditor == ModeEditor.SkinPers)
		{
			Dictionary<string, Rect> dictionary2 = new Dictionary<string, Rect>();
			dictionary2.Add("Top", new Rect(8f, 24f, 8f, 8f));
			dictionary2.Add("Down", new Rect(16f, 24f, 8f, 8f));
			dictionary2.Add("Left", new Rect(0f, 16f, 8f, 8f));
			dictionary2.Add("Front", new Rect(8f, 16f, 8f, 8f));
			dictionary2.Add("Right", new Rect(16f, 16f, 8f, 8f));
			dictionary2.Add("Back", new Rect(24f, 16f, 8f, 8f));
			rectsPartsInSkin.Add("Head", dictionary2);
			Dictionary<string, Rect> dictionary3 = new Dictionary<string, Rect>();
			dictionary3.Add("Top", new Rect(4f, 12f, 4f, 4f));
			dictionary3.Add("Down", new Rect(8f, 12f, 4f, 4f));
			dictionary3.Add("Left", new Rect(0f, 0f, 4f, 12f));
			dictionary3.Add("Front", new Rect(4f, 0f, 4f, 12f));
			dictionary3.Add("Right", new Rect(8f, 0f, 4f, 12f));
			dictionary3.Add("Back", new Rect(12f, 0f, 4f, 12f));
			rectsPartsInSkin.Add("Foot_left", dictionary3);
			Dictionary<string, Rect> dictionary4 = new Dictionary<string, Rect>();
			dictionary4.Add("Top", new Rect(4f, 12f, 4f, 4f));
			dictionary4.Add("Down", new Rect(8f, 12f, 4f, 4f));
			dictionary4.Add("Left", new Rect(0f, 0f, 4f, 12f));
			dictionary4.Add("Front", new Rect(4f, 0f, 4f, 12f));
			dictionary4.Add("Right", new Rect(8f, 0f, 4f, 12f));
			dictionary4.Add("Back", new Rect(12f, 0f, 4f, 12f));
			rectsPartsInSkin.Add("Foot_right", dictionary4);
			Dictionary<string, Rect> dictionary5 = new Dictionary<string, Rect>();
			dictionary5.Add("Top", new Rect(20f, 12f, 8f, 4f));
			dictionary5.Add("Down", new Rect(28f, 12f, 8f, 4f));
			dictionary5.Add("Left", new Rect(16f, 0f, 4f, 12f));
			dictionary5.Add("Front", new Rect(20f, 0f, 8f, 12f));
			dictionary5.Add("Right", new Rect(28f, 0f, 4f, 12f));
			dictionary5.Add("Back", new Rect(32f, 0f, 8f, 12f));
			rectsPartsInSkin.Add("Body", dictionary5);
			Dictionary<string, Rect> dictionary6 = new Dictionary<string, Rect>();
			dictionary6.Add("Top", new Rect(44f, 12f, 4f, 4f));
			dictionary6.Add("Down", new Rect(48f, 12f, 4f, 4f));
			dictionary6.Add("Left", new Rect(40f, 0f, 4f, 12f));
			dictionary6.Add("Front", new Rect(44f, 0f, 4f, 12f));
			dictionary6.Add("Right", new Rect(48f, 0f, 4f, 12f));
			dictionary6.Add("Back", new Rect(52f, 0f, 4f, 12f));
			rectsPartsInSkin.Add("Arm_right", dictionary6);
			Dictionary<string, Rect> dictionary7 = new Dictionary<string, Rect>();
			dictionary7.Add("Top", new Rect(44f, 12f, 4f, 4f));
			dictionary7.Add("Down", new Rect(48f, 12f, 4f, 4f));
			dictionary7.Add("Left", new Rect(40f, 0f, 4f, 12f));
			dictionary7.Add("Front", new Rect(44f, 0f, 4f, 12f));
			dictionary7.Add("Right", new Rect(48f, 0f, 4f, 12f));
			dictionary7.Add("Back", new Rect(52f, 0f, 4f, 12f));
			rectsPartsInSkin.Add("Arm_left", dictionary7);
		}
	}

	public void UpdateTexturesPartsInDictionary()
	{
		texturesParts.Clear();
		foreach (KeyValuePair<string, Dictionary<string, Rect>> item in rectsPartsInSkin)
		{
			Dictionary<string, Texture2D> dictionary = new Dictionary<string, Texture2D>();
			foreach (KeyValuePair<string, Rect> item2 in rectsPartsInSkin[item.Key])
			{
				dictionary.Add(item2.Key, TextureFromRect(currentSkin, rectsPartsInSkin[item.Key][item2.Key]));
			}
			texturesParts.Add(item.Key, dictionary);
		}
	}

	public static Texture2D BuildSkin(Dictionary<string, Dictionary<string, Texture2D>> _texturesParts)
	{
		int width = currentSkin.width;
		int height = currentSkin.height;
		Texture2D texture2D = new Texture2D(width, height, TextureFormat.RGBA32, false);
		Color clear = Color.clear;
		for (int i = 0; i < height; i++)
		{
			for (int j = 0; j < width; j++)
			{
				texture2D.SetPixel(j, i, clear);
			}
		}
		foreach (KeyValuePair<string, Dictionary<string, Texture2D>> _texturesPart in _texturesParts)
		{
			foreach (KeyValuePair<string, Texture2D> item in _texturesParts[_texturesPart.Key])
			{
				texture2D.SetPixels(Mathf.RoundToInt(rectsPartsInSkin[_texturesPart.Key][item.Key].x), Mathf.RoundToInt(rectsPartsInSkin[_texturesPart.Key][item.Key].y), Mathf.RoundToInt(rectsPartsInSkin[_texturesPart.Key][item.Key].width), Mathf.RoundToInt(rectsPartsInSkin[_texturesPart.Key][item.Key].height), _texturesParts[_texturesPart.Key][item.Key].GetPixels());
			}
		}
		texture2D.filterMode = FilterMode.Point;
		texture2D.Apply();
		return texture2D;
	}

	public void SelectPart(string _partName)
	{
		if (!texturesParts.ContainsKey(_partName))
		{
			Debug.Log("texturesParts not contain key");
			return;
		}
		isEditingPartSkin = false;
		selectedPartName = _partName;
		topPart.SetActive(false);
		downPart.SetActive(false);
		leftPart.SetActive(false);
		frontPart.SetActive(false);
		rigthPart.SetActive(false);
		backPart.SetActive(false);
		int num = 22;
		foreach (KeyValuePair<string, Texture2D> item in texturesParts[_partName])
		{
			if (item.Key.Equals("Top"))
			{
				topPart.SetActive(true);
				topPart.GetComponent<BoxCollider>().size = new Vector3(item.Value.width * num, item.Value.height * num, 0f);
				topPart.transform.GetChild(0).GetComponent<UITexture>().width = item.Value.width * num;
				topPart.transform.GetChild(0).GetComponent<UITexture>().height = item.Value.height * num;
				topPart.transform.localPosition = new Vector3((float)(-item.Value.width) * 0.5f * (float)num, (float)(texturesParts[_partName]["Front"].height + item.Value.height) * 0.5f * (float)num, 0f);
				topPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture = EditorTextures.CreateCopyTexture(item.Value);
			}
			if (item.Key.Equals("Down"))
			{
				downPart.SetActive(true);
				downPart.GetComponent<BoxCollider>().size = new Vector3(item.Value.width * num, item.Value.height * num, 0f);
				downPart.transform.GetChild(0).GetComponent<UITexture>().width = item.Value.width * num;
				downPart.transform.GetChild(0).GetComponent<UITexture>().height = item.Value.height * num;
				downPart.transform.localPosition = new Vector3((float)(-item.Value.width) * 0.5f * (float)num, (float)(-(texturesParts[_partName]["Front"].height + item.Value.height)) * 0.5f * (float)num, 0f);
				downPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture = EditorTextures.CreateCopyTexture(item.Value);
			}
			if (item.Key.Equals("Left"))
			{
				leftPart.SetActive(true);
				leftPart.GetComponent<BoxCollider>().size = new Vector3(item.Value.width * num, item.Value.height * num, 0f);
				leftPart.transform.GetChild(0).GetComponent<UITexture>().width = item.Value.width * num;
				leftPart.transform.GetChild(0).GetComponent<UITexture>().height = item.Value.height * num;
				leftPart.transform.localPosition = new Vector3((0f - ((float)item.Value.width * 0.5f + (float)texturesParts[_partName]["Front"].width)) * (float)num, 0f, 0f);
				leftPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture = EditorTextures.CreateCopyTexture(item.Value);
			}
			if (item.Key.Equals("Front"))
			{
				frontPart.SetActive(true);
				frontPart.GetComponent<BoxCollider>().size = new Vector3(item.Value.width * num, item.Value.height * num, 0f);
				frontPart.transform.GetChild(0).GetComponent<UITexture>().width = item.Value.width * num;
				frontPart.transform.GetChild(0).GetComponent<UITexture>().height = item.Value.height * num;
				frontPart.transform.localPosition = new Vector3((0f - (float)item.Value.width * 0.5f) * (float)num, 0f, 0f);
				frontPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture = EditorTextures.CreateCopyTexture(item.Value);
			}
			if (item.Key.Equals("Right"))
			{
				rigthPart.SetActive(true);
				rigthPart.GetComponent<BoxCollider>().size = new Vector3(item.Value.width * num, item.Value.height * num, 0f);
				rigthPart.transform.GetChild(0).GetComponent<UITexture>().width = item.Value.width * num;
				rigthPart.transform.GetChild(0).GetComponent<UITexture>().height = item.Value.height * num;
				rigthPart.transform.localPosition = new Vector3((float)item.Value.width * 0.5f * (float)num, 0f, 0f);
				rigthPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture = EditorTextures.CreateCopyTexture(item.Value);
			}
			if (item.Key.Equals("Back"))
			{
				backPart.SetActive(true);
				backPart.GetComponent<BoxCollider>().size = new Vector3(item.Value.width * num, item.Value.height * num, 0f);
				backPart.transform.GetChild(0).GetComponent<UITexture>().width = item.Value.width * num;
				backPart.transform.GetChild(0).GetComponent<UITexture>().height = item.Value.height * num;
				backPart.transform.localPosition = new Vector3(((float)item.Value.width * 0.5f + (float)texturesParts[_partName]["Right"].width) * (float)num, 0f, 0f);
				backPart.transform.GetChild(0).GetComponent<UITexture>().mainTexture = EditorTextures.CreateCopyTexture(item.Value);
			}
		}
		partPreviewPanel.SetActive(true);
		skinPreviewPanel.SetActive(false);
	}

	private Texture2D TextureFromRect(Texture2D texForCut, Rect rectForCut)
	{
		Color[] pixels = texForCut.GetPixels((int)rectForCut.x, (int)rectForCut.y, (int)rectForCut.width, (int)rectForCut.height);
		Texture2D texture2D = new Texture2D((int)rectForCut.width, (int)rectForCut.height);
		texture2D.filterMode = FilterMode.Point;
		texture2D.SetPixels(pixels);
		texture2D.Apply();
		return texture2D;
	}

	private void ExitFromScene()
	{
		if (SkinEditorController.ExitFromSkinEditor != null)
		{
			SkinEditorController.ExitFromSkinEditor(newNameSkin);
			currentSkinName = null;
		}
		UnityEngine.Object.Destroy(base.gameObject);
		if (modeEditor != ModeEditor.LogoClan && ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.isShowRanks = true;
		}
	}

	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			Input.ResetInputAxes();
			HandleBackButtonClicked(this, EventArgs.Empty);
		}
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
