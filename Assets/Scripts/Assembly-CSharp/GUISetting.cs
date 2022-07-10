using UnityEngine;

public sealed class GUISetting : MonoBehaviour
{
	public GUIStyle back;

	public GUIStyle soundOnOff;

	public GUIStyle restore;

	public GUIStyle sliderStyle;

	public GUIStyle thumbStyle;

	public Texture settingPlashka;

	public Texture settingTitle;

	public Texture fon;

	public Texture slow_fast;

	public Texture polzunok;

	private GameObject _purchaseActivityIndicator;

	private float mySens;

	private void Start()
	{
		_purchaseActivityIndicator = StoreKitEventListener.purchaseActivityInd;
		if (_purchaseActivityIndicator == null)
		{
			Debug.LogWarning("_purchaseActivityIndicator == null");
		}
	}

	private void Update()
	{
		if (_purchaseActivityIndicator != null)
		{
			_purchaseActivityIndicator.SetActive(StoreKitEventListener.purchaseInProcess);
		}
	}

	private void OnGUI()
	{
		GUI.depth = 2;
		float num = (float)Screen.height / 768f;
		GUI.DrawTexture(new Rect((float)Screen.width / 2f - 683f * num, 0f, 1366f * num, Screen.height), fon);
		GUI.DrawTexture(new Rect((float)Screen.width / 2f - (float)settingPlashka.width * num * 0.5f, (float)Screen.height * 0.52f - (float)settingPlashka.height * num * 0.5f, (float)settingPlashka.width * num, (float)settingPlashka.height * num), settingPlashka);
		GUI.DrawTexture(new Rect((float)Screen.width / 2f - (float)settingTitle.width / 2f * Defs.Coef, (float)Screen.height * 0.08f, (float)settingTitle.width * Defs.Coef, (float)settingTitle.height * Defs.Coef), settingTitle);
		Rect position = new Rect((float)Screen.width * 0.5f - (float)soundOnOff.normal.background.width * 0.5f * num, (float)Screen.height * 0.52f - (float)soundOnOff.normal.background.height * 0.5f * num, (float)soundOnOff.normal.background.width * num, (float)soundOnOff.normal.background.height * num);
		bool @bool = PlayerPrefsX.GetBool(PlayerPrefsX.SndSetting, true);
		@bool = GUI.Toggle(position, @bool, string.Empty, soundOnOff);
		AudioListener.volume = (@bool ? 1 : 0);
		PlayerPrefsX.SetBool(PlayerPrefsX.SndSetting, @bool);
		PlayerPrefs.Save();
		Rect position2 = new Rect((float)Screen.width * 0.5f - (float)soundOnOff.normal.background.width * 0.5f * num, (float)Screen.height * 0.72f - (float)soundOnOff.normal.background.height * 0.5f * num, (float)soundOnOff.normal.background.width * num, (float)soundOnOff.normal.background.height * num);
		bool isChatOn = Defs.IsChatOn;
		isChatOn = (Defs.IsChatOn = GUI.Toggle(position2, isChatOn, string.Empty, soundOnOff));
		PlayerPrefs.Save();
		if (GUI.Button(new Rect(21f * num, (float)Screen.height - (21f + (float)back.normal.background.height) * num, (float)back.normal.background.width * num, (float)back.normal.background.height * num), string.Empty, back))
		{
			FlurryPluginWrapper.LogEvent("Back to Main Menu");
			Application.LoadLevel(Defs.MainMenuScene);
		}
		GUI.enabled = !StoreKitEventListener.purchaseInProcess;
		Rect position3 = new Rect((float)Screen.width / 2f - (float)restore.normal.background.width * num * 0.5f, (float)Screen.height - (21f + (float)restore.normal.background.height) * num, (float)restore.normal.background.width * num, (float)restore.normal.background.height * num);
		if (GUI.Button(position3, string.Empty, restore))
		{
			StoreKitEventListener.purchaseInProcess = true;
		}
		GUI.enabled = true;
		sliderStyle.fixedWidth = (float)slow_fast.width * num;
		sliderStyle.fixedHeight = (float)slow_fast.height * num;
		thumbStyle.fixedWidth = (float)polzunok.width * num;
		thumbStyle.fixedHeight = (float)polzunok.height * num;
		Rect position4 = new Rect((float)Screen.width * 0.5f - (float)slow_fast.width * 0.5f * num, (float)Screen.height * 0.81f - (float)slow_fast.height * 0.5f * num, (float)slow_fast.width * num, (float)slow_fast.height * num);
		mySens = GUI.HorizontalSlider(position4, Defs.Sensitivity, 6f, 18f, sliderStyle, thumbStyle);
		Defs.Sensitivity = mySens;
	}

	private void OnDestroy()
	{
		if (_purchaseActivityIndicator != null)
		{
			_purchaseActivityIndicator.SetActive(false);
		}
	}
}
