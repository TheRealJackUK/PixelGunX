using UnityEngine;

public class SetPositionZero : MonoBehaviour
{
	private Transform myTransform;

	private void Start()
	{
		myTransform = base.transform;
		myTransform.localPosition = Vector3.zero;
	}

	private void Update()
	{
		myTransform.localPosition = Vector3.zero;
	}
}
