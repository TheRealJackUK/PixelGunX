using System;
using System.Collections.Generic;
using UnityEngine;

namespace I2.Loc
{
	public class GoogleLanguages
	{
		public static Dictionary<string, string> mLanguageDef = new Dictionary<string, string>
		{
			{ "Afrikaans", "af" },
			{ "Albanian", "sq" },
			{ "Arabic/Algeria", "ar-DZ" },
			{ "Arabic/Arabic", "ar" },
			{ "Arabic/Bahrain", "ar-BH" },
			{ "Arabic/Egypt", "ar-EG" },
			{ "Arabic/Iraq", "ar-IQ" },
			{ "Arabic/Jordan", "ar-JO" },
			{ "Arabic/Kuwait", "ar-KW" },
			{ "Arabic/Lebanon", "ar-LB" },
			{ "Arabic/Libya", "ar-LY" },
			{ "Arabic/Morocco", "ar-MA" },
			{ "Arabic/Oman", "ar-OM" },
			{ "Arabic/Qatar", "ar-QA" },
			{ "Arabic/Saudi Arabia", "ar-SA" },
			{ "Arabic/Syria", "ar-SY" },
			{ "Arabic/Tunisia", "ar-TN" },
			{ "Arabic/U.A.E.", "ar-AE" },
			{ "Arabic/Yemen", "ar-YE" },
			{ "Armenian", "hy" },
			{ "Azeri", "az" },
			{ "Basque/Basque", "eu" },
			{ "Basque/Spain", "eu-ES" },
			{ "Belarusian", "be" },
			{ "Bosnian", "bs-BA" },
			{ "Bulgariaa", "bg-BG" },
			{ "Catalan", "ca" },
			{ "Chinese/Chinese", "zh" },
			{ "Chinese/Hong Kong SAR", "zh-HK" },
			{ "Chinese/Macau", "zh-MO" },
			{ "Chinese/PRC", "zh-CN" },
			{ "Chinese/Simplified", "zh-CHS" },
			{ "Chinese/Singapore", "zh-SG" },
			{ "Chinese/Taiwan", "zh-TW" },
			{ "Chinese/Traditional", "zh-CHT" },
			{ "Croatian/Bosnia and Herzegovina", "hr-BA" },
			{ "Croatian/Croatia", "hr-HR" },
			{ "Czech", "cs" },
			{ "Danish", "da" },
			{ "Dhivehi", "diV" },
			{ "Divehi", "dv" },
			{ "Dutch/Belgium", "nl-BE" },
			{ "Dutch/Netherlands", "nl-NL" },
			{ "Dutch/Standard", "nl" },
			{ "English/Australia", "en-AU" },
			{ "English/Belize", "en-BZ" },
			{ "English/Canada", "en-CA" },
			{ "English/Caribbean", "en-CB" },
			{ "English/Ireland", "en-IE" },
			{ "English/Jamaica", "en-JM" },
			{ "English/New Zealand", "en-NZ" },
			{ "English/Republic of the Philippines", "en-PH" },
			{ "English/South Africa", "en-ZA" },
			{ "English/Trinidad", "en-TT" },
			{ "English/United Kingdom", "en-GB" },
			{ "English/United States", "en-US" },
			{ "English/Zimbabwe", "en-ZW" },
			{ "Esperanto", "eo" },
			{ "Estonian", "et" },
			{ "Faeroese", "fo" },
			{ "Farsi", "fa" },
			{ "Finnish", "fi" },
			{ "French/Belgium", "fr-BE" },
			{ "French/Canada", "fr-CA" },
			{ "French/France", "fr-FR" },
			{ "French/Luxembourg", "fr-LU" },
			{ "French/Principality of Monaco", "fr-MC" },
			{ "French/Standard", "fr" },
			{ "French/Switzerland", "fr-CH" },
			{ "Gaelic", "gd" },
			{ "Galician/Galician", "gl" },
			{ "Galician/Spain", "gl-ES" },
			{ "Georgian", "ka" },
			{ "German/Austria", "de-AT" },
			{ "German/Germany", "de-DE" },
			{ "German/Liechtenstein", "de-LI" },
			{ "German/Luxembourg", "de-LU" },
			{ "German/Standard", "de" },
			{ "German/Switzerland", "de-CH" },
			{ "Greek", "el" },
			{ "Gujarati", "gu" },
			{ "Hebrew", "he" },
			{ "Hindi", "hi" },
			{ "Hungarian", "hu" },
			{ "Icelandic", "is" },
			{ "Indonesian", "id" },
			{ "Irish", "ga" },
			{ "Italian/Italy", "it-IT" },
			{ "Italian/Standard", "it" },
			{ "Italian/Switzerland", "it-CH" },
			{ "Japanese", "ja" },
			{ "Kannada", "kn" },
			{ "Kazakh", "kk" },
			{ "Konkani", "koK" },
			{ "Korean", "ko" },
			{ "Kurdish", "ku" },
			{ "Kyrgyz", "ky" },
			{ "Latvian", "lv" },
			{ "Lithuanian", "lt" },
			{ "Macedonian", "mk" },
			{ "Malay/Brunei Darussalam", "ms-BN" },
			{ "Malay/Malaysia", "ms-MY" },
			{ "Malayalam", "ml" },
			{ "Maltese", "mt" },
			{ "Maori", "mi" },
			{ "Marathi", "mr" },
			{ "Mongolian", "mn" },
			{ "Northern Sotho", "ns" },
			{ "Norwegian/Nynorsk", "nn" },
			{ "Norwegian", "nb" },
			{ "Pashto", "ps" },
			{ "Polish", "pl" },
			{ "Portuguese/Brazil", "pt-BR" },
			{ "Portuguese/Portugal", "pt-PT" },
			{ "Punjabi", "pa" },
			{ "Quechua/Bolivia", "qu-BO" },
			{ "Quechua/Ecuador", "qu-EC" },
			{ "Quechua/Peru", "qu-PE" },
			{ "Rhaeto-Romanic", "rm" },
			{ "Romanian", "ro-RO" },
			{ "Russian/Republic of Moldova", "ru-MO" },
			{ "Russian/Russia", "ru-RU" },
			{ "Sami/Finland", "se-FI" },
			{ "Sami/Lappish", "sz" },
			{ "Sami/Northern", "se-NO" },
			{ "Sami/Sweden", "se-SE" },
			{ "Sanskrit", "sa" },
			{ "Serbian/Bosnia and Herzegovina", "sr-BA" },
			{ "Serbian/Serbia and Montenegro", "sr-SP" },
			{ "Slovak", "sk" },
			{ "Slovenian", "sl" },
			{ "Sorbian", "sb" },
			{ "Spanish/Argentina", "es-AR" },
			{ "Spanish/Bolivia", "es-BO" },
			{ "Spanish/Castilian", "es-ES" },
			{ "Spanish/Chile", "es-CL" },
			{ "Spanish/Colombia", "es-CO" },
			{ "Spanish/Costa Rica", "es-CR" },
			{ "Spanish/Dominican Republic", "es-DO" },
			{ "Spanish/Ecuador", "es-EC" },
			{ "Spanish/El Salvador", "es-SV" },
			{ "Spanish/Guatemala", "es-GT" },
			{ "Spanish/Honduras", "es-HN" },
			{ "Spanish/Mexico", "es-MX" },
			{ "Spanish/Nicaragua", "es-NI" },
			{ "Spanish/Panama", "es-PA" },
			{ "Spanish/Paraguay", "es-PY" },
			{ "Spanish/Peru", "es-PE" },
			{ "Spanish/Puerto Rico", "es-PR" },
			{ "Spanish/Spain", "es" },
			{ "Spanish/Uruguay", "es-UY" },
			{ "Spanish/Venezuela", "es-VE" },
			{ "Sutu", "sx" },
			{ "Swahili", "sw" },
			{ "Swedish/Finland", "sv-FI" },
			{ "Swedish/Sweden", "sv-SE" },
			{ "Swedish/Swedish", "sv" },
			{ "Syriac", "syR" },
			{ "Tagalog", "tl" },
			{ "Tamil", "ta" },
			{ "Tatar", "tt" },
			{ "Telugu", "te" },
			{ "Thai", "th" },
			{ "Tsonga", "ts" },
			{ "Tswana", "tn" },
			{ "Turkish", "tr" },
			{ "Ukrainian", "uk" },
			{ "Urdu", "ur" },
			{ "Uzbek", "uz" },
			{ "Venda", "ve" },
			{ "Vietnamese", "vi" },
			{ "Welsh", "cy" },
			{ "Xhosa", "xh" },
			{ "Yiddish", "ji" },
			{ "Zulu", "zu" }
		};

