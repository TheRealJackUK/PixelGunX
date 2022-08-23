using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rilisoft;
using System;

public class FallbackMenuController : MonoBehaviour {

	public UIButton clearBtn;
	public UIButton incLvlBtn;
	public UIButton decLvlBtn;
	public UIButton restartBtn;
	public UILabel lvlLbl;

	void SetLevel(int lvl){
		Storager.setInt("currentLevel" + lvl, 1, true);
		PlayerPrefs.SetInt("currentLevel", lvl);
		// ExperienceController.sharedController.Refresh();
		lvlLbl.text = "Current level: " + lvl;
	}

	void HandleClear(object sender, EventArgs e){
		PlayerPrefs.DeleteAll();
		Application.Quit();
	}

	void HandleRestart(object sender, EventArgs e){
		Application.LoadLevel("AppCenter");
	}

	void HandleIncLvl(object sender, EventArgs e){
		int lvl = PlayerPrefs.GetInt("currentLevel");
		SetLevel(lvl+1);
	}

	void HandleDecLvl(object sender, EventArgs e){
		int lvl = PlayerPrefs.GetInt("currentLevel");
		PlayerPrefs.DeleteKey("currentLevel"+lvl);
		SetLevel(lvl-1);
	}

	public static GameObject[] GetDontDestroyOnLoadObjects()
	{
		GameObject temp = null;
		try
		{
			temp = new GameObject();
			UnityEngine.Object.DontDestroyOnLoad( temp );
			UnityEngine.SceneManagement.Scene dontDestroyOnLoad = temp.scene;
			UnityEngine.Object.DestroyImmediate( temp );
			temp = null;
			return dontDestroyOnLoad.GetRootGameObjects();
		}
		finally
		{
			if( temp != null )
				UnityEngine.Object.DestroyImmediate( temp );
		}
	}

	void Start () {
		ButtonHandler bh1 = clearBtn.GetComponent<ButtonHandler>();
		if (bh1 != null)
		{
			bh1.Clicked += HandleClear;
		}
		ButtonHandler bh2 = incLvlBtn.GetComponent<ButtonHandler>();
		if (bh2 != null)
		{
			bh2.Clicked += HandleIncLvl;
		}
		ButtonHandler bh3 = decLvlBtn.GetComponent<ButtonHandler>();
		if (bh3 != null)
		{
			bh3.Clicked += HandleDecLvl;
		}
		ButtonHandler bh4 = restartBtn.GetComponent<ButtonHandler>();
		if (bh4 != null)
		{
			bh4.Clicked += HandleRestart;
		}
		int lvl = PlayerPrefs.GetInt("currentLevel");
		lvlLbl.text = "Current level: " + lvl;
		foreach (GameObject gobj in GetDontDestroyOnLoadObjects()){
			UnityEngine.Object.Destroy(gobj);
		}
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
