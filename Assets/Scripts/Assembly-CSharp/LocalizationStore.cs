using System.Collections.Generic;
using I2.Loc;
using UnityEngine;

public static class LocalizationStore
{
	private static int EnglishLanguageIndex;

	private static LanguageSource _globalSource;

	public static string Key_0190
	{
		get
		{
			return Get("Key_0190");
		}
	}

	public static string Key_0193
	{
		get
		{
			return Get("Key_0193");
		}
	}

	public static string Key_0204
	{
		get
		{
			return Get("Key_0204");
		}
	}

	public static string Key_0207
	{
		get
		{
			return Get("Key_0207");
		}
	}

	public static string Key_0226
	{
		get
		{
			return Get("Key_0226");
		}
	}

	public static string Key_0275
	{
		get
		{
			return Get("Key_0275");
		}
	}

	public static string Key_0318
	{
		get
		{
			return Get("Key_0318");
		}
	}

	public static string Key_0319
	{
		get
		{
			return Get("Key_0319");
		}
	}

	public static string Key_0348
	{
		get
		{
			return Get("Key_0348");
		}
	}

	public static string Key_0349
	{
		get
		{
			return Get("Key_0349");
		}
	}

	public static string Key_0350
	{
		get
		{
			return Get("Key_0350");
		}
	}

	public static string Key_0351
	{
		get
		{
			return Get("Key_0351");
		}
	}

	public static string Key_0419
	{
		get
		{
			return Get("Key_0419");
		}
	}

	public static string Key_0545
	{
		get
		{
			return Get("Key_0545");
		}
	}

	public static string Key_0546
	{
		get
		{
			return Get("Key_0546");
		}
	}

	public static string Key_0547
	{
		get
		{
			return Get("Key_0547");
		}
	}

	public static string Key_0548
	{
		get
		{
			return Get("Key_0548");
		}
	}

	public static string Key_0549
	{
		get
		{
			return Get("Key_0549");
		}
	}

	public static string Key_0550
	{
		get
		{
			return Get("Key_0550");
		}
	}

	public static string Key_0551
	{
		get
		{
			return Get("Key_0551");
		}
	}

	public static string Key_0552
	{
		get
		{
			return Get("Key_0552");
		}
	}

	public static string Key_0553
	{
		get
		{
			return Get("Key_0553");
		}
	}

	public static string Key_0554
	{
		get
		{
			return Get("Key_0554");
		}
	}

	public static string Key_0555
	{
		get
		{
			return Get("Key_0555");
		}
	}

	public static string Key_0556
	{
		get
		{
			return Get("Key_0556");
		}
	}

	public static string Key_0557
	{
		get
		{
			return Get("Key_0557");
		}
	}

	public static string Key_0558
	{
		get
		{
			return Get("Key_0558");
		}
	}

	public static string Key_0559
	{
		get
		{
			return Get("Key_0559");
		}
	}

	public static string Key_0560
	{
		get
		{
			return Get("Key_0560");
		}
	}

	public static string Key_0561
	{
		get
		{
			return Get("Key_0561");
		}
	}

	public static string Key_0562
	{
		get
		{
			return Get("Key_0562");
		}
	}

	public static string Key_0563
	{
		get
		{
			return Get("Key_0563");
		}
	}

	public static string Key_0564
	{
		get
		{
			return Get("Key_0564");
		}
	}

	public static string Key_0565
	{
		get
		{
			return Get("Key_0565");
		}
	}

	public static string Key_0566
	{
		get
		{
			return Get("Key_0566");
		}
	}

	public static string Key_0567
	{
		get
		{
			return Get("Key_0567");
		}
	}

	public static string Key_0568
	{
		get
		{
			return Get("Key_0568");
		}
	}

	public static string Key_0569
	{
		get
		{
			return Get("Key_0569");
		}
	}

	public static string Key_0570
	{
		get
		{
			return Get("Key_0570");
		}
	}

	public static string Key_0571
	{
		get
		{
			return Get("Key_0571");
		}
	}

	public static string Key_0588
	{
		get
		{
			return Get("Key_0588");
		}
	}

	public static string Key_0589
	{
		get
		{
			return Get("Key_0589");
		}
	}

	public static string CurrentLanguage
	{
		get
		{
			return LocalizationManager.CurrentLanguage;
		}
		set
		{
			if (!(value == LocalizationManager.CurrentLanguage) && LocalizationManager.HasLanguage(value, false))
			{
				LocalizationManager.CurrentLanguage = value;
				PlayerPrefs.SetString(Defs.CurrentLanguage, value);
				PlayerPrefs.Save();
			}
		}
	}

	public static string Get(string Term)
	{
		return LocalizationManager.GetTranslation(Term);
	}

	public static string GetByDefault(string Term)
	{
		return LocalizationManager.GetTermTranslationByDefault(Term);
	}

	public static void AddEventCallAfterLocalize(LocalizationManager.OnLocalizeCallback addEvent)
	{
		LocalizationManager.OnLocalizeEvent += addEvent;
	}

	public static void DelEventCallAfterLocalize(LocalizationManager.OnLocalizeCallback delEvent)
	{
		LocalizationManager.OnLocalizeEvent -= delEvent;
	}

	public static void ImportWeaponLocalizeToSource(string newKey, string englishText)
	{
		if (_globalSource == null)
		{
			GameObject gameObject = Resources.Load("I2Languages") as GameObject;
			_globalSource = ((!gameObject) ? null : gameObject.GetComponent<LanguageSource>());
			if (_globalSource == null)
			{
				Debug.Log("Not found LanguageResource. Process stop!");
				return;
			}
		}
		TermData termData = null;
		if (_globalSource.ContainsTerm(newKey))
		{
			termData = _globalSource.GetTermData(newKey);
			if (termData != null && termData.Languages[EnglishLanguageIndex] != englishText)
			{
				termData.Languages[EnglishLanguageIndex] = englishText;
			}
		}
		else
		{
			termData = _globalSource.AddTerm(newKey, eTermType.Text);
			termData.Languages[EnglishLanguageIndex] = englishText;
		}
	}

	public static Font GetFontByLocalize(string keyFontLocalize)
	{
		string path = Get(keyFontLocalize);
		return Resources.Load<Font>(path);
	}

	public static int GetCurrentLanguageIndex()
	{
		List<string> allLanguages = LocalizationManager.GetAllLanguages();
		if (allLanguages == null || allLanguages.Count == 0)
		{
			return -1;
		}
		for (int i = 0; i < allLanguages.Count; i++)
		{
			if (allLanguages[i] == CurrentLanguage)
			{
				return i;
			}
		}
		return -1;
	}

	public static string GetCurrentLanguageCode()
	{
		string languageCode = LocalizationManager.GetLanguageCode(CurrentLanguage);
		if (languageCode.Contains("ru"))
		{
			return "ru";
		}
		if (languageCode.Contains("en"))
		{
			return "en";
		}
		if (languageCode.Contains("pt"))
		{
			return "pt";
		}
		return languageCode;
	}
}
