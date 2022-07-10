using UnityEngine;

namespace SponsorPay
{
	public class AndroidSPUser : SPUser
	{
		private AndroidJavaObject spUser;

		private AndroidJavaObject SPUserObject
		{
			get
			{
				if (spUser == null)
				{
					spUser = new AndroidJavaObject("com.sponsorpay.unity.SPUserWrapper");
				}
				return spUser;
			}
		}

		protected override void NativePut(string json)
		{
			SPUserObject.Call("put", json);
		}

		protected override void NativeReset()
		{
			SPUtils.printWarningMessage();
		}

		protected override string GetJsonMessage(string key)
		{
			return SPUserObject.Call<string>("get", new object[1] { key });
		}
	}
}
