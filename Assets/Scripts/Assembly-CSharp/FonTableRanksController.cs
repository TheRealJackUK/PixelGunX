using UnityEngine;

public class FonTableRanksController : MonoBehaviour
{
	public GameObject scoreHead;

	public GameObject countKillsHead;

	private void Start()
	{
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture)
		{
			float x = countKillsHead.transform.position.x;
			countKillsHead.transform.position = new Vector3(scoreHead.transform.position.x, countKillsHead.transform.position.y, countKillsHead.transform.position.z);
			scoreHead.transform.position = new Vector3(x, scoreHead.transform.position.y, scoreHead.transform.position.z);
			countKillsHead.GetComponent<UILabel>().text = LocalizationStore.Get("Key_1006");
		}
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TimeBattle)
		{
			scoreHead.transform.position = new Vector3(countKillsHead.transform.position.x, scoreHead.transform.position.y, scoreHead.transform.position.z);
			countKillsHead.SetActive(false);
		}
	}
}
