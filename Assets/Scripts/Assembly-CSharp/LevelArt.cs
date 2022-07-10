using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using UnityEngine;

internal sealed class LevelArt : MonoBehaviour
{
	private const int ComicsOnScreen = 4;

	public static readonly bool ShouldShowArts = true;

	public GUIStyle startButton;

	public static bool endOfBox;

	public GUIStyle labelsStyle;

	public float widthBackLabel = 770f;

	public float heightBackLabel = 100f;

	private float _alphaForComics;

	private int _currentComicsImageIndex;

	private bool _isFirstLaunch = true;

	public float _delayShowComics = 3f;

	private bool _isSkipComics;

	private int _countOfComics = 4;

	private Texture _backgroundComics;

	private List<Texture> _comicsTextures = new List<Texture>();

	private bool _isShowButton;

	private string _currentSubtitle;

	private bool _needShowSubtitle;

	[Obsolete("Use ComicsCampaign via uGUI instead of this class.")]
	private void Start()
	{
		_needShowSubtitle = LocalizationStore.CurrentLanguage != "English";
		labelsStyle.font = LocalizationStore.GetFontByLocalize("Key_04B_03");
		labelsStyle.fontSize = Mathf.RoundToInt(20f * Defs.Coef);
		if (Resources.Load<Texture>(_NameForNumber(5)) != null)
		{
			_countOfComics *= 2;
		}
		StartCoroutine("ShowArts");
		_backgroundComics = Resources.Load<Texture>("Arts_background_" + CurrentCampaignGame.boXName);
		if (endOfBox)
		{
			string[] array = Load.LoadStringArray(Defs.ArtBoxS) ?? new string[0];
			string[] array2 = array;
			foreach (string text in array2)
			{
				if (text.Equals(CurrentCampaignGame.boXName))
				{
					_isFirstLaunch = false;
					break;
				}
			}
		}
		else
		{
			string[] array3 = Load.LoadStringArray(Defs.ArtLevsS) ?? new string[0];
			string[] array4 = array3;
			foreach (string text2 in array4)
			{
				if (text2.Equals(CurrentCampaignGame.levelSceneName))
				{
					_isFirstLaunch = false;
					break;
				}
			}
		}
		_isShowButton = !_isFirstLaunch;
	}

	private void GoToLevel()
	{
		if (endOfBox)
		{
			string[] array = Load.LoadStringArray(Defs.ArtBoxS) ?? new string[0];
			if (Array.IndexOf(array, CurrentCampaignGame.boXName) == -1)
			{
				List<string> list = new List<string>();
				string[] array2 = array;
				foreach (string item in array2)
				{
					list.Add(item);
				}
				list.Add(CurrentCampaignGame.boXName);
				Save.SaveStringArray(Defs.ArtBoxS, list.ToArray());
			}
		}
		else
		{
			string[] array3 = Load.LoadStringArray(Defs.ArtLevsS) ?? new string[0];
			if (!endOfBox && Array.IndexOf(array3, CurrentCampaignGame.levelSceneName) == -1)
			{
				List<string> list2 = new List<string>();
				string[] array4 = array3;
				foreach (string item2 in array4)
				{
					list2.Add(item2);
				}
				list2.Add(CurrentCampaignGame.levelSceneName);
				Save.SaveStringArray(Defs.ArtLevsS, list2.ToArray());
			}
		}
		Application.LoadLevel((!endOfBox) ? "CampaignLoading" : "ChooseLevel");
	}

	private string _NameForNumber(int num)
	{
		return ResPath.Combine("Arts", ResPath.Combine((!endOfBox) ? CurrentCampaignGame.levelSceneName : CurrentCampaignGame.boXName, num.ToString()));
	}

	[Obfuscation(Exclude = true)]
	private IEnumerator ShowArts()
	{
		string pathToComicsTexture = string.Empty;
		Texture newComicsTexture = null;
		do
		{
			newComicsTexture = null;
			_currentComicsImageIndex++;
			pathToComicsTexture = _NameForNumber(_currentComicsImageIndex);
			newComicsTexture = Resources.Load<Texture>(pathToComicsTexture);
			if (newComicsTexture != null)
			{
				if (_comicsTextures.Count == 4)
				{
					_comicsTextures.Clear();
				}
				_comicsTextures.Add(newComicsTexture);
				string localizationKey = ((!endOfBox) ? string.Format("{0}_{1}", CurrentCampaignGame.levelSceneName, _currentComicsImageIndex - 1) : string.Format("{0}_{1}", CurrentCampaignGame.boXName, _currentComicsImageIndex - 1));
				_currentSubtitle = LocalizationStore.Get(localizationKey) ?? string.Empty;
				if (localizationKey.Equals(_currentSubtitle))
				{
					_currentSubtitle = string.Empty;
				}
				Resources.UnloadUnusedAssets();
				_alphaForComics = 0f;
				float prevTime = Time.time;
				float startTime = Time.time;
				do
				{
					yield return new WaitForEndOfFrame();
					_alphaForComics += (Time.time - prevTime) / _delayShowComics;
					prevTime = Time.time;
				}
				while (Time.time - startTime < _delayShowComics && !_isSkipComics);
				_isSkipComics = false;
				_alphaForComics = 1f;
				continue;
			}
			GoToLevel();
			yield break;
		}
		while (newComicsTexture != null && _currentComicsImageIndex % 4 != 0);
		yield return new WaitForSeconds(_delayShowComics);
		_isShowButton = true;
	}

	[Obsolete("Use ComicsCampaign via uGUI instead of this class.")]
	private void OnGUI()
	{
	}

	public static string WrappedText(string text)
	{
		int num = 30;
		StringBuilder stringBuilder = new StringBuilder();
		int num2 = 0;
		int num3 = 0;
		while (num2 < text.Length)
		{
			stringBuilder.Append(text[num2]);
			if (text[num2] == '\n')
			{
				stringBuilder.Append('\n');
			}
			if (num3 >= num && text[num2] == ' ')
			{
				stringBuilder.Append("\n\n");
				num3 = 0;
			}
			num2++;
			num3++;
		}
		return stringBuilder.ToString();
	}
}
