namespace Rilisoft
{
	internal sealed class DummyTwitterFacade : TwitterFacade
	{
		public override void Init(string consumerKey, string consumerSecret)
		{
		}

		public override bool IsLoggedIn()
		{
			return true;
		}

		public override void PostStatusUpdate(string status)
		{
		}

		public override void ShowLoginDialog()
		{
		}
	}
}
