using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class FriendProfileController : IDisposable
	{
		public static string currentFriendId = null;

		private bool _disposed;

		private FriendProfileView _friendProfileView;

		private GameObject _friendProfileViewGo;

		private IFriendsGUIController _friendsGuiController;

		private string _friendId = string.Empty;

		private string _selfId = string.Empty;

		private static readonly IDictionary<string, string> _gameModes = new Dictionary<string, string>
		{
			{ "0", "Key_0104" },
			{ "1", "Key_0025" },
			{ "2", "Key_1037" },
			{ "3", "Key_1038" },
			{ "4", "Key_1006" }
		};

		public GameObject FriendProfileGo
		{
			get
			{
				return _friendProfileViewGo;
			}
		}

		public FriendProfileController(IFriendsGUIController friendsGuiController)
		{
			if (friendsGuiController == null)
			{
				throw new ArgumentNullException("friendsGuiController");
			}
			_friendsGuiController = friendsGuiController;
			_friendProfileViewGo = UnityEngine.Object.Instantiate(Resources.Load("FriendProfileView")) as GameObject;
			if (_friendProfileViewGo == null)
			{
				_disposed = true;
				return;
			}
			_friendProfileViewGo.SetActive(false);
			_friendProfileView = _friendProfileViewGo.GetComponent<FriendProfileView>();
			if (_friendProfileView == null)
			{
				UnityEngine.Object.DestroyObject(_friendProfileViewGo);
				_friendProfileViewGo = null;
				_disposed = true;
				return;
			}
			_selfId = FriendsController.sharedController.id ?? string.Empty;
			FriendPreviewClicker.FriendPreviewClicked += HandleProfileClicked;
			_friendProfileView.BackPressed += HandleBackClicked;
			_friendProfileView.JoinPressed += HandleJoinClicked;
			_friendProfileView.MessageCommitted += HandleMessageCommitted;
			_friendProfileView.UpdateRequested += HandleUpdateRequested;
			FriendsController.FullInfoUpdated += HandleUpdateRequested;
		}

		public void Dispose()
		{
			if (!_disposed)
			{
				FriendPreviewClicker.FriendPreviewClicked -= HandleProfileClicked;
				_friendProfileView.BackPressed -= HandleBackClicked;
				_friendProfileView.JoinPressed -= HandleJoinClicked;
				_friendProfileView.MessageCommitted -= HandleMessageCommitted;
				_friendProfileView.UpdateRequested -= HandleUpdateRequested;
				FriendsController.FullInfoUpdated -= HandleUpdateRequested;
				_friendProfileView = null;
				UnityEngine.Object.DestroyObject(_friendProfileViewGo);
				_friendProfileViewGo = null;
				_disposed = true;
			}
		}

		private void Update()
		{
			Dictionary<string, object> value;
			if (!string.IsNullOrEmpty(_friendId) && FriendsController.sharedController.playersInfo.TryGetValue(_friendId, out value))
			{
				UpdatePlayer(value);
				UpdateScores(value);
				UpdateAccessories(value);
				UpdateOnline(value);
			}
		}

		private void UpdateAccessories(Dictionary<string, object> playerInfo)
		{
			object value;
			if (playerInfo == null || playerInfo.Count == 0 || !playerInfo.TryGetValue("accessories", out value))
			{
				return;
			}
			List<object> list = value as List<object>;
			if (list == null)
			{
				return;
			}
			IEnumerable<Dictionary<string, object>> enumerable = list.OfType<Dictionary<string, object>>();
			foreach (Dictionary<string, object> item in enumerable)
			{
				string text = string.Empty;
				object value2;
				if (item.TryGetValue("name", out value2))
				{
					text = (value2 as string) ?? string.Empty;
				}
				object value3;
				int result;
				if (!item.TryGetValue("type", out value3) || !int.TryParse(value3 as string, out result))
				{
					continue;
				}
				switch (result)
				{
				case 0:
					if (text.Equals(Wear.cape_Custom, StringComparison.Ordinal))
					{
						object value4;
						if (item.TryGetValue("skin", out value4))
						{
							string text2 = value4 as string;
							if (!string.IsNullOrEmpty(text2))
							{
								byte[] customCape = Convert.FromBase64String(text2);
								_friendProfileView.SetCustomCape(customCape);
							}
						}
					}
					else
					{
						_friendProfileView.SetStockCape(text);
					}
					break;
				case 1:
					_friendProfileView.SetHat(text);
					break;
				case 2:
					_friendProfileView.SetBoots(text);
					break;
				case 3:
					_friendProfileView.SetArmor(text);
					break;
				}
			}
		}

		private void UpdateOnline(Dictionary<string, object> playerInfo)
		{
			object value;
			if (playerInfo == null || playerInfo.Count == 0 || !playerInfo.TryGetValue("online", out value))
			{
				return;
			}
			Dictionary<string, object> dictionary = value as Dictionary<string, object>;
			if (dictionary != null)
			{
				int myPlatformConnect = (int)ConnectSceneNGUIController.myPlatformConnect;
				object value2;
				int result;
				if (dictionary.TryGetValue("game_mode", out value2) && int.TryParse(value2 as string, out result) && result > 99)
				{
					myPlatformConnect = result / 100;
				}
				object value3;
				float result2;
				if (!dictionary.TryGetValue("delta", out value3) || !float.TryParse(value3 as string, out result2))
				{
					return;
				}
				if (result2 > FriendsController.onlineDelta)
				{
					_friendProfileView.Online = OnlineState.Offline;
					_friendProfileView.FriendLocation = string.Empty;
					return;
				}
				object value4;
				if (dictionary.TryGetValue("protocol", out value4))
				{
					string text = value4 as string;
					if (string.IsNullOrEmpty(text))
					{
						_friendProfileView.Compatible = false;
					}
					else
					{
						try
						{
							string text2 = text;
							string multiplayerProtocolVersion = GlobalGameController.MultiplayerProtocolVersion;
							_friendProfileView.Compatible = text2 == multiplayerProtocolVersion;
						}
						catch
						{
							_friendProfileView.Compatible = false;
						}
					}
				}
				_friendProfileView.Online = OnlineState.Online;
				object value5;
				if (dictionary.TryGetValue("map", out value5) && !Defs.levelNamesFromNums.ContainsKey(value5.ToString()))
				{
					_friendProfileView.Compatible = false;
				}
				object value6;
				if (!dictionary.TryGetValue("game_mode", out value6))
				{
					return;
				}
				string text3 = value6.ToString();
				if (string.IsNullOrEmpty(text3))
				{
					Debug.LogWarning("Game mode object is null or empty.");
				}
				else
				{
					string value7;
					if (!_gameModes.TryGetValue(text3.Substring(text3.Length - 1), out value7) || value7 == null)
					{
						return;
					}
					value7 = LocalizationStore.Get(value7) ?? string.Empty;
					object value8;
					int mapIndex;
					if (!dictionary.TryGetValue("map", out value8) || !int.TryParse(value8 as string, out mapIndex))
					{
						return;
					}
					if (mapIndex == -1)
					{
						_friendProfileView.Online = OnlineState.Online;
						return;
					}
					bool flag = Defs.levelNamesFromNums.ContainsKey(mapIndex.ToString());
					_friendProfileView.Compatible &= flag;
					string key = Defs.levelNumsForMusicInMult.FirstOrDefault((KeyValuePair<string, int> kv) => kv.Value == mapIndex).Key;
					if (!string.IsNullOrEmpty(key))
					{
						string value9;
						if (Defs2.mapNamesForUser.TryGetValue(key, out value9))
						{
							_friendProfileView.FriendLocation = string.Format("{0}/{1}", value7, value9);
							_friendProfileView.Online = OnlineState.Playing;
						}
						else
						{
							_friendProfileView.FriendLocation = string.Empty;
						}
					}
				}
			}
			else
			{
				_friendProfileView.Online = OnlineState.Offline;
				_friendProfileView.FriendLocation = string.Empty;
			}
		}

		private void UpdatePlayer(Dictionary<string, object> playerInfo)
		{
			if (playerInfo == null || playerInfo.Count == 0)
			{
				Debug.LogWarning("playerInfo == null || playerInfo.Count == 0");
				return;
			}
			Dictionary<string, object> dictionary = playerInfo["player"] as Dictionary<string, object>;
			if (dictionary == null)
			{
				return;
			}
			object value;
			int result;
			if (dictionary.TryGetValue("friends", out value) && int.TryParse(value as string, out result))
			{
				_friendProfileView.FriendCount = result;
			}
			object value2;
			if (dictionary.TryGetValue("nick", out value2))
			{
				_friendProfileView.FriendName = value2 as string;
			}
			object value3;
			int result2;
			if (dictionary.TryGetValue("rank", out value3) && int.TryParse(value3 as string, out result2))
			{
				_friendProfileView.Rank = result2;
			}
			object value4;
			if (dictionary.TryGetValue("skin", out value4))
			{
				string text = value4 as string;
				if (!string.IsNullOrEmpty(text))
				{
					byte[] array = Convert.FromBase64String(text);
					if (array != null && array.Length > 0)
					{
						_friendProfileView.SetSkin(array);
					}
				}
			}
			object value5;
			if (dictionary.TryGetValue("clan_name", out value5))
			{
				_friendProfileView.clanName.gameObject.SetActive(true);
				string text2 = value5 as string;
				if (!string.IsNullOrEmpty(text2))
				{
					int num = 10000;
					if (text2 != null && text2.Length > num)
					{
						text2 = string.Format("{0}..{1}", text2.Substring(0, (num - 2) / 2), text2.Substring(text2.Length - (num - 2) / 2, (num - 2) / 2));
					}
					_friendProfileView.clanName.text = text2 ?? string.Empty;
				}
				else
				{
					_friendProfileView.clanName.gameObject.SetActive(false);
				}
			}
			object value6;
			if (dictionary.TryGetValue("clan_logo", out value6))
			{
				string text3 = value6 as string;
				if (!string.IsNullOrEmpty(text3))
				{
					_friendProfileView.clanLogo.gameObject.SetActive(true);
					byte[] array2 = Convert.FromBase64String(text3);
					if (array2 != null && array2.Length > 0)
					{
						try
						{
							Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoHeight, TextureFormat.ARGB32, false);
							texture2D.LoadImage(array2);
							texture2D.filterMode = FilterMode.Point;
							texture2D.Apply();
							Texture mainTexture = _friendProfileView.clanLogo.mainTexture;
							_friendProfileView.clanLogo.mainTexture = texture2D;
							if (mainTexture != null)
							{
								UnityEngine.Object.Destroy(mainTexture);
							}
						}
						catch (Exception)
						{
							Texture mainTexture2 = _friendProfileView.clanLogo.mainTexture;
							_friendProfileView.clanLogo.mainTexture = null;
							if (mainTexture2 != null)
							{
								UnityEngine.Object.Destroy(mainTexture2);
							}
						}
					}
				}
				else
				{
					_friendProfileView.clanLogo.gameObject.SetActive(false);
				}
			}
			string playerNameOrDefault = Defs.GetPlayerNameOrDefault();
			_friendProfileView.Username = playerNameOrDefault;
			object value7;
			int result3;
			if (dictionary.TryGetValue("wins", out value7) && int.TryParse(value7 as string, out result3))
			{
				_friendProfileView.WinCount = result3;
			}
			object value8;
			if (dictionary.TryGetValue("total_wins", out value8))
			{
				int result4;
				if (int.TryParse(value8 as string, out result4))
				{
					_friendProfileView.TotalWinCount = result4;
				}
				else
				{
					Debug.LogWarning("Can not parse “total_wins” field: " + value8);
				}
			}
			else
			{
				Debug.LogWarning("player does not have “total_wins” field.");
			}
			List<Message> value9;
			if (!MessagesController.Instance.IncomingMessages.TryGetValue(_friendId, out value9))
			{
				value9 = new List<Message>();
			}
			if (Application.isEditor)
			{
				Debug.Log(string.Format("Incoming messages from {0} ({1}): {2}", _friendId, MessagesController.Instance.IncomingMessages.Count, value9.Count));
			}
			List<Message> value10;
			if (!MessagesController.Instance.OutgoingMessages.TryGetValue(_friendId, out value10))
			{
				value10 = new List<Message>();
			}
			List<Message> messages = (from m in value9.Concat(value10)
				orderby m.Timestamp
				select m).ToList();
			_friendProfileView.SetMessages(messages);
		}

		private void UpdateScores(Dictionary<string, object> playerInfo)
		{
			object value;
			if (playerInfo == null || playerInfo.Count == 0 || !playerInfo.TryGetValue("scores", out value))
			{
				return;
			}
			List<object> list = value as List<object>;
			if (list == null)
			{
				return;
			}
			IEnumerable<Dictionary<string, object>> source = list.OfType<Dictionary<string, object>>();
			if (source.Any())
			{
				Dictionary<string, object> dictionary = source.FirstOrDefault((Dictionary<string, object> d) => d.ContainsKey("game") && d["game"].Equals("0"));
				object value2;
				int result;
				if (dictionary != null && dictionary.TryGetValue("max_score", out value2) && int.TryParse(value2 as string, out result))
				{
					_friendProfileView.SurvivalScore = result;
				}
			}
		}

		private void HandleProfileClicked(string id)
		{
			//Discarded unreachable code: IL_005b
			if (!_disposed)
			{
				if (string.IsNullOrEmpty(id))
				{
					throw new ArgumentException("Id should not be null or empty.", "id");
				}
				try
				{
					_friendId = id;
					currentFriendId = _friendId;
					_friendProfileView.Reset();
					Update();
				}
				catch (Exception message)
				{
					Debug.Log(message);
					return;
				}
				_friendsGuiController.Hide(true);
				FriendsController.sharedController.StartRefreshingInfo(_friendId);
				_friendProfileViewGo.SetActive(true);
				string selfId = _selfId;
				MessagesController.Instance.ScheduleReceivingMessages(selfId);
			}
		}

		public void HandleBackClicked(object sender, EventArgs e)
		{
			_friendProfileView.Reset();
			_friendProfileViewGo.SetActive(false);
			MessagesController.Instance.UnscheduleReceivingMessages();
			FriendsController.sharedController.StopRefreshingInfo();
			_friendsGuiController.Hide(false);
		}

		private void HandleJoinClicked(object sender, EventArgs e)
		{
			string friendId = _friendId;
			if (FriendsController.sharedController.onlineInfo.ContainsKey(friendId))
			{
				JoinRoomFromFrends.friendProfilePanel = _friendProfileViewGo;
				int game_mode = int.Parse(FriendsController.sharedController.onlineInfo[friendId]["game_mode"]);
				string room_name = FriendsController.sharedController.onlineInfo[friendId]["room_name"];
				string text = FriendsController.sharedController.onlineInfo[friendId]["map"];
				if (Defs.levelNamesFromNums.ContainsKey(text))
				{
					JoinRoomFromFrends.sharedJoinRoomFromFrends.ConnectToRoom(game_mode, room_name, text);
				}
			}
		}

		private void HandleMessageCommitted(object sender, MessageEventArgs e)
		{
			if (!string.IsNullOrEmpty(_friendId))
			{
				MessagesController.Instance.SaveOutgoingMessage(_friendId, e.Message);
				string selfId = _selfId;
				if (!string.IsNullOrEmpty(selfId))
				{
					MessagesController.Instance.SendChatMessage(selfId, _friendId, e.Message.Text);
				}
			}
		}

		private void HandleUpdateRequested(object sender, EventArgs e)
		{
			Update();
		}
	}
}
