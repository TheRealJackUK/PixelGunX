using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Rilisoft
{
	internal static class FlurryEvents
	{
		public const string CoinsGained = "Coins Gained";

		public const string FeatureEnabled = "Feature Enabled";

		public const string ShopPurchasesFormat = "Shop Purchases {0}";

		public const string TimeWeaponsFormat = "Time Weapons {0}";

		public const string TimeWeaponsRedFormat = "Time Weapons (red test) {0}";

		public const string TimeArmorAndHatFormat = "Time Armor and Hat {0}";

		public const string GemsFormat = "Purchase for Gems {0}";

		public const string GemsTempArmorFormat = "Purchase for Gems TempArmor {0}";

		public const string CoinsFormat = "Purchase for Coins {0}";

		public const string CoinsTempArmorFormat = "Purchase for Coins TempArmor {0}";

		public const string TrainingProgress = "Training Progress";

		public const string PurchaseAfterPayment = "Purchase After Payment";

		public const string PurchaseAfterPaymentCumulative = "Purchase After Payment Cumulative";

		public const string FastPurchase = "Fast Purchase";

		public const string AfterTraining = "After Training";

		public static float? PaymentTime { get; set; }

		public static void LogAfterTraining(string action, bool trainingState)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add((!trainingState) ? "Skipped" : "Completed", action ?? string.Empty);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("After Training", parameters);
		}

		public static void LogCoinsGained(string mode, int coinCount)
		{
			mode = mode ?? string.Empty;
			string value = ((!(ExperienceController.sharedController != null)) ? "Unknown" : ExperienceController.sharedController.currentLevel.ToString());
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Total", mode);
			dictionary.Add(mode + " (Rank)", value);
			Dictionary<string, string> dictionary2 = dictionary;
			if (coinCount >= 1000)
			{
				string eventName = "Coins Gained Suspiciously Large Amount";
				dictionary2.Add("Amount", coinCount.ToString());
				FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, dictionary2);
				return;
			}
			int num = coinCount;
			int num2 = 1;
			while (num > 0 && num2 < 100)
			{
				int num3 = num % 10;
				string eventName2 = string.Format("{0} x{1}", "Coins Gained", num2);
				for (int i = 0; i < num3; i++)
				{
					FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName2, dictionary2);
				}
				num /= 10;
				num2 *= 10;
			}
			if (num > 0)
			{
				string eventName3 = string.Format("{0} x{1}", "Coins Gained", 100);
				for (int j = 0; j < num; j++)
				{
					FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName3, dictionary2);
				}
			}
		}

		public static void LogGemsGained(string mode, int gemsCount)
		{
		}

		public static void LogTrainingProgress(string kind)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Kind", kind);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Training Progress", parameters);
		}

		public static string GetPlayingMode()
		{
			if (Application.loadedLevelName == Defs.MainMenuScene)
			{
				return "Main Menu";
			}
			if (Application.loadedLevelName.Equals("ConnectScene", StringComparison.OrdinalIgnoreCase))
			{
				return "Connect Scene";
			}
			if (!Defs.IsSurvival && !Defs.isMulti)
			{
				return "Campaign";
			}
			if (Defs.IsSurvival)
			{
				return (!Defs.isMulti) ? "Survival" : "Time Survival";
			}
			if (Defs.isCompany)
			{
				return "Team Battle";
			}
			if (Defs.isFlag)
			{
				return "Flag Capture";
			}
			if (Defs.isHunger)
			{
				return "Deadly Games";
			}
			if (Defs.isCapturePoints)
			{
				return "Capture Points";
			}
			return (!Defs.isInet) ? "Deathmatch Local" : "Deathmatch Worldwide";
		}

		internal static void StartLoggingGameModeEvent()
		{
			string gameModeEventName = GetGameModeEventName(GetPlayingMode());
			StartLoggingGameModeEvent(gameModeEventName);
		}

		internal static void StopLoggingGameModeEvent()
		{
			string[] source = new string[10] { "Main Menu", "Connect Scene", "Campaign", "Time Survival", "Survival", "Team Battle", "Flag Capture", "Deadly Games", "Deathmatch Worldwide", "Deathmatch Local" };
			IEnumerable<string> enumerable = source.Select(GetGameModeEventName);
			foreach (string item in enumerable)
			{
				StopLoggingGameModeEvent(item);
			}
		}

		private static void StartLoggingGameModeEvent(string eventName)
		{
			FlurryPluginWrapper.LogTimedEventAndDublicateToConsole(eventName);
		}

		internal static void StopLoggingGameModeEvent(string eventName)
		{
			FlurryPluginWrapper.EndTimedEvent(eventName);
		}

		private static string GetGameModeEventName(string gameMode)
		{
			return "Game Mode " + gameMode;
		}
	}
}
