using System;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class Wp8TwitterFacade : TwitterFacade
	{
		public override void Init(string consumerKey, string consumerSecret)
		{
		}

		public override bool IsLoggedIn()
		{
			throw new NotSupportedException();
		}

		public override void PostStatusUpdate(string status)
		{
		}

		public override void ShowLoginDialog()
		{
		}

		private static void HandlePostComplete(object obj, string error)
		{
			if (error != null)
			{
				Debug.LogWarning("Twitter request error: " + error);
			}
			else if (obj != null)
			{
				Debug.Log(obj);
			}
			else
			{
				Debug.LogWarning("obj == null");
			}
		}
	}
}
