using UnityEngine;

public class CameraPathAnimator : MonoBehaviour
{
	public enum animationModes
	{
		once,
		loop,
		reverse,
		reverseLoop,
		pingPong
	}

	public enum orientationModes
	{
		custom,
		target,
		mouselook,
		followpath,
		reverseFollowpath,
		followTransform,
		twoDimentions,
		fixedOrientation,
		none
	}

	public delegate void AnimationStartedEventHandler();

	public delegate void AnimationPausedEventHandler();

	public delegate void AnimationStoppedEventHandler();

	public delegate void AnimationFinishedEventHandler();

	public delegate void AnimationLoopedEventHandler();

	public delegate void AnimationPingPongEventHandler();

	public delegate void AnimationPointReachedEventHandler();

	public delegate void AnimationCustomEventHandler(string eventName);

	public delegate void AnimationPointReachedWithNumberEventHandler(int pointNumber);

	public float minimumCameraSpeed = 0.01f;

	public Transform orientationTarget;

	[SerializeField]
	private CameraPath _cameraPath;

	public bool playOnStart = true;

	public Transform animationObject;

	private Camera animationObjectCamera;

	private bool _isCamera = true;

	private bool _playing;

	public animationModes animationMode;

	public orientationModes orientationMode;

	private float pingPongDirection = 1f;

	public Vector3 fixedOrientaion = Vector3.forward;

	public bool normalised = true;

	public float editorPercentage;

	[SerializeField]
	private float _pathTime = 10f;

	[SerializeField]
	private float _pathSpeed = 10f;

	private float _percentage;

	private float _lastPercentage;

	public float nearestOffset;

	private float delayTime;

	public float sensitivity = 5f;

	public float minX = -90f;

	public float maxX = 90f;

	private float rotationX;

	private float rotationY;

	public bool showPreview = true;

	public GameObject editorPreview;

	public bool showScenePreview = true;

	private bool _animateSceneObjectInEditor;

	public Vector3 animatedObjectStartPosition;

	public Quaternion animatedObjectStartRotation;

	public float pathSpeed
	{
		get
		{
			return _pathSpeed;
		}
		set
		{
			if (_cameraPath.speedList.listEnabled)
			{
				Debug.LogWarning("Path Speed in Animator component is ignored and overridden by Camera Path speed points.");
			}
			_pathSpeed = Mathf.Max(value, minimumCameraSpeed);
		}
	}

	public float currentTime
	{
		get
		{
			return _pathTime * _percentage;
		}
	}

	public bool isPlaying
	{
		get
		{
			return _playing;
		}
	}

	public float percentage
	{
		get
		{
			return _percentage;
		}
	}

	public bool pingPongGoingForward
	{
		get
		{
			return pingPongDirection == 1f;
		}
	}

	public CameraPath cameraPath
	{
		get
		{
			if (!_cameraPath)
			{
				_cameraPath = GetComponent<CameraPath>();
			}
			return _cameraPath;
		}
	}

	private bool isReversed
	{
		get
		{
			return animationMode == animationModes.reverse || animationMode == animationModes.reverseLoop || pingPongDirection < 0f;
		}
	}

	public bool isCamera
	{
		get
		{
			if (animationObject == null)
			{
				_isCamera = false;
			}
			else
			{
				_isCamera = animationObjectCamera != null;
			}
			return _isCamera;
		}
	}

	public bool animateSceneObjectInEditor
	{
		get
		{
			return _animateSceneObjectInEditor;
		}
		set
		{
			if (value != _animateSceneObjectInEditor)
			{
				_animateSceneObjectInEditor = value;
				if (animationObject != null)
				{
					if (_animateSceneObjectInEditor)
					{
						animatedObjectStartPosition = animationObject.transform.position;
						animatedObjectStartRotation = animationObject.transform.rotation;
					}
					else
					{
						animationObject.transform.position = animatedObjectStartPosition;
						animationObject.transform.rotation = animatedObjectStartRotation;
					}
				}
			}
			_animateSceneObjectInEditor = value;
		}
	}

	public event AnimationStartedEventHandler AnimationStartedEvent;

	public event AnimationPausedEventHandler AnimationPausedEvent;

	public event AnimationStoppedEventHandler AnimationStoppedEvent;

