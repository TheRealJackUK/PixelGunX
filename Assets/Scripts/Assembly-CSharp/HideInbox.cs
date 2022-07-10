using UnityEngine;

public sealed class HideInbox : MonoBehaviour
{
	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			Input.ResetInputAxes();
			OnClick();
		}
	}

	private void OnClick()
	{
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().inboxPanel.gameObject.SetActive(false);
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().friendsPanel.gameObject.SetActive(true);
		FriendsController.sharedController.StartCoroutine(FriendsController.sharedController.GetFriendDataOnce(false));
		ButtonClickSound.Instance.PlayClick();
	}
}
