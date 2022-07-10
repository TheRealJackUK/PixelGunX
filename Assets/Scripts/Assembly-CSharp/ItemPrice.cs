using System;
using Rilisoft;

public sealed class ItemPrice
{
	private float CoefGemsToCoins = 1.7f;

	private readonly SaltedInt _price;

	private static readonly Random _prng = new Random(268898311);

	public int Price
	{
		get
		{
			return _price.Value;
		}
	}

	public string Currency { get; private set; }

	public ItemPrice(int price, string currency)
	{
		_price = new SaltedInt(_prng.Next(), price);
		Currency = currency;
	}

	public int CompareTo(ItemPrice p)
	{
		if (p == null)
		{
			return 1;
		}
		if (Currency.Equals(p.Currency))
		{
			return Price - p.Price;
		}
		float num = 0f;
		num = ((!Currency.Equals("Coins")) ? ((float)Price * CoefGemsToCoins - (float)p.Price) : ((float)Price - (float)p.Price * CoefGemsToCoins));
		return (num > 0f) ? 1 : ((num < 0f) ? (-1) : 0);
	}
}
