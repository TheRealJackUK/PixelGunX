using UnityEngine;

public class LabePlaterNameInSpectatorMode : MonoBehaviour
{
	private UILabel label;

	public UILabel clanNameLabel;

	public UITexture clanTexture;

	private void Start()
	{
		label = GetComponent<UILabel>();
	}

	private void Update()
	{
		if (label != null && WeaponManager.sharedManager.myTable != null)
		{
			label.text = WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().playerVidosNick;
			clanNameLabel.text = WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().playerVidosClanName;
			clanTexture.mainTexture = WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().playerVidosClanTexture;
		}
	}
}
