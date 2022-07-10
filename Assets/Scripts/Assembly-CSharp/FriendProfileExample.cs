using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

internal sealed class FriendProfileExample : MonoBehaviour
{
	public FriendProfileView friendProfileView;

	private void Start()
	{
		if (friendProfileView != null)
		{
			friendProfileView.Reset();
			friendProfileView.Compatible = true;
			friendProfileView.FriendLocation = "Deathmatch/Bridge";
			friendProfileView.FriendCount = 42;
			friendProfileView.FriendName = "Дуэйн «Rock» Джонсон";
			friendProfileView.Online = OnlineState.Playing;
			friendProfileView.Rank = 4;
			friendProfileView.SurvivalScore = 4376;
			friendProfileView.Username = "John Doe";
			friendProfileView.WinCount = 13;
			List<Rilisoft.Message> list = new List<Rilisoft.Message>();
			list.Add(new Rilisoft.Message
			{
				SenderName = friendProfileView.Username,
				Text = "Hello!"
			});
			list.Add(new Rilisoft.Message
			{
				SenderName = friendProfileView.FriendName,
				Text = "Hi there!"
			});
			list.Add(new Rilisoft.Message
			{
				SenderName = friendProfileView.FriendName,
				Text = "Lorem ipsum dolor sit amet. The quick brown fox..."
			});
			list.Add(new Rilisoft.Message
			{
				SenderName = friendProfileView.FriendName,
				Text = "Jumped over the lazy dog."
			});
			list.Add(new Rilisoft.Message
			{
				SenderName = friendProfileView.Username,
				Text = "Ok!"
			});
			list.Add(new Rilisoft.Message
			{
				SenderName = friendProfileView.FriendName,
				Text = "Testing brackets: :-["
			});
			List<Rilisoft.Message> messages = list;
			friendProfileView.SetMessages(messages);
			friendProfileView.SetBoots("boots_blue");
			friendProfileView.SetHat("hat_KingsCrown");
			friendProfileView.SetStockCape("cape_BloodyDemon");
		}
	}
}