		public static string GetLanguageCode(string Filter, bool ShowWarnings = false)
		{
			if (string.IsNullOrEmpty(Filter))
			{
				return string.Empty;
			}
			string[] filters = Filter.Split(" /(),".ToCharArray());
			foreach (KeyValuePair<string, string> item in mLanguageDef)
			{
				if (LanguageMatchesFilter(item.Key, filters))
				{
					return item.Value;
				}
			}
			if (ShowWarnings)
			{
				Debug.Log(string.Format("Language '{0}' not recognized. Please, add the language code to GoogleTranslation.cs", Filter));
			}
			return string.Empty;
		}

		public static List<string> GetSupportedLanguages(string Filter)
		{
			if (string.IsNullOrEmpty(Filter))
			{
				return new List<string>(mLanguageDef.Keys);
			}
			string[] filters = Filter.Split(" /(),".ToCharArray());
			List<string> list = new List<string>();
			foreach (KeyValuePair<string, string> item in mLanguageDef)
			{
				if (LanguageMatchesFilter(item.Key, filters))
				{
					list.Add(item.Key);
				}
			}
			return list;
		}

		public static string GetClosestLanguage(string Filter)
		{
			if (string.IsNullOrEmpty(Filter))
			{
				return string.Empty;
			}
			string[] filters = Filter.Split(" /(),".ToCharArray());
			foreach (KeyValuePair<string, string> item in mLanguageDef)
			{
				if (LanguageMatchesFilter(item.Key, filters))
				{
					return GetFormatedLanguageName(item.Key);
				}
			}
			return string.Empty;
		}

