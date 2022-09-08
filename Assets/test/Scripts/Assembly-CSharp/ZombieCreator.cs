using UnityEngine;
using System.Collections.Generic;

public class ZombieCreator : MonoBehaviour
{
	public GameObject weaponBonus;
	public int currentWave;
	public List<GameObject> waveZombiePrefabs;
	public GUIStyle labelStyle;
	public bool bossShowm;
	public bool stopGeneratingBonuses;
	public List<GameObject> zombiePrefabs;
	public float curInterval;
}
