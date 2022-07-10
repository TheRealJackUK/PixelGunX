using Rilisoft;
using UnityEngine;

public class ChestBonusModel : MonoBehaviour
{
	public const string pathToCommonBonusItems = "Textures/Bank/StarterPack_Weapon";

	public static string GetUrlForDownloadBonusesData()
	{
		string arg = "https://secure.pixelgunserver.com/";
		string empty = string.Empty;
		empty = (Defs.IsDeveloperBuild ? "chest_bonus_test.json" : ((BuildSettings.BuildTarget == BuildTarget.Android) ? ((Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon) ? "chest_bonus_android.json" : "chest_bonus_amazon.json") : ((BuildSettings.BuildTarget != BuildTarget.WP8Player) ? "chest_bonus_ios.json" : "chest_bonus_wp8.json")));
		return string.Format("{0}{1}", arg, empty);
	}
}
