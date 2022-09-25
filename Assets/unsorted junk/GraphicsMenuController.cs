using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rilisoft;
using Holoville.HOTween;
using I2.Loc;
using System;

public class GraphicsMenuController : MonoBehaviour {

	public ButtonHandler bloomBtn;
	public ButtonHandler aoBtn;
	public ButtonHandler cgBtn;
	public ButtonHandler mbBtn;
	public ButtonHandler quitBtn;

	public UILabel fovLabel;
	public UISlider fovSlider;

	public ButtonHandler mojanglesBtn;
	public ButtonHandler miniBtn;
	public ButtonHandler ponderosaBtn;
	public ButtonHandler unibodyBtn;

	public ButtonHandler offGuiBtn;

	public ButtonHandler secretBtn;

	public ButtonHandler potatoBtn;
	public ButtonHandler veryLowBtn;
	public ButtonHandler lowBtn;
	public ButtonHandler standardBtn;
	public ButtonHandler highBtn;
	public ButtonHandler ultraBtn;

	public ButtonHandler crosshairBtn;

	public void SwitchBtn(bool on, ButtonHandler btn) {
		HOTween.Init(true, true, true);
		if (on){
			//btn.gameObject.transform.localPosition = new Vector3(12, 0, 0);
			HOTween.To(btn.gameObject.transform, 0.3f, "localPosition", new Vector3(12, 0, 0));
			btn.gameObject.GetComponent<UISprite>().color = new Color(0, 1, 0, 1);
			btn.gameObject.GetComponent<UIButton>().defaultColor = new Color(0, 1, 0, 1);
			btn.gameObject.GetComponent<UIButton>().hover = new Color(0, 0.9f, 0, 1);
			btn.gameObject.GetComponent<UIButton>().pressed = new Color(0, 0.7f, 0, 1);
		}else{
			//btn.gameObject.transform.localPosition = new Vector3(-12, 0, 0);
			HOTween.To(btn.gameObject.transform, 0.3f, "localPosition", new Vector3(-12, 0, 0));
			btn.gameObject.GetComponent<UISprite>().color = new Color(1, 0, 0, 1);
			btn.gameObject.GetComponent<UIButton>().defaultColor = new Color(1, 0, 0, 1);
			btn.gameObject.GetComponent<UIButton>().hover = new Color(0.9f, 0, 0, 1);
			btn.gameObject.GetComponent<UIButton>().pressed = new Color(0.7f, 0, 0, 1);
		}
		PlayerPrefs.Save();
	}

