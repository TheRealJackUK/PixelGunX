using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using SimpleJSON;
using UnityEngine;

namespace I2.Loc
{
	[AddComponentMenu("I2/Localization/Source")]
	public class LanguageSource : MonoBehaviour
	{
		public string Google_WebServiceURL;

		public string Google_SpreadsheetKey;

		public string Google_SpreadsheetName;

		public string Google_LastUpdatedVersion;

		private CoroutineManager mCoroutineManager;

		public static string EmptyCategory = "Default";

		public static char[] CategorySeparators = "/\\".ToCharArray();

		public List<TermData> mTerms = new List<TermData>();

		public List<LanguageData> mLanguages = new List<LanguageData>();

		[NonSerialized]
		public Dictionary<string, TermData> mDictionary = new Dictionary<string, TermData>();

		public UnityEngine.Object[] Assets;

		public bool NeverDestroy = true;

		public bool UserAgreesToHaveItOnTheScene;

		public string Export_CSV(string Category)
		{
			StringBuilder stringBuilder = new StringBuilder();
			int count = mLanguages.Count;
			stringBuilder.Append("Key,Type,Desc");
			foreach (LanguageData mLanguage in mLanguages)
			{
				stringBuilder.Append(",");
				AppendString(stringBuilder, GoogleLanguages.GetCodedLanguage(mLanguage.Name, mLanguage.Code));
			}
			stringBuilder.Append("\n");
			foreach (TermData mTerm in mTerms)
			{
				string text;
				if (string.IsNullOrEmpty(Category) || (Category == EmptyCategory && mTerm.Term.IndexOfAny(CategorySeparators) < 0))
				{
					text = mTerm.Term;
				}
				else
				{
					if (!mTerm.Term.StartsWith(Category) || !(Category != mTerm.Term))
					{
						continue;
					}
					text = mTerm.Term.Substring(Category.Length + 1);
				}
				AppendString(stringBuilder, text);
				stringBuilder.AppendFormat(",{0}", mTerm.TermType.ToString());
				stringBuilder.Append(",");
				AppendString(stringBuilder, mTerm.Description);
				for (int i = 0; i < Mathf.Min(count, mTerm.Languages.Length); i++)
				{
					stringBuilder.Append(",");
					AppendString(stringBuilder, mTerm.Languages[i]);
				}
				stringBuilder.Append("\n");
			}
			return stringBuilder.ToString();
		}

		private static void AppendString(StringBuilder Builder, string Text)
		{
			if (!string.IsNullOrEmpty(Text))
			{
				Text = Text.Replace("\\n", "\n");
				if (Text.IndexOfAny(",\n\"".ToCharArray()) >= 0)
				{
					Text = Text.Replace("\"", "\"\"");
					Builder.AppendFormat("\"{0}\"", Text);
				}
				else
				{
					Builder.Append(Text);
				}
			}
		}

		public void UpdateTheFont() {
			foreach (TermData term in mTerms) {
				for (int i = 0; i < term.Languages.Length; i++) {
					if (term.Languages[i] == "minecraft" || term.Languages[i] == "MINI" || term.Languages[i] == "Ponderosa" || term.Languages[i] == "Unibody" || term.Languages[i] == "HandleUnibody"){
						term.Languages[i] = Storager.getString("currentfont", false);
					}
				}
			}
		}

		public WWW Export_Google_CreateWWWcall(eSpreadsheetUpdateMode UpdateMode = eSpreadsheetUpdateMode.Replace)
		{
			string value = Export_Google_CreateData();
			WWWForm wWWForm = new WWWForm();
			wWWForm.AddField("key", Google_SpreadsheetKey);
			wWWForm.AddField("action", "SetLanguageSource");
			wWWForm.AddField("data", value);
			wWWForm.AddField("updateMode", UpdateMode.ToString());
			return new WWW(Google_WebServiceURL, wWWForm);
		}

		private string Export_Google_CreateData()
		{
			List<string> categories = GetCategories(true);
			StringBuilder stringBuilder = new StringBuilder();
			bool flag = true;
			foreach (string item in categories)
			{
				if (flag)
				{
					flag = false;
				}
				else
				{
					stringBuilder.Append("<I2Loc>");
				}
				string value = Export_CSV(item);
				stringBuilder.Append(item);
				stringBuilder.Append("<I2Loc>");
				stringBuilder.Append(value);
			}
			return stringBuilder.ToString();
		}

