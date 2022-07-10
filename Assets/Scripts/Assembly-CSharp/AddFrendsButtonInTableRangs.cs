using UnityEngine;

public class AddFrendsButtonInTableRangs : MonoBehaviour
{
	public int ID;

	private void OnPress(bool isDown)
	{
		if (!isDown)
		{
			FriendsController.sharedController.SendInvitation(ID.ToString());
			if (!FriendsController.sharedController.notShowAddIds.Contains(ID.ToString()))
			{
				FriendsController.sharedController.notShowAddIds.Add(ID.ToString());
			}
			base.gameObject.SetActive(false);
		}
	}
}
