using UnityEngine;

public class RPG_Camera : MonoBehaviour
{
	public Transform cameraPivot;
	public float TimeRotationCam;
	public float distance;
	public float distanceMin;
	public float distanceMax;
	public float mouseSpeed;
	public float mouseScroll;
	public float mouseSmoothingFactor;
	public float camDistanceSpeed;
	public float camBottomDistance;
	public float firstPersonThreshold;
	public float characterFadeThreshold;
	public bool isDragging;
	public float desiredDistance;
	public float offsetMaxDistance;
	public float offsetY;
	public float lastDistance;
	public float mouseX;
	public float deltaMouseX;
	public float mouseY;
	public float mouseYSmooth;
	public Vector2 controlVector;
	public Vector3 curTargetEulerAngles;
	public LayerMask collisionLayer;
}
