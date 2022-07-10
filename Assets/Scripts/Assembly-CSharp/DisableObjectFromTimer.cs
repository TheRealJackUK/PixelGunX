using UnityEngine;

public class DisableObjectFromTimer : MonoBehaviour
{
	public float timer = -1f;

	public bool isDestroy;

	private void Start()
	{
	}

	private void Update()
	{
		if (!(timer >= 0f))
		{
			return;
		}
		timer -= Time.deltaTime;
		if (timer < 0f)
		{
			if (isDestroy)
			{
				Object.Destroy(base.gameObject);
			}
			else
			{
				base.gameObject.SetActive(false);
			}
		}
	}
}
