internal sealed class AdvertisementInfo
{
	private static readonly AdvertisementInfo _default = new AdvertisementInfo(-1, -1, -1);

	private readonly int _round;

	private readonly int _slot;

	private readonly int _unit;

	private readonly string _details;

	public int Round
	{
		get
		{
			return _round;
		}
	}

	public int Slot
	{
		get
		{
			return _slot;
		}
	}

	public int Unit
	{
		get
		{
			return _unit;
		}
	}

	public string Details
	{
		get
		{
			return _details;
		}
	}

	public static AdvertisementInfo Default
	{
		get
		{
			return _default;
		}
	}

	public AdvertisementInfo(int round, int slot, int unit = 0, string details = null)
	{
		_round = round;
		_slot = slot;
		_unit = unit;
		_details = details ?? string.Empty;
	}
}
