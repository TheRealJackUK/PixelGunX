using UnityEngine;

public class InboxPresser : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().friendsPanel.gameObject.SetActive(false);
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().inboxPanel.gameObject.SetActive(true);
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().invitationsGrid.Reposition();
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().sentInvitationsGrid.Reposition();
	}
}
