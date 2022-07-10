using System;
using System.Collections.Generic;
using EveryplayMiniJSON;

public static class EveryplayDictionaryExtensions
{
	public static bool TryGetValue<T>(this Dictionary<string, object> dict, string key, out T value)
	{
		//Discarded unreachable code: IL_0069
		if (dict != null && dict.ContainsKey(key))
		{
			if (dict[key].GetType() == typeof(T))
			{
				value = (T)dict[key];
				return true;
			}
			try
			{
				value = (T)Convert.ChangeType(dict[key], typeof(T));
				return true;
			}
			catch
			{
			}
		}
		value = default(T);
		return false;
	}

	public static Dictionary<string, object> JsonToDictionary(string json)
	{
		if (json != null && json.Length > 0)
		{
			return Json.Deserialize(json) as Dictionary<string, object>;
		}
		return null;
	}
}
