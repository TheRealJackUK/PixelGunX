using UnityEngine;

namespace I2.Loc
{
	public class Localize : MonoBehaviour
	{
		public enum TermModification
		{
			DontModify = 0,
			ToUpper = 1,
			ToLower = 2,
		}

		public string mTerm;
		public string mTermSecondary;
		public string FinalTerm;
		public string FinalSecondaryTerm;
		public TermModification PrimaryTermModifier;
		public TermModification SecondaryTermModifier;
		public Object mTarget;
		public bool CanUseSecondaryTerm;
		public bool AllowMainTermToBeRTL;
		public bool AllowSecondTermToBeRTL;
		public bool IgnoreRTL;
		public Object[] TranslatedObjects;
		public EventCallback LocalizeCallBack;
	}
}
