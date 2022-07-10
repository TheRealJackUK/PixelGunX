public sealed class DevToDevSocialNetwork
{
	private string name;

	public static readonly DevToDevSocialNetwork Vk = new DevToDevSocialNetwork("vk");

	public static readonly DevToDevSocialNetwork Twitter = new DevToDevSocialNetwork("tw");

	public static readonly DevToDevSocialNetwork Facebook = new DevToDevSocialNetwork("fb");

	public static readonly DevToDevSocialNetwork GooglePlus = new DevToDevSocialNetwork("gp");

	private DevToDevSocialNetwork(string name)
	{
		this.name = name;
	}

	public override string ToString()
	{
		return name;
	}

	public static DevToDevSocialNetwork Custom(string network)
	{
		return new DevToDevSocialNetwork(network);
	}
}
