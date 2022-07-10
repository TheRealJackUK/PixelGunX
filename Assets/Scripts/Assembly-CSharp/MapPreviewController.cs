using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public sealed class MapPreviewController : MonoBehaviour
{
	public UILabel NameMapLbl;

	public UILabel SizeMapNameLbl;

	public UILabel popularityLabel;

	public GameObject premium;

	public GameObject milee;

	public string mapID;

	private string[] masRatingStr;

	private void Start()
	{
		masRatingStr = new string[5]
		{
			LocalizationStore.Key_0545,
			LocalizationStore.Key_0546,
			LocalizationStore.Key_0547,
			LocalizationStore.Key_0548,
			LocalizationStore.Key_0549
		};
		StartCoroutine(SetPopularity());
	}

	private IEnumerator SetPopularity()
	{
		Dictionary<string, string> _mapsPoplarityInCurrentRegim;
		while (true)
		{
			if (FriendsController.mapPopularityDictionary.Count > 0)
			{
				_mapsPoplarityInCurrentRegim = null;
				try
				{
					_mapsPoplarityInCurrentRegim = FriendsController.mapPopularityDictionary[((int)ConnectSceneNGUIController.regim).ToString()];
				}
				catch (KeyNotFoundException)
				{
				}
				if (_mapsPoplarityInCurrentRegim != null)
				{
					break;
				}
				yield return StartCoroutine(MyWaitForSeconds(2f));
			}
			else
			{
				yield return StartCoroutine(MyWaitForSeconds(2f));
			}
		}
		int countMaps = 0;
		foreach (KeyValuePair<string, string> item in _mapsPoplarityInCurrentRegim)
		{
			countMaps += int.Parse(item.Value);
		}
		int rating = 0;
		if (_mapsPoplarityInCurrentRegim.ContainsKey(mapID))
		{
			float procentRating = (float)int.Parse(_mapsPoplarityInCurrentRegim[mapID]) / (float)countMaps * 100f;
			if (procentRating > 0f && procentRating < 3f)
			{
				rating = 1;
			}
			if (procentRating >= 3f && procentRating < 8f)
			{
				rating = 3;
			}
			if (procentRating >= 8f)
			{
				rating = 4;
			}
		}
		popularityLabel.text = masRatingStr[rating];
		popularityLabel.gameObject.SetActive(true);
	}

	public IEnumerator MyWaitForSeconds(float tm)
	{
		float startTime = Time.realtimeSinceStartup;
		do
		{
			yield return null;
		}
		while (Time.realtimeSinceStartup - startTime < tm);
	}

	private void Update()
	{
	}

	private void OnClick()
	{
		ConnectSceneNGUIController.sharedController.grid.GetComponent<MyCenterOnChild>().CenterOn(base.transform);
	}
}
