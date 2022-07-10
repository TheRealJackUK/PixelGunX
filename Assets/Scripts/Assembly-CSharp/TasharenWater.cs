using System.Collections;
using UnityEngine;

[RequireComponent(typeof(Renderer))]
[AddComponentMenu("Tasharen/Water")]
[ExecuteInEditMode]
public class TasharenWater : MonoBehaviour
{
	public enum Quality
	{
		Fastest,
		Low,
		Medium,
		High,
		Uber
	}

	public Quality quality = Quality.High;

	public LayerMask highReflectionMask = -1;

	public LayerMask mediumReflectionMask = -1;

	public bool keepUnderCamera = true;

	private Transform mTrans;

	private Hashtable mCameras = new Hashtable();

	private RenderTexture mTex;

	private int mTexSize;

	private Renderer mRen;

	private static bool mIsRendering;

	public int reflectionTextureSize
	{
		get
		{
			switch (quality)
			{
			case Quality.Uber:
				return 1024;
			case Quality.Medium:
			case Quality.High:
				return 512;
			default:
				return 0;
			}
		}
	}

	public LayerMask reflectionMask
	{
		get
		{
			switch (quality)
			{
			case Quality.High:
			case Quality.Uber:
				return highReflectionMask;
			case Quality.Medium:
				return mediumReflectionMask;
			default:
				return 0;
			}
		}
	}

	public bool useRefraction
	{
		get
		{
			return quality > Quality.Fastest;
		}
	}

	private static float SignExt(float a)
	{
		if (a > 0f)
		{
			return 1f;
		}
		if (a < 0f)
		{
			return -1f;
		}
		return 0f;
	}

	private static void CalculateObliqueMatrix(ref Matrix4x4 projection, Vector4 clipPlane)
	{
		Vector4 b = projection.inverse * new Vector4(SignExt(clipPlane.x), SignExt(clipPlane.y), 1f, 1f);
		Vector4 vector = clipPlane * (2f / Vector4.Dot(clipPlane, b));
		projection[2] = vector.x - projection[3];
		projection[6] = vector.y - projection[7];
		projection[10] = vector.z - projection[11];
		projection[14] = vector.w - projection[15];
	}

	private static void CalculateReflectionMatrix(ref Matrix4x4 reflectionMat, Vector4 plane)
	{
		reflectionMat.m00 = 1f - 2f * plane[0] * plane[0];
		reflectionMat.m01 = -2f * plane[0] * plane[1];
		reflectionMat.m02 = -2f * plane[0] * plane[2];
		reflectionMat.m03 = -2f * plane[3] * plane[0];
		reflectionMat.m10 = -2f * plane[1] * plane[0];
		reflectionMat.m11 = 1f - 2f * plane[1] * plane[1];
		reflectionMat.m12 = -2f * plane[1] * plane[2];
		reflectionMat.m13 = -2f * plane[3] * plane[1];
		reflectionMat.m20 = -2f * plane[2] * plane[0];
		reflectionMat.m21 = -2f * plane[2] * plane[1];
		reflectionMat.m22 = 1f - 2f * plane[2] * plane[2];
		reflectionMat.m23 = -2f * plane[3] * plane[2];
		reflectionMat.m30 = 0f;
		reflectionMat.m31 = 0f;
		reflectionMat.m32 = 0f;
		reflectionMat.m33 = 1f;
	}

	public static Quality GetQuality()
	{
		return (Quality)PlayerPrefs.GetInt("Water", 3);
	}

	public static void SetQuality(Quality q)
	{
		TasharenWater[] array = Object.FindObjectsOfType(typeof(TasharenWater)) as TasharenWater[];
		if (array.Length > 0)
		{
			TasharenWater[] array2 = array;
			foreach (TasharenWater tasharenWater in array2)
			{
				tasharenWater.quality = q;
			}
		}
		else
		{
			PlayerPrefs.SetInt("Water", (int)q);
		}
	}