	public event AnimationFinishedEventHandler AnimationFinishedEvent;

	public event AnimationLoopedEventHandler AnimationLoopedEvent;

	public event AnimationPingPongEventHandler AnimationPingPongEvent;

	public event AnimationPointReachedEventHandler AnimationPointReachedEvent;

	public event AnimationPointReachedWithNumberEventHandler AnimationPointReachedWithNumberEvent;

	public event AnimationCustomEventHandler AnimationCustomEvent;

	public void Play()
	{
		_playing = true;
		if (!isReversed)
		{
			if (_percentage == 0f)
			{
				if (this.AnimationStartedEvent != null)
				{
					this.AnimationStartedEvent();
				}
				cameraPath.eventList.OnAnimationStart(0f);
			}
		}
		else if (_percentage == 1f)
		{
			if (this.AnimationStartedEvent != null)
			{
				this.AnimationStartedEvent();
			}
			cameraPath.eventList.OnAnimationStart(1f);
		}
		_lastPercentage = _percentage;
	}

	public void Stop()
	{
		_playing = false;
		_percentage = 0f;
		if (this.AnimationStoppedEvent != null)
		{
			this.AnimationStoppedEvent();
		}
	}

	public void Pause()
	{
		_playing = false;
		if (this.AnimationPausedEvent != null)
		{
			this.AnimationPausedEvent();
		}
	}

	public void Seek(float value)
	{
		_percentage = Mathf.Clamp01(value);
		_lastPercentage = _percentage;
		UpdateAnimationTime(false);
		UpdatePointReached();
		bool playing = _playing;
		_playing = true;
		UpdateAnimation();
		_playing = playing;
	}

	public void Reverse()
	{
		switch (animationMode)
		{
		case animationModes.once:
			animationMode = animationModes.reverse;
			break;
		case animationModes.reverse:
			animationMode = animationModes.once;
			break;
		case animationModes.pingPong:
			pingPongDirection = ((pingPongDirection == -1f) ? 1 : (-1));
			break;
		case animationModes.loop:
			animationMode = animationModes.reverseLoop;
			break;
		case animationModes.reverseLoop:
			animationMode = animationModes.loop;
			break;
		}
	}

	public Quaternion GetAnimatedOrientation(float percent, bool ignoreNormalisation)
	{
		Quaternion quaternion = Quaternion.identity;
		switch (orientationMode)
		{
		case orientationModes.custom:
			quaternion = cameraPath.GetPathRotation(percent, ignoreNormalisation);
			break;
		case orientationModes.target:
		{
			Vector3 pathPosition = cameraPath.GetPathPosition(percent);
			Vector3 forward = ((!(orientationTarget != null)) ? Vector3.forward : (orientationTarget.transform.position - pathPosition));
			quaternion = Quaternion.LookRotation(forward);
			break;
		}
		case orientationModes.followpath:
			quaternion = Quaternion.LookRotation(cameraPath.GetPathDirection(percent));
			quaternion *= Quaternion.Euler(base.transform.forward * (0f - cameraPath.GetPathTilt(percent)));
			break;
		case orientationModes.reverseFollowpath:
			quaternion = Quaternion.LookRotation(-cameraPath.GetPathDirection(percent));
			quaternion *= Quaternion.Euler(base.transform.forward * (0f - cameraPath.GetPathTilt(percent)));
			break;
		case orientationModes.mouselook:
			if (!Application.isPlaying)
			{
				quaternion = Quaternion.LookRotation(cameraPath.GetPathDirection(percent));
				quaternion *= Quaternion.Euler(base.transform.forward * (0f - cameraPath.GetPathTilt(percent)));
			}
			else
			{
				quaternion = GetMouseLook();
			}
			break;
		case orientationModes.followTransform:
		{
			if (orientationTarget == null)
			{
				return Quaternion.identity;
			}
			float nearestPoint = cameraPath.GetNearestPoint(orientationTarget.position);
			nearestPoint = Mathf.Clamp01(nearestPoint + nearestOffset);
			Vector3 pathPosition = cameraPath.GetPathPosition(nearestPoint);
			Vector3 forward = orientationTarget.transform.position - pathPosition;
			quaternion = Quaternion.LookRotation(forward);
			break;
		}
		case orientationModes.twoDimentions:
			quaternion = Quaternion.LookRotation(Vector3.forward);
			break;
		case orientationModes.fixedOrientation:
			quaternion = Quaternion.LookRotation(fixedOrientaion);
			break;
		case orientationModes.none:
			quaternion = animationObject.rotation;
			break;
		}
		return quaternion * base.transform.rotation;
	}

