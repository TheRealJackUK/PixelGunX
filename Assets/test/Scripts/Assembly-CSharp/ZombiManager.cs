using UnityEngine;
using System.Collections.Generic;

public class ZombiManager : MonoBehaviour
{
	public double timeGame;
	public float nextTimeSynch;
	public float nextAddZombi;
	public List<GameObject> zombiePrefabs;
	public bool startGame;
	public double maxTimeGame;
	public PhotonView photonView;
}
