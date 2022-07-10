using UnityEngine;

public class HungerRandomBtn : MonoBehaviour
{
	private void OnClick()
	{
		if (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled)
		{
			ButtonClickSound.Instance.PlayClick();
			if (WeaponManager.sharedManager.myTable != null)
			{
				WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().RandomRoomClickBtnInHunger();
			}
		}
	}
}