		private static bool LanguageMatchesFilter(string Language, string[] Filters)
		{
			Language = Language.ToLower();
			int i = 0;
			for (int num = Filters.Length; i < num; i++)
			{
				if (!Language.Contains(Filters[i].ToLower()))
				{
					return false;
				}
			}
			return true;
		}

		public static string GetFormatedLanguageName(string Language)
		{
			int num = Language.IndexOf('/');
			if (num < 0)
			{
				return Language;
			}
			return Language.Replace("/", " (") + ")";
		}

		public static string GetCodedLanguage(string Language, string code)
		{
			string languageCode = GetLanguageCode(Language);
			if (string.Compare(code, languageCode, StringComparison.OrdinalIgnoreCase) == 0)
			{
				return Language;
			}
			return Language + " [" + code + "]";
		}

		public static void UnPackCodeFromLanguageName(string CodedLanguage, out string Language, out string code)
		{
			if (string.IsNullOrEmpty(CodedLanguage))
			{
				Language = string.Empty;
				code = string.Empty;
				return;
			}
			int num = CodedLanguage.IndexOf("[");
			if (num < 0)
			{
				Language = CodedLanguage;
				code = GetLanguageCode(Language);
			}
			else
			{
				Language = CodedLanguage.Substring(0, num).Trim();
				code = CodedLanguage.Substring(num + 1, CodedLanguage.IndexOf("]", num) - num - 1);
			}
		}
	}
}
