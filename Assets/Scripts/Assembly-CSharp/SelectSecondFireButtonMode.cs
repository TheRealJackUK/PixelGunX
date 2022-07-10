using System;
using Rilisoft;
using UnityEngine;

public class SelectSecondFireButtonMode : MonoBehaviour
{
	public UIToggle sniperModeButton;

	public UIToggle onModeButton;

	public UIToggle offSniperModeButton;

	private void Start()
	{
		sniperModeButton.gameObject.GetComponent<ButtonHandler>().Clicked += HandleSniperClicked;
		onModeButton.gameObject.GetComponent<ButtonHandler>().Clicked += HandleOnClicked;
		offSniperModeButton.gameObject.GetComponent<ButtonHandler>().Clicked += HandleOffClicked;
		sniperModeButton.value = Defs.gameSecondFireButtonMode == Defs.GameSecondFireButtonMode.Sniper;
		onModeButton.value = Defs.gameSecondFireButtonMode == Defs.GameSecondFireButtonMode.On;
		offSniperModeButton.value = Defs.gameSecondFireButtonMode == Defs.GameSecondFireButtonMode.Off;
	}

	private void HandleSniperClicked(object sender, EventArgs e)
	{
		Defs.gameSecondFireButtonMode = Defs.GameSecondFireButtonMode.Sniper;
		PlayerPrefs.SetInt("GameSecondFireButtonMode", (int)Defs.gameSecondFireButtonMode);
	}

	private void HandleOnClicked(object sender, EventArgs e)
	{
		Defs.gameSecondFireButtonMode = Defs.GameSecondFireButtonMode.On;
		PlayerPrefs.SetInt("GameSecondFireButtonMode", (int)Defs.gameSecondFireButtonMode);
	}

	private void HandleOffClicked(object sender, EventArgs e)
	{
		Defs.gameSecondFireButtonMode = Defs.GameSecondFireButtonMode.Off;
		PlayerPrefs.SetInt("GameSecondFireButtonMode", (int)Defs.gameSecondFireButtonMode);
	}
}
