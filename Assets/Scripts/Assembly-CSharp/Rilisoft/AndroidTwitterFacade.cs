using Prime31;

namespace Rilisoft
{
	internal sealed class AndroidTwitterFacade : TwitterFacade
	{
		public override void Init(string consumerKey, string consumerSecret)
		{
			TwitterAndroid.init(consumerKey, consumerSecret);
		}

		public override bool IsLoggedIn()
		{
			return TwitterAndroid.isLoggedIn();
		}

		public override void PostStatusUpdate(string status)
		{
			TwitterAndroid.postStatusUpdate(status);
		}

		public override void ShowLoginDialog()
		{
			TwitterAndroid.showLoginDialog(false);
		}
	}
}
