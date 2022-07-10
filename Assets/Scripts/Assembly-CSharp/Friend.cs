using System;
using UnityEngine;

public class Friend
{
	public string name;

	public string id;

	public bool isUser;

	public Texture2D avatar;

	public DateTime nextVisit;

	public UILabel timeLabel;

	public UITexture avatarTexture;

	public Friend(string friendName, string friendId, bool friendIsUser)
	{
		name = friendName;
		id = friendId;
		isUser = friendIsUser;
		avatar = null;
	}

	public void SetAvatar(Texture2D txt)
	{
		avatar = txt;
	}

	public void SetTimeLastVisit(DateTime visitTime)
	{
		nextVisit = visitTime;
	}

	public void SetTimeLabel(UILabel tL)
	{
		timeLabel = tL;
	}

	public void SetAvatarObj(UITexture aT)
	{
		avatarTexture = aT;
	}
}