		public string Import_CSV(string Category, string CSVstring, eSpreadsheetUpdateMode UpdateMode = eSpreadsheetUpdateMode.Replace)
		{
			List<string[]> list = LocalizationReader.ReadCSV(CSVstring);
			string[] array = list[0];
			if (UpdateMode == eSpreadsheetUpdateMode.Replace)
			{
				ClearAllData();
			}
			int num = Mathf.Max(array.Length - 3, 0);
			int[] array2 = new int[num];
			for (int i = 0; i < num; i++)
			{
				string Language;
				string code;
				GoogleLanguages.UnPackCodeFromLanguageName(array[i + 3], out Language, out code);
				int num2 = GetLanguageIndex(Language);
				if (num2 < 0)
				{
					LanguageData languageData = new LanguageData();
					languageData.Name = Language;
					languageData.Code = code;
					mLanguages.Add(languageData);
					num2 = mLanguages.Count - 1;
				}
				array2[i] = num2;
			}
			num = mLanguages.Count;
			int j = 0;
			for (int count = mTerms.Count; j < count; j++)
			{
				TermData termData = mTerms[j];
				if (termData.Languages.Length < num)
				{
					Array.Resize(ref termData.Languages, num);
				}
			}
			int k = 1;
			for (int count2 = list.Count; k < count2; k++)
			{
				array = list[k];
				string Term = ((!string.IsNullOrEmpty(Category)) ? (Category + "/" + array[0]) : array[0]);
				ValidateFullTerm(ref Term);
				TermData termData2 = GetTermData(Term);
				if (termData2 == null)
				{
					termData2 = new TermData();
					termData2.Term = Term;
					termData2.Languages = new string[mLanguages.Count];
					for (int l = 0; l < mLanguages.Count; l++)
					{
						termData2.Languages[l] = string.Empty;
					}
					mTerms.Add(termData2);
					mDictionary.Add(Term, termData2);
				}
				else if (UpdateMode == eSpreadsheetUpdateMode.AddNewTerms)
				{
					continue;
				}
				termData2.TermType = GetTermType(array[1]);
				termData2.Description = array[2];
				for (int m = 0; m < array2.Length && m < array.Length - 3; m++)
				{
					if (!string.IsNullOrEmpty(array[m + 3]))
					{
						termData2.Languages[array2[m]] = array[m + 3];
					}
				}
			}
			return string.Empty;
		}

		public static eTermType GetTermType(string type)
		{
			int i = 0;
			for (int num = 8; i <= num; i++)
			{
				if (string.Equals(((eTermType)i).ToString(), type, StringComparison.OrdinalIgnoreCase))
				{
					return (eTermType)i;
				}
			}
			return eTermType.Text;
		}

		public void Import_Google()
		{
			if (Application.isPlaying && !(mCoroutineManager != null))
			{
				string @string = PlayerPrefs.GetString("I2Source_" + Google_SpreadsheetKey, string.Empty);
				if (!string.IsNullOrEmpty(@string))
				{
					Import_Google_Result(@string, eSpreadsheetUpdateMode.Replace);
				}
				GameObject gameObject = new GameObject("ImportingSpreadsheet");
				gameObject.hideFlags |= HideFlags.HideAndDontSave;
				mCoroutineManager = gameObject.AddComponent<CoroutineManager>();
				mCoroutineManager.StartCoroutine(Import_Google_Coroutine());
			}
		}

		private IEnumerator Import_Google_Coroutine()
		{
			WWW www = Import_Google_CreateWWWcall(false);
			if (www != null)
			{
				while (!www.isDone)
				{
					yield return null;
				}
				if (string.IsNullOrEmpty(www.error) && www.text != "\"\"")
				{
					PlayerPrefs.SetString("I2Source_" + Google_SpreadsheetKey, www.text);
					PlayerPrefs.Save();
					Import_Google_Result(www.text, eSpreadsheetUpdateMode.Replace);
					LocalizationManager.LocalizeAll();
					Debug.Log("Done Google Sync '" + www.text + "'");
				}
				else
				{
					Debug.Log("Language Source was up-to-date with Google Spreadsheet");
				}
				UnityEngine.Object.Destroy(mCoroutineManager.gameObject);
				mCoroutineManager = null;
			}
		}

		public WWW Import_Google_CreateWWWcall(bool ForceUpdate = false)
		{
			if (!HasGoogleSpreadsheet())
			{
				return null;
			}
			string url = string.Format("{0}?key={1}&action=GetLanguageSource&version={2}", Google_WebServiceURL, Google_SpreadsheetKey, (!ForceUpdate) ? Google_LastUpdatedVersion : "0");
			return new WWW(url);
		}

		public bool HasGoogleSpreadsheet()
		{
			return !string.IsNullOrEmpty(Google_WebServiceURL) && !string.IsNullOrEmpty(Google_SpreadsheetKey);
		}

