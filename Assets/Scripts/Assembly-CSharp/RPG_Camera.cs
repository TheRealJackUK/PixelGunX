using System;
using UnityEngine;

public class RPG_Camera : MonoBehaviour
{
	public struct ClipPlaneVertexes
	{
		public Vector3 UpperLeft;

		public Vector3 UpperRight;

		public Vector3 LowerLeft;

		public Vector3 LowerRight;
	}

	public static RPG_Camera instance;

	public Transform cameraPivot;

	public float TimeRotationCam = 15f;

	public float distance = 5f;

	public float distanceMin = 1f;

	public float distanceMax = 30f;

	public float mouseSpeed = 8f;

	public float mouseScroll = 15f;

	public float mouseSmoothingFactor = 0.08f;

	public float camDistanceSpeed = 0.7f;

	public float camBottomDistance = 1f;

	public float firstPersonThreshold = 0.8f;

	public float characterFadeThreshold = 1.8f;

	private float speedRotateXfree = 180f;

	public bool isDragging;

	private Vector3 desiredPosition;

	public float desiredDistance;

	public float offsetMaxDistance;

	public float offsetY;

	public float lastDistance;

	public float mouseX;

	public float deltaMouseX;

	private float mouseXSmooth;

	private float mouseXVel;

	public float mouseY;

	public float mouseYSmooth;

	private float mouseYVel;

	private float mouseYMin = -89.5f;

	private float mouseYMax = 89.5f;

	private float distanceVel;

	private bool camBottom;

	private bool constraint;

	private static float halfFieldOfView;

	private static float planeAspect;

	private static float halfPlaneHeight;

	private static float halfPlaneWidth;

	public Vector2 controlVector;

	public Vector3 curTargetEulerAngles;

	private bool enabledSledCamera = true;

	private bool isCameraIntersect;

	private RaycastHit hitInfo;

	[HideInInspector]
	public static Camera cam;

	private float nearClipPlaneNormal;

	public LayerMask collisionLayer;

	private void Awake()
	{
		instance = this;
		cam = GetComponent<Camera>();
		nearClipPlaneNormal = cam.nearClipPlane;
	}

	private void Start()
	{
		distance = Mathf.Clamp(distance, distanceMin, distanceMax);
		desiredDistance = distance;
		halfFieldOfView = cam.fieldOfView / 2f * ((float)Math.PI / 180f);
		planeAspect = cam.aspect;
		halfPlaneHeight = cam.nearClipPlane * Mathf.Tan(halfFieldOfView);
		halfPlaneWidth = halfPlaneHeight * planeAspect;
		mouseY = 15f;
	}

	private void OnDestroy()
	{
		cam = null;
	}

	public static void CameraSetup()
	{
		GameObject gameObject;
		if (cam != null)
		{
			gameObject = cam.gameObject;
		}
		else
		{
			gameObject = new GameObject("Main Camera");
			gameObject.AddComponent<Camera>();
			gameObject.tag = "MainCamera";
		}
		if (!gameObject.GetComponent("RPG_Camera"))
		{
			gameObject.AddComponent<RPG_Camera>();
		}
		RPG_Camera rPG_Camera = gameObject.GetComponent("RPG_Camera") as RPG_Camera;
		GameObject gameObject2 = GameObject.Find("cameraPivot");
		rPG_Camera.cameraPivot = gameObject2.transform;
	}

	private void Update()
	{
		if (!(cameraPivot == null))
		{
			if (!RotatorKillCam.isDraggin && distance < 2f)
			{
				deltaMouseX += Time.deltaTime * speedRotateXfree;
			}
			curTargetEulerAngles = cameraPivot.eulerAngles;
			GetInput();
			GetDesiredPosition();
			PositionUpdate();
		}
	}

