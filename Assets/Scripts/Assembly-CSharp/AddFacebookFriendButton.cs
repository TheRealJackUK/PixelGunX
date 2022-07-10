using UnityEngine;

public class AddFacebookFriendButton : MonoBehaviour
{
	private void OnClick()
	{
		FriendPreview component = base.transform.parent.GetComponent<FriendPreview>();
		ButtonClickSound.Instance.PlayClick();
		string id = component.id;
		if (id != null)
		{
			if (component.ClanInvite)
			{
				FriendsController.sharedController.SendClanInvitation(id);
				FriendsController.sharedController.clanSentInvitesLocal.Add(id);
			}
			else
			{
				FriendsController.sharedController.SendInvitation(id);
			}
		}
		if (!component.ClanInvite)
		{
			component.DisableButtons();
		}
	}
}
