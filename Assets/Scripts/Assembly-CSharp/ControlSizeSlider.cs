using System;
using UnityEngine;

internal sealed class ControlSizeSlider : MonoBehaviour
{
	public class EnabledChangedEventArgs : EventArgs
	{
		public bool Enabled { get; set; }
	}

	public UISlider slider;

	public event EventHandler<EnabledChangedEventArgs> EnabledChanged;

	private void OnEnable()
	{
		EventHandler<EnabledChangedEventArgs> enabledChanged = this.EnabledChanged;
		if (enabledChanged != null)
		{
			enabledChanged(slider, new EnabledChangedEventArgs
			{
				Enabled = true
			});
		}
	}

	private void OnDisable()
	{
		EventHandler<EnabledChangedEventArgs> enabledChanged = this.EnabledChanged;
		if (enabledChanged != null)
		{
			enabledChanged(slider, new EnabledChangedEventArgs
			{
				Enabled = false
			});
		}
	}
}
