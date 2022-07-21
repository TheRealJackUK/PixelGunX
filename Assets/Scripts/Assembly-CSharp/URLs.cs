using System.IO;
using System.Text;
using Rilisoft;
using UnityEngine;

public class URLs
{
	public static string BanURL = "https://secure.pixelgunserver.com/getBanList.php";

	public static string PopularityMapUrl = "http://secure.pixelgunserver.com/mapstat.txt";

	public static string PromoActions
	{
		get
		{
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				return (Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon) ? "https://secure.pixelgunserver.com/promo_actions_android.php" : "https://secure.pixelgunserver.com/promo_actions_amazon.php";
			}
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				return "https://secure.pixelgunserver.com/promo_actions_wp8.php";
			}
			return "https://secure.pixelgunserver.com/promo_actions.php";
		}
	}

	public static string PromoActionsTest
	{
		get
		{
			return "https://secure.pixelgunserver.com/promo_actions_test.php";
		}
	}

	public static string EventX3
	{
		get
		{
			if (Defs.IsDeveloperBuild)
			{
				return "https://secure.pixelgunserver.com/event_x3_test.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				return "https://secure.pixelgunserver.com/event_x3_ios.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
				{
					return "https://secure.pixelgunserver.com/event_x3_android.json";
				}
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					return "https://secure.pixelgunserver.com/event_x3_amazon.json";
				}
				return string.Empty;
			}
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				return "https://secure.pixelgunserver.com/event_x3_wp8.json";
			}
			return string.Empty;
		}
	}

	public static string Advert
	{
		get
		{
			if (Defs.IsDeveloperBuild)
			{
				if (BuildSettings.BuildTarget == BuildTarget.iPhone)
				{
					return "https://secure.pixelgunserver.com/advert_ios_TEST.json";
				}
				if (BuildSettings.BuildTarget == BuildTarget.Android)
				{
					if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
					{
						return "https://secure.pixelgunserver.com/advert_amazon_TEST.json";
					}
					return "https://secure.pixelgunserver.com/advert_android_TEST.json";
				}
				return string.Empty;
			}
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				return "https://secure.pixelgunserver.com/advert_ios.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					return "https://secure.pixelgunserver.com/advert_amazon.json";
				}
				return "https://secure.pixelgunserver.com/advert_android.json";
			}
			return string.Empty;
		}
	}

	public static string BestBuy
	{
		get
		{
			if (Defs.IsDeveloperBuild)
			{
				return "https://secure.pixelgunserver.com/best_buy_test.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				return "https://secure.pixelgunserver.com/best_buy_ios.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
				{
					return "https://secure.pixelgunserver.com/best_buy_android.json";
				}
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					return "https://secure.pixelgunserver.com/best_buy_amazon.json";
				}
				return string.Empty;
			}
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				return "https://secure.pixelgunserver.com/best_buy_wp8.json";
			}
			return string.Empty;
		}
	}

	public static string DayOfValor
	{
		get
		{
			if (Defs.IsDeveloperBuild)
			{
				return "https://secure.pixelgunserver.com/days_of_valor_test.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				return "https://secure.pixelgunserver.com/days_of_valor_ios.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
				{
					return "https://secure.pixelgunserver.com/days_of_valor_android.json";
				}
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					return "https://secure.pixelgunserver.com/days_of_valor_amazon.json";
				}
				return string.Empty;
			}
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				return "https://secure.pixelgunserver.com/days_of_valor_wp8.json";
			}
			return string.Empty;
		}
	}

	public static string PremiumAccount
	{
		get
		{
			if (Defs.IsDeveloperBuild)
			{
				return "https://secure.pixelgunserver.com/premium_account_test.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				return "https://secure.pixelgunserver.com/premium_account_ios.json";
			}
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
				{
					return "https://secure.pixelgunserver.com/premium_account_android.json";
				}
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					return "https://secure.pixelgunserver.com/premium_account_amazon.json";
				}
				return string.Empty;
			}
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				return "https://secure.pixelgunserver.com/premium_account_wp8.json";
			}
			return string.Empty;
		}
	}

	public static string Friends
	{
		get
		{
			return "http://oldpg3d.7m.pl/~pgx/action.php";
		}
	}

	internal static string Sanitize(WWW request)
	{
		//Discarded unreachable code: IL_006c
		if (!string.IsNullOrEmpty(request.error))
		{
			return string.Empty;
		}
		UTF8Encoding uTF8Encoding = new UTF8Encoding(false);
		if (BuildSettings.BuildTarget != BuildTarget.WP8Player)
		{
			return uTF8Encoding.GetString(request.bytes, 0, request.bytes.Length).Trim();
		}
		using (StreamReader streamReader = new StreamReader(new MemoryStream(request.bytes), uTF8Encoding))
		{
			return streamReader.ReadToEnd().Trim();
		}
	}
}
