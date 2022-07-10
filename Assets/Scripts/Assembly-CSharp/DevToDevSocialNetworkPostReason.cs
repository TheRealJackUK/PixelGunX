public class DevToDevSocialNetworkPostReason
{
	private string name;

	public static readonly DevToDevSocialNetworkPostReason LevelUp = new DevToDevSocialNetworkPostReason("levelup");

	public static readonly DevToDevSocialNetworkPostReason Quest = new DevToDevSocialNetworkPostReason("quest");

	public static readonly DevToDevSocialNetworkPostReason Screenshot = new DevToDevSocialNetworkPostReason("ss");

	public static readonly DevToDevSocialNetworkPostReason HelpRequest = new DevToDevSocialNetworkPostReason("help");

	public static readonly DevToDevSocialNetworkPostReason CollectionCharged = new DevToDevSocialNetworkPostReason("colch");

	public static readonly DevToDevSocialNetworkPostReason BuildingNew = new DevToDevSocialNetworkPostReason("bldnew");

	public static readonly DevToDevSocialNetworkPostReason BuildingUpgrade = new DevToDevSocialNetworkPostReason("bldupg");

	public static readonly DevToDevSocialNetworkPostReason StartPlaying = new DevToDevSocialNetworkPostReason("playing");

	public static readonly DevToDevSocialNetworkPostReason Other = new DevToDevSocialNetworkPostReason("other");

	public static readonly DevToDevSocialNetworkPostReason Achievement = new DevToDevSocialNetworkPostReason("ad");

	public static readonly DevToDevSocialNetworkPostReason ReferralCodeShare = new DevToDevSocialNetworkPostReason("rcs");

	private DevToDevSocialNetworkPostReason(string name)
	{
		this.name = name;
	}

	public override string ToString()
	{
		return name;
	}

	public static DevToDevSocialNetworkPostReason Custom(string customReason)
	{
		return new DevToDevSocialNetworkPostReason(customReason);
	}
}
