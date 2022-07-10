using UnityEngine;

public class GameInfo : MonoBehaviour
{
	public GameObject openSprite;

	public GameObject closeSprite;

	public UILabel countPlayersLabel;

	public UILabel serverNameLabel;

	public UILabel mapNameLabel;

	public RoomInfo roomInfo;

	public LANBroadcastService.ReceivedMessage roomInfoLocal;

	private void Start()
	{
	}

	private void OnClick()
	{
		if (ButtonClickSound.Instance != null)
		{
			ButtonClickSound.Instance.PlayClick();
		}
		if (ConnectSceneNGUIController.sharedController != null)
		{
			if (Defs.isInet)
			{
				ConnectSceneNGUIController.sharedController.JoinToRoomPhoton(roomInfo);
			}
			else
			{
				ConnectSceneNGUIController.sharedController.JoinToLocalRoom(roomInfoLocal);
			}
		}
	}
}
