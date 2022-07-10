using UnityEngine;

public class RotatorKillCam : MonoBehaviour
{
	public static bool isDraggin;

	private void Start()
	{
		isDraggin = false;
		ReturnCameraToDefaultOrientation();
	}

	private void OnEnable()
	{
		isDraggin = false;
		ReturnCameraToDefaultOrientation();
	}

	private void OnPress(bool isDown)
	{
		isDraggin = isDown;
	}

	private void OnDrag(Vector2 delta)
	{
		if (!(RPG_Camera.instance == null))
		{
			RPG_Camera.instance.deltaMouseX += delta.x;
		}
	}

	private void ReturnCameraToDefaultOrientation()
	{
		if (!(RPG_Camera.instance == null))
		{
			RPG_Camera.instance.deltaMouseX = 0f;
			RPG_Camera.instance.mouseY = 15f;
		}
	}
}
