using UnityEngine;

internal sealed class JoinRoomFromFrendsButton : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		string id = base.transform.parent.GetComponent<FriendPreview>().id;
		if (FriendsController.sharedController.onlineInfo.ContainsKey(id))
		{
			int game_mode = int.Parse(FriendsController.sharedController.onlineInfo[id]["game_mode"]);
			string room_name = FriendsController.sharedController.onlineInfo[id]["room_name"];
			string text = FriendsController.sharedController.onlineInfo[id]["map"];
			if (Defs.levelNamesFromNums.ContainsKey(text))
			{
				JoinRoomFromFrends.sharedJoinRoomFromFrends.ConnectToRoom(game_mode, room_name, text);
			}
		}
	}
}
