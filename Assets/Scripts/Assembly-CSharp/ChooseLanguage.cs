using UnityEngine;

public class ChooseLanguage : MonoBehaviour
{
	public UIButton[] languageButtons;

	private UIButton _currentLanguage;

	private void SetSelectCurrentLanguage()
	{
		int currentLanguageIndex = LocalizationStore.GetCurrentLanguageIndex();
		if (currentLanguageIndex != -1 && currentLanguageIndex < languageButtons.Length)
		{
			if (_currentLanguage != null)
			{
				_currentLanguage.ResetDefaultColor();
			}
			languageButtons[currentLanguageIndex].defaultColor = Color.grey;
			_currentLanguage = languageButtons[currentLanguageIndex];
		}
	}

	private void Start()
	{
		SetSelectCurrentLanguage();
	}

	private void SelectLanguage(string languageName)
	{
		LocalizationStore.CurrentLanguage = languageName;
		SetSelectCurrentLanguage();
	}

	public void SetRussianLanguage()
	{
		SelectLanguage("Russian");
	}

	public void SetEnglishLanguage()
	{
		SelectLanguage("English");
	}

	public void SetFrancianLanguage()
	{
		SelectLanguage("French");
	}

	public void SetDeutschLanguage()
	{
		SelectLanguage("German");
	}

	public void SetJapanLanguage()
	{
		SelectLanguage("Japanese");
	}

	public void SetEspanolaLanguage()
	{
		SelectLanguage("Spanish");
	}

	public void SetChinseLanguage()
	{
		SelectLanguage("Chinese (Chinese)");
	}

	public void SetKoreanLanguage()
	{
		SelectLanguage("Korean");
	}

	public void SetBrazilLanguage()
	{
		SelectLanguage("Portuguese (Brazil)");
	}
}