		public void Import_Google_Result(string JsonString, eSpreadsheetUpdateMode UpdateMode)
		{
			if (JsonString == "\"\"")
			{
				Debug.Log("Language Source was up to date");
				return;
			}
			JSONClass asObject = JSON.Parse(JsonString).AsObject;
			if (UpdateMode == eSpreadsheetUpdateMode.Replace)
			{
				ClearAllData();
			}
			Google_LastUpdatedVersion = asObject["version"];
			JSONClass asObject2 = asObject["spreadsheet"].AsObject;
			foreach (KeyValuePair<string, JSONNode> item in asObject2)
			{
				Import_CSV(item.Key, item.Value, UpdateMode);
				if (UpdateMode == eSpreadsheetUpdateMode.Replace)
				{
					UpdateMode = eSpreadsheetUpdateMode.Merge;
				}
			}
		}

		public List<string> GetCategories(bool OnlyMainCategory = false)
		{
			List<string> list = new List<string>();
			foreach (TermData mTerm in mTerms)
			{
				string categoryFromFullTerm = GetCategoryFromFullTerm(mTerm.Term, OnlyMainCategory);
				if (!list.Contains(categoryFromFullTerm))
				{
					list.Add(categoryFromFullTerm);
				}
			}
			list.Sort();
			return list;
		}

		internal static string GetKeyFromFullTerm(string FullTerm, bool OnlyMainCategory = false)
		{
			int num = ((!OnlyMainCategory) ? FullTerm.LastIndexOfAny(CategorySeparators) : FullTerm.IndexOfAny(CategorySeparators));
			return (num >= 0) ? FullTerm.Substring(num + 1) : FullTerm;
		}

		internal static string GetCategoryFromFullTerm(string FullTerm, bool OnlyMainCategory = false)
		{
			int num = ((!OnlyMainCategory) ? FullTerm.LastIndexOfAny(CategorySeparators) : FullTerm.IndexOfAny(CategorySeparators));
			return (num >= 0) ? FullTerm.Substring(0, num) : EmptyCategory;
		}

		internal static void DeserializeFullTerm(string FullTerm, out string Key, out string Category, bool OnlyMainCategory = false)
		{
			int num = ((!OnlyMainCategory) ? FullTerm.LastIndexOfAny(CategorySeparators) : FullTerm.IndexOfAny(CategorySeparators));
			if (num < 0)
			{
				Category = EmptyCategory;
				Key = FullTerm;
			}
			else
			{
				Category = FullTerm.Substring(0, num);
				Key = FullTerm.Substring(num + 1);
			}
		}

		private void Awake()
		{
			if (NeverDestroy)
			{
				if (ManagerHasASimilarSource())
				{
					UnityEngine.Object.Destroy(this);
					return;
				}
				UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			}
			LocalizationManager.AddSource(this);
			UpdateDictionary();
		}

		public void UpdateDictionary()
		{
			mDictionary.Clear();
			int i = 0;
			for (int count = mTerms.Count; i < count; i++)
			{
				ValidateFullTerm(ref mTerms[i].Term);
				mDictionary[mTerms[i].Term] = mTerms[i];
			}
		}

		public string GetSourceName()
		{
			string text = base.gameObject.name;
			Transform parent = base.transform.parent;
			while ((bool)parent)
			{
				text = parent.name + "_" + text;
				parent = parent.parent;
			}
			return text;
		}

		public int GetLanguageIndex(string language, bool AllowDiscartingRegion = true)
		{
			int i = 0;
			for (int count = mLanguages.Count; i < count; i++)
			{
				if (string.Compare(mLanguages[i].Name, language, StringComparison.OrdinalIgnoreCase) == 0)
				{
					return i;
				}
			}
			if (AllowDiscartingRegion)
			{
				int j = 0;
				for (int count2 = mLanguages.Count; j < count2; j++)
				{
					if (AreTheSameLanguage(mLanguages[j].Name, language))
					{
						return j;
					}
				}
			}
			return -1;
		}

		public static bool AreTheSameLanguage(string Language1, string Language2)
		{
			Language1 = GetLanguageWithoutRegion(Language1);
			Language2 = GetLanguageWithoutRegion(Language2);
			return string.Compare(Language1, Language2, StringComparison.OrdinalIgnoreCase) == 0;
		}

		public static string GetLanguageWithoutRegion(string Language)
		{
			int num = Language.IndexOfAny("(/\\[,{".ToCharArray());
			if (num < 0)
			{
				return Language;
			}
			return Language.Substring(0, num).Trim();
		}

