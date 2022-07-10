using System;
using UnityEngine;

internal sealed class PauseONGuiDrawer : MonoBehaviour
{
	public Action act;

	private void OnGUI()
	{
		if (act != null)
		{
			act();
		}
	}
}
