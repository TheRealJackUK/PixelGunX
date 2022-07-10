using UnityEngine;

public class BackButtonFromEnterPasswordInFriensJoin : MonoBehaviour
{
	private void Start()
	{
	}

	private void OnClick()
	{
		if (JoinRoomFromFrends.sharedJoinRoomFromFrends != null)
		{
			JoinRoomFromFrends.sharedJoinRoomFromFrends.BackFromPasswordButton();
		}
	}
}
