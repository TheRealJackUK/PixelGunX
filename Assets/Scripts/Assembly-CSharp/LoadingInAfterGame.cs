using UnityEngine;

public class LoadingInAfterGame : MonoBehaviour
{
	public static Texture loadingTexture;

	public static bool isShowLoading;

	private float timerShow = 2f;

	private LoadingNGUIController _loadingNGUIController;

	private bool ShouldShowLoading
	{
		get
		{
			return !(timerShow <= 0f) && !(loadingTexture == null) && Defs.isMulti && !Defs.isHunger;
		}
	}

	private void Awake()
	{
		if (ShouldShowLoading)
		{
			_loadingNGUIController = (Object.Instantiate(Resources.Load<GameObject>("LoadingGUI")) as GameObject).GetComponent<LoadingNGUIController>();
			_loadingNGUIController.SceneToLoad = Application.loadedLevelName;
			_loadingNGUIController.loadingNGUITexture.mainTexture = loadingTexture;
			_loadingNGUIController.transform.localPosition = Vector3.zero;
			_loadingNGUIController.Init();
			isShowLoading = true;
		}
	}

	private void Update()
	{
		if (timerShow > 0f)
		{
			timerShow -= Time.deltaTime;
		}
		if (!ActivityIndicator.sharedActivityIndicator.activeSelf)
		{
			ActivityIndicator.sharedActivityIndicator.SetActive(true);
		}
		if (!ShouldShowLoading)
		{
			isShowLoading = false;
			base.enabled = false;
			loadingTexture = null;
			ActivityIndicator.sharedActivityIndicator.SetActive(false);
			if (_loadingNGUIController != null)
			{
				Object.Destroy(_loadingNGUIController.gameObject);
				_loadingNGUIController = null;
				Resources.UnloadUnusedAssets();
			}
		}
	}

	private void OnDestroy()
	{
		isShowLoading = false;
	}
}
