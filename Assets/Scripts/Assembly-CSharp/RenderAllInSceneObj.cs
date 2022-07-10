using UnityEngine;

public class RenderAllInSceneObj : MonoBehaviour
{
	private void Awake()
	{
		if (Device.IsLoweMemoryDevice)
		{
			Object.Destroy(base.gameObject);
			return;
		}
		Transform transform = (Object.Instantiate(Resources.Load<GameObject>("RenderAllInSceneObjInner")) as GameObject).transform;
		transform.parent = base.transform;
		transform.localPosition = Vector3.zero;
	}
}
