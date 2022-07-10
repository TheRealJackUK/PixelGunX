using UnityEngine;

public class StartHeadUp : MonoBehaviour
{
	private void Start()
	{
		if (!Defs.isInet || (Defs.isInet && PhotonNetwork.room != null && !PhotonNetwork.room.customProperties["pass"].Equals(string.Empty)))
		{
			GetComponent<UILabel>().text = LocalizationStore.Key_0560;
		}
		else if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			GetComponent<UILabel>().text = LocalizationStore.Key_0561;
		}
		else if (Defs.isCOOP)
		{
			GetComponent<UILabel>().text = LocalizationStore.Key_0562;
		}
		else
		{
			GetComponent<UILabel>().text = LocalizationStore.Key_0563;
		}
	}

	private void Update()
	{
	}
}
