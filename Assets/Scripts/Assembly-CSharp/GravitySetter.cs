using UnityEngine;

public class GravitySetter : MonoBehaviour
{
	public static readonly float normalGravity = -9.81f;

	public static readonly float spaceBaseGravity = -6.54f;

	public static readonly float matrixGravity = -4.9049997f;

	private void OnLevelWasLoaded(int lev)
	{
		if (Application.loadedLevelName.Equals("Space"))
		{
			Physics.gravity = new Vector3(0f, spaceBaseGravity, 0f);
		}
		else if (Application.loadedLevelName.Equals("Matrix"))
		{
			Physics.gravity = new Vector3(0f, matrixGravity, 0f);
		}
		else
		{
			Physics.gravity = new Vector3(0f, normalGravity, 0f);
		}
	}
}
