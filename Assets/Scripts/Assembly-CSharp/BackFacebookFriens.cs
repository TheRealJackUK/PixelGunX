using UnityEngine;

public class BackFacebookFriens : MonoBehaviour
{
	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			OnClick();
			Input.ResetInputAxes();
		}
	}

	private void OnClick()
	{
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().friendsPanel.gameObject.SetActive(true);
		NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>().facebookFriensPanel.gameObject.SetActive(false);
		FriendsController.sharedController.facebookFriendsInfo.Clear();
		FacebookFriendsGUIController.sharedController._infoRequested = false;
		ButtonClickSound.Instance.PlayClick();
	}
}
