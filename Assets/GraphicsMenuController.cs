using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rilisoft;

public class GraphicsMenuController : MonoBehaviour {

	public ButtonHandler bloomBtn;
	public ButtonHandler aoBtn;
	public ButtonHandler cgBtn;
	public ButtonHandler mbBtn;
	public ButtonHandler quitBtn;

	public void SwitchBtn(bool on, ButtonHandler btn) {
		if (on){
			btn.gameObject.transform.localPosition = new Vector3(12, 0, 0);
			btn.gameObject.GetComponent<UISprite>().color = new Color(0, 1, 0, 1);
			btn.gameObject.GetComponent<UIButton>().defaultColor = new Color(0, 1, 0, 1);
			btn.gameObject.GetComponent<UIButton>().hover = new Color(0, 0.9f, 0, 1);
			btn.gameObject.GetComponent<UIButton>().pressed = new Color(0, 0.7f, 0, 1);
		}else{
			btn.gameObject.transform.localPosition = new Vector3(-12, 0, 0);
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

	void Start () {
		SwitchBtn(Storager.getInt("bloom", false) == 1, bloomBtn);
		SwitchBtn(Storager.getInt("ao", false) == 1, aoBtn);
		SwitchBtn(Storager.getInt("cg", false) == 1, cgBtn);
		SwitchBtn(Storager.getInt("mb", false) == 1, mbBtn);
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
	}
}
