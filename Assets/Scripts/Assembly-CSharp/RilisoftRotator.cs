using UnityEngine;

public class RilisoftRotator : MonoBehaviour
{
	public float rate = 10f;

	private Transform _transform;

	private void Start()
	{
		_transform = base.transform;
	}

	private void Update()
	{
		_transform.Rotate(Vector3.forward, rate * Time.deltaTime, Space.Self);
	}
}
