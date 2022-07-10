using System.Collections.Generic;

public class FacebookFriendsResult : FacebookBaseDTO
{
	public List<FacebookFriend> data = new List<FacebookFriend>();

	public FacebookResultsPaging paging;
}