	private void Awake()
	{
		if (animationObject == null)
		{
			_isCamera = false;
		}
		else
		{
			animationObjectCamera = animationObject.GetComponentInChildren<Camera>();
			_isCamera = animationObjectCamera != null;
		}
		Camera[] allCameras = Camera.allCameras;
		if (allCameras.Length == 0)
		{
			Debug.LogWarning("Warning: There are no cameras in the scene");
			_isCamera = false;
		}
		if (!isReversed)
		{
			_percentage = 0f;
		}
		else
		{
			_percentage = 1f;
		}
		Vector3 eulerAngles = cameraPath.GetPathRotation(0f, false).eulerAngles;
		rotationX = eulerAngles.y;
		rotationY = eulerAngles.x;
	}

	private void OnEnable()
	{
		cameraPath.eventList.CameraPathEventPoint += OnCustomEvent;
		cameraPath.delayList.CameraPathDelayEvent += OnDelayEvent;
		if (animationObject != null)
		{
			animationObjectCamera = animationObject.GetComponentInChildren<Camera>();
		}
	}

	private void Start()
	{
		if (playOnStart)
		{
			Play();
		}
		if (Application.isPlaying && orientationTarget == null && (orientationMode == orientationModes.followTransform || orientationMode == orientationModes.target))
		{
			Debug.LogWarning("There has not been an orientation target specified in the Animation component of Camera Path.", base.transform);
		}
	}

	private void Update()
	{
		if (!isCamera)
		{
			if (_playing)
			{
				UpdateAnimationTime();
				UpdateAnimation();
				UpdatePointReached();
			}
			else if (_cameraPath.nextPath != null && _percentage >= 1f)
			{
				PlayNextAnimation();
			}
		}
	}

	private void LateUpdate()
	{
		if (isCamera)
		{
			if (_playing)
			{
				UpdateAnimationTime();
				UpdateAnimation();
				UpdatePointReached();
			}
			else if (_cameraPath.nextPath != null && _percentage >= 1f)
			{
				PlayNextAnimation();
			}
		}
	}

	private void OnDisable()
	{
		CleanUp();
	}

	private void OnDestroy()
	{
		CleanUp();
	}

	private void PlayNextAnimation()
	{
		if (_cameraPath.nextPath != null)
		{
			_cameraPath.nextPath.GetComponent<CameraPathAnimator>().Play();
			_percentage = 0f;
			Stop();
		}
	}

	private void UpdateAnimation()
	{
		if (animationObject == null)
		{
			Debug.LogError("There is no animation object specified in the Camera Path Animator component. Nothing to animate.\nYou can find this component in the main camera path game object called " + base.gameObject.name + ".");
			Stop();
		}
		else
		{
			if (!_playing)
			{
				return;
			}
			if (cameraPath.speedList.listEnabled)
			{
				_pathTime = _cameraPath.pathLength / Mathf.Max(cameraPath.GetPathSpeed(_percentage), minimumCameraSpeed);
			}
			else
			{
				_pathTime = _cameraPath.pathLength / Mathf.Max(_pathSpeed * cameraPath.GetPathEase(_percentage), minimumCameraSpeed);
			}
			animationObject.position = cameraPath.GetPathPosition(_percentage);
			if (orientationMode != orientationModes.none)
			{
				animationObject.rotation = GetAnimatedOrientation(_percentage, false);
			}
			if (isCamera && _cameraPath.fovList.listEnabled)
			{
				if (orientationMode != orientationModes.twoDimentions)
				{
					animationObjectCamera.fieldOfView = _cameraPath.GetPathFOV(_percentage);
				}
				else
				{
					animationObjectCamera.orthographicSize = _cameraPath.GetPathFOV(_percentage);
				}
			}
			CheckEvents();
		}
	}

