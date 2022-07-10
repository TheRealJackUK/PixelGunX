namespace SponsorPay
{
	public class VCSResponse : AbstractResponse
	{
		public RequestError error { get; set; }

		public SuccessfulCurrencyResponse transaction { get; set; }
	}
}
