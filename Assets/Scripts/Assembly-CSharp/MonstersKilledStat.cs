using UnityEngine;

public class MonstersKilledStat : MonoBehaviour
{
	private void Start()
	{
		GetComponent<UILabel>().text = string.Empty + PlayerPrefs.GetInt(Defs.KilledZombiesSett, 0);
	}
}
