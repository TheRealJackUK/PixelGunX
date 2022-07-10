using UnityEngine;
using UnityEngine.SocialPlatforms;

public class AGSSocialUser : IUserProfile
{
	private AGSPlayer player;

	public string userName
	{
		get
		{
			return player.alias;
		}
	}

	public string id
	{
		get
		{
			return player.playerId;
		}
	}

	public bool isFriend
	{
		get
		{
			foreach (AGSSocialUser friend in AGSSocialLocalUser.friendList)
			{
				if (friend.id == id)
				{
					return true;
				}
			}
			return false;
		}
	}

	public UserState state
	{
		get
		{
			AGSClient.LogGameCircleError("ILocalUser.state.get is not available for GameCircle");
			return UserState.Offline;
		}
	}

	public Texture2D image
	{
		get
		{
			AGSClient.LogGameCircleError("ILocalUser.image.get is not available for GameCircle");
			return null;
		}
	}

	public AGSSocialUser()
	{
		player = AGSPlayer.GetBlankPlayer();
	}

	public AGSSocialUser(AGSPlayer player)
	{
		this.player = ((player != null) ? player : AGSPlayer.GetBlankPlayer());
	}
}
