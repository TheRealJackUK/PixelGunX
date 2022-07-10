using System;
using System.Collections.Generic;
using Rilisoft.MiniJson;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class Statistics
	{
		private readonly Dictionary<string, int> _weaponToPopularity;

		private readonly List<Dictionary<string, int>> _weaponToPopularityForTier;

		private readonly Dictionary<string, int> _armorToPopularity;

		private readonly List<Dictionary<string, int>> _armorToPopularityForTier;

		private readonly Dictionary<int, Dictionary<string, int>> _armorToPopularityForLevel;

		private static Statistics _instance;

		public static Statistics Instance
		{
			get
			{
				if (_instance == null)
				{
					_instance = new Statistics();
				}
				return _instance;
			}
		}

		public Statistics()
		{
			_weaponToPopularity = LoadPopularityFromPlayerPrefs("Statistics.WeaponPopularity");
			_weaponToPopularityForTier = LoadPopularityForTierFromPlayerPrefs("Statistics.WeaponPopularityForTier");
			_armorToPopularity = LoadPopularityFromPlayerPrefs("Statistics.ArmorPopularity");
			_armorToPopularityForTier = LoadPopularityForTierFromPlayerPrefs("Statistics.ArmorPopularityForTier");
			_armorToPopularityForLevel = LoadPopularityForLevelFromPlayerPrefs("Statistics.ArmorPopularityForLevel");
		}

		private Dictionary<string, int> LoadPopularityFromPlayerPrefs(string playerPrefsKey)
		{
			Dictionary<string, int> dictionary = new Dictionary<string, int>();
			string @string = PlayerPrefs.GetString(playerPrefsKey, "{}");
			Dictionary<string, object> dictionary2 = Json.Deserialize(@string) as Dictionary<string, object>;
			if (dictionary2 == null)
			{
				return dictionary;
			}
			foreach (KeyValuePair<string, object> item in dictionary2)
			{
				dictionary.Add(item.Key, Convert.ToInt32(item.Value));
			}
			return dictionary;
		}

		private List<Dictionary<string, int>> LoadPopularityForTierFromPlayerPrefs(string playerPrefsKey)
		{
			List<Dictionary<string, int>> list = new List<Dictionary<string, int>>();
			for (int i = 0; i < ExpController.LevelsForTiers.Length; i++)
			{
				list.Add(new Dictionary<string, int>());
			}
			string @string = PlayerPrefs.GetString(playerPrefsKey, "{}");
			List<object> list2 = Json.Deserialize(@string) as List<object>;
			if (list2 == null)
			{
				return list;
			}
			for (int j = 0; j < ExpController.LevelsForTiers.Length; j++)
			{
				if (j >= list2.Count)
				{
					continue;
				}
				Dictionary<string, object> dictionary = list2[j] as Dictionary<string, object>;
				foreach (KeyValuePair<string, object> item in dictionary)
				{
					list[j].Add(item.Key, Convert.ToInt32(item.Value));
				}
			}
			return list;
		}

		private Dictionary<int, Dictionary<string, int>> LoadPopularityForLevelFromPlayerPrefs(string playerPrefsKey)
		{
			Dictionary<int, Dictionary<string, int>> dictionary = new Dictionary<int, Dictionary<string, int>>();
			string @string = PlayerPrefs.GetString(playerPrefsKey, "{}");
			Dictionary<string, object> dictionary2 = Json.Deserialize(@string) as Dictionary<string, object>;
			if (dictionary2 == null)
			{
				return dictionary;
			}
			foreach (KeyValuePair<string, object> item in dictionary2)
			{
				int key = Convert.ToInt32(item.Key);
				Dictionary<string, int> value;
				if (!dictionary.TryGetValue(key, out value))
				{
					value = new Dictionary<string, int>();
					dictionary.Add(key, value);
				}
				Dictionary<string, object> dictionary3 = item.Value as Dictionary<string, object>;
				foreach (KeyValuePair<string, object> item2 in dictionary3)
				{
					value.Add(item2.Key, Convert.ToInt32(item2.Value));
				}
			}
			return dictionary;
		}

		public string[] GetMostPopularWeapons()
		{
			return GetMostPopularFrom(_weaponToPopularity);
		}

		public string[] GetMostPopularWeaponsForTier(int tier)
		{
			return GetMostPopularFrom(_weaponToPopularityForTier[tier]);
		}

		public string[] GetMostPopularArmors()
		{
			return GetMostPopularFrom(_armorToPopularity);
		}

		public string[] GetMostPopularArmorsForTier(int tier)
		{
			return GetMostPopularFrom(_armorToPopularityForTier[tier]);
		}

		public string[] GetMostPopularArmorsForLevel(int level)
		{
			Dictionary<string, int> value;
			if (_armorToPopularityForLevel.TryGetValue(level, out value))
			{
				return GetMostPopularFrom(value);
			}
			return new string[0];
		}

		private string[] GetMostPopularFrom(Dictionary<string, int> popularityMap)
		{
			int num = 0;
			foreach (KeyValuePair<string, int> item in popularityMap)
			{
				if (item.Value > num)
				{
					num = item.Value;
				}
			}
			if (num == 0)
			{
				return new string[0];
			}
			List<string> list = new List<string>();
			foreach (KeyValuePair<string, int> item2 in popularityMap)
			{
				if (item2.Value == num)
				{
					list.Add(item2.Key);
				}
			}
			return list.ToArray();
		}

		public void IncrementWeaponPopularity(string key, bool save = true)
		{
			IncrementPopularity(_weaponToPopularity, key);
			int ourTier = ExpController.Instance.OurTier;
			Dictionary<string, int> popularityDict = _weaponToPopularityForTier[ourTier];
			IncrementPopularity(popularityDict, key);
			if (save)
			{
				SaveWeaponPopularity();
			}
		}

		public void IncrementArmorPopularity(string key, bool save = true)
		{
			IncrementPopularity(_armorToPopularity, key);
			int ourTier = ExpController.Instance.OurTier;
			Dictionary<string, int> popularityDict = _armorToPopularityForTier[ourTier];
			IncrementPopularity(popularityDict, key);
			int currentLevel = ExperienceController.sharedController.currentLevel;
			Dictionary<string, int> value;
			if (!_armorToPopularityForLevel.TryGetValue(currentLevel, out value))
			{
				value = new Dictionary<string, int>();
				_armorToPopularityForLevel.Add(currentLevel, value);
			}
			IncrementPopularity(value, key);
			if (save)
			{
				SaveArmorPopularity();
			}
		}

		private void IncrementPopularity(Dictionary<string, int> popularityDict, string key)
		{
			int value;
			if (popularityDict.TryGetValue(key, out value))
			{
				popularityDict[key] = value + 1;
			}
			else
			{
				popularityDict.Add(key, 1);
			}
		}

		public void SaveWeaponPopularity()
		{
			SavePopularityInfo("Statistics.WeaponPopularity", _weaponToPopularity);
			SavePopularityInfo("Statistics.WeaponPopularityForTier", _weaponToPopularityForTier);
			PlayerPrefs.Save();
		}

		public void SaveArmorPopularity()
		{
			SavePopularityInfo("Statistics.ArmorPopularity", _armorToPopularity);
			SavePopularityInfo("Statistics.ArmorPopularityForLevel", _armorToPopularityForLevel);
			SavePopularityInfo("Statistics.ArmorPopularityForTier", _armorToPopularityForTier);
			PlayerPrefs.Save();
		}

		private void SavePopularityInfo(string playerPrefsKey, object popularityInfo)
		{
			string text = Json.Serialize(popularityInfo);
			if (Debug.isDebugBuild)
			{
				Debug.Log(string.Format("Saving: playerPrefsKey: {0}, popularityInfo: {1}", playerPrefsKey, text));
			}
			PlayerPrefs.SetString(playerPrefsKey, text);
		}
	}
}
