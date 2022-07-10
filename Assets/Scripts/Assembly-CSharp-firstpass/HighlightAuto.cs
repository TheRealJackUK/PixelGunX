using UnityEngine;

public class HighlightAuto : MonoBehaviour
{
	private GameObject textObject;

	public Color colorHL;

	private void Start()
	{
		textObject = base.gameObject;
	}

	private void Update()
	{
		Objectlight();
	}

	public void Objectlight()
	{
		HighlightableObject componentInChildren = textObject.transform.root.GetComponentInChildren<HighlightableObject>();
		if (componentInChildren != null)
		{
			componentInChildren.On(colorHL);
		}
	}
}