		public void AddLanguage(string LanguageName, string LanguageCode)
		{
			if (GetLanguageIndex(LanguageName) < 0)
			{
				LanguageData languageData = new LanguageData();
				languageData.Name = LanguageName;
				languageData.Code = LanguageCode;
				mLanguages.Add(languageData);
				int count = mLanguages.Count;
				int i = 0;
				for (int count2 = mTerms.Count; i < count2; i++)
				{
					Array.Resize(ref mTerms[i].Languages, count);
				}
			}
		}

		public void RemoveLanguage(string LanguageName)
		{
			int languageIndex = GetLanguageIndex(LanguageName);
			if (languageIndex < 0)
			{
				return;
			}
			int count = mLanguages.Count;
			int i = 0;
			for (int count2 = mTerms.Count; i < count2; i++)
			{
				for (int j = languageIndex + 1; j < count; j++)
				{
					mTerms[i].Languages[j - 1] = mTerms[i].Languages[j];
				}
				Array.Resize(ref mTerms[i].Languages, count - 1);
			}
			mLanguages.RemoveAt(languageIndex);
		}

		public List<string> GetLanguages()
		{
			List<string> list = new List<string>();
			int i = 0;
			for (int count = mLanguages.Count; i < count; i++)
			{
				list.Add(mLanguages[i].Name);
			}
			return list;
		}

		public string GetTermTranslation(string term)
		{
			int languageIndex = GetLanguageIndex(LocalizationManager.CurrentLanguage);
			if (languageIndex < 0)
			{
				return string.Empty;
			}
			TermData termData = GetTermData(term);
			if (termData != null)
			{
				return termData.Languages[languageIndex];
			}
			return string.Empty;
		}

		public TermData AddTerm(string term)
		{
			return AddTerm(term, eTermType.Text);
		}

		public TermData GetTermData(string term)
		{
			if (mDictionary.Count == 0)
			{
				UpdateDictionary();
			}
			TermData value;
			mDictionary.TryGetValue(term, out value);
			return value;
		}

		public bool ContainsTerm(string term)
		{
			return GetTermData(term) != null;
		}

		public List<string> GetTermsList()
		{
			return new List<string>(mDictionary.Keys);
		}

		public TermData AddTerm(string NewTerm, eTermType termType)
		{
			ValidateFullTerm(ref NewTerm);
			NewTerm = NewTerm.Trim();
			TermData termData = GetTermData(NewTerm);
			if (termData == null)
			{
				termData = new TermData();
				termData.Term = NewTerm;
				termData.TermType = termType;
				termData.Languages = new string[mLanguages.Count];
				mTerms.Add(termData);
				mDictionary.Add(NewTerm, termData);
			}
			return termData;
		}

		public void RemoveTerm(string term)
		{
			int i = 0;
			for (int count = mTerms.Count; i < count; i++)
			{
				if (mTerms[i].Term == term)
				{
					mTerms.RemoveAt(i);
					mDictionary.Remove(term);
					break;
				}
			}
		}

		public static void ValidateFullTerm(ref string Term)
		{
			Term = Term.Replace('\\', '/');
			Term = Term.Trim();
			if (Term.StartsWith(EmptyCategory) && Term.Length > EmptyCategory.Length && Term[EmptyCategory.Length] == '/')
			{
				Term = Term.Substring(EmptyCategory.Length + 1);
			}
		}

		public bool IsEqualTo(LanguageSource Source)
		{
			if (Source.mLanguages.Count != mLanguages.Count)
			{
				return false;
			}
			int i = 0;
			for (int count = mLanguages.Count; i < count; i++)
			{
				if (Source.GetLanguageIndex(mLanguages[i].Name) < 0)
				{
					return false;
				}
			}
			return true;
		}

		internal bool ManagerHasASimilarSource()
		{
			int i = 0;
			for (int count = LocalizationManager.Sources.Count; i < count; i++)
			{
				LanguageSource languageSource = LocalizationManager.Sources[i];
				if (languageSource != null && languageSource.IsEqualTo(this) && languageSource != this)
				{
					return true;
				}
			}
			return false;
		}

		public void ClearAllData()
		{
			mTerms.Clear();
			mLanguages.Clear();
			mDictionary.Clear();
		}

		public UnityEngine.Object FindAsset(string Name)
		{
			if (Assets != null)
			{
				int i = 0;
				for (int num = Assets.Length; i < num; i++)
				{
					if (Assets[i] != null && Assets[i].name == Name)
					{
						return Assets[i];
					}
				}
			}
			return null;
		}

		public bool HasAsset(UnityEngine.Object Obj)
		{
			return Array.IndexOf(Assets, Obj) >= 0;
		}
	}
}
