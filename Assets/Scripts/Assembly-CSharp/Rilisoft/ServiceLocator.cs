namespace Rilisoft
{
	internal static class ServiceLocator
	{
		private static readonly FacebookFacade _facebookFacade;

		private static readonly TwitterFacade _twitterFacade;

		public static FacebookFacade FacebookFacade
		{
			get
			{
				return _facebookFacade;
			}
		}

		public static TwitterFacade TwitterFacade
		{
			get
			{
				return _twitterFacade;
			}
		}

		static ServiceLocator()
		{
			switch (BuildSettings.BuildTarget)
			{
			case BuildTarget.iPhone:
				_facebookFacade = new IosFacebookFacade();
				_twitterFacade = new IosTwitterFacade();
				break;
			case BuildTarget.Android:
				_facebookFacade = new AndroidFacebookFacade();
				_twitterFacade = new AndroidTwitterFacade();
				break;
			case BuildTarget.WP8Player:
				_facebookFacade = new Wp8FacebookFacade();
				_twitterFacade = new Wp8TwitterFacade();
				break;
			default:
				_facebookFacade = new DummyFacebookFacade();
				_twitterFacade = new DummyTwitterFacade();
				break;
			}
		}
	}
}
