namespace SponsorPay
{
	public class UnsupportedPlatformSPUser : SPUser
	{
		protected override void NativePut(string json)
		{
			SPUtils.printWarningMessage();
		}

		protected override void NativeReset()
		{
			SPUtils.printWarningMessage();
		}

		protected override string GetJsonMessage(string key)
		{
			SPUtils.printWarningMessage();
			return "{\"success\":false,\"error\":\"Unsupported platform\":\"key\":" + key + "}";
		}
	}
}
