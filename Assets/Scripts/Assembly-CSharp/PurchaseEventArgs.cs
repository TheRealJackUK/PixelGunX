using System;

public sealed class PurchaseEventArgs : EventArgs
{
	public int Index { get; private set; }

	public int Count { get; set; }

	public decimal CurrencyAmount { get; set; }

	public string Currency { get; private set; }

	public int Discount { get; private set; }

	public PurchaseEventArgs(int index, int count, decimal currencyAmount, string currency = "Coins", int discount = 0)
	{
		Index = index;
		Count = count;
		CurrencyAmount = currencyAmount;
		Currency = currency;
		Discount = discount;
	}

	public PurchaseEventArgs(PurchaseEventArgs other)
	{
		if (other != null)
		{
			Index = other.Index;
			Count = other.Count;
			CurrencyAmount = other.CurrencyAmount;
			Currency = other.Currency;
			Discount = other.Discount;
		}
	}

	public override string ToString()
	{
		return string.Format("{{ Index: {0}, Count: {1}, CurrencyAmount: {2}, Currency: {3}, Discount: {4} }}", Index, Count, CurrencyAmount, Currency, Discount);
	}
}
