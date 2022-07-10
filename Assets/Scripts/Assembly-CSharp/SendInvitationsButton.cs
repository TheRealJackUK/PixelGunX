using UnityEngine;

public class SendInvitationsButton : MonoBehaviour
{
	private void OnClick()
	{
		FacebookController.sharedController.InvitePlayer();
		ButtonClickSound.Instance.PlayClick();
	}
}
