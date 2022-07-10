using System.Collections.Generic;
using Prime31;

namespace Rilisoft
{
	internal sealed class DummyFacebookFacade : FacebookFacade
	{
		public override bool CanUserUseFacebookComposer()
		{
			return false;
		}

		public override List<object> GetSessionPermissions()
		{
			return new List<object>();
		}

		public override void Init()
		{
		}

		public override bool IsSessionValid()
		{
			return true;
		}

		public override void LoginWithReadPermissions(string[] permissions)
		{
		}

		public override void ReauthorizeWithPublishPermissions(string[] permissions, FacebookSessionDefaultAudience defaultAudience)
		{
		}

		public override void SetSessionLoginBehavior(FacebookSessionLoginBehavior loginBehavior)
		{
		}
	}
}
