using System;
using System.Collections.Generic;
using UnityEngine;

namespace ExitGames.Client.Photon.Chat
{
	public class ChatClient : IPhotonPeerListener
	{
		private const string ChatApppName = "chat";

		private string chatRegion = "EU";

		public readonly Dictionary<string, ChatChannel> PublicChannels;

		public readonly Dictionary<string, ChatChannel> PrivateChannels;

		private readonly IChatClientListener listener;

		private ChatPeer chatPeer;

		private bool didAuthenticate;

		private int msDeltaForServiceCalls = 50;

		private int msTimestampOfLastServiceCall;

		public string FrontendAddress { get; private set; }

		public string ChatRegion
		{
			get
			{
				return chatRegion;
			}
			set
			{
				chatRegion = value;
			}
		}

		public AuthenticationValues CustomAuthenticationValues { get; set; }

		public ChatState State { get; private set; }

		public ChatDisconnectCause DisconnectedCause { get; private set; }

		public bool CanChat
		{
			get
			{
				return State == ChatState.ConnectedToFrontEnd && HasPeer;
			}
		}

		private bool HasPeer
		{
			get
			{
				return chatPeer != null;
			}
		}

		public string AppVersion { get; private set; }

		public string AppId { get; private set; }

		public string UserId { get; private set; }

		public ChatClient(IChatClientListener listener)
		{
			this.listener = listener;
			State = ChatState.Uninitialized;
			PublicChannels = new Dictionary<string, ChatChannel>();
			PrivateChannels = new Dictionary<string, ChatChannel>();
		}

		void IPhotonPeerListener.DebugReturn(DebugLevel level, string message)
		{
		}

		void IPhotonPeerListener.OnEvent(EventData eventData)
		{
			switch (eventData.Code)
			{
			case 0:
				HandleChatMessagesEvent(eventData);
				break;
			case 2:
				HandlePrivateMessageEvent(eventData);
				break;
			case 4:
				HandleStatusUpdate(eventData);
				break;
			case 5:
				HandleSubscribeEvent(eventData);
				break;
			case 6:
				HandleUnsubscribeEvent(eventData);
				break;
			case 1:
			case 3:
				break;
			}
		}

		void IPhotonPeerListener.OnOperationResponse(OperationResponse operationResponse)
		{
			switch (operationResponse.OperationCode)
			{
			case 230:
				HandleAuthResponse(operationResponse);
				return;
			}
			if (operationResponse.ReturnCode != 0)
			{
				((IPhotonPeerListener)this).DebugReturn(DebugLevel.ERROR, string.Format("Chat Operation {0} failed (Code: {1}). Debug Message: {2}", operationResponse.OperationCode, operationResponse.ReturnCode, operationResponse.DebugMessage));
			}
		}

		void IPhotonPeerListener.OnStatusChanged(StatusCode statusCode)
		{
			switch (statusCode)
			{
			case StatusCode.Connect:
				if (!chatPeer.IsProtocolSecure)
				{
					Debug.Log("Establishing Encryption");
					chatPeer.EstablishEncryption();
				}
				else
				{
					Debug.Log("Skipping Encryption");
					if (!didAuthenticate)
					{
						didAuthenticate = chatPeer.AuthenticateOnNameServer(AppId, AppVersion, chatRegion, UserId, CustomAuthenticationValues);
						if (!didAuthenticate)
						{
							((IPhotonPeerListener)this).DebugReturn(DebugLevel.ERROR, "Error calling OpAuthenticate! Did not work. Check log output, CustomAuthenticationValues and if you're connected. State: " + State);
						}
					}
				}
				if (State == ChatState.ConnectingToNameServer)
				{
					State = ChatState.ConnectedToNameServer;
					listener.OnChatStateChange(State);
				}
				else if (State == ChatState.ConnectingToFrontEnd)
				{
					AuthenticateOnFrontEnd();
				}
				break;
			case StatusCode.EncryptionEstablished:
				if (!didAuthenticate)
				{
					didAuthenticate = chatPeer.AuthenticateOnNameServer(AppId, AppVersion, chatRegion, UserId, CustomAuthenticationValues);
					if (!didAuthenticate)
					{
						((IPhotonPeerListener)this).DebugReturn(DebugLevel.ERROR, "Error calling OpAuthenticate! Did not work. Check log output, CustomAuthenticationValues and if you're connected. State: " + State);
					}
				}
				break;
			case StatusCode.EncryptionFailedToEstablish:
				State = ChatState.Disconnecting;
				chatPeer.Disconnect();
				break;
			case StatusCode.Disconnect:
				if (State == ChatState.Authenticated)
				{
					ConnectToFrontEnd();
					break;
				}
				State = ChatState.Disconnected;
				listener.OnChatStateChange(ChatState.Disconnected);
				listener.OnDisconnected();
				break;
			}
		}

