using UnityEngine;

public class EveryplayHudCamera : MonoBehaviour
{
	private void OnPreRender()
	{
		Everyplay.SnapshotRenderbuffer();
	}
}
