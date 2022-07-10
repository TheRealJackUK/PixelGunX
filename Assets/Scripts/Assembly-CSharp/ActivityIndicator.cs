using UnityEngine;

[ExecuteInEditMode]
public sealed class ActivityIndicator : MonoBehaviour
{
	public static GameObject sharedActivityIndicator;

	public Texture2D[] animTexture;

	private int indexTexture;

	public Vector2 size = new Vector2(128f, 128f);

	private Vector2 pos = new Vector2(0f, 0f);

	private Rect rect;

	private Vector2 pivot;

	private float rotSpeed = 180f;

	public GUIStyle labelFonStyle;

	public GUIStyle labelStyle;

	public float delta;

	public string text;

	private float x;

	private float y;

	private float w;

	private float h;

	private void Awake()
	{
		Object.DontDestroyOnLoad(base.gameObject);
		size *= (float)Screen.height / 768f;
		UpdateSettings();
	}

	private void Start()
	{
		sharedActivityIndicator = base.gameObject;
		labelFonStyle.fontSize = Mathf.RoundToInt(24f * Defs.Coef);
		labelStyle.fontSize = Mathf.RoundToInt(24f * Defs.Coef);
		delta = 2f * Defs.Coef;
		x = ((float)Screen.width - 180f * (float)Screen.height / 768f) * 0.5f;
		y = ((float)Screen.height + 100f * (float)Screen.height / 768f) * 0.5f;
		w = 180f * (float)Screen.height / 768f;
		h = 22f * (float)Screen.height / 768f;
		OnEnable();
		if (Launcher.UsingNewLauncher)
		{
			base.gameObject.SetActive(false);
		}
	}

	private void OnEnable()
	{
		text = LocalizationStore.Get("Key_0853");
		Font fontByLocalize = LocalizationStore.GetFontByLocalize("Key_04B_03");
		labelFonStyle.font = fontByLocalize;
		labelStyle.font = fontByLocalize;
	}

	private void UpdateSettings()
	{
		pos = new Vector2((float)Screen.width / 2f, (float)Screen.height / 2f);
		rect = new Rect(pos.x - size.x * 0.5f, pos.y - size.y * 0.5f, size.x, size.y);
		pivot = new Vector2(rect.xMin + rect.width * 0.5f, rect.yMin + rect.height * 0.5f);
	}

	private void Update()
	{
		indexTexture++;
		if (indexTexture >= animTexture.Length)
		{
			indexTexture = 0;
		}
	}

	private void OnGUI()
	{
		GUI.depth = -3;
		GUI.DrawTexture(new Rect(((float)Screen.width - 180f * (float)Screen.height / 768f) * 0.5f, ((float)Screen.height - 170f * (float)Screen.height / 768f) * 0.5f, 180f * (float)Screen.height / 768f, (float)(170 * Screen.height) / 768f), animTexture[indexTexture]);
		GUI.Label(new Rect(x - delta, y, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x - delta, y - delta, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x, y - delta, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x + delta, y - delta, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x + delta, y, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x + delta, y + delta, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x, y + delta, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x - delta, y + delta, w, h), text, labelFonStyle);
		GUI.Label(new Rect(x, y, w, h), text, labelStyle);
	}

	public static bool IsLoadingActive()
	{
		if (sharedActivityIndicator == null)
		{
			return false;
		}
		return sharedActivityIndicator.gameObject.activeSelf;
	}
}
