using UnityEngine;

public class DamageTakenController : MonoBehaviour
{
	private float time;

	private float maxTime = 3f;

	public UISprite mySprite;

	public void reset(float alpha)
	{
		time = maxTime;
		base.transform.localRotation = Quaternion.Euler(new Vector3(0f, 0f, 0f - alpha));
	}

	private void Start()
	{
		mySprite.color = new Color(1f, 1f, 1f, 0f);
	}

	public void Remove()
	{
		time = -1f;
		mySprite.color = new Color(1f, 1f, 1f, 0f);
	}

	private void Update()
	{
		if (time > 0f)
		{
			mySprite.color = new Color(1f, 1f, 1f, time / maxTime);
			time -= Time.deltaTime;
			if (time < 0f)
			{
				mySprite.color = new Color(1f, 1f, 1f, 0f);
			}
		}
	}
}
