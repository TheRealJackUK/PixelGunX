using UnityEngine;

public class BestScoresStat : MonoBehaviour
{
	private void Start()
	{
		GetComponent<UILabel>().text = PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0).ToString();
	}
}
