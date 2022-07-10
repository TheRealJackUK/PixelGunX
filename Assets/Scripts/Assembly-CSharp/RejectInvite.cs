using Rilisoft;
using UnityEngine;

internal sealed class RejectInvite : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		Invitation component = base.transform.parent.GetComponent<Invitation>();
		if (component != null)
		{
			FriendsController.sharedController.RejectInvite(component.recordId, component.id);
			base.transform.parent.GetComponent<Invitation>().DisableButtons();
		}
		else
		{
			Debug.LogWarning("invitation == null");
		}
	}
}
