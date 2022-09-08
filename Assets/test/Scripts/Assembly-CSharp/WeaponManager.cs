using UnityEngine;
using System.Collections.Generic;

public class WeaponManager : MonoBehaviour
{
	public GameObject _grenadeWeaponCache;
	public GameObject _turretWeaponCache;
	public GameObject _rocketCache;
	public GameObject _turretCache;
	public List<int> newWeaponsInCats;
	public List<string> shownWeapons;
	public string ServerIp;
	public GameObject myPlayer;
	public Player_move_c myPlayerMoveC;
	public GameObject myGun;
	public GameObject myTable;
	public NetworkStartTable myNetworkStartTable;
	public int CurrentWeaponIndex;
	public Camera useCam;
	public int _currentFilterMap;
}
