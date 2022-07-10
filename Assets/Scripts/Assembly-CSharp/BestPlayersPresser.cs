using Rilisoft;
using UnityEngine;

internal sealed class BestPlayersPresser : MonoBehaviour
{
	private void Start()
	{
		if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			base.gameObject.SetActive(false);
		}
	}

	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		FriendsGUIController component = NGUITools.GetRoot(base.gameObject).GetComponent<FriendsGUIController>();
		component.friendsPanel.gameObject.SetActive(false);
		component.leaderboardsView.gameObject.SetActive(true);
		component.RequestLeaderboards();
	}
}
