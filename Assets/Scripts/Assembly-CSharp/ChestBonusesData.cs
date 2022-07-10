using System.Collections.Generic;

public class ChestBonusesData
{
	public int timeStart;

	public int duration;

	public List<ChestBonusData> bonuses;

	public void Clear()
	{
		if (bonuses != null)
		{
			for (int i = 0; i < bonuses.Count; i++)
			{
				bonuses[i].items.Clear();
			}
			bonuses.Clear();
		}
	}
}
