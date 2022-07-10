namespace Rilisoft
{
	internal abstract class TwitterFacade
	{
		public abstract void Init(string consumerKey, string consumerSecret);

		public abstract bool IsLoggedIn();

		public abstract void PostStatusUpdate(string status);

		public abstract void ShowLoginDialog();
	}
}
