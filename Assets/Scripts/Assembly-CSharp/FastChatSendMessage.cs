using UnityEngine;

public class FastChatSendMessage : MonoBehaviour
{
	public string message = "-=GO!=-";

	private void OnClick()
	{
		if (InGameGUI.sharedInGameGUI.playerMoveC != null)
		{
			InGameGUI.sharedInGameGUI.playerMoveC.SendChat(message, false);
			InGameGUI.sharedInGameGUI.SetVisibleFactChatPanel(false);
			InGameGUI.sharedInGameGUI.fastChatToggle.value = false;
			if ((bool)ChatViewrController.sharedController && !ChatViewrController.isHold)
			{
				ChatViewrController.sharedController.closeChat();
			}
		}
	}
}
