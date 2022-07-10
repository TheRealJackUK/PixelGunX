using UnityEngine;

public class NetworkStartTableStartPlashka : MonoBehaviour
{
	public GameObject plashka;

	private void Start()
	{
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			base.gameObject.SetActive(false);
			plashka.SetActive(false);
		}
		else if (Defs.isCOOP)
		{
			GetComponent<UILabel>().text = LocalizationStore.Key_0555;
		}
		else if (Defs.isHunger)
		{
			GetComponent<UILabel>().text = LocalizationStore.Key_0556;
		}
		else
		{
			GetComponent<UILabel>().text = LocalizationStore.Key_0557;
		}
	}

	private void Update()
	{
	}
}
