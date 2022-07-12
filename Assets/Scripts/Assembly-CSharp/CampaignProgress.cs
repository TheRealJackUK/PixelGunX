using System;
using System.Collections.Generic;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

public sealed class CampaignProgress
{
	private const string CampaignProgressKey = "CampaignProgress";

	public static Dictionary<string, Dictionary<string, int>> boxesLevelsAndStars;

	static CampaignProgress()
	{
		boxesLevelsAndStars = new Dictionary<string, Dictionary<string, int>>();
		Storager.hasKey("CampaignProgress");
		LoadCampaignProgress();
		if (boxesLevelsAndStars.Keys.Count == 0)
		{
			boxesLevelsAndStars.Add(LevelBox.campaignBoxes[0].name, new Dictionary<string, int>());
			SaveCampaignProgress();
		}
	}

	public static void OpenNewBoxIfPossible()
	{
		int num = 0;
		for (int i = 1; i < LevelBox.campaignBoxes.Count; i++)
		{
			LevelBox levelBox = LevelBox.campaignBoxes[i];
			if (boxesLevelsAndStars.ContainsKey(levelBox.name))
			{
				num = i;
			}
		}
		int num2 = 0;
		foreach (KeyValuePair<string, Dictionary<string, int>> boxesLevelsAndStar in boxesLevelsAndStars)
		{
			foreach (KeyValuePair<string, int> item in boxesLevelsAndStar.Value)
			{
				num2 += item.Value;
			}
		}
		int num3 = num + 1;
		if (num3 < LevelBox.campaignBoxes.Count)
		{
			string name = LevelBox.campaignBoxes[num3].name;
			if (LevelBox.campaignBoxes[num3].starsToOpen <= num2 && !boxesLevelsAndStars.ContainsKey(name))
			{
				boxesLevelsAndStars.Add(name, new Dictionary<string, int>());
				SaveCampaignProgress();
				FlurryPluginWrapper.LogBoxOpened(name);
			}
		}
		SaveCampaignProgress();
	}

	public static bool FirstTimeCompletesLevel(string lev)
	{
		return !boxesLevelsAndStars[CurrentCampaignGame.boXName].ContainsKey(lev);
	}

	public static void SaveCampaignProgress()
	{
		SetProgressDictionary("CampaignProgress", boxesLevelsAndStars, false);
	}

	public static string GetCampaignProgressString()
	{
		return Storager.getString("CampaignProgress", false);
	}

	public static void LoadCampaignProgress()
	{
		Dictionary<string, Dictionary<string, int>> dictionary = (boxesLevelsAndStars = GetProgressDictionary("CampaignProgress", false));
	}

	internal static string SerializeProgress(Dictionary<string, Dictionary<string, int>> progress)
	{
		//Discarded unreachable code: IL_000e, IL_0051
		try
		{
			return Json.Serialize(progress);
		}
		catch (Exception ex)
		{
			Debug.LogError(ex);
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Message", ex.Message);
			Dictionary<string, string> dictionary2 = dictionary;
			FlurryPluginWrapper.LogEvent(ex.GetType().Name);
			return "{ }";
		}
	}

	internal static Dictionary<string, Dictionary<string, int>> DeserializeProgress(string serializedProgress)
	{
		Dictionary<string, Dictionary<string, int>> dictionary = new Dictionary<string, Dictionary<string, int>>();
		object obj = Json.Deserialize(serializedProgress);
		if (Debug.isDebugBuild && obj != null && BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			Type type = obj.GetType();
			Debug.Log("Deserialized progress type: " + type);
			Debug.Log("##### Serialized campaign progress:\n" + serializedProgress);
		}
		Dictionary<string, object> dictionary2 = obj as Dictionary<string, object>;
		if (dictionary2 != null)
		{
			foreach (KeyValuePair<string, object> item in dictionary2)
			{
				Dictionary<string, int> dictionary3 = new Dictionary<string, int>();
				IDictionary<string, object> dictionary4 = item.Value as IDictionary<string, object>;
				if (dictionary4 != null)
				{
					foreach (KeyValuePair<string, object> item2 in dictionary4)
					{
						try
						{
							int value = Convert.ToInt32(item2.Value);
							dictionary3.Add(item2.Key, value);
						}
						catch (InvalidCastException)
						{
							Debug.LogWarning(string.Concat("Cannot convert ", item2.Value, " to int."));
						}
					}
				}
				else if (Debug.isDebugBuild)
				{
					Debug.LogWarning("boxProgressDictionary == null");
				}
				dictionary.Add(item.Key, dictionary3);
			}
			return dictionary;
		}
		if (Debug.isDebugBuild)
		{
			Debug.LogWarning("campaignProgressDictionary == null,    serializedProgress == " + serializedProgress);
		}
		return dictionary;
	}

	private static void SetProgressDictionary(string key, Dictionary<string, Dictionary<string, int>> dictionary, bool useCloud)
	{
		string val = SerializeProgress(dictionary);
		Storager.setString(key, val, false);
		PlayerPrefs.Save();
	}

	private static Dictionary<string, Dictionary<string, int>> GetProgressDictionary(string key, bool useCloud)
	{
		string @string = Storager.getString(key, false);
		return DeserializeProgress(@string);
	}

	internal static Dictionary<string, Dictionary<string, int>> DeserializeTestDictionary()
	{
		string serializedProgress = "{\"Box_11\": { \"Level_02\": 1, \"Level_05\": 3 },\"Box_13\": { \"Level_03\": 1, \"Level_08\": 3, \"Level_21\": 2 },\"Box_34\": { },\"Box_99\": { \"Level_55\": 2 },}";
		return DeserializeProgress(serializedProgress);
	}
}
