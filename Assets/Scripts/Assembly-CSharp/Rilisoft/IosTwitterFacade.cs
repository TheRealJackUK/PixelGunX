using System;

namespace Rilisoft
{
	internal sealed class IosTwitterFacade : TwitterFacade
	{
		public override void Init(string consumerKey, string consumerSecret)
		{
		}

		public override bool IsLoggedIn()
		{
			throw new NotSupportedException();
		}

		public string LoggedInUsername()
		{
			throw new NotSupportedException();
		}

		public override void PostStatusUpdate(string status)
		{
		}

		public override void ShowLoginDialog()
		{
		}
	}
}
