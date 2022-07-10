using System.Diagnostics;
using UnityEngine;

namespace SponsorPay
{
	public class SPUtils
	{
		public static void printWarningMessage()
		{
			UnityEngine.Debug.Log("WARNING: SponsorPay plugin is not available on this platform.");
			UnityEngine.Debug.Log("WARNING: the \"" + GetMethodName() + "\" method does not do anything");
		}

		private static string GetMethodName()
		{
			StackTrace stackTrace = new StackTrace();
			StackFrame frame = stackTrace.GetFrame(2);
			return frame.GetMethod().Name;
		}
	}
}
