using System.Collections.Generic;
using UnityEngine;


namespace ExitGames.Client.Photon
{
	internal class LoadbalancingPeer : PhotonPeer
	{
		private readonly Dictionary<byte, object> opParameters = new Dictionary<byte, object>();

		internal virtual bool IsProtocolSecure
		{
			get
			{
				return base.UsedProtocol == ConnectionProtocol.WebSocketSecure;
			}
		}

		public LoadbalancingPeer(IPhotonPeerListener listener, ConnectionProtocol protocolType)
			: base(listener, protocolType)
		{
		}

		public virtual bool OpGetRegions(string appId)
		{
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary[224] = appId;
			return SendOperation(220, dictionary, SendOptions.SendReliable);
		}

		public virtual bool OpJoinLobby(TypedLobby lobby)
		{
			if ((int)base.DebugOut >= 3)
			{
				base.Listener.DebugReturn(DebugLevel.INFO, "OpJoinLobby()");
			}
			Dictionary<byte, object> dictionary = null;
			if (lobby != null && !lobby.IsDefault)
			{
				dictionary = new Dictionary<byte, object>();
				dictionary[213] = lobby.Name;
				dictionary[212] = (byte)lobby.Type;
			}
			return SendOperation(229, dictionary, SendOptions.SendReliable);
		}

		public virtual bool OpLeaveLobby()
		{
			if ((int)base.DebugOut >= 3)
			{
				base.Listener.DebugReturn(DebugLevel.INFO, "OpLeaveLobby()");
			}
			//return SendOperation(228, null, SendOptions.SendReliable);
			return true;
		}

