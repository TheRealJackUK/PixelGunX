using System;
using Rilisoft;

public class StarterPackModel
{
	public enum TypePack
	{
		Items,
		Coins,
		Gems,
		None
	}

	public enum TypeCost
	{
		Money,
		Gems,
		InApp,
		None
	}

	public const int MaxCountShownWindow = 1;

	private const float HoursToShowWindow = 8f;

	public const string pathToCoinsImage = "Textures/Bank/Coins_Shop_5";

	public const string pathToGemsImage = "Textures/Bank/Coins_Shop_Gem_5";

	public const string pathToGemsPackImage = "Textures/Bank/StarterPack_Gem";

	public const string pathToCoinsPackImage = "Textures/Bank/StarterPack_Gold";

	public const string pathToItemsPackImage = "Textures/Bank/StarterPack_Weapon";

	public static TimeSpan TimeOutShownWindow = TimeSpan.FromHours(8.0);

	public static TimeSpan MaxLiveTimeEvent = TimeSpan.FromDays(1.0);

	public static TimeSpan CooldownTimeEvent = TimeSpan.FromDays(1.5);

	public static string[] packNameLocalizeKey = new string[8] { "Key_1049", "Key_1050", "Key_1051", "Key_1052", "Key_1053", "Key_1054", "Key_1055", "Key_1056" };

	public static int[] savingMoneyForBuyPack = new int[8] { 7, 5, 17, 14, 27, 21, 22, 42 };

	public static DateTime GetTimeDataEvent(string timeEventKey)
	{
		DateTime result = default(DateTime);
		string @string = Storager.getString(timeEventKey, false);
		DateTime.TryParse(@string, out result);
		return result;
	}

	public static string GetUrlForDownloadEventData()
	{
		string arg = "https://secure.pixelgunserver.com/";
		string empty = string.Empty;
		empty = (Defs.IsDeveloperBuild ? "starter_pack_test.json" : ((BuildSettings.BuildTarget == BuildTarget.Android) ? ((Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon) ? "starter_pack_android.json" : "starter_pack_amazon.json") : ((BuildSettings.BuildTarget != BuildTarget.WP8Player) ? "starter_pack_ios.json" : "starter_pack_wp8.json")));
		return string.Format("{0}{1}", arg, empty);
	}

	public static DateTime GetCurrentTimeByUnixTime(int unixTime)
	{
		return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc).AddSeconds(unixTime);
	}
}
