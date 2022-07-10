using UnityEngine;

public class ButtonActionOnClick : MonoBehaviour
{
	public ChatViewrController chatViewrController;

	private void Start()
	{
		if (Application.platform == RuntimePlatform.Android && base.gameObject.name.Equals("HoldChatButton"))
		{
			base.gameObject.SetActive(false);
		}
	}

	private void OnPress(bool isDown)
	{
		if (!isDown && chatViewrController != null)
		{
			chatViewrController.clickButton(base.gameObject.name);
		}
	}
}
