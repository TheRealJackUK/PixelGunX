using ExitGames.Client.Photon;

public class RoomInfo
{
	private Hashtable customPropertiesField = new Hashtable();

	protected byte maxPlayersField;

	protected bool openField = true;

	protected bool visibleField = true;

	protected bool autoCleanUpField = PhotonNetwork.autoCleanUpPlayerObjects;

	protected string nameField;

	protected internal int masterClientIdField;

	public bool removedFromList { get; internal set; }

	protected internal bool serverSideMasterClient { get; private set; }

	public Hashtable customProperties
	{
		get
		{
			return customPropertiesField;
		}
	}

	public string name
	{
		get
		{
			return nameField;
		}
	}

	public int playerCount { get; private set; }

	public bool isLocalClientInside { get; set; }

	public byte maxPlayers
	{
		get
		{
			return maxPlayersField;
		}
	}

	public bool open
	{
		get
		{
			return openField;
		}
	}

	public bool visible
	{
		get
		{
			return visibleField;
		}
	}

	protected internal RoomInfo(string roomName, Hashtable properties)
	{
		CacheProperties(properties);
		nameField = roomName;
	}

	public override bool Equals(object p)
	{
		Room room = p as Room;
		return room != null && nameField.Equals(room.nameField);
	}

	public override int GetHashCode()
	{
		return nameField.GetHashCode();
	}

	public override string ToString()
	{
		return string.Format("Room: '{0}' {1},{2} {4}/{3} players.", nameField, (!visibleField) ? "hidden" : "visible", (!openField) ? "closed" : "open", maxPlayersField, playerCount);
	}

	public string ToStringFull()
	{
		return string.Format("Room: '{0}' {1},{2} {4}/{3} players.\ncustomProps: {5}", nameField, (!visibleField) ? "hidden" : "visible", (!openField) ? "closed" : "open", maxPlayersField, playerCount, customPropertiesField.ToStringFull());
	}

	protected internal void CacheProperties(Hashtable propertiesToCache)
	{
		if (propertiesToCache == null || propertiesToCache.Count == 0 || customPropertiesField.Equals(propertiesToCache))
		{
			return;
		}
		if (propertiesToCache.ContainsKey((byte)251))
		{
			removedFromList = (bool)propertiesToCache[(byte)251];
			if (removedFromList)
			{
				return;
			}
		}
		if (propertiesToCache.ContainsKey(byte.MaxValue))
		{
			maxPlayersField = (byte)propertiesToCache[byte.MaxValue];
		}
		if (propertiesToCache.ContainsKey((byte)253))
		{
			openField = (bool)propertiesToCache[(byte)253];
		}
		if (propertiesToCache.ContainsKey((byte)254))
		{
			visibleField = (bool)propertiesToCache[(byte)254];
		}
		if (propertiesToCache.ContainsKey((byte)252))
		{
			playerCount = (byte)propertiesToCache[(byte)252];
		}
		if (propertiesToCache.ContainsKey((byte)249))
		{
			autoCleanUpField = (bool)propertiesToCache[(byte)249];
		}
		if (propertiesToCache.ContainsKey((byte)248))
		{
			serverSideMasterClient = true;
			bool flag = masterClientIdField != 0;
			masterClientIdField = (int)propertiesToCache[(byte)248];
			if (flag)
			{
				PhotonNetwork.networkingPeer.UpdateMasterClient();
			}
		}
		customPropertiesField.MergeStringKeys(propertiesToCache);
	}
}
