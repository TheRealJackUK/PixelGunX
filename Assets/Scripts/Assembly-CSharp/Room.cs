using ExitGames.Client.Photon;
using UnityEngine;

public class Room : RoomInfo
{
	public new int playerCount
	{
		get
		{
			if (PhotonNetwork.playerList != null)
			{
				return PhotonNetwork.playerList.Length;
			}
			return 0;
		}
	}

	public new string name
	{
		get
		{
			return nameField;
		}
		internal set
		{
			nameField = value;
		}
	}

	public new int maxPlayers
	{
		get
		{
			return maxPlayersField;
		}
		set
		{
			if (!Equals(PhotonNetwork.room))
			{
				Debug.LogWarning("Can't set maxPlayers when not in that room.");
			}
			if (value > 255)
			{
				Debug.LogWarning("Can't set Room.maxPlayers to: " + value + ". Using max value: 255.");
				value = 255;
			}
			if (value != maxPlayersField && !PhotonNetwork.offlineMode)
			{
				PhotonNetwork.networkingPeer.OpSetPropertiesOfRoom(new Hashtable { 
				{
					byte.MaxValue,
					(byte)value
				} }, true, 0, null);
			}
			maxPlayersField = (byte)value;
		}
	}

	public new bool open
	{
		get
		{
			return openField;
		}
		set
		{
			if (!Equals(PhotonNetwork.room))
			{
				Debug.LogWarning("Can't set open when not in that room.");
			}
			if (value != openField && !PhotonNetwork.offlineMode)
			{
				PhotonNetwork.networkingPeer.OpSetPropertiesOfRoom(new Hashtable { 
				{
					(byte)253,
					value
				} }, true, 0, null);
			}
			openField = value;
		}
	}

	public new bool visible
	{
		get
		{
			return visibleField;
		}
		set
		{
			if (!Equals(PhotonNetwork.room))
			{
				Debug.LogWarning("Can't set visible when not in that room.");
			}
			if (value != visibleField && !PhotonNetwork.offlineMode)
			{
				PhotonNetwork.networkingPeer.OpSetPropertiesOfRoom(new Hashtable { 
				{
					(byte)254,
					value
				} }, true, 0, null);
			}
			visibleField = value;
		}
	}

	public string[] propertiesListedInLobby { get; private set; }

	public bool autoCleanUp
	{
		get
		{
			return autoCleanUpField;
		}
	}

	protected internal int masterClientId
	{
		get
		{
			return masterClientIdField;
		}
		set
		{
			masterClientIdField = value;
		}
	}

	internal Room(string roomName, RoomOptions options)
		: base(roomName, null)
	{
		if (options == null)
		{
			options = new RoomOptions();
		}
		visibleField = options.isVisible;
		openField = options.isOpen;
		maxPlayersField = options.maxPlayers;
		autoCleanUpField = false;
		CacheProperties(options.customRoomProperties);
		propertiesListedInLobby = options.customRoomPropertiesForLobby;
	}

	public void SetCustomProperties(Hashtable propertiesToSet)
	{
		if (propertiesToSet != null)
		{
			base.customProperties.MergeStringKeys(propertiesToSet);
			base.customProperties.StripKeysWithNullValues();
			Hashtable gameProperties = propertiesToSet.StripToStringKeys();
			if (!PhotonNetwork.offlineMode)
			{
				PhotonNetwork.networkingPeer.OpSetCustomPropertiesOfRoom(gameProperties, true, 0);
			}
			NetworkingPeer.SendMonoMessage(PhotonNetworkingMessage.OnPhotonCustomRoomPropertiesChanged, propertiesToSet);
		}
	}

	public void SetCustomProperties(Hashtable propertiesToSet, Hashtable expectedValues)
	{
		if (propertiesToSet != null)
		{
			if (expectedValues == null || expectedValues.Count == 0)
			{
				Debug.LogWarning("SetCustomProperties(props, expected) requires some expectedValues. Use SetCustomProperties(props) to simply set some without check.");
			}
			else if (!PhotonNetwork.offlineMode)
			{
				Hashtable gameProperties = propertiesToSet.StripToStringKeys();
				Hashtable expectedValues2 = expectedValues.StripToStringKeys();
				PhotonNetwork.networkingPeer.OpSetPropertiesOfRoom(gameProperties, false, 0, expectedValues2);
			}
		}
	}

	public void SetPropertiesListedInLobby(string[] propsListedInLobby)
	{
		Hashtable hashtable = new Hashtable();
		hashtable[(byte)250] = propsListedInLobby;
		PhotonNetwork.networkingPeer.OpSetPropertiesOfRoom(hashtable, false, 0, null);
		propertiesListedInLobby = propsListedInLobby;
	}

	public override string ToString()
	{
		return string.Format("Room: '{0}' {1},{2} {4}/{3} players.", nameField, (!visibleField) ? "hidden" : "visible", (!openField) ? "closed" : "open", maxPlayersField, playerCount);
	}

	public new string ToStringFull()
	{
		return string.Format("Room: '{0}' {1},{2} {4}/{3} players.\ncustomProps: {5}", nameField, (!visibleField) ? "hidden" : "visible", (!openField) ? "closed" : "open", maxPlayersField, playerCount, base.customProperties.ToStringFull());
	}
}
