using System;
using Rilisoft;
using UnityEngine;

public sealed class SettingsToggleButtons : MonoBehaviour
{
	public UIButton offButton;

	public UIButton onButton;

	private bool _isChecked;

	public bool IsChecked
	{
		get
		{
			return _isChecked;
		}
		set
		{
			_isChecked = value;
			offButton.isEnabled = _isChecked;
			onButton.isEnabled = !_isChecked;
			EventHandler<ToggleButtonEventArgs> clicked = this.Clicked;
			if (clicked != null)
			{
				clicked(this, new ToggleButtonEventArgs
				{
					IsChecked = _isChecked
				});
			}
		}
	}

	public event EventHandler<ToggleButtonEventArgs> Clicked;

	private void Start()
	{
		onButton.GetComponent<ButtonHandler>().Clicked += delegate
		{
			IsChecked = true;
		};
		offButton.GetComponent<ButtonHandler>().Clicked += delegate
		{
			IsChecked = false;
		};
	}
}
