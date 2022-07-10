namespace SponsorPay
{
	public class SuccessfulCurrencyResponse
	{
		public string LatestTransactionId { get; set; }

		public double DeltaOfCoins { get; set; }

		public string CurrencyId { get; set; }

		public string CurrencyName { get; set; }
	}
}