	private void GetInput()
	{
		if ((double)distance > 0.1)
		{
			camBottom = Physics.Linecast(base.transform.position, base.transform.position - Vector3.up * camBottomDistance, collisionLayer);
		}
		bool flag = camBottom && base.transform.position.y - cameraPivot.transform.position.y <= 0f;
		mouseY = ClampAngle(mouseY, -89.5f, 89.5f);
		mouseXSmooth = Mathf.SmoothDamp(mouseXSmooth, mouseX, ref mouseXVel, mouseSmoothingFactor);
		mouseYSmooth = Mathf.SmoothDamp(mouseYSmooth, mouseY, ref mouseYVel, mouseSmoothingFactor);
		if (flag)
		{
			mouseYMin = mouseY;
		}
		else
		{
			mouseYMin = -89.5f;
		}
		mouseYSmooth = ClampAngle(mouseYSmooth, mouseYMin, mouseYMax);
		if (desiredDistance > distanceMax)
		{
			desiredDistance = distanceMax;
		}
		if (desiredDistance < distanceMin)
		{
			desiredDistance = distanceMin;
		}
		controlVector = Vector2.zero;
	}

	private void GetDesiredPosition()
	{
		distance = desiredDistance;
		desiredPosition = GetCameraPosition(mouseYSmooth, mouseX, distance);
		constraint = false;
		float num = CheckCameraClipPlane(cameraPivot.position, desiredPosition);
		if (num != -1f)
		{
			distance = num;
			desiredPosition = GetCameraPosition(mouseYSmooth, mouseX, distance);
			constraint = true;
		}
		distance -= cam.nearClipPlane;
		if (lastDistance < distance || !constraint)
		{
			distance = Mathf.SmoothDamp(lastDistance, distance, ref distanceVel, camDistanceSpeed);
		}
		if (distance < distanceMin)
		{
			distance = distanceMin;
		}
		lastDistance = distance;
		desiredPosition = GetCameraPosition(mouseYSmooth, mouseX, distance);
		if (distance < 4f && hitInfo.normal != Vector3.zero)
		{
			desiredPosition -= hitInfo.normal * offsetY * (4f - distance) * 0.25f;
			isCameraIntersect = true;
			return;
		}
		isCameraIntersect = false;
		if (cam.nearClipPlane != nearClipPlaneNormal)
		{
			cam.nearClipPlane = nearClipPlaneNormal;
		}
	}

	private void PositionUpdate()
	{
		base.transform.position = desiredPosition;
		if (distance > distanceMin)
		{
			base.transform.LookAt(cameraPivot);
			base.transform.eulerAngles -= new Vector3(2f, 0f, 0f);
		}
	}

	public void UpdateMouseX()
	{
		if (!(cameraPivot == null))
		{
			for (mouseX = 150f + deltaMouseX + cameraPivot.rotation.eulerAngles.y; mouseX > 360f; mouseX -= 360f)
			{
			}
		}
	}

	private void CharacterFade()
	{
		if (RPG_Animation.instance == null)
		{
			return;
		}
		if (distance < firstPersonThreshold)
		{
			RPG_Animation.instance.GetComponent<Renderer>().enabled = false;
		}
		else if (distance < characterFadeThreshold)
		{
			RPG_Animation.instance.GetComponent<Renderer>().enabled = true;
			float num = 1f - (characterFadeThreshold - distance) / (characterFadeThreshold - firstPersonThreshold);
			if (RPG_Animation.instance.GetComponent<Renderer>().material.color.a != num)
			{
				RPG_Animation.instance.GetComponent<Renderer>().material.color = new Color(RPG_Animation.instance.GetComponent<Renderer>().material.color.r, RPG_Animation.instance.GetComponent<Renderer>().material.color.g, RPG_Animation.instance.GetComponent<Renderer>().material.color.b, num);
			}
		}
		else
		{
			RPG_Animation.instance.GetComponent<Renderer>().enabled = true;
			if (RPG_Animation.instance.GetComponent<Renderer>().material.color.a != 1f)
			{
				RPG_Animation.instance.GetComponent<Renderer>().material.color = new Color(RPG_Animation.instance.GetComponent<Renderer>().material.color.r, RPG_Animation.instance.GetComponent<Renderer>().material.color.g, RPG_Animation.instance.GetComponent<Renderer>().material.color.b, 1f);
			}
		}
	}

	private Vector3 GetCameraPosition(float xAxis, float yAxis, float distance)
	{
		Vector3 vector = new Vector3(0f, 0f, 0f - distance);
		Quaternion quaternion = Quaternion.Euler(xAxis, yAxis, 0f);
		return cameraPivot.position + quaternion * vector;
	}