		public bool Connect(string appId, string appVersion, string userId, AuthenticationValues authValues)
		{
			ConnectionProtocol protocol = ConnectionProtocol.Udp;
			return Connect(protocol, appId, appVersion, userId, authValues);
		}

		public bool Connect(ConnectionProtocol protocol, string appId, string appVersion, string userId, AuthenticationValues authValues)
		{
			if (!HasPeer)
			{
				chatPeer = new ChatPeer(this, protocol);
			}
			else
			{
				Disconnect();
				if (chatPeer.UsedProtocol != protocol)
				{
					chatPeer = new ChatPeer(this, protocol);
				}
			}
			chatPeer.TimePingInterval = 3000;
			DisconnectedCause = ChatDisconnectCause.None;
			CustomAuthenticationValues = authValues;
			UserId = userId;
			AppId = appId;
			AppVersion = appVersion;
			didAuthenticate = false;
			msDeltaForServiceCalls = 100;
			PublicChannels.Clear();
			PrivateChannels.Clear();
			bool flag = chatPeer.Connect();
			if (flag)
			{
				State = ChatState.ConnectingToNameServer;
			}
			return flag;
		}

		public void Service()
		{
			if (HasPeer && (Environment.TickCount - msTimestampOfLastServiceCall > msDeltaForServiceCalls || msTimestampOfLastServiceCall == 0))
			{
				msTimestampOfLastServiceCall = Environment.TickCount;
				chatPeer.Service();
			}
		}

		public void Disconnect()
		{
			if (HasPeer && chatPeer.PeerState != 0)
			{
				chatPeer.Disconnect();
			}
		}

		public void StopThread()
		{
			if (HasPeer)
			{
				chatPeer.StopThread();
			}
		}

		public bool Subscribe(string[] channels)
		{
			return Subscribe(channels, 0);
		}

		public bool Subscribe(string[] channels, int messagesFromHistory)
		{
			if (!CanChat)
			{
				return false;
			}
			if (channels == null || channels.Length == 0)
			{
				LogWarning("Subscribe can't be called for empty or null cannels-list.");
				return false;
			}
			return SendChannelOperation(channels, 0, messagesFromHistory);
		}

		public bool Unsubscribe(string[] channels)
		{
			if (!CanChat)
			{
				return false;
			}
			if (channels == null || channels.Length == 0)
			{
				LogWarning("Unsubscribe can't be called for empty or null cannels-list.");
				return false;
			}
			return SendChannelOperation(channels, 1, 0);
		}

