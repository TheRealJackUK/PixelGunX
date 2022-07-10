namespace Rilisoft
{
	public enum ResponseCode
	{
		Licensed = 0,
		NotLicensed = 1,
		LicensedOldKey = 2,
		ErrorNotMarketManaged = 3,
		ErrorServerFailure = 4,
		ErrorOverQuota = 5,
		ErrorContactingServer = 257,
		ErrorInvalidPackageName = 258,
		ErrorNonMatchingUid = 259
	}
}
