using UnityEngine;

public class BlinkHealthButton : MonoBehaviour
{
	public enum RegimButton
	{
		Health = 0,
		Ammo = 1,
	}

	public RegimButton typeButton;
	public float timerBlink;
	public float maxTimerBlink;
	public Color blinkColor;
	public Color unBlinkColor;
	public bool isBlinkState;
	public UISprite[] blinkObjs;
	public bool isBlinkTemp;
	public UISprite shine;
}
