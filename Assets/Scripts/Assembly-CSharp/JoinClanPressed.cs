using Rilisoft;
using UnityEngine;

public class JoinClanPressed : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		FriendsController.sharedController.AcceptClanInvite(base.transform.parent.GetComponent<Invitation>().recordId);
		base.transform.parent.GetComponent<Invitation>().DisableButtons();
		base.transform.parent.GetComponent<Invitation>().KeepClanData();
	}
}
