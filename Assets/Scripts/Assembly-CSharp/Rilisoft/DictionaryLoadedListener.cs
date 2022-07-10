using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Rilisoft
{
	internal sealed class DictionaryLoadedListener : StateLoadedListenerBase
	{

		internal static string MergeProgress(string localDataString, string serverDataString)
		{
			Dictionary<string, Dictionary<string, int>> dictionary = CampaignProgress.DeserializeProgress(localDataString);
			if (dictionary == null)
			{
				dictionary = new Dictionary<string, Dictionary<string, int>>();
			}
			Dictionary<string, Dictionary<string, int>> dictionary2 = CampaignProgress.DeserializeProgress(serverDataString);
			if (dictionary2 == null)
			{
				dictionary2 = new Dictionary<string, Dictionary<string, int>>();
			}
			Dictionary<string, Dictionary<string, int>> dictionary3 = new Dictionary<string, Dictionary<string, int>>();
			foreach (string item in dictionary.Keys.Concat(dictionary2.Keys).Distinct())
			{
				dictionary3.Add(item, new Dictionary<string, int>());
			}
			foreach (KeyValuePair<string, Dictionary<string, int>> item2 in dictionary3)
			{
				Dictionary<string, int> value;
				if (dictionary.TryGetValue(item2.Key, out value))
				{
					foreach (KeyValuePair<string, int> item3 in value)
					{
						item2.Value.Add(item3.Key, item3.Value);
					}
				}
				Dictionary<string, int> value2;
				if (!dictionary2.TryGetValue(item2.Key, out value2))
				{
					continue;
				}
				foreach (KeyValuePair<string, int> item4 in value2)
				{
					int value3;
					if (item2.Value.TryGetValue(item4.Key, out value3))
					{
						item2.Value[item4.Key] = Math.Max(value3, item4.Value);
					}
					else
					{
						item2.Value.Add(item4.Key, item4.Value);
					}
				}
			}
			return CampaignProgress.SerializeProgress(dictionary3);
		}

		protected override string HandleStateConflict(int slot, string localDataString, string serverDataString)
		{
			return MergeProgress(localDataString, serverDataString);
		}
	}
}
