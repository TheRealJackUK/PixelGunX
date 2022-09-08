using UnityEngine;

public class CameraPathAnimator : MonoBehaviour
{
	public enum animationModes
	{
		once = 0,
		loop = 1,
		reverse = 2,
		reverseLoop = 3,
		pingPong = 4,
	}

	public enum orientationModes
	{
		custom = 0,
		target = 1,
		mouselook = 2,
		followpath = 3,
		reverseFollowpath = 4,
		followTransform = 5,
		twoDimentions = 6,
		fixedOrientation = 7,
		none = 8,
	}

	public float minimumCameraSpeed;
	public Transform orientationTarget;
	[SerializeField]
	private CameraPath cameraPath_0;
	public bool playOnStart;
	public Transform animationObject;
	public animationModes animationMode;
	public orientationModes orientationMode;
	public Vector3 fixedOrientaion;
	public bool normalised;
	public float editorPercentage;
	[SerializeField]
	private float float_1;
	[SerializeField]
	private float float_2;
	public float nearestOffset;
	public float sensitivity;
	public float minX;
	public float maxX;
	public bool showPreview;
	public GameObject editorPreview;
	public bool showScenePreview;
	public Vector3 animatedObjectStartPosition;
	public Quaternion animatedObjectStartRotation;
}
