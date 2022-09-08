using System;

[Serializable]
public class InvStat
{
	public enum Identifier
	{
		Strength = 0,
		Constitution = 1,
		Agility = 2,
		Intelligence = 3,
		Damage = 4,
		Crit = 5,
		Armor = 6,
		Health = 7,
		Mana = 8,
		Other = 9,
	}

	public enum Modifier
	{
		Added = 0,
		Percent = 1,
	}

	public Identifier id;
	public Modifier modifier;
	public int amount;
}
