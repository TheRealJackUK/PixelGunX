using UnityEngine;

public class ScoreTableLabel : MonoBehaviour
{
	private void Start()
	{
		if (Defs.isCOOP)
		{
			GetComponent<UILabel>().text = LocalizationStore.Get("Key_0190");
		}
		else if (Defs.isFlag)
		{
			GetComponent<UILabel>().text = LocalizationStore.Get("Key_1006");
		}
		else
		{
			GetComponent<UILabel>().text = LocalizationStore.Get("Key_0191");
		}
	}

	private void Update()
	{
	}
}