	private void Awake()
	{
		mTrans = base.transform;
		mRen = base.GetComponent<Renderer>();
		quality = GetQuality();
	}

	private void OnDisable()
	{
		Clear();
		foreach (DictionaryEntry mCamera in mCameras)
		{
			Object.DestroyImmediate(((Camera)mCamera.Value).gameObject);
		}
		mCameras.Clear();
	}

	private void Clear()
	{
		if ((bool)mTex)
		{
			Object.DestroyImmediate(mTex);
			mTex = null;
		}
	}

	private void CopyCamera(Camera src, Camera dest)
	{
		if (src.clearFlags == CameraClearFlags.Skybox)
		{
			Skybox component = src.GetComponent<Skybox>();
			Skybox component2 = dest.GetComponent<Skybox>();
			if (!component || !component.material)
			{
				component2.enabled = false;
			}
			else
			{
				component2.enabled = true;
				component2.material = component.material;
			}
		}
		dest.clearFlags = src.clearFlags;
		dest.backgroundColor = src.backgroundColor;
		dest.farClipPlane = src.farClipPlane;
		dest.nearClipPlane = src.nearClipPlane;
		dest.orthographic = src.orthographic;
		dest.fieldOfView = src.fieldOfView;
		dest.aspect = src.aspect;
		dest.orthographicSize = src.orthographicSize;
		dest.depthTextureMode = DepthTextureMode.None;
		dest.renderingPath = RenderingPath.Forward;
	}

	private Camera GetReflectionCamera(Camera current, Material mat, int textureSize)
	{
		if (!mTex || mTexSize != textureSize)
		{
			if ((bool)mTex)
			{
				Object.DestroyImmediate(mTex);
			}
			mTex = new RenderTexture(textureSize, textureSize, 16);
			mTex.name = "__MirrorReflection" + GetInstanceID();
			mTex.isPowerOfTwo = true;
			mTex.hideFlags = HideFlags.DontSave;
			mTexSize = textureSize;
		}
		Camera camera = mCameras[current] as Camera;
		if (!camera)
		{
			GameObject gameObject = new GameObject("Mirror Refl Camera id" + GetInstanceID() + " for " + current.GetInstanceID(), typeof(Camera), typeof(Skybox));
			gameObject.hideFlags = HideFlags.HideAndDontSave;
			camera = gameObject.GetComponent<Camera>();
			camera.enabled = false;
			Transform transform = camera.transform;
			transform.position = mTrans.position;
			transform.rotation = mTrans.rotation;
			camera.gameObject.AddComponent<FlareLayer>();
			mCameras[current] = camera;
		}
		if (mat.HasProperty("_ReflectionTex"))
		{
			mat.SetTexture("_ReflectionTex", mTex);
		}
		return camera;
	}

	private Vector4 CameraSpacePlane(Camera cam, Vector3 pos, Vector3 normal, float sideSign)
	{
		Matrix4x4 worldToCameraMatrix = cam.worldToCameraMatrix;
		Vector3 lhs = worldToCameraMatrix.MultiplyPoint(pos);
		Vector3 rhs = worldToCameraMatrix.MultiplyVector(normal).normalized * sideSign;
		return new Vector4(rhs.x, rhs.y, rhs.z, 0f - Vector3.Dot(lhs, rhs));
	}

	private void LateUpdate()
	{
		if (keepUnderCamera)
		{
			Transform transform = Camera.main.transform;
			Vector3 position = transform.position;
			position.y = mTrans.position.y;
			if (mTrans.position != position)
			{
				mTrans.position = position;
			}
		}
	}

	private void OnWillRenderObject()
	{
		if (mIsRendering)
		{
			return;
		}
		if (!base.enabled || !mRen || !mRen.enabled)
		{
			Clear();
			return;
		}
		Material sharedMaterial = mRen.sharedMaterial;
		if ((bool)sharedMaterial)
		{
			quality = Quality.Fastest;
			sharedMaterial.shader.maximumLOD = 100;
		}
	}
}
