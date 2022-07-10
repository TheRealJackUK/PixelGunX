using UnityEngine;

public sealed class HoleScript : MonoBehaviour
{
	public float liveTime = -1f;

	public float maxliveTime = 3f;

	public bool isUseMine;

	private Transform myTransform;

	private void Start()
	{
		myTransform = base.transform;
		myTransform.position = new Vector3(-10000f, -10000f, -10000f);
	}

	public void StartShowHole(Vector3 pos, Quaternion rot, bool _isUseMine)
	{
		isUseMine = _isUseMine;
		liveTime = maxliveTime;
		myTransform.position = pos;
		myTransform.rotation = rot;
	}

	private void Update()
	{
		if (!(liveTime < 0f))
		{
			liveTime -= Time.deltaTime;
			if (liveTime < 0f)
			{
				myTransform.position = new Vector3(-10000f, -10000f, -10000f);
				isUseMine = false;
			}
		}
	}
}
