using UnityEngine;

public class BlueRedButtonController : MonoBehaviour
{
	public UIButton blueButton;

	public UIButton redButton;

	public bool isBlueAvalible = true;

	public bool isRedAvalible = true;

	private void Start()
	{
		if (!Defs.isFlag && !Defs.isCompany && !Defs.isCapturePoints)
		{
			base.enabled = false;
		}
	}

	private void Update()
	{
		int num = 0;
		int num2 = 0;
		GameObject[] array = GameObject.FindGameObjectsWithTag("NetworkTable");
		foreach (GameObject gameObject in array)
		{
			if (gameObject.GetComponent<NetworkStartTable>().myCommand == 1)
			{
				num++;
			}
			if (gameObject.GetComponent<NetworkStartTable>().myCommand == 2)
			{
				num2++;
			}
		}
		isBlueAvalible = true;
		isRedAvalible = true;
		if (PhotonNetwork.room != null && (num >= PhotonNetwork.room.maxPlayers / 2 || num - num2 > 1))
		{
			isBlueAvalible = false;
		}
		if (PhotonNetwork.room != null && (num2 >= PhotonNetwork.room.maxPlayers / 2 || num2 - num > 1))
		{
			isRedAvalible = false;
		}
		if (isBlueAvalible != blueButton.isEnabled)
		{
			blueButton.isEnabled = isBlueAvalible;
		}
		if (isRedAvalible != redButton.isEnabled)
		{
			redButton.isEnabled = isRedAvalible;
		}
	}
}
