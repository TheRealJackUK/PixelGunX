using UnityEngine;

[ExecuteInEditMode]
public class CameraPathOrientation : CameraPathPoint
{
	public Quaternion rotation = Quaternion.identity;

	public Transform lookAt;

	private void OnEnable()
	{
		base.hideFlags = HideFlags.HideInInspector;
	}
}
