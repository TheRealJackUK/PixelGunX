using UnityEngine;

public class SynhRotationWithGameObject : MonoBehaviour
{
	public new Transform gameObject;

	private Transform myTransform;

	private void Start()
	{
		myTransform = base.transform;
	}

	private void Update()
	{
		myTransform.rotation = gameObject.rotation;
	}
}
