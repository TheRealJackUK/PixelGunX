using UnityEngine;

public class SpectorModeOnOffBtn : MonoBehaviour
{
	public bool isOnBtn;

	private void OnClick()
	{
		if (ShopNGUIController.GuiActive || ExperienceController.sharedController.isShowNextPlashka)
		{
			return;
		}
		ButtonClickSound.Instance.PlayClick();
		if (!isOnBtn)
		{
			if (NetworkStartTableNGUIController.sharedController != null)
			{
				NetworkStartTableNGUIController.sharedController.StartSpectatorMode();
			}
		}
		else if (NetworkStartTableNGUIController.sharedController != null)
		{
			NetworkStartTableNGUIController.sharedController.EndSpectatorMode();
		}
	}
}
