using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FacebookFriendsGUIController : MonoBehaviour
{
	public static FacebookFriendsGUIController sharedController;

	public bool _infoRequested;

	private void Start()
	{
		sharedController = this;
	}

	private void Update()
	{
		if (FacebookController.sharedController.friendsList != null && FacebookController.sharedController.friendsList.Count > 0 && FriendsController.sharedController.facebookFriendsInfo.Count == 0 && !_infoRequested && FriendsController.sharedController.GetFacebookFriendsCallback == null)
		{
			FriendsController.sharedController.GetFacebookFriendsInfo(GetFacebookFriendsCallback);
			_infoRequested = true;
		}
	}

	private void GetFacebookFriendsCallback()
	{
		if (FriendsController.sharedController == null || FriendsController.sharedController.facebookFriendsInfo == null)
		{
			return;
		}
		Dictionary<string, Dictionary<string, object>> dictionary = new Dictionary<string, Dictionary<string, object>>();
		foreach (string key in FriendsController.sharedController.facebookFriendsInfo.Keys)
		{
			bool flag = false;
			if (FriendsController.sharedController.friends != null)
			{
				foreach (Dictionary<string, string> friend in FriendsController.sharedController.friends)
				{
					if (friend.ContainsKey("friend") && friend["friend"].Equals(key))
					{
						flag = true;
						break;
					}
				}
			}
			if (FriendsController.sharedController.invitesFromUs != null)
			{
				foreach (Dictionary<string, string> invitesFromU in FriendsController.sharedController.invitesFromUs)
				{
					if (invitesFromU.ContainsKey("friend") && invitesFromU["friend"].Equals(key))
					{
						flag = true;
						break;
					}
				}
			}
			if (!flag)
			{
				dictionary.Add(key, FriendsController.sharedController.facebookFriendsInfo[key]);
			}
		}
		UIGrid componentInChildren = GetComponentInChildren<UIGrid>();
		if (componentInChildren == null)
		{
			return;
		}
		FriendPreview[] array = GetComponentsInChildren<FriendPreview>(true);
		if (array == null)
		{
			array = new FriendPreview[0];
		}
		Dictionary<string, FriendPreview> dictionary2 = new Dictionary<string, FriendPreview>();
		FriendPreview[] array2 = array;
		foreach (FriendPreview friendPreview in array2)
		{
			if (friendPreview.id != null && dictionary.ContainsKey(friendPreview.id))
			{
				dictionary2.Add(friendPreview.id, friendPreview);
				continue;
			}
			friendPreview.transform.parent = null;
			Object.Destroy(friendPreview.gameObject);
		}
		foreach (KeyValuePair<string, Dictionary<string, object>> item in dictionary)
		{
			Dictionary<string, string> dictionary3 = new Dictionary<string, string>();
			foreach (KeyValuePair<string, object> item2 in item.Value)
			{
				dictionary3.Add(item2.Key, item2.Value as string);
			}
			if (dictionary2.ContainsKey(item.Key))
			{
				GameObject gameObject = dictionary2[item.Key].gameObject;
				gameObject.GetComponent<FriendPreview>().facebookFriend = true;
				gameObject.GetComponent<FriendPreview>().id = item.Key;
				if (item.Value.ContainsKey("nick"))
				{
					gameObject.GetComponent<FriendPreview>().nm.text = item.Value["nick"] as string;
				}
				if (item.Value.ContainsKey("rank"))
				{
					string text = item.Value["rank"] as string;
					if (text.Equals("0"))
					{
						text = "1";
					}
					gameObject.GetComponent<FriendPreview>().rank.spriteName = "Rank_" + text;
				}
				if (item.Value.ContainsKey("skin"))
				{
					gameObject.GetComponent<FriendPreview>().SetSkin(item.Value["skin"] as string);
				}
				gameObject.GetComponent<FriendPreview>().FillClanAttrs(dictionary3);
				continue;
			}
			GameObject gameObject2 = Object.Instantiate(Resources.Load("Friend") as GameObject) as GameObject;
			gameObject2.transform.parent = componentInChildren.transform;
			gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
			gameObject2.GetComponent<FriendPreview>().facebookFriend = true;
			gameObject2.GetComponent<FriendPreview>().id = item.Key;
			if (item.Value.ContainsKey("nick"))
			{
				gameObject2.GetComponent<FriendPreview>().nm.text = item.Value["nick"] as string;
			}
			if (item.Value.ContainsKey("rank"))
			{
				string text2 = item.Value["rank"] as string;
				if (text2.Equals("0"))
				{
					text2 = "1";
				}
				gameObject2.GetComponent<FriendPreview>().rank.spriteName = "Rank_" + text2;
			}
			if (item.Value.ContainsKey("skin"))
			{
				gameObject2.GetComponent<FriendPreview>().SetSkin(item.Value["skin"] as string);
			}
			gameObject2.GetComponent<FriendPreview>().FillClanAttrs(dictionary3);
		}
		StartCoroutine(Repos(componentInChildren));
	}

	private IEnumerator Repos(UIGrid grid)
	{
		yield return null;
		grid.Reposition();
	}

	private void OnApplicationPause(bool pause)
	{
		if (pause)
		{
			FriendsController.sharedController.facebookFriendsInfo.Clear();
			_infoRequested = false;
		}
	}

	private void OnDestroy()
	{
		FriendsController.sharedController.GetFacebookFriendsCallback = null;
		sharedController = null;
	}
}
