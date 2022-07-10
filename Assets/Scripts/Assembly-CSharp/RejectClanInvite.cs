using Rilisoft;
using UnityEngine;

public class RejectClanInvite : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		FriendsController.sharedController.RejectClanInvite(base.transform.parent.GetComponent<Invitation>().recordId);
		base.transform.parent.GetComponent<Invitation>().DisableButtons();
	}
}
