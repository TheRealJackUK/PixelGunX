using UnityEngine;

public class LabelAddToFrieadsNote : MonoBehaviour
{
	private bool isBigPorog;

	private bool isBigPorogOld;

	private void Update()
	{
		isBigPorog = !Defs2.IsAvalibleAddFrends();
		if (isBigPorog != isBigPorogOld)
		{
			if (!isBigPorog)
			{
				GetComponent<UILabel>().text = Defs.smallPorogString;
			}
			else
			{
				GetComponent<UILabel>().text = Defs.bigPorogString;
			}
		}
		isBigPorogOld = isBigPorog;
	}
}
