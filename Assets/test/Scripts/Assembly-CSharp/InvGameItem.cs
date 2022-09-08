using System;
using UnityEngine;

[Serializable]
public class InvGameItem
{
	public enum Quality
	{
		Broken = 0,
		Cursed = 1,
		Damaged = 2,
		Worn = 3,
		Sturdy = 4,
		Polished = 5,
		Improved = 6,
		Crafted = 7,
		Superior = 8,
		Enchanted = 9,
		Epic = 10,
		Legendary = 11,
		_LastDoNotUse = 12,
	}

	public InvGameItem(int int_1)
	{
	}

	[SerializeField]
	private int int_0;
	public Quality quality;
	public int itemLevel;
}
