using System.Collections;
using System.Collections.Generic;

public class AGSScore
{
	public AGSPlayer player;

	public int rank;

	public string scoreString;

	public long scoreValue;

	public static AGSScore fromHashtable(Hashtable scoreHashTable)
	{
		AGSScore aGSScore = new AGSScore();
		aGSScore.player = AGSPlayer.fromHashtable(scoreHashTable["player"] as Hashtable);
		aGSScore.rank = int.Parse(scoreHashTable["rank"].ToString());
		aGSScore.scoreString = scoreHashTable["scoreString"].ToString();
		aGSScore.scoreValue = long.Parse(scoreHashTable["score"].ToString());
		return aGSScore;
	}

	public static List<AGSScore> fromArrayList(ArrayList list)
	{
		List<AGSScore> list2 = new List<AGSScore>();
		foreach (Hashtable item in list)
		{
			list2.Add(fromHashtable(item));
		}
		return list2;
	}

	public override string ToString()
	{
		return string.Format("player: {0}, rank: {1}, scoreValue: {2}, scoreString: {3}", player.ToString(), rank, scoreValue, scoreString);
	}
}
