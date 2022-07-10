using UnityEngine;

internal sealed class SpinObject : MonoBehaviour
{
	public bool defaultRect = true;

	public bool menuTouchZone;

	public float coef = 1f;

	private float lastTime;

	public Rect touchZone;

	private void Start()
	{
		if (defaultRect)
		{
			touchZone = new Rect(0f, 0.1f * (float)Screen.height, 0.5f * (float)Screen.width, 0.8f * (float)Screen.height);
		}
		if (menuTouchZone)
		{
			touchZone = new Rect(0.38f * (float)Screen.width, 0.25f * (float)Screen.height, 0.4f * (float)Screen.width, 0.65f * (float)Screen.height);
		}
	}

	private void Update()
	{
		if (Application.isEditor)
		{
			base.transform.Rotate(Vector3.up, Input.GetAxis("Horizontal") * -120f * (Time.realtimeSinceStartup - lastTime));
		}
		if (Input.touchCount > 0)
		{
			Touch touch = Input.GetTouch(0);
			if (touch.phase == TouchPhase.Moved && touchZone.Contains(touch.position))
			{
				base.transform.Rotate(Vector3.up, touch.deltaPosition.x * -120f * coef * (Time.realtimeSinceStartup - lastTime));
			}
		}
		if (Application.isEditor)
		{
			base.transform.Rotate(Vector3.up, Input.GetAxis("Mouse ScrollWheel") * 3f * -120f * (Time.realtimeSinceStartup - lastTime));
		}
		lastTime = Time.realtimeSinceStartup;
	}
}