		public virtual bool OpCreateRoom(string roomName, RoomOptions roomOptions, TypedLobby lobby, Hashtable playerProperties, bool onGameServer)
		{
			if ((int)base.DebugOut >= 3)
			{
				base.Listener.DebugReturn(DebugLevel.INFO, "OpCreateRoom()");
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			if (!string.IsNullOrEmpty(roomName))
			{
				dictionary[byte.MaxValue] = roomName;
			}
			if (lobby != null)
			{
				dictionary[213] = lobby.Name;
				dictionary[212] = (byte)lobby.Type;
			}
			if (onGameServer)
			{
				if (playerProperties != null && playerProperties.Count > 0)
				{
					dictionary[249] = playerProperties;
					dictionary[250] = true;
				}
				if (roomOptions == null)
				{
					roomOptions = new RoomOptions();
				}
				Hashtable hashtable2 = (Hashtable)(dictionary[248] = new Hashtable());
				hashtable2.MergeStringKeys(roomOptions.customRoomProperties);
				hashtable2[(byte)253] = roomOptions.isOpen;
				hashtable2[(byte)254] = roomOptions.isVisible;
				hashtable2[(byte)250] = roomOptions.customRoomPropertiesForLobby;
				if (roomOptions.maxPlayers > 0)
				{
					hashtable2[byte.MaxValue] = roomOptions.maxPlayers;
				}
				if (roomOptions.cleanupCacheOnLeave)
				{
					dictionary[241] = true;
					hashtable2[(byte)249] = true;
				}
				if (roomOptions.suppressRoomEvents)
				{
					dictionary[237] = true;
				}
			}
			return SendOperation(227, dictionary, SendOptions.SendReliable);
		}

		public virtual bool OpJoinRoom(string roomName, RoomOptions roomOptions, TypedLobby lobby, bool createIfNotExists, Hashtable playerProperties, bool onGameServer)
		{
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			if (!string.IsNullOrEmpty(roomName))
			{
				dictionary[byte.MaxValue] = roomName;
			}
			if (createIfNotExists)
			{
				dictionary[215] = true;
				if (lobby != null)
				{
					dictionary[213] = lobby.Name;
					dictionary[212] = (byte)lobby.Type;
				}
			}
			if (onGameServer)
			{
				if (playerProperties != null && playerProperties.Count > 0)
				{
					dictionary[249] = playerProperties;
					dictionary[250] = true;
				}
				if (createIfNotExists)
				{
					if (roomOptions == null)
					{
						roomOptions = new RoomOptions();
					}
					Hashtable hashtable2 = (Hashtable)(dictionary[248] = new Hashtable());
					hashtable2.MergeStringKeys(roomOptions.customRoomProperties);
					hashtable2[(byte)253] = roomOptions.isOpen;
					hashtable2[(byte)254] = roomOptions.isVisible;
					hashtable2[(byte)250] = roomOptions.customRoomPropertiesForLobby;
					if (roomOptions.maxPlayers > 0)
					{
						hashtable2[byte.MaxValue] = roomOptions.maxPlayers;
					}
					if (roomOptions.cleanupCacheOnLeave)
					{
						dictionary[241] = true;
						hashtable2[(byte)249] = true;
					}
					if (roomOptions.suppressRoomEvents)
					{
						dictionary[237] = true;
					}
				}
			}
			return SendOperation(226, dictionary, SendOptions.SendReliable);
		}

		public virtual bool OpJoinRandomRoom(Hashtable expectedCustomRoomProperties, byte expectedMaxPlayers, Hashtable playerProperties, MatchmakingMode matchingType, TypedLobby typedLobby, string sqlLobbyFilter)
		{
			if ((int)base.DebugOut >= 3)
			{
				base.Listener.DebugReturn(DebugLevel.INFO, "OpJoinRandomRoom()");
			}
			Hashtable hashtable = new Hashtable();
			hashtable.MergeStringKeys(expectedCustomRoomProperties);
			if (expectedMaxPlayers > 0)
			{
				hashtable[byte.MaxValue] = expectedMaxPlayers;
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			if (hashtable.Count > 0)
			{
				dictionary[248] = hashtable;
			}
			if (playerProperties != null && playerProperties.Count > 0)
			{
				dictionary[249] = playerProperties;
			}
			if (matchingType != 0)
			{
				dictionary[223] = (byte)matchingType;
			}
			if (typedLobby != null)
			{
				dictionary[213] = typedLobby.Name;
				dictionary[212] = (byte)typedLobby.Type;
			}
			if (!string.IsNullOrEmpty(sqlLobbyFilter))
			{
				dictionary[245] = sqlLobbyFilter;
			}
			return SendOperation(225, dictionary, SendOptions.SendReliable);
		}

		public virtual bool OpFindFriends(string[] friendsToFind)
		{
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			if (friendsToFind != null && friendsToFind.Length > 0)
			{
				dictionary[1] = friendsToFind;
			}
			return SendOperation(222, dictionary, SendOptions.SendReliable);
		}

		public bool OpSetCustomPropertiesOfActor(int actorNr, Hashtable actorProperties, bool broadcast, byte channelId)
		{
			return OpSetPropertiesOfActor(actorNr, actorProperties.StripToStringKeys(), broadcast, channelId, null);
		}

		protected internal bool OpSetPropertiesOfActor(int actorNr, Hashtable actorProperties, bool broadcast, byte channelId, Hashtable expectedValues)
		{
			if ((int)base.DebugOut >= 3)
			{
				base.Listener.DebugReturn(DebugLevel.INFO, "OpSetPropertiesOfActor()");
			}
			if (actorNr <= 0 || actorProperties == null)
			{
				if ((int)base.DebugOut >= 3)
				{
					base.Listener.DebugReturn(DebugLevel.INFO, "OpSetPropertiesOfActor not sent. ActorNr must be > 0 and actorProperties != null.");
				}
				return false;
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(251, actorProperties);
			dictionary.Add(254, actorNr);
			if (broadcast)
			{
				dictionary.Add(250, broadcast);
			}
			if (expectedValues != null && expectedValues.Count > 0)
			{
				dictionary.Add(231, expectedValues);
			}
			return SendOperation(252, dictionary, SendOptions.SendReliable);
		}

		protected void OpSetPropertyOfRoom(byte propCode, object value)
		{
			Hashtable hashtable = new Hashtable();
			hashtable[propCode] = value;
			OpSetPropertiesOfRoom(hashtable, true, 0, null);
		}

		public bool OpSetCustomPropertiesOfRoom(Hashtable gameProperties, bool broadcast, byte channelId)
		{
			return OpSetPropertiesOfRoom(gameProperties.StripToStringKeys(), broadcast, channelId, null);
		}

		protected internal bool OpSetPropertiesOfRoom(Hashtable gameProperties, bool broadcast, byte channelId, Hashtable expectedValues)
		{
			if ((int)base.DebugOut >= 3)
			{
				base.Listener.DebugReturn(DebugLevel.INFO, "OpSetPropertiesOfRoom()");
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(251, gameProperties);
			if (broadcast)
			{
				dictionary.Add(250, true);
			}
			if (expectedValues != null && expectedValues.Count > 0)
			{
				dictionary.Add(231, expectedValues);
			}
			return SendOperation(252, dictionary, SendOptions.SendReliable);
		}

		public virtual bool OpAuthenticate(string appId, string appVersion, AuthenticationValues authValues, string regionCode)
		{
			if ((int)base.DebugOut >= 3)
			{
				base.Listener.DebugReturn(DebugLevel.INFO, "OpAuthenticate()");
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			if (authValues != null && authValues.Token != null)
			{
				dictionary[221] = authValues.Token;
				return SendOperation(230, dictionary, SendOptions.SendReliable);
			}
			dictionary[220] = appVersion;
			dictionary[224] = appId;
			if (!string.IsNullOrEmpty(regionCode))
			{
				dictionary[210] = regionCode;
			}
			if (authValues != null)
			{
				if (!string.IsNullOrEmpty(authValues.UserId))
				{
					Debug.LogWarning("UserId sent: " + authValues.UserId);
					dictionary[225] = authValues.UserId;
				}
				if (authValues.AuthType != CustomAuthenticationType.None)
				{
					if (!IsProtocolSecure && !base.IsEncryptionAvailable)
					{
						base.Listener.DebugReturn(DebugLevel.ERROR, "OpAuthenticate() failed. When you want Custom Authentication encryption is mandatory.");
						return false;
					}
					dictionary[217] = (byte)authValues.AuthType;
					if (!string.IsNullOrEmpty(authValues.Token))
					{
						dictionary[221] = authValues.Token;
					}
					if (!string.IsNullOrEmpty(authValues.AuthGetParameters))
					{
						dictionary[216] = authValues.AuthGetParameters;
					}
					if (authValues.AuthPostData != null)
					{
						dictionary[214] = authValues.AuthPostData;
					}
				}
			}
			bool flag = SendOperation(230, dictionary, SendOptions.SendReliable);
			if (!flag)
			{
				base.Listener.DebugReturn(DebugLevel.ERROR, "Error calling OpAuthenticate! Did not work. Check log output, CustomAuthenticationValues and if you're connected.");
			}
			return flag;
		}

		public virtual bool OpChangeGroups(byte[] groupsToRemove, byte[] groupsToAdd)
		{
			if ((int)base.DebugOut >= 5)
			{
				base.Listener.DebugReturn(DebugLevel.ALL, "OpChangeGroups()");
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			if (groupsToRemove != null)
			{
				dictionary[239] = groupsToRemove;
			}
			if (groupsToAdd != null)
			{
				dictionary[238] = groupsToAdd;
			}
			return SendOperation(248, dictionary, SendOptions.SendReliable);
		}

		public virtual bool OpRaiseEvent(byte eventCode, object customEventContent, bool sendReliable, RaiseEventOptions raiseEventOptions)
		{
			opParameters.Clear();
			opParameters[244] = eventCode;
			if (customEventContent != null)
			{
				opParameters[245] = customEventContent;
			}
			if (raiseEventOptions == null)
			{
				raiseEventOptions = RaiseEventOptions.Default;
			}
			else
			{
				if (raiseEventOptions.CachingOption != 0)
				{
					opParameters[247] = (byte)raiseEventOptions.CachingOption;
				}
				if (raiseEventOptions.Receivers != 0)
				{
					opParameters[246] = (byte)raiseEventOptions.Receivers;
				}
				if (raiseEventOptions.InterestGroup != 0)
				{
					opParameters[240] = raiseEventOptions.InterestGroup;
				}
				if (raiseEventOptions.TargetActors != null)
				{
					opParameters[252] = raiseEventOptions.TargetActors;
				}
				if (raiseEventOptions.ForwardToWebhook)
				{
					opParameters[234] = true;
				}
			}
			return SendOperation(253, opParameters, SendOptions.SendReliable);
		}
	}
}
