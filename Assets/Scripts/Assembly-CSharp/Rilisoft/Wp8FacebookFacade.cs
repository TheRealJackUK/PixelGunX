using System;
using System.Collections.Generic;
using Prime31;
using Rilisoft.MiniJson;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class Wp8FacebookFacade : FacebookFacade
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

		private void HandleCompletion(string error, object result)
		{
			if (error != null)
			{
				Debug.Log(error);
			}
			else
			{
				Debug.Log(Rilisoft.MiniJson.Json.Serialize(result));
			}
		}
	}
}
