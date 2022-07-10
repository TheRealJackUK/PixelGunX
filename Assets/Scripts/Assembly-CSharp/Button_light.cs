using UnityEngine;

public class Button_light : MonoBehaviour
{
	public UITexture lightTexture;

	private void Start()
	{
		lightTexture.enabled = false;
	}

	private void OnPress(bool isDown)
	{
		lightTexture.enabled = isDown;
	}
}
