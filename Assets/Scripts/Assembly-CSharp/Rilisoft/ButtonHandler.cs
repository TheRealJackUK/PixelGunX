using System;
using UnityEngine;

namespace Rilisoft
{
	public sealed class ButtonHandler : MonoBehaviour
	{
		public bool noSound;

		public event EventHandler Clicked;

		private void OnClick()
		{
			if (ButtonClickSound.Instance != null && !noSound)
			{
				ButtonClickSound.Instance.PlayClick();
			}
			EventHandler clicked = this.Clicked;
			if (clicked != null)
			{
				clicked(this, EventArgs.Empty);
			}
		}

		public void DoClick()
		{
			OnClick();
		}
	}
}
