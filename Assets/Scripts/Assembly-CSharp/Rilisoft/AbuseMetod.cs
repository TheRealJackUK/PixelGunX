using System;

namespace Rilisoft
{
	[Flags]
	internal enum AbuseMetod
	{
		None = 0,
		UpgradeFromVulnerableVersion = 1,
		Coins = 2,
		Gems = 4,
		Expendables = 8,
		Weapons = 0x10,
		AndroidPackageSignature = 0x20
	}
}