	public void HandleBloom(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("bloom", false) == 1);
		Storager.setInt("bloom", (x==true?1:0), false);
		SwitchBtn(x, bloomBtn);
		PlayerPrefs.Save();
	}

	public void HandleAO(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("ao", false) == 1);
		Storager.setInt("ao", (x==true?1:0), false);
		SwitchBtn(x, aoBtn);
		PlayerPrefs.Save();
	}

	public void HandleCrosshair(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("crosshair", false) == 1);
		Storager.setInt("crosshair", (x==true?1:0), false);
		SwitchBtn(x, crosshairBtn);
		PlayerPrefs.Save();
	}

	public void HandleCG(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("cg", false) == 1);
		Storager.setInt("cg", (x==true?1:0), false);
		SwitchBtn(x, cgBtn);
		PlayerPrefs.Save();
	}

	public void HandleMB(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("mb", false) == 1);
		Storager.setInt("mb", (x==true?1:0), false);
		SwitchBtn(x, mbBtn);
		PlayerPrefs.Save();
	}

	public void HandleOffGui(object sender, System.EventArgs e){
		bool x = !(Storager.getInt(Defs.GameGUIOffMode, false) == 1);
		Storager.setInt(Defs.GameGUIOffMode, (x==true?1:0), false);
		SwitchBtn(x, offGuiBtn);
		PlayerPrefs.Save();
	}

	public void HandleQuit(object sender, System.EventArgs e){
		Application.LoadLevel(Defs.MainMenuScene);
		PlayerPrefs.Save();
	}

	public void HandleSecret(object sender, System.EventArgs e){
		Application.LoadLevel("EasterEgg");
		PlayerPrefs.Save();
	}

	public void HandleMojangles(object sender, System.EventArgs e){
		PlayerPrefs.SetString("currentfont", "minecraft");
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
		SwitchBtn(true, mojanglesBtn);
		SwitchBtn(false, miniBtn);
		SwitchBtn(false, ponderosaBtn);
		SwitchBtn(false, unibodyBtn);
		PlayerPrefs.Save();
	}

	public void HandleMini(object sender, System.EventArgs e){
		PlayerPrefs.SetString("currentfont", "MINI");
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
		SwitchBtn(false, mojanglesBtn);
		SwitchBtn(true, miniBtn);
		SwitchBtn(false, ponderosaBtn);
		SwitchBtn(false, unibodyBtn);
		PlayerPrefs.Save();
	}

	public void HandlePonderosa(object sender, System.EventArgs e){
		PlayerPrefs.SetString("currentfont", "Ponderosa");
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
		foreach (UILabel lbl in GameObject.FindObjectsOfType<UILabel>()){
			if (lbl.GetComponent<Localize>()) {
				lbl.GetComponent<Localize>().Awake();
			}
		}
		SwitchBtn(false, mojanglesBtn);
		SwitchBtn(false, miniBtn);
		SwitchBtn(true, ponderosaBtn);
		SwitchBtn(false, unibodyBtn);
		PlayerPrefs.Save();
	}

	public void HandleUnibody(object sender, System.EventArgs e){
		PlayerPrefs.SetString("currentfont", "Unibody");
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
		foreach (UILabel lbl in GameObject.FindObjectsOfType<UILabel>()){
			if (lbl.GetComponent<Localize>()) {
				lbl.GetComponent<Localize>().Awake();
			}
		}
		SwitchBtn(false, mojanglesBtn);
		SwitchBtn(false, miniBtn);
		SwitchBtn(false, ponderosaBtn);
		SwitchBtn(true, unibodyBtn);
		PlayerPrefs.Save();
	}

	public void HandleGraphicBtn(object sender, System.EventArgs e){
		string var1 = (sender as ButtonHandler).transform.parent.parent.gameObject.name;
		var1 = var1.Replace("Btn", "");
		SwitchBtn(false, potatoBtn);
		SwitchBtn(false, veryLowBtn);
		SwitchBtn(false, lowBtn);
		SwitchBtn(false, standardBtn);
		SwitchBtn(false, highBtn);
		SwitchBtn(false, ultraBtn);
		for (int i = 0; i < QualitySettings.names.Length; i++) {
			if (var1 == QualitySettings.names[i]) {
				SwitchBtn(true, (sender as ButtonHandler));
				Storager.setInt("graphicSetting", i);
				QualitySettings.SetQualityLevel(i);
			}
		}
	}

	public void fovchanged() {
		int currentFOV = Storager.getInt("camerafov", false);
		int num = 130;
		int num2 = Mathf.Clamp(Convert.ToInt32(fovSlider.value * (float)num), 0, num);
		float fovPercentage = (float)num2 / (float)num;
		fovLabel.text = "FOV: " + num2 + '/' + num;
		// view.FOVPercentage = fovPercentage;
		Storager.setInt("camerafov", num2, false);
		PlayerPrefs.Save();
	}

	public bool IsGraphicSetting(string var1) {
		for (int i = 0; i < QualitySettings.names.Length; i++) {
			if (var1 == QualitySettings.names[QualitySettings.GetQualityLevel()]) {
				return true;
			}
		}
		return false;
	}

	void Start () {
		SwitchBtn(Storager.getInt("bloom", false) == 1, bloomBtn);
		SwitchBtn(Storager.getInt("ao", false) == 1, aoBtn);
		SwitchBtn(Storager.getInt("cg", false) == 1, cgBtn);
		SwitchBtn(Storager.getInt("mb", false) == 1, mbBtn);
		//
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "minecraft", mojanglesBtn);
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "MINI", miniBtn);
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "Ponderosa", ponderosaBtn);
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "Unibody", unibodyBtn);
		//
		SwitchBtn(IsGraphicSetting("Potato"), potatoBtn);
		SwitchBtn(IsGraphicSetting("Very Low"), veryLowBtn);
		SwitchBtn(IsGraphicSetting("Low"), lowBtn);
		SwitchBtn(IsGraphicSetting("Standard"), standardBtn);
		SwitchBtn(IsGraphicSetting("High"), highBtn);
		SwitchBtn(IsGraphicSetting("Ultra"), ultraBtn);
		//
		SwitchBtn(PlayerPrefs.GetInt(Defs.GameGUIOffMode) == 1, offGuiBtn);
		//
		SwitchBtn(Storager.getInt("crosshair", false) == 1, crosshairBtn);
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
		int currentFOV = Storager.getInt("camerafov", false);
		int num = 179;
		int num2 = Mathf.Clamp(Convert.ToInt32(currentFOV * (float)num), 0, num);
		float fovPercentage = (float)currentFOV / (float)num;
		fovLabel.text = "FOV: " + currentFOV + '/' + num;
		fovSlider.value = fovPercentage;
		if (bloomBtn != null)
		{
			bloomBtn.Clicked += HandleBloom;
		}
		if (aoBtn != null)
		{
			aoBtn.Clicked += HandleAO;
		}
		if (cgBtn != null)
		{
			cgBtn.Clicked += HandleCG;
		}
		if (mbBtn != null)
		{
			mbBtn.Clicked += HandleMB;
		}
		if (quitBtn != null)
		{
			quitBtn.Clicked += HandleQuit;
		}
		if (mojanglesBtn != null)
		{
			mojanglesBtn.Clicked += HandleMojangles;
		}
		if (miniBtn != null)
		{
			miniBtn.Clicked += HandleMini;
		}
		if (ponderosaBtn != null)
		{
			ponderosaBtn.Clicked += HandlePonderosa;
		}
		if (unibodyBtn != null)
		{
			unibodyBtn.Clicked += HandleUnibody;
		}
		if (offGuiBtn != null)
		{
			offGuiBtn.Clicked += HandleOffGui;
		}
		if (secretBtn != null)
		{
			secretBtn.Clicked += HandleSecret;
		}
		if (potatoBtn != null)
		{
			potatoBtn.Clicked += HandleGraphicBtn;
		}
		if (veryLowBtn != null)
		{
			veryLowBtn.Clicked += HandleGraphicBtn;
		}
		if (lowBtn != null)
		{
			lowBtn.Clicked += HandleGraphicBtn;
		}
		if (standardBtn != null)
		{
			standardBtn.Clicked += HandleGraphicBtn;
		}
		if (highBtn != null)
		{
			highBtn.Clicked += HandleGraphicBtn;
		}
		if (ultraBtn != null)
		{
			ultraBtn.Clicked += HandleGraphicBtn;
		}
		if (crosshairBtn != null) {
			crosshairBtn.Clicked += HandleCrosshair;
		}
	}
}
