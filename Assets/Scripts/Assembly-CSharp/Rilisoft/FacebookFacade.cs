using System.Collections.Generic;
using Prime31;

namespace Rilisoft
{
	internal abstract class FacebookFacade
	{
		public abstract bool CanUserUseFacebookComposer();

		public abstract List<object> GetSessionPermissions();

		public abstract void Init();

		public abstract bool IsSessionValid();

		public abstract void LoginWithReadPermissions(string[] permissions);

		public abstract void ReauthorizeWithPublishPermissions(string[] permissions, FacebookSessionDefaultAudience defaultAudience);

		public abstract void SetSessionLoginBehavior(FacebookSessionLoginBehavior loginBehavior);
	}
}