	private float CheckCameraClipPlane(Vector3 from, Vector3 to)
	{
		float num = -1f;
		ClipPlaneVertexes clipPlaneAt = GetClipPlaneAt(to);
		if (Physics.Linecast(from, to, out hitInfo, collisionLayer) && IsIgnorCollider(hitInfo))
		{
			num = hitInfo.distance - cam.nearClipPlane;
		}
		else if (Physics.Linecast(from - base.transform.right * halfPlaneWidth + base.transform.up * halfPlaneHeight, clipPlaneAt.UpperLeft, out hitInfo, collisionLayer) && IsIgnorCollider(hitInfo))
		{
			if (hitInfo.distance < num || num == -1f)
			{
				num = Vector3.Distance(hitInfo.point + base.transform.right * halfPlaneWidth - base.transform.up * halfPlaneHeight, from);
			}
		}
		else if (Physics.Linecast(from + base.transform.right * halfPlaneWidth + base.transform.up * halfPlaneHeight, clipPlaneAt.UpperRight, out hitInfo, collisionLayer) && IsIgnorCollider(hitInfo))
		{
			if (hitInfo.distance < num || num == -1f)
			{
				num = Vector3.Distance(hitInfo.point - base.transform.right * halfPlaneWidth - base.transform.up * halfPlaneHeight, from);
			}
		}
		else if (Physics.Linecast(from - base.transform.right * halfPlaneWidth - base.transform.up * halfPlaneHeight, clipPlaneAt.LowerLeft, out hitInfo, collisionLayer) && IsIgnorCollider(hitInfo))
		{
			if (hitInfo.distance < num || num == -1f)
			{
				num = Vector3.Distance(hitInfo.point + base.transform.right * halfPlaneWidth + base.transform.up * halfPlaneHeight, from);
			}
		}
		else if (Physics.Linecast(from + base.transform.right * halfPlaneWidth - base.transform.up * halfPlaneHeight, clipPlaneAt.LowerRight, out hitInfo, collisionLayer) && IsIgnorCollider(hitInfo) && (hitInfo.distance < num || num == -1f))
		{
			num = Vector3.Distance(hitInfo.point - base.transform.right * halfPlaneWidth + base.transform.up * halfPlaneHeight, from);
		}
		return num;
	}

	private bool IsIgnorCollider(RaycastHit curHitInfo)
	{
		if (curHitInfo.collider.tag != "Player" && curHitInfo.collider.tag != "Vision" && curHitInfo.collider.tag != "colliderPoint" && curHitInfo.collider.tag != "Helicopter")
		{
			return true;
		}
		return false;
	}

	private float ClampAngle(float angle, float min, float max)
	{
		while (angle < -360f || angle > 360f)
		{
			if (angle < -360f)
			{
				angle += 360f;
			}
			if (angle > 360f)
			{
				angle -= 360f;
			}
		}
		return Mathf.Clamp(angle, min, max);
	}

	public ClipPlaneVertexes GetClipPlaneAt(Vector3 pos)
	{
		ClipPlaneVertexes result = default(ClipPlaneVertexes);
		if (cam == null)
		{
			return result;
		}
		Transform transform = cam.transform;
		float nearClipPlane = cam.nearClipPlane;
		result.UpperLeft = pos - transform.right * halfPlaneWidth;
		result.UpperLeft += transform.up * halfPlaneHeight;
		result.UpperLeft += transform.forward * nearClipPlane;
		result.UpperRight = pos + transform.right * halfPlaneWidth;
		result.UpperRight += transform.up * halfPlaneHeight;
		result.UpperRight += transform.forward * nearClipPlane;
		result.LowerLeft = pos - transform.right * halfPlaneWidth;
		result.LowerLeft -= transform.up * halfPlaneHeight;
		result.LowerLeft += transform.forward * nearClipPlane;
		result.LowerRight = pos + transform.right * halfPlaneWidth;
		result.LowerRight -= transform.up * halfPlaneHeight;
		result.LowerRight += transform.forward * nearClipPlane;
		return result;
	}

	public void RotateWithCharacter()
	{
		float num = Input.GetAxis("Horizontal") * RPG_Controller.instance.turnSpeed;
		mouseX += num;
	}
}
