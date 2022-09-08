using UnityEngine;
using System.Collections.Generic;

namespace I2.Loc
{
	public class LanguageSource : MonoBehaviour
	{
		public string Google_WebServiceURL;
		public string Google_SpreadsheetKey;
		public string Google_SpreadsheetName;
		public string Google_LastUpdatedVersion;
		public List<TermData> mTerms;
		public List<LanguageData> mLanguages;
		public Object[] Assets;
		public bool NeverDestroy;
		public bool UserAgreesToHaveItOnTheScene;
	}
}
