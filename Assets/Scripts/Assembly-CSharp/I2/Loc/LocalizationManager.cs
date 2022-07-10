using System;
using System.Collections.Generic;
using UnityEngine;

namespace I2.Loc
{
	public static class LocalizationManager
	{
		public delegate void OnLocalizeCallback();

		private static string mCurrentLanguage;

		private static string mLanguageCode;

		public static bool IsRight2Left = false;

		public static List<LanguageSource> Sources = new List<LanguageSource>();

		private static string[] LanguagesRTL = new string[20]
		{
			"ar-DZ", "ar", "ar-BH", "ar-EG", "ar-IQ", "ar-JO", "ar-KW", "ar-LB", "ar-LY", "ar-MA",
			"ar-OM", "ar-QA", "ar-SA", "ar-SY", "ar-TN", "ar-AE", "ar-YE", "he", "ur", "ji"
		};

		public static string CurrentLanguage
		{
			get
			{
				if (string.IsNullOrEmpty(mCurrentLanguage))
				{
					RegisterSceneSources();
					RegisterSourceInResources();
					SelectStartupLanguage();
				}
				return mCurrentLanguage;
			}
			set
			{
				string supportedLanguage = GetSupportedLanguage(value);
				if (mCurrentLanguage != value && !string.IsNullOrEmpty(supportedLanguage))
				{
					mCurrentLanguage = supportedLanguage;
					CurrentLanguageCode = GetLanguageCode(supportedLanguage);
					LocalizeAll();
				}
			}
		}

		public static string CurrentLanguageCode
		{
			get
			{
				return mLanguageCode;
			}
			set
			{
				mLanguageCode = value;
				IsRight2Left = IsRTL(mLanguageCode);
			}
		}

		public static event OnLocalizeCallback OnLocalizeEvent;

		private static void SelectStartupLanguage()
		{
			string @string = PlayerPrefs.GetString(Defs.CurrentLanguage, string.Empty);
			string language = Application.systemLanguage.ToString();
			if (HasLanguage(@string))
			{
				CurrentLanguage = @string;
				return;
			}
			string supportedLanguage = GetSupportedLanguage(language);
			if (!string.IsNullOrEmpty(supportedLanguage))
			{
				CurrentLanguage = supportedLanguage;
				return;
			}
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				if (Sources[i].mLanguages.Count > 0)
				{
					CurrentLanguage = Sources[i].mLanguages[0].Name;
					break;
				}
			}
		}

		public static string GetTermTranslation(string Term)
		{
			return GetTranslation(Term);
		}

		public static string GetTermTranslationByDefault(string term)
		{
			if (Sources.Count == 0)
			{
				RegisterSourceInResources();
			}
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				TermData termData = Sources[i].GetTermData(term);
				if (termData == null)
				{
					return string.Empty;
				}
				if (termData.Languages.Length != 0)
				{
					return termData.Languages[0];
				}
			}
			return string.Empty;
		}

		public static string GetTranslation(string term)
		{
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				TermData termData = Sources[i].GetTermData(term);
				if (termData == null)
				{
					continue;
				}
				int languageIndex = Sources[i].GetLanguageIndex(CurrentLanguage);
				if (languageIndex != -1)
				{
					string text = termData.Languages[languageIndex];
					if (!string.IsNullOrEmpty(text))
					{
						return text;
					}
				}
				if (termData.Languages.Length != 0)
				{
					return termData.Languages[0];
				}
			}
			return term;
		}

		internal static void LocalizeAll()
		{
			Localize[] array = (Localize[])Resources.FindObjectsOfTypeAll(typeof(Localize));
			int i = 0;
			for (int num = array.Length; i < num; i++)
			{
				Localize localize = array[i];
				localize.OnLocalize();
			}
			if (LocalizationManager.OnLocalizeEvent != null)
			{
				LocalizationManager.OnLocalizeEvent();
			}
			ResourceManager.pInstance.CleanResourceCache();
		}

		private static void RegisterSceneSources()
		{
			LanguageSource[] array = (LanguageSource[])Resources.FindObjectsOfTypeAll(typeof(LanguageSource));
			int i = 0;
			for (int num = array.Length; i < num; i++)
			{
				if (!Sources.Contains(array[i]))
				{
					AddSource(array[i]);
				}
			}
		}

		private static void RegisterSourceInResources()
		{
			GameObject asset = ResourceManager.pInstance.GetAsset<GameObject>("I2Languages");
			LanguageSource languageSource = ((!asset) ? null : asset.GetComponent<LanguageSource>());
			if ((bool)languageSource && !Sources.Contains(languageSource))
			{
				AddSource(languageSource);
			}
		}

		internal static void AddSource(LanguageSource Source)
		{
			if (!Sources.Contains(Source))
			{
				Sources.Add(Source);
				Source.Import_Google();
			}
		}

		internal static void RemoveSource(LanguageSource Source)
		{
			Sources.Remove(Source);
		}

		public static bool HasLanguage(string Language, bool AllowDiscartingRegion = true)
		{
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				if (Sources[i].GetLanguageIndex(Language, false) >= 0)
				{
					return true;
				}
			}
			if (AllowDiscartingRegion)
			{
				int j = 0;
				for (int count2 = Sources.Count; j < count2; j++)
				{
					if (Sources[j].GetLanguageIndex(Language) >= 0)
					{
						return true;
					}
				}
			}
			return false;
		}

		public static string GetSupportedLanguage(string Language)
		{
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				int languageIndex = Sources[i].GetLanguageIndex(Language, false);
				if (languageIndex >= 0)
				{
					return Sources[i].mLanguages[languageIndex].Name;
				}
			}
			int j = 0;
			for (int count2 = Sources.Count; j < count2; j++)
			{
				int languageIndex2 = Sources[j].GetLanguageIndex(Language);
				if (languageIndex2 >= 0)
				{
					return Sources[j].mLanguages[languageIndex2].Name;
				}
			}
			return string.Empty;
		}

		public static string GetLanguageCode(string Language)
		{
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				int languageIndex = Sources[i].GetLanguageIndex(Language);
				if (languageIndex >= 0)
				{
					return Sources[i].mLanguages[languageIndex].Code;
				}
			}
			return string.Empty;
		}

		public static List<string> GetAllLanguages()
		{
			List<string> list = new List<string>();
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				int j = 0;
				for (int count2 = Sources[i].mLanguages.Count; j < count2; j++)
				{
					if (!list.Contains(Sources[i].mLanguages[j].Name))
					{
						list.Add(Sources[i].mLanguages[j].Name);
					}
				}
			}
			return list;
		}

		public static UnityEngine.Object FindAsset(string value)
		{
			int i = 0;
			for (int count = Sources.Count; i < count; i++)
			{
				UnityEngine.Object @object = Sources[i].FindAsset(value);
				if ((bool)@object)
				{
					return @object;
				}
			}
			return null;
		}

		private static bool IsRTL(string Code)
		{
			return Array.IndexOf(LanguagesRTL, Code) >= 0;
		}
	}
}
