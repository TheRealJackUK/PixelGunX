using UnityEngine;

public class BounceCounter : MonoBehaviour
{
	public UnityDataConnector conn;

	public bool trackBounces = true;

	private void OnCollisionEnter(Collision c)
	{
		if (trackBounces)
		{
			conn.SaveDataOnTheCloud(base.gameObject.name, c.relativeVelocity.magnitude);
		}
	}
}
