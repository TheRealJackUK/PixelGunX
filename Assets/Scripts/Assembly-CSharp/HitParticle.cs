using UnityEngine;

public class HitParticle : MonoBehaviour
{
	private float liveTime = -1f;

	public float maxliveTime = 0.3f;

	public bool isUseMine;

	private Transform myTransform;

	public ParticleSystem myParticleSystem;

	private void Start()
	{
		myTransform = base.transform;
		myTransform.position = new Vector3(-10000f, -10000f, -10000f);
		myParticleSystem.enableEmission = false;
	}

	public void StartShowParticle(Vector3 pos, Quaternion rot, bool _isUseMine)
	{
		isUseMine = _isUseMine;
		liveTime = maxliveTime;
		myTransform.position = pos;
		myTransform.rotation = rot;
		myParticleSystem.enableEmission = true;
	}

	private void Update()
	{
		if (!(liveTime < 0f))
		{
			liveTime -= Time.deltaTime;
			if (liveTime < 0f)
			{
				myTransform.position = new Vector3(-10000f, -10000f, -10000f);
				myParticleSystem.enableEmission = false;
				isUseMine = false;
			}
		}
	}
}
