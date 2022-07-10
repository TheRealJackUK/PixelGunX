using System.Reflection;
using UnityEngine;

public class SetFontSize : MonoBehaviour
{
	private UILabel myLabel;

	private void Start()
	{
		myLabel = GetComponent<UILabel>();
		UpdateFontSize();
	}

	[Obfuscation(Exclude = true)]
	private void UpdateFontSize()
	{
		if (myLabel != null)
		{
			myLabel.fontSize = myLabel.height;
		}
	}

	private void OnEnable()
	{
		Invoke("UpdateFontSize", 0.05f);
	}

	private void Update()
	{
		if (myLabel.fontSize != myLabel.height)
		{
			myLabel.fontSize = myLabel.height;
		}
	}
}
