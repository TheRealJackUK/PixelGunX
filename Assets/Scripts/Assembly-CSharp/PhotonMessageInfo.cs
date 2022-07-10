public class PhotonMessageInfo
{
	private int timeInt;

	public PhotonPlayer sender;

	public PhotonView photonView;

	public double timestamp
	{
		get
		{
			uint num = (uint)timeInt;
			double num2 = num;
			return num2 / 1000.0;
		}
	}

	public PhotonMessageInfo()
	{
		sender = PhotonNetwork.player;
		timeInt = (int)(PhotonNetwork.time * 1000.0);
		photonView = null;
	}

	public PhotonMessageInfo(PhotonPlayer player, int timestamp, PhotonView view)
	{
		sender = player;
		timeInt = timestamp;
		photonView = view;
	}

	public override string ToString()
	{
		return string.Format("[PhotonMessageInfo: Sender='{1}' Senttime={0}]", timestamp, sender);
	}
}
