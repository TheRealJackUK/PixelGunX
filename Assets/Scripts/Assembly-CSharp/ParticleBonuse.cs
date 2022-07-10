using UnityEngine;

public class ParticleBonuse : MonoBehaviour
{
	public float maxTimer = 2f;

	public float timer = -1f;

	private void Start()
	{
	}

	private void Update()
	{
		if (timer > 0f)
		{
			timer -= Time.deltaTime;
			if (timer < 0f)
			{
				base.gameObject.SetActive(false);
			}
		}
	}

	public void ShowParticle()
	{
		Debug.Log("OnEnable " + base.gameObject.name);
		base.gameObject.SetActive(true);
		timer = maxTimer;
	}
}
