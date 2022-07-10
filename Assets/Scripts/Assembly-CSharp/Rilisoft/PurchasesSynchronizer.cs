using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Rilisoft.MiniJson;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class PurchasesSynchronizer
	{
		public const string Filename = "Purchases";

		private const int Slot = 0;

		private static PurchasesSynchronizer _instance;

		public static PurchasesSynchronizer Instance
		{
			get
			{
				if (_instance == null)
				{
					_instance = new PurchasesSynchronizer();
				}
				return _instance;
			}
		}

		public static IEnumerable<string> AllItemIds()
		{
			Dictionary<string, string>.ValueCollection values = WeaponManager.storeIDtoDefsSNMapping.Values;
			List<string> list = new List<string>();
			foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item in Wear.wear)
			{
				foreach (List<string> item2 in item.Value)
				{
					list.AddRange(item2);
				}
			}
			IEnumerable<string> second = InAppData.inAppData.Values.Select((KeyValuePair<string, string> kv) => kv.Value);
			IEnumerable<string> second2 = from i in Enumerable.Range(1, ExperienceController.maxLevel - 1)
				select "currentLevel" + i;
			string[] second3 = new string[6]
			{
				Defs.SkinsMakerInProfileBought,
				Defs.hungerGamesPurchasedKey,
				Defs.CaptureFlagPurchasedKey,
				Defs.smallAsAntKey,
				Defs.code010110_Key,
				Defs.UnderwaterKey
			};
			string[] second4 = new string[1] { "PayingUser" };
			return values.Concat(list).Concat(second).Concat(second2)
				.Concat(second3)
				.Concat(second4);
		}

		public static IEnumerable<string> GetPurchasesIds()
		{
			IEnumerable<string> source = AllItemIds();
			return source.Where((string id) => Storager.getInt(id, false) != 0);
		}

		public void SynchronizeAmazonPurchases()
		{
			if (BuildSettings.BuildTarget != BuildTarget.Android || Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon)
			{
				Debug.LogWarning("SynchronizeAmazonPurchases() is not implemented for current target.");
				return;
			}
			AGSWhispersyncClient.Synchronize();
			using (AGSGameDataMap aGSGameDataMap = AGSWhispersyncClient.GetGameData())
			{
				if (aGSGameDataMap == null)
				{
					Debug.LogWarning("dataMap == null");
					return;
				}
				using (AGSSyncableStringSet aGSSyncableStringSet = aGSGameDataMap.GetStringSet("purchases"))
				{
					string[] array = (from s in aGSSyncableStringSet.GetValues()
						select s.GetValue()).ToArray();
					Debug.Log("Trying to sync purchases cloud -> local:    " + Json.Serialize(array));
					string[] array2 = array;
					foreach (string key in array2)
					{
						Storager.setInt(key, 1, false);
					}
					string[] array3 = GetPurchasesIds().ToArray();
					Debug.Log("Trying to sync purchases local -> cloud:    " + Json.Serialize(array3));
					string[] array4 = array3;
					foreach (string val in array4)
					{
						aGSSyncableStringSet.Add(val);
					}
					AGSWhispersyncClient.Synchronize();
					if (ExperienceController.sharedController != null)
					{
						ExperienceController.sharedController.Refresh();
					}
					if (ExpController.Instance != null)
					{
						ExpController.Instance.Refresh();
					}
				}
			}
		}

		public void AuthenticateAndSynchronize(Action<bool> callback, bool silent)
		{
				Debug.LogWarning("Authentication failed.");
		}

		private void SynchronizeIfAuthenticatedWithSavedGamesService(Action<bool> callback)
		{
		}

		private void SynchronizeIfAuthenticatedWithDeprecatedCloudSave(Action<bool> callback)
		{
		}

		public void SynchronizeIfAuthenticated(Action<bool> callback)
		{
				if (callback == null)
				{
					throw new ArgumentNullException("callback");
				}
				SynchronizeIfAuthenticatedWithSavedGamesService(callback);
				SynchronizeIfAuthenticatedWithDeprecatedCloudSave(callback);
		}
	}
}
