using System;
using Rilisoft;
using UnityEngine;

internal sealed class NicknameInput : MonoBehaviour
{
	private const string PlayerNameKey = "NamePlayer";

	public UIInput input;

	private UIButton _okButton;

	private void HandleOkClicked(object sender, EventArgs e)
	{
		if (ButtonClickSound.Instance != null)
		{
			ButtonClickSound.Instance.PlayClick();
		}
		PlayerPrefs.SetString("NicknameRequested", "1");
		if (input != null)
		{
			if (input.value != null)
			{
				string text = input.value.Trim();
				string value = ((!string.IsNullOrEmpty(text)) ? text : "Unnamed");
				PlayerPrefs.SetString("NamePlayer", value);
				input.value = value;
			}
			if (_okButton != null)
			{
				_okButton.isEnabled = false;
			}
		}
		Application.LoadLevel(Defs.MainMenuScene);
	}

	private void Start()
	{
		ButtonHandler componentInChildren = base.gameObject.GetComponentInChildren<ButtonHandler>();
		if (componentInChildren != null)
		{
			componentInChildren.Clicked += HandleOkClicked;
			_okButton = componentInChildren.GetComponent<UIButton>();
		}
		if (ExperienceController.sharedController != null && ExpController.Instance != null)
		{
			ExperienceController.sharedController.isShowRanks = false;
			ExpController.Instance.InterfaceEnabled = false;
		}
		if (input != null)
		{
			string playerNameOrDefault = Defs.GetPlayerNameOrDefault();
			input.value = playerNameOrDefault;
		}
	}
}
