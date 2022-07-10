using System;
using UnityEngine;

public class FriendPreviewClicker : MonoBehaviour
{
	public static event Action<string> FriendPreviewClicked;

	private void OnClick()
	{
		Debug.Log("Clicked");
		ButtonClickSound.Instance.PlayClick();
		if (FriendPreviewClicker.FriendPreviewClicked != null)
		{
			string id = base.transform.parent.GetComponent<FriendPreview>().id;
			FriendPreviewClicker.FriendPreviewClicked(id);
		}
	}
}
