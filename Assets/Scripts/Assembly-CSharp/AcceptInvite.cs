using Rilisoft;
using UnityEngine;

internal sealed class AcceptInvite : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		Invitation component = base.transform.parent.GetComponent<Invitation>();
		if (component == null)
		{
			Debug.LogWarning("invitation == null");
			return;
		}
		FriendsController.sharedController.AcceptInvite(component.recordId, component.id);
		component.DisableButtons();
	}
}
