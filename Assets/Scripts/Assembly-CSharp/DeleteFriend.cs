using System.Collections.Generic;
using UnityEngine;

public sealed class DeleteFriend : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		if (!base.transform.parent.GetComponent<FriendPreview>().ClanMember)
		{
			string clanID = FriendsController.sharedController.ClanID;
			string clanLeaderID = FriendsController.sharedController.clanLeaderID;
			FriendPreview fp = base.transform.parent.GetComponent<FriendPreview>();
			if (!string.IsNullOrEmpty(clanID) && !string.IsNullOrEmpty(clanLeaderID) && fp.id != null && FriendsController.sharedController.clanLeaderID.Equals(fp.id))
			{
				FriendsController.sharedController.RejectInvite(fp.recordId, fp.id);
				fp.DisableButtons();
				FriendsController.sharedController.ExitClan(null);
			}
			else if (!string.IsNullOrEmpty(clanID) && !string.IsNullOrEmpty(clanLeaderID) && !string.IsNullOrEmpty(FriendsController.sharedController.id) && FriendsController.sharedController.id.Equals(FriendsController.sharedController.clanLeaderID) && fp.id != null && FriendsController.sharedController.playersInfo.ContainsKey(fp.id) && FriendsController.sharedController.playersInfo[fp.id].ContainsKey("player") && (FriendsController.sharedController.playersInfo[fp.id]["player"] as Dictionary<string, object>).ContainsKey("clan_creator_id") && (FriendsController.sharedController.playersInfo[fp.id]["player"] as Dictionary<string, object>)["clan_creator_id"] != null && ((FriendsController.sharedController.playersInfo[fp.id]["player"] as Dictionary<string, object>)["clan_creator_id"] as string).Equals(FriendsController.sharedController.clanLeaderID))
			{
				FriendsController.sharedController.RejectInvite(fp.recordId, fp.id, delegate(bool ok)
				{
					if (ok)
					{
						FriendsController.sharedController.friendsDeletedLocal.Add(fp.id);
					}
					else
					{
						FriendsController.sharedController.friendsDeletedLocal.Remove(fp.id);
					}
				});
				fp.DisableButtons();
				FriendsController.sharedController.ExitClan(fp.id);
			}
			else
			{
				FriendsController.sharedController.RejectInvite(fp.recordId, fp.id);
				fp.DisableButtons();
			}
		}
		else
		{
			FriendsController.sharedController.clanDeletedLocal.Add(base.transform.parent.GetComponent<FriendPreview>().id);
			FriendsController.sharedController.DeleteClanMember(base.transform.parent.GetComponent<FriendPreview>().id);
		}
	}
}
