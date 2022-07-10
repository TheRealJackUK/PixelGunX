using UnityEngine;

public class ButtonEnabledLabel : MonoBehaviour
{
	public UIButton myButton;

	public GameObject enabledLabel;

	public GameObject disableLabel;

	private void Start()
	{
	}

	private void Update()
	{
		if (myButton.isEnabled && !enabledLabel.activeSelf)
		{
			enabledLabel.SetActive(true);
			disableLabel.SetActive(false);
		}
		if (!myButton.isEnabled && enabledLabel.activeSelf)
		{
			enabledLabel.SetActive(false);
			disableLabel.SetActive(true);
		}
	}
}
