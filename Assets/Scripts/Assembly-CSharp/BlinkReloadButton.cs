using UnityEngine;

public class BlinkReloadButton : MonoBehaviour
{
	public static bool isBlink;

	private bool isBlinkOld;

	private float timerBlink;

	public float maxTimerBlink = 0.5f;

	public Color blinkColor = new Color(1f, 0f, 0f);

	public Color unBlinkColor = new Color(1f, 1f, 1f);

	public static bool isBlinkState;

	public UISprite[] blinkObjs;

	public bool isBlinkTemp;

	private void Start()
	{
		isBlink = false;
		isBlinkState = false;
	}

	private void Update()
	{
		isBlinkTemp = isBlink;
		if (isBlinkOld != isBlink)
		{
			timerBlink = maxTimerBlink;
		}
		if (isBlink)
		{
			timerBlink -= Time.deltaTime;
			if (timerBlink < 0f)
			{
				timerBlink = maxTimerBlink;
				isBlinkState = !isBlinkState;
				for (int i = 0; i < blinkObjs.Length; i++)
				{
					blinkObjs[i].color = ((!isBlinkState) ? unBlinkColor : blinkColor);
				}
			}
		}
		if (!isBlink && isBlinkState)
		{
			isBlinkState = !isBlinkState;
			for (int j = 0; j < blinkObjs.Length; j++)
			{
				blinkObjs[j].color = ((!isBlinkState) ? unBlinkColor : blinkColor);
			}
		}
		isBlinkOld = isBlink;
	}
}
