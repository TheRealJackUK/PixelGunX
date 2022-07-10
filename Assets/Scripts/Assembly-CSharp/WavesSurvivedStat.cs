using UnityEngine;

public class WavesSurvivedStat : MonoBehaviour
{
	private void Start()
	{
		GetComponent<UILabel>().text = string.Empty + PlayerPrefs.GetInt(Defs.WavesSurvivedS, 0);
	}
}
