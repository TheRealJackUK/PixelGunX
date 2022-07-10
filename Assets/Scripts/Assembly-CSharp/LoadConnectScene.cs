using System.Reflection;
using UnityEngine;

public sealed class LoadConnectScene : MonoBehaviour
{
	public static string sceneToLoad = string.Empty;

	public static Texture textureToShow = null;

	public static Texture noteToShow = null;

	public static float interval = _defaultInterval;

	public Texture loadingNote;

	private static readonly float _defaultInterval = 1f;

	private Texture loading;

	private GameObject aInd;

	private LoadingNGUIController _loadingNGUIController;

	private void Awake()
	{
		loading = textureToShow;
		if (loading == null)
		{
			string path = ConnectSceneNGUIController.MainLoadingTexture();
			loading = Resources.Load<Texture>(path);
		}
		_loadingNGUIController = (Object.Instantiate(Resources.Load<GameObject>("LoadingGUI")) as GameObject).GetComponent<LoadingNGUIController>();
		_loadingNGUIController.SceneToLoad = sceneToLoad;
		_loadingNGUIController.loadingNGUITexture.mainTexture = loading;
		_loadingNGUIController.Init();
	}

	private void Start()
	{
		Invoke("_loadConnectScene", interval);
		interval = _defaultInterval;
		aInd = StoreKitEventListener.purchaseActivityInd;
		if (aInd == null)
		{
			Debug.LogWarning("aInd == null");
		}
		else
		{
			aInd.SetActive(true);
		}
	}

	private void OnGUI()
	{
		if (aInd != null)
		{
			aInd.SetActive(true);
		}
	}

	[Obfuscation(Exclude = true)]
	private void _loadConnectScene()
	{
		if (sceneToLoad.Equals("ConnectScene"))
		{
			Application.LoadLevel(sceneToLoad);
		}
		else
		{
			Application.LoadLevelAsync(sceneToLoad);
		}
	}

	private void OnDestroy()
	{
		if (!sceneToLoad.Equals("ConnectScene") && aInd != null)
		{
			aInd.SetActive(false);
		}
		textureToShow = null;
	}
}
