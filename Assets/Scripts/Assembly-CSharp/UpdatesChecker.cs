using System.Collections;
using Rilisoft;
using UnityEngine;

internal sealed class UpdatesChecker : MonoBehaviour
{
	private enum Store
	{
		Ios,
		Play,
		Wp8,
		Amazon,
		Unknown
	}

	private const string ActionAddress = "http://oldpg3d.7m.pl/~pgx/action.php";

	private Store _currentStore;

	private IEnumerator CheckUpdatesCoroutine(Store store)
	{
		string version = string.Format("{0}:{1}", (int)store, GlobalGameController.AppVersion);
		if (Application.isEditor)
		{
			Debug.Log("Sending version: " + version);
		}
		WWWForm form = new WWWForm();
		form.AddField("action", "check_shop_version");
		form.AddField("app_version", version);
		WWW request = new WWW("http://oldpg3d.7m.pl/~pgx/action.php", form);
		yield return request;
		if (!string.IsNullOrEmpty(request.error))
		{
			Debug.LogWarning("Error while receiving version: " + request.error);
			yield break;
		}
		string response = URLs.Sanitize(request);
		if (string.IsNullOrEmpty(response))
		{
			Debug.Log("response is empty");
			yield break;
		}
		if (Application.isEditor)
		{
			Debug.Log("UpdatesChecker: " + response);
		}
		if (response.Equals("no"))
		{
			GlobalGameController.NewVersionAvailable = true;
			Debug.Log("NewVersionAvailable: true");
		}
	}

	private void Awake()
	{
		if (Application.isEditor)
		{
			Debug.Log(">>> UpdatesChecker.Awake()");
		}
		Object.DontDestroyOnLoad(base.gameObject);
		_currentStore = Store.Unknown;
		switch (BuildSettings.BuildTarget)
		{
		case BuildTarget.iPhone:
			_currentStore = Store.Ios;
			break;
		case BuildTarget.Android:
			switch (Defs.AndroidEdition)
			{
			case Defs.RuntimeAndroidEdition.GoogleLite:
				_currentStore = Store.Play;
				break;
			case Defs.RuntimeAndroidEdition.Amazon:
				_currentStore = Store.Amazon;
				break;
			}
			break;
		case BuildTarget.WP8Player:
			_currentStore = Store.Wp8;
			break;
		}
	}

	private void Start()
	{
		if (Application.isEditor)
		{
			Debug.Log(">>> UpdatesChecker.Start()");
		}
		StartCoroutine(CheckUpdatesCoroutine(_currentStore));
	}

	private void OnApplicationPause(bool pause)
	{
		if (Application.isEditor)
		{
			Debug.Log(">>> UpdatesChecker.OnApplicationPause()");
		}
		if (!pause)
		{
			StartCoroutine(CheckUpdatesCoroutine(_currentStore));
		}
	}
}
