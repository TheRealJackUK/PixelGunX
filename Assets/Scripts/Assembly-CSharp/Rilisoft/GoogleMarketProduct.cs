namespace Rilisoft
{
	internal sealed class GoogleMarketProduct : IMarketProduct
	{
		private readonly GoogleSkuInfo _marketProduct;

		public string Id
		{
			get
			{
				return _marketProduct.productId;
			}
		}

		public string Title
		{
			get
			{
				return _marketProduct.title;
			}
		}

		public string Description
		{
			get
			{
				return _marketProduct.description;
			}
		}

		public string Price
		{
			get
			{
				return _marketProduct.price;
			}
		}

		public GoogleMarketProduct(GoogleSkuInfo googleSkuInfo)
		{
			_marketProduct = googleSkuInfo;
		}

		public override bool Equals(object obj)
		{
			GoogleMarketProduct googleMarketProduct = obj as GoogleMarketProduct;
			if (googleMarketProduct == null)
			{
				return false;
			}
			GoogleSkuInfo marketProduct = googleMarketProduct._marketProduct;
			return _marketProduct.Equals(marketProduct);
		}

		public override int GetHashCode()
		{
			return _marketProduct.GetHashCode();
		}

		public override string ToString()
		{
			return _marketProduct.ToString();
		}
	}
}
