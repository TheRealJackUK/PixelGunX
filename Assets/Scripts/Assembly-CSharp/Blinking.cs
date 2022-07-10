using UnityEngine;

public class Blinking : MonoBehaviour
{
	public float halfCycle = 1f;

	private UISprite mySprite;

	private float _time;

	private void Start()
	{
		mySprite = GetComponent<UISprite>();
	}

	private void Update()
	{
		_time += Time.deltaTime;
		if (mySprite != null)
		{
			Color color = mySprite.color;
			float num = 2f * (_time - Mathf.Floor(_time / halfCycle) * halfCycle) / halfCycle;
			if (num > 1f)
			{
				num = 2f - num;
			}
			mySprite.color = new Color(color.r, color.g, color.b, num);
		}
	}
}