	private void UpdatePointReached()
	{
		if (_percentage == _lastPercentage)
		{
			return;
		}
		if (Mathf.Abs(percentage - _lastPercentage) > 0.999f)
		{
			_lastPercentage = percentage;
			return;
		}
		for (int i = 0; i < cameraPath.realNumberOfPoints; i++)
		{
			CameraPathControlPoint cameraPathControlPoint = cameraPath[i];
			if ((cameraPathControlPoint.percentage >= _lastPercentage && cameraPathControlPoint.percentage <= percentage) || (cameraPathControlPoint.percentage >= percentage && cameraPathControlPoint.percentage <= _lastPercentage))
			{
				if (this.AnimationPointReachedEvent != null)
				{
					this.AnimationPointReachedEvent();
				}
				if (this.AnimationPointReachedWithNumberEvent != null)
				{
					this.AnimationPointReachedWithNumberEvent(i);
				}
			}
		}
		_lastPercentage = percentage;
	}

	private void UpdateAnimationTime()
	{
		UpdateAnimationTime(true);
	}

	private void UpdateAnimationTime(bool advance)
	{
		if (orientationMode == orientationModes.followTransform)
		{
			return;
		}
		if (delayTime > 0f)
		{
			delayTime += 0f - Time.deltaTime;
			return;
		}
		if (advance)
		{
			switch (animationMode)
			{
			case animationModes.once:
				if (_percentage >= 1f)
				{
					_playing = false;
					if (this.AnimationFinishedEvent != null)
					{
						this.AnimationFinishedEvent();
					}
				}
				else
				{
					_percentage += Time.deltaTime * (1f / _pathTime);
				}
				break;
			case animationModes.loop:
				if (_percentage >= 1f)
				{
					_percentage = 0f;
					_lastPercentage = 0f;
					if (this.AnimationLoopedEvent != null)
					{
						this.AnimationLoopedEvent();
					}
				}
				_percentage += Time.deltaTime * (1f / _pathTime);
				break;
			case animationModes.reverseLoop:
				if (_percentage <= 0f)
				{
					_percentage = 1f;
					_lastPercentage = 1f;
					if (this.AnimationLoopedEvent != null)
					{
						this.AnimationLoopedEvent();
					}
				}
				_percentage += (0f - Time.deltaTime) * (1f / _pathTime);
				break;
			case animationModes.reverse:
				if (_percentage <= 0f)
				{
					_percentage = 0f;
					_playing = false;
					if (this.AnimationFinishedEvent != null)
					{
						this.AnimationFinishedEvent();
					}
				}
				else
				{
					_percentage += (0f - Time.deltaTime) * (1f / _pathTime);
				}
				break;
			case animationModes.pingPong:
			{
				float num = Time.deltaTime * (1f / _pathTime);
				_percentage += num * pingPongDirection;
				if (_percentage >= 1f)
				{
					_percentage = 1f - num;
					_lastPercentage = 1f;
					pingPongDirection = -1f;
					if (this.AnimationPingPongEvent != null)
					{
						this.AnimationPingPongEvent();
					}
				}
				if (_percentage <= 0f)
				{
					_percentage = num;
					_lastPercentage = 0f;
					pingPongDirection = 1f;
					if (this.AnimationPingPongEvent != null)
					{
						this.AnimationPingPongEvent();
					}
				}
				break;
			}
			}
		}
		_percentage = Mathf.Clamp01(_percentage);
	}

	private Quaternion GetMouseLook()
	{
		if (animationObject == null)
		{
			return Quaternion.identity;
		}
		rotationX += Input.GetAxis("Mouse X") * sensitivity;
		rotationY += (0f - Input.GetAxis("Mouse Y")) * sensitivity;
		rotationY = Mathf.Clamp(rotationY, minX, maxX);
		return Quaternion.Euler(new Vector3(rotationY, rotationX, 0f));
	}

	private void CheckEvents()
	{
		cameraPath.CheckEvents(_percentage);
	}

	private void CleanUp()
	{
		cameraPath.eventList.CameraPathEventPoint += OnCustomEvent;
		cameraPath.delayList.CameraPathDelayEvent += OnDelayEvent;
	}

	private void OnDelayEvent(float time)
	{
		if (time > 0f)
		{
			delayTime = time;
		}
		else
		{
			Pause();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (this.AnimationCustomEvent != null)
		{
			this.AnimationCustomEvent(eventName);
		}
	}
}
