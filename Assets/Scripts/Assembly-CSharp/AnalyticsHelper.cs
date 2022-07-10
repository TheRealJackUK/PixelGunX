using Rilisoft;

internal sealed class AnalyticsHelper
{
	public const string AdStatisticsTotalEventName = "ADS Statistics Total";

	private AdvertisementInfo _advertisementContext = AdvertisementInfo.Default;

	private static readonly Lazy<AnalyticsHelper> _instance = new Lazy<AnalyticsHelper>(() => new AnalyticsHelper());

	public static AnalyticsHelper Instance
	{
		get
		{
			return _instance.Value;
		}
	}

	public AdvertisementInfo AdvertisementContext
	{
		get
		{
			return _advertisementContext;
		}
		set
		{
			_advertisementContext = value ?? AdvertisementInfo.Default;
		}
	}

	public static string GetAdProviderName(AdProvider provider)
	{
		return (provider != AdProvider.GoogleMobileAds) ? provider.ToString() : "AdMob";
	}
}
