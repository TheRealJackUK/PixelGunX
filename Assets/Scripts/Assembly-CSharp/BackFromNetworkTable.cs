using UnityEngine;

public sealed class BackFromNetworkTable : MonoBehaviour
{
	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			OnClick();
			if (Application.isEditor)
			{
				Debug.Log("ESC BackFromNetworkTable");
			}
			Input.ResetInputAxes();
		}
	}

	private void OnClick()
	{
		if ((!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled) && (!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !LoadingInAfterGame.isShowLoading && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			ButtonClickSound.Instance.PlayClick();
			if (WeaponManager.sharedManager.myTable != null)
			{
				WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().BackButtonPress();
			}
		}
	}
}
