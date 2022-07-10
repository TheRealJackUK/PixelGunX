using UnityEngine;

public class AdmobPerelivWindow : MonoBehaviour
{
	public enum WinState
	{
		none,
		on,
		show,
		off
	}

	public WinState state;

	private float timeOn = 0.2f;

	private Transform myTransform;

	public static Texture admobTexture = null;

	public static string admobUrl = string.Empty;

	public UITexture adTexture;

	public GameObject closeAnchor;

	public UISprite closeSprite;

	public UITexture lightTexture;

	public UISprite closeSpriteAndr;

	public static string Context { get; set; }

	private void Awake()
	{
		myTransform = base.transform;
		closeSprite.gameObject.SetActive(false);
		closeSpriteAndr.gameObject.SetActive(true);
	}

	private void Start()
	{
		if (closeAnchor != null)
		{
			closeAnchor.transform.localPosition = new Vector3((float)(-Screen.width / 2) * 768f / (float)Screen.height, 384f, 0f);
		}
	}

	private void Update()
	{
		if (state == WinState.on && myTransform.localPosition.y < 0f)
		{
			float y = myTransform.localPosition.y;
			y += 770f / timeOn * Time.deltaTime;
			if (y > 0f)
			{
				y = 0f;
				state = WinState.show;
			}
			myTransform.localPosition = new Vector3(0f, y, 0f);
		}
		if (state != WinState.off || !(myTransform.localPosition.y > -770f))
		{
			return;
		}
		float y2 = myTransform.localPosition.y;
		y2 -= 770f / timeOn * Time.deltaTime;
		if (y2 < -770f)
		{
			y2 = -770f;
			state = WinState.none;
			base.gameObject.SetActive(false);
			adTexture.mainTexture = null;
			if (admobTexture != null)
			{
				Object.Destroy(admobTexture);
			}
			admobTexture = null;
			admobUrl = string.Empty;
		}
		myTransform.localPosition = new Vector3(0f, y2, 0f);
	}

	public void Show()
	{
		if (state == WinState.none)
		{
			float num = admobTexture.width;
			float num2 = admobTexture.height;
			Debug.Log(num + "x" + num2 + "     " + Screen.width + "x" + Screen.height);
			if (num2 / num >= (float)Screen.height / (float)Screen.width)
			{
				num = num * 768f / num2;
				num2 = 768f;
			}
			else
			{
				num2 = num2 * (768f * (float)Screen.width) / ((float)Screen.height * num);
				num = 768f * (float)Screen.width / (float)Screen.height;
			}
			adTexture.keepAspectRatio = UIWidget.AspectRatioSource.Free;
			adTexture.mainTexture = admobTexture;
			adTexture.width = Mathf.RoundToInt(num);
			adTexture.height = Mathf.RoundToInt(num2);
			myTransform.localPosition = new Vector3(0f, 0f, 0f);
			state = WinState.show;
		}
	}

	public void Hide()
	{
		if (state == WinState.show)
		{
			adTexture.mainTexture = null;
			if (admobTexture != null)
			{
				Object.Destroy(admobTexture);
			}
			admobTexture = null;
			admobUrl = string.Empty;
			state = WinState.none;
			base.gameObject.SetActive(false);
		}
	}
}