		public bool PublishMessage(string channelName, object message)
		{
			if (!CanChat)
			{
				return false;
			}
			if (string.IsNullOrEmpty(channelName) || message == null)
			{
				LogWarning("PublishMessage parameters must be non-null and not empty.");
				return false;
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(1, channelName);
			dictionary.Add(3, message);
			Dictionary<byte, object> customOpParameters = dictionary;
			return chatPeer.OpCustom(2, customOpParameters, true);
		}

		public bool SendPrivateMessage(string target, object message)
		{
			return SendPrivateMessage(target, message, false);
		}

		public bool SendPrivateMessage(string target, object message, bool encrypt)
		{
			if (!CanChat)
			{
				return false;
			}
			if (string.IsNullOrEmpty(target) || message == null)
			{
				LogWarning("SendPrivateMessage parameters must be non-null and not empty.");
				return false;
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(225, target);
			dictionary.Add(3, message);
			Dictionary<byte, object> customOpParameters = dictionary;
			return chatPeer.OpCustom(3, customOpParameters, true, 0, encrypt);
		}

		private bool SetOnlineStatus(int status, object message, bool skipMessage)
		{
			if (!CanChat)
			{
				return false;
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(10, status);
			Dictionary<byte, object> dictionary2 = dictionary;
			if (skipMessage)
			{
				dictionary2[12] = true;
			}
			else
			{
				dictionary2[3] = message;
			}
			return chatPeer.OpCustom(5, dictionary2, true);
		}

		public bool SetOnlineStatus(int status)
		{
			return SetOnlineStatus(status, null, true);
		}

		public bool SetOnlineStatus(int status, object message)
		{
			return SetOnlineStatus(status, message, false);
		}

		public bool AddFriends(string[] friends)
		{
			if (!CanChat)
			{
				return false;
			}
			if (friends == null || friends.Length == 0)
			{
				LogWarning("AddFriends can't be called for empty or null list.");
				return false;
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(11, friends);
			Dictionary<byte, object> customOpParameters = dictionary;
			return chatPeer.OpCustom(6, customOpParameters, true);
		}

		public bool RemoveFriends(string[] friends)
		{
			if (!CanChat)
			{
				return false;
			}
			if (friends == null || friends.Length == 0)
			{
				LogWarning("RemoveFriends can't be called for empty or null list.");
				return false;
			}
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(11, friends);
			Dictionary<byte, object> customOpParameters = dictionary;
			return chatPeer.OpCustom(7, customOpParameters, true);
		}

		public string GetPrivateChannelNameByUser(string userName)
		{
			return string.Format("{0}:{1}", UserId, userName);
		}

		public bool TryGetChannel(string channelName, bool isPrivate, out ChatChannel channel)
		{
			if (!isPrivate)
			{
				return PublicChannels.TryGetValue(channelName, out channel);
			}
			return PrivateChannels.TryGetValue(channelName, out channel);
		}

		public void SendAcksOnly()
		{
			if (chatPeer != null)
			{
				chatPeer.SendAcksOnly();
			}
		}

		private bool SendChannelOperation(string[] channels, byte operation, int historyLength)
		{
			Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
			dictionary.Add(0, channels);
			Dictionary<byte, object> dictionary2 = dictionary;
			if (historyLength != 0)
			{
				dictionary2.Add(14, historyLength);
			}
			return chatPeer.OpCustom(operation, dictionary2, true);
		}

		private void HandlePrivateMessageEvent(EventData eventData)
		{
			object message = eventData.Parameters[3];
			string text = (string)eventData.Parameters[5];
			string privateChannelNameByUser;
			if (UserId != null && UserId.Equals(text))
			{
				string userName = (string)eventData.Parameters[225];
				privateChannelNameByUser = GetPrivateChannelNameByUser(userName);
			}
			else
			{
				privateChannelNameByUser = GetPrivateChannelNameByUser(text);
			}
			ChatChannel value;
			if (!PrivateChannels.TryGetValue(privateChannelNameByUser, out value))
			{
				value = new ChatChannel(privateChannelNameByUser);
				value.IsPrivate = true;
				PrivateChannels.Add(value.Name, value);
			}
			value.Add(text, message);
			listener.OnPrivateMessage(text, message, privateChannelNameByUser);
		}

		private void HandleChatMessagesEvent(EventData eventData)
		{
			object[] messages = (object[])eventData.Parameters[2];
			string[] senders = (string[])eventData.Parameters[4];
			string text = (string)eventData.Parameters[1];
			ChatChannel value;
			if (PublicChannels.TryGetValue(text, out value))
			{
				value.Add(senders, messages);
				listener.OnGetMessages(text, senders, messages);
			}
		}

		private void HandleSubscribeEvent(EventData eventData)
		{
			string[] array = (string[])eventData.Parameters[0];
			bool[] array2 = (bool[])eventData.Parameters[15];
			for (int i = 0; i < array.Length; i++)
			{
				if (array2[i])
				{
					string text = array[i];
					if (!PublicChannels.ContainsKey(text))
					{
						ChatChannel chatChannel = new ChatChannel(text);
						PublicChannels.Add(chatChannel.Name, chatChannel);
					}
				}
			}
			listener.OnSubscribed(array, array2);
		}

		private void HandleUnsubscribeEvent(EventData eventData)
		{
			string[] array = (string[])eventData[0];
			foreach (string key in array)
			{
				PublicChannels.Remove(key);
			}
			listener.OnUnsubscribed(array);
		}

		private void HandleAuthResponse(OperationResponse operationResponse)
		{
			((IPhotonPeerListener)this).DebugReturn(DebugLevel.INFO, operationResponse.ToStringFull() + " on: " + chatPeer.NameServerAddress);
			if (operationResponse.ReturnCode == 0)
			{
				if (State == ChatState.ConnectedToNameServer)
				{
					State = ChatState.Authenticated;
					listener.OnChatStateChange(State);
					if (operationResponse.Parameters.ContainsKey(221))
					{
						if (CustomAuthenticationValues == null)
						{
							CustomAuthenticationValues = new AuthenticationValues();
						}
						CustomAuthenticationValues.Secret = operationResponse[221] as string;
						FrontendAddress = (string)operationResponse[230];
						chatPeer.Disconnect();
					}
				}
				else if (State == ChatState.ConnectingToFrontEnd)
				{
					msDeltaForServiceCalls *= 4;
					State = ChatState.ConnectedToFrontEnd;
					listener.OnChatStateChange(State);
					listener.OnConnected();
				}
				return;
			}
			switch (operationResponse.ReturnCode)
			{
			case short.MaxValue:
				DisconnectedCause = ChatDisconnectCause.InvalidAuthentication;
				break;
			case 32755:
				DisconnectedCause = ChatDisconnectCause.CustomAuthenticationFailed;
				break;
			case 32756:
				DisconnectedCause = ChatDisconnectCause.InvalidRegion;
				break;
			case 32757:
				DisconnectedCause = ChatDisconnectCause.MaxCcuReached;
				break;
			case -3:
				DisconnectedCause = ChatDisconnectCause.OperationNotAllowedInCurrentState;
				break;
			}
			State = ChatState.Disconnecting;
			chatPeer.Disconnect();
		}

		private void HandleStatusUpdate(EventData eventData)
		{
			string user = (string)eventData.Parameters[5];
			int status = (int)eventData.Parameters[10];
			object message = null;
			bool flag = eventData.Parameters.ContainsKey(3);
			if (flag)
			{
				message = eventData.Parameters[3];
			}
			listener.OnStatusUpdate(user, status, flag, message);
		}

		private void ConnectToFrontEnd()
		{
			State = ChatState.ConnectingToFrontEnd;
			((IPhotonPeerListener)this).DebugReturn(DebugLevel.INFO, "Connecting to frontend " + FrontendAddress);
			chatPeer.Connect(FrontendAddress, "chat");
		}

		private bool AuthenticateOnFrontEnd()
		{
			if (CustomAuthenticationValues != null)
			{
				Dictionary<byte, object> dictionary = new Dictionary<byte, object>();
				dictionary.Add(221, CustomAuthenticationValues.Secret);
				Dictionary<byte, object> customOpParameters = dictionary;
				return chatPeer.OpCustom(230, customOpParameters, true);
			}
			return false;
		}

		private void LogWarning(string message)
		{
			Debug.LogWarning(message);
		}

		private void Log(string message)
		{
			Debug.Log(message);
		}
	}
}
