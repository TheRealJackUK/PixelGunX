using UnityEngine;

public class TestAddFriends : MonoBehaviour
{
	private void OnClick()
	{
		FriendsController.sharedController.SendInvitation("123");
	}
}
