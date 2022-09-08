using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class InvBaseItem
{
	public enum Slot
	{
		None = 0,
		Weapon = 1,
		Shield = 2,
		Body = 3,
		Shoulders = 4,
		Bracers = 5,
		Boots = 6,
		Trinket = 7,
		_LastDoNotUse = 8,
	}

	public int id16;
	public string name;
	public string description;
	public Slot slot;
	public int minItemLevel;
	public int maxItemLevel;
	public List<InvStat> stats;
	public GameObject attachment;
	public Color color;
	public UIAtlas iconAtlas;
	public string iconName;
}
