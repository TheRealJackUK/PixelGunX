using Photon;
using UnityEngine;

public class SettingBonus : Photon.MonoBehaviour
{
	public int typeOfMass;

	public int numberSpawnZone = -1;

	private void Start()
	{
	}

	public void SetNumberSpawnZone(int _number)
	{
		base.photonView.RPC("SynchNamberSpawnZoneRPC", PhotonTargets.AllBuffered, _number);
	}

	[PunRPC]
	public void SynchNamberSpawnZoneRPC(int _number)
	{
		numberSpawnZone = _number;
	}

	private void Update()
	{
	}
}
