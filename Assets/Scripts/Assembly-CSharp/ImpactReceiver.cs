using UnityEngine;

public class ImpactReceiver : MonoBehaviour
{
	private float mass = 1f;

	private Vector3 impact = Vector3.zero;

	private CharacterController character;

	private void Start()
	{
		character = GetComponent<CharacterController>();
	}

	private void Update()
	{
		if (impact.magnitude > 0.2f)
		{
			character.Move(impact * Time.deltaTime);
		}
		impact = Vector3.Lerp(impact, Vector3.zero, 5f * Time.deltaTime);
	}

	public void AddImpact(Vector3 dir, float force)
	{
		dir.Normalize();
		if (dir.y < 0f)
		{
			dir.y = 0f - dir.y;
		}
		impact += dir.normalized * force / mass;
	}
}
