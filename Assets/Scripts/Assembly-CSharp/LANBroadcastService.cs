using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using UnityEngine;

public class LANBroadcastService : MonoBehaviour
{
	private enum enuState
	{
		NotActive,
		Searching,
		Announcing
	}

	public struct ReceivedMessage
	{
		public string ipAddress;

		public string name;

		public string map;

		public int connectedPlayers;

		public int playerLimit;

		public string comment;

		public float fTime;

		public int regim;

		public string protocol;
	}

	public delegate void delJoinServer(string strIP);

	public delegate void delStartServer();

	public ReceivedMessage serverMessage;

	private string strMessage = string.Empty;

	private enuState currentState;

	private UdpClient objUDPClient;

	public List<ReceivedMessage> lstReceivedMessages;

	private delJoinServer delWhenServerFound;

	private delStartServer delWhenServerMustStarted;

	private string strServerNotReady = "wanttobeaserver";

	private string strServerReady = "iamaserver";

	private float fTimeLastMessageSent;

	private float fIntervalMessageSending = 1f;

	private float fTimeMessagesLive = 5f;

	private float fTimeToSearch = 5f;

	private float fTimeSearchStarted;

	private string ipaddress;

	public string Message
	{
		get
		{
			return strMessage;
		}
	}

	private void Start()
	{
		lstReceivedMessages = new List<ReceivedMessage>();
		ipaddress = PhotonNetwork.player.ID.ToString();
	}

	private void Update()
	{
		if (currentState == enuState.Announcing && Time.time > fTimeLastMessageSent + fIntervalMessageSending)
		{
			string s = strServerReady + "ý" + serverMessage.name + "ý" + serverMessage.map + "ý" + serverMessage.connectedPlayers + "ý" + serverMessage.playerLimit + "ý" + serverMessage.comment + "ý" + serverMessage.regim + "ý" + GlobalGameController.MultiplayerProtocolVersion;
			byte[] bytes = Encoding.Unicode.GetBytes(s);
			if (objUDPClient != null)
			{
				try
				{
					objUDPClient.Send(bytes, bytes.Length, new IPEndPoint(IPAddress.Broadcast, 22043));
				}
				catch (Exception)
				{
					Debug.Log("soccet close");
				}
			}
			else
			{
				Debug.Log("objUDPClient=NULL");
			}
			fTimeLastMessageSent = Time.time;
		}
		if (currentState == enuState.Searching)
		{
			bool flag = false;
			if (lstReceivedMessages == null)
			{
				return;
			}
			for (int i = 0; i < lstReceivedMessages.Count; i++)
			{
				ReceivedMessage item = lstReceivedMessages[i];
				if (item.fTime < 0f)
				{
					ReceivedMessage item2 = default(ReceivedMessage);
					item2.ipAddress = item.ipAddress;
					item2.name = item.name;
					item2.map = item.map;
					item2.connectedPlayers = item.connectedPlayers;
					item2.playerLimit = item.playerLimit;
					item2.comment = item.comment;
					item2.fTime = Time.time;
					item2.regim = item.regim;
					lstReceivedMessages.RemoveAt(i);
					lstReceivedMessages.Add(item2);
				}
				if (Time.time > item.fTime + fTimeMessagesLive)
				{
					lstReceivedMessages.Remove(item);
					break;
				}
			}
		}
		if (currentState != enuState.Searching)
		{
		}
	}

	private void BeginAsyncReceive()
	{
		if (objUDPClient != null)
		{
			objUDPClient.BeginReceive(EndAsyncReceive, null);
		}
	}

	private void EndAsyncReceive(IAsyncResult objResult)
	{
		if (objUDPClient == null)
		{
			return;
		}
		IPEndPoint remoteEP = new IPEndPoint(IPAddress.Any, 0);
		byte[] array = objUDPClient.EndReceive(objResult, ref remoteEP);
		if (array.Length > 0 && !remoteEP.Address.ToString().Equals(ipaddress))
		{
			string @string = Encoding.Unicode.GetString(array);
			string[] array2 = @string.Split(new char[1] { 'ý' }, @string.Length);
			if (array2.Length == 8 && array2[7].Equals(GlobalGameController.MultiplayerProtocolVersion))
			{
				for (int i = 0; i < lstReceivedMessages.Count; i++)
				{
					ReceivedMessage receivedMessage = lstReceivedMessages[i];
					if (remoteEP.Address.ToString().Equals(receivedMessage.ipAddress))
					{
						lstReceivedMessages.RemoveAt(i);
					}
				}
				ReceivedMessage item = default(ReceivedMessage);
				item.ipAddress = remoteEP.Address.ToString();
				item.name = array2[1];
				item.map = array2[2];
				item.connectedPlayers = int.Parse(array2[3]);
				item.playerLimit = int.Parse(array2[4]);
				item.comment = array2[5];
				item.regim = int.Parse(array2[6]);
				item.protocol = array2[7];
				item.fTime = -1f;
				lstReceivedMessages.Add(item);
			}
		}
		if (currentState == enuState.Searching)
		{
			BeginAsyncReceive();
		}
	}

	private void StartAnnouncing()
	{
		currentState = enuState.Announcing;
		strMessage = "Announcing we are a server...";
	}

	private void StopAnnouncing()
	{
		currentState = enuState.NotActive;
		strMessage = "Announcements stopped.";
	}

	private void StartSearching()
	{
		if (lstReceivedMessages == null)
		{
			lstReceivedMessages = new List<ReceivedMessage>();
		}
		lstReceivedMessages.Clear();
		BeginAsyncReceive();
		fTimeSearchStarted = Time.time;
		currentState = enuState.Searching;
		strMessage = "Searching for other players...";
	}

	private void StopSearching()
	{
		currentState = enuState.NotActive;
		strMessage = "Search stopped.";
	}

	public void StartSearchBroadCasting(delJoinServer connectToServer)
	{
		delWhenServerFound = connectToServer;
		StartBroadcastingSession();
		StartSearching();
	}

	public void StartAnnounceBroadCasting()
	{
		StartBroadcastingSession();
		StartAnnouncing();
	}

	private void StartBroadcastingSession()
	{
		if (currentState != 0)
		{
			StopBroadCasting();
		}
		objUDPClient = new UdpClient(22043);
		objUDPClient.EnableBroadcast = true;
		fTimeLastMessageSent = Time.time;
	}

	public void StopBroadCasting()
	{
		if (currentState == enuState.Searching)
		{
			StopSearching();
		}
		else if (currentState == enuState.Announcing)
		{
			StopAnnouncing();
		}
		if (objUDPClient != null)
		{
			UdpClient udpClient = objUDPClient;
			objUDPClient = null;
			udpClient.Close();
		}
	}

	private long ScoreOfIP(string strIP)
	{
		long num = 0L;
		string s = strIP.Replace(".", string.Empty);
		return long.Parse(s);
	}
}
