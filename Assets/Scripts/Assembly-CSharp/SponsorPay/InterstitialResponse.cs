namespace SponsorPay
{
	public class InterstitialResponse : AbstractResponse
	{
		public string error { get; set; }

		public bool adsAvailable { get; set; }
	}
}
