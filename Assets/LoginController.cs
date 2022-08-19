using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rilisoft;

public class LoginController : MonoBehaviour {

	public ButtonHandler login;
	public ButtonHandler signup;
	public UILabel captcha;
	public UIInput captchaInput;

	public void HandleLogin(object sender, System.EventArgs e){

	}

	public void HandleSignup(object sender, System.EventArgs e){
		string captchaText = captcha.text;
		string input = captchaInput.value;
		CreateNewCaptcha();
	}

	public void CreateNewCaptcha(){
		captcha.text = Random.Range(1, 20).ToString() + " * " + Random.Range(1, 20).ToString();
	}

	public void Start() {
		CreateNewCaptcha();
		if (login != null)
		{
			login.Clicked += HandleLogin;
		}
		if (signup != null)
		{
			signup.Clicked += HandleSignup;
		}
	}

}
