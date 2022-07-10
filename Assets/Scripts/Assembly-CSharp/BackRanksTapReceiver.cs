using UnityEngine;

public sealed class BackRanksTapReceiver : MonoBehaviour
{
	public NetworkStartTableNGUIController networkStartTableNGUIController;

	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			OnClick();
			if (Application.isEditor)
			{
				Debug.Log("ESC BackRanksTapReceiver");
			}
			Input.ResetInputAxes();
		}
	}

	private void OnClick()
	{
		networkStartTableNGUIController.BackPressFromRanksTable(true);
	}
}
