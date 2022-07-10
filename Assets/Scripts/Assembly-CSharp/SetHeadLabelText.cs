using UnityEngine;

public class SetHeadLabelText : MonoBehaviour
{
	public UILabel[] labels;

	public void SetText(string text)
	{
		for (int i = 0; i < labels.Length; i++)
		{
			labels[i].text = text;
		}
	}
}
