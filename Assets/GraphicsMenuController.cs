using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rilisoft;
using Holoville.HOTween;
using I2.Loc;

public class GraphicsMenuController : MonoBehaviour {

	public ButtonHandler bloomBtn;
	public ButtonHandler aoBtn;
	public ButtonHandler cgBtn;
	public ButtonHandler mbBtn;
	public ButtonHandler quitBtn;

	public ButtonHandler mojanglesBtn;
	public ButtonHandler miniBtn;
	public ButtonHandler ponderosaBtn;
	public ButtonHandler unibodyBtn;

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
	}

	public void HandleBloom(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("bloom", false) == 1);
		Storager.setInt("bloom", (x==true?1:0), false);
		SwitchBtn(x, bloomBtn);
	}

	public void HandleAO(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("ao", false) == 1);
		Storager.setInt("ao", (x==true?1:0), false);
		SwitchBtn(x, aoBtn);
	}

	public void HandleCG(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("cg", false) == 1);
		Storager.setInt("cg", (x==true?1:0), false);
		SwitchBtn(x, cgBtn);
	}

	public void HandleMB(object sender, System.EventArgs e){
		bool x = !(Storager.getInt("mb", false) == 1);
		Storager.setInt("mb", (x==true?1:0), false);
		SwitchBtn(x, mbBtn);
	}

	public void HandleQuit(object sender, System.EventArgs e){
		Application.LoadLevel(Defs.MainMenuScene);
	}

	public void HandleMojangles(object sender, System.EventArgs e){
		PlayerPrefs.SetString("currentfont", "minecraft");
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
		SwitchBtn(true, mojanglesBtn);
		SwitchBtn(false, miniBtn);
		SwitchBtn(false, ponderosaBtn);
		SwitchBtn(false, unibodyBtn);
	}

	public void HandleMini(object sender, System.EventArgs e){
		PlayerPrefs.SetString("currentfont", "MINI");
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
		SwitchBtn(false, mojanglesBtn);
		SwitchBtn(true, miniBtn);
		SwitchBtn(false, ponderosaBtn);
		SwitchBtn(false, unibodyBtn);
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
	}

	void Start () {
		SwitchBtn(Storager.getInt("bloom", false) == 1, bloomBtn);
		SwitchBtn(Storager.getInt("ao", false) == 1, aoBtn);
		SwitchBtn(Storager.getInt("cg", false) == 1, cgBtn);
		SwitchBtn(Storager.getInt("mb", false) == 1, mbBtn);
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "minecraft", mojanglesBtn);
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "MINI", miniBtn);
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "Ponderosa", ponderosaBtn);
		SwitchBtn(PlayerPrefs.GetString("currentfont") == "Unibody", unibodyBtn);
		Resources.Load<LanguageSource>("I2Languages").UpdateTheFont();
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
	}
}
