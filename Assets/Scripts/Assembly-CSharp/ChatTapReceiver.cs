using System;
using UnityEngine;

public class ChatTapReceiver : MonoBehaviour
{
	public static event Action ChatClicked;

	private void Start()
	{
		HandleChatSettUpdated();
		PauseNGUIController.ChatSettUpdated += HandleChatSettUpdated;
	}

	private void HandleChatSettUpdated()
	{
		base.gameObject.SetActive(Defs.isMulti && Defs.IsChatOn);
	}

	private void OnDestroy()
	{
		PauseNGUIController.ChatSettUpdated -= HandleChatSettUpdated;
	}

	private void OnClick()
	{
		if (ChatTapReceiver.ChatClicked != null)
		{
			ChatTapReceiver.ChatClicked();
		}
	}
}
