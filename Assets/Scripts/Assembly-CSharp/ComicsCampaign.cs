using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

internal sealed class ComicsCampaign : MonoBehaviour
{
	public RawImage background;

	public RawImage[] comicFrames = new RawImage[4];

	public Button skipButton;

	public Text subtitlesText;

	private string[] _subtitles = new string[4]
	{
		string.Empty,
		string.Empty,
		string.Empty,
		string.Empty
	};

	private int _frameCount;

	private bool _hasSecondPage;

	private bool _isFirstLaunch = true;

	private Coroutine _coroutine;

	private Action _skipHandler;

	public void HandleSkipPressed()
	{
		Debug.Log("[Skip] pressed.");
		if (_skipHandler != null)
		{
			_skipHandler();
		}
	}

	private bool DetermineIfFirstLaunch()
	{
		if (LevelArt.endOfBox)
		{
			string[] source = Load.LoadStringArray(Defs.ArtBoxS) ?? new string[0];
			return !source.Any(CurrentCampaignGame.boXName.Equals);
		}
		string[] source2 = Load.LoadStringArray(Defs.ArtLevsS) ?? new string[0];
		return !source2.Any(CurrentCampaignGame.levelSceneName.Equals);
	}

	private void Awake()
	{
		if (subtitlesText != null)
		{
			subtitlesText.transform.parent.gameObject.SetActive(LocalizationStore.CurrentLanguage != "English");
		}
		_frameCount = Math.Min(4, comicFrames.Length);
		_isFirstLaunch = DetermineIfFirstLaunch();
	}

	private IEnumerator Start()
	{
		Texture nextTexture = Resources.Load<Texture>(GetNameForIndex(_frameCount + 1, LevelArt.endOfBox));
		_hasSecondPage = nextTexture != null;
		if (_isFirstLaunch)
		{
			SetSkipHandler(null);
		}
		else if (_hasSecondPage)
		{
			SetSkipHandler(GotoNextPage);
		}
		else
		{
			SetSkipHandler(GotoLevelOrBoxmap);
		}
		if (background != null)
		{
			background.texture = Resources.Load<Texture>("Arts_background_" + CurrentCampaignGame.boXName);
		}
		for (int i = 0; i != _frameCount; i++)
		{
			string pathToComicTexture = GetNameForIndex(i + 1, LevelArt.endOfBox);
			Texture texture = Resources.Load<Texture>(pathToComicTexture);
			if (texture == null)
			{
				Debug.LogWarning("Texture is null: " + pathToComicTexture);
				break;
			}
			comicFrames[i].rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, texture.width);
			comicFrames[i].rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, texture.height);
			comicFrames[i].texture = texture;
			comicFrames[i].color = new Color(1f, 1f, 1f, 0f);
			string localizationKey = ((!LevelArt.endOfBox) ? string.Format("{0}_{1}", CurrentCampaignGame.levelSceneName, i) : string.Format("{0}_{1}", CurrentCampaignGame.boXName, i));
			_subtitles[i] = LocalizationStore.Get(localizationKey) ?? string.Empty;
		}
		_coroutine = StartCoroutine(FadeInCoroutine(null));
		yield return _coroutine;
		if (_hasSecondPage)
		{
			SetSkipHandler(GotoNextPage);
		}
		else
		{
			SetSkipHandler(GotoLevelOrBoxmap);
		}
	}

	private void GotoNextPage()
	{
		if (_isFirstLaunch)
		{
			SetSkipHandler(null);
		}
		else
		{
			SetSkipHandler(GotoLevelOrBoxmap);
		}
		if (_coroutine != null)
		{
			StopCoroutine(_coroutine);
		}
		for (int i = 0; i != comicFrames.Length; i++)
		{
			if (!(comicFrames[i] == null))
			{
				comicFrames[i].texture = null;
				comicFrames[i].color = new Color(1f, 1f, 1f, 0f);
				_subtitles[i] = string.Empty;
			}
		}
		Resources.UnloadUnusedAssets();
		for (int j = 0; j != _frameCount; j++)
		{
			string nameForIndex = GetNameForIndex(_frameCount + j + 1, LevelArt.endOfBox);
			Texture texture = Resources.Load<Texture>(nameForIndex);
			if (texture == null)
			{
				break;
			}
			comicFrames[j].rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, texture.width);
			comicFrames[j].rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, texture.height);
			comicFrames[j].texture = texture;
			string term = ((!LevelArt.endOfBox) ? string.Format("{0}_{1}", CurrentCampaignGame.levelSceneName, _frameCount + j) : string.Format("{0}_{1}", CurrentCampaignGame.boXName, _frameCount + j));
			_subtitles[j] = LocalizationStore.Get(term) ?? string.Empty;
		}
		_coroutine = StartCoroutine(FadeInCoroutine(GotoLevelOrBoxmap));
	}

	private void GotoLevelOrBoxmap()
	{
		if (_coroutine != null)
		{
			StopCoroutine(_coroutine);
		}
		if (LevelArt.endOfBox)
		{
			string[] array = Load.LoadStringArray(Defs.ArtBoxS) ?? new string[0];
			if (Array.IndexOf(array, CurrentCampaignGame.boXName) == -1)
			{
				List<string> list = new List<string>(array);
				list.Add(CurrentCampaignGame.boXName);
				Save.SaveStringArray(Defs.ArtBoxS, list.ToArray());
			}
		}
		else
		{
			string[] array2 = Load.LoadStringArray(Defs.ArtLevsS) ?? new string[0];
			if (Array.IndexOf(array2, CurrentCampaignGame.levelSceneName) == -1)
			{
				List<string> list2 = new List<string>(array2);
				list2.Add(CurrentCampaignGame.levelSceneName);
				Save.SaveStringArray(Defs.ArtLevsS, list2.ToArray());
			}
		}
		Application.LoadLevel((!LevelArt.endOfBox) ? "CampaignLoading" : "ChooseLevel");
	}

	private void SetSkipHandler(Action skipHandler)
	{
		_skipHandler = skipHandler;
		if (skipButton != null)
		{
			skipButton.gameObject.SetActive(skipHandler != null);
		}
	}

	private IEnumerator FadeInCoroutine(Action skipHandler = null)
	{
		for (int comicFrameIndex = 0; comicFrameIndex != comicFrames.Length; comicFrameIndex++)
		{
			RawImage f = comicFrames[comicFrameIndex];
			if (!(f == null))
			{
				if (subtitlesText != null)
				{
					subtitlesText.text = _subtitles[comicFrameIndex];
				}
				for (int i = 0; i != 30; i++)
				{
					float newAlpha = Mathf.InverseLerp(0f, 30f, i);
					f.color = new Color(1f, 1f, 1f, newAlpha);
					yield return new WaitForSeconds(1f / 30f);
				}
				f.color = new Color(1f, 1f, 1f, 1f);
				yield return new WaitForSeconds(2f);
			}
		}
		if (skipHandler != null)
		{
			SetSkipHandler(skipHandler);
		}
	}

	private static string GetNameForIndex(int num, bool endOfBox)
	{
		return ResPath.Combine("Arts", ResPath.Combine((!endOfBox) ? CurrentCampaignGame.levelSceneName : CurrentCampaignGame.boXName, num.ToString()));
	}
}
