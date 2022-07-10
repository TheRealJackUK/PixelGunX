using System;
using System.Collections.Generic;
using Prime31;

namespace Rilisoft
{
	internal sealed class IosFacebookFacade : FacebookFacade
	{
		public override bool CanUserUseFacebookComposer()
		{
			throw new NotSupportedException();
		}

		public override List<object> GetSessionPermissions()
		{
			throw new NotSupportedException();
		}

		public override void Init()
		{
		}

		public override bool IsSessionValid()
		{
			throw new NotSupportedException();
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
