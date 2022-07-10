namespace Rilisoft
{
	internal sealed class AmazonMarketProduct : IMarketProduct
	{
		private readonly AmazonItem _marketProduct;

		public string Id
		{
			get
			{
				return _marketProduct.sku;
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

		public AmazonMarketProduct(AmazonItem amazonItem)
		{
			_marketProduct = amazonItem;
		}

		public override string ToString()
		{
			return _marketProduct.ToString();
		}

		public override bool Equals(object obj)
		{
			AmazonMarketProduct amazonMarketProduct = obj as AmazonMarketProduct;
			if (amazonMarketProduct == null)
			{
				return false;
			}
			AmazonItem marketProduct = amazonMarketProduct._marketProduct;
			return _marketProduct.Equals(marketProduct);
		}

		public override int GetHashCode()
		{
			return _marketProduct.GetHashCode();
		}
	}
}
