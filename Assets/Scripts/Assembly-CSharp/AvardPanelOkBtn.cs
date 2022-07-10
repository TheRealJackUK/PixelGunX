using UnityEngine;

internal sealed class AvardPanelOkBtn : MonoBehaviour
{
	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			OnClick();
			if (Application.isEditor)
			{
				Debug.Log("ESC AvardPanelOkBtn");
			}
			Input.ResetInputAxes();
		}
	}

	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.HideAvardPanel();
		}
	}
}
