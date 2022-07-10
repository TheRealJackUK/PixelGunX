using UnityEngine;

public class EnterPasswordInFriensJoinButton : MonoBehaviour
{
	public UILabel passwordLabel;

	private void Start()
	{
	}

	private void OnClick()
	{
		if (JoinRoomFromFrends.sharedJoinRoomFromFrends != null)
		{
			JoinRoomFromFrends.sharedJoinRoomFromFrends.EnterPassword(passwordLabel.text);
		}
	}
}
