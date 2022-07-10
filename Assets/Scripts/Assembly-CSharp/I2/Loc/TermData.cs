using System;

namespace I2.Loc
{
	[Serializable]
	public class TermData
	{
		public string Term = string.Empty;

		public eTermType TermType;

		public string Description = string.Empty;

		public string[] Languages = new string[0];
	}
}
