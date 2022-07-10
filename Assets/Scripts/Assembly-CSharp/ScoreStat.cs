using UnityEngine;

public class ScoreStat : MonoBehaviour
{
	private void Start()
	{
		GetComponent<UILabel>().text = string.Empty + GlobalGameController.Score;
	}
}
