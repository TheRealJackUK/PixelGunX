using UnityEngine;

[RequireComponent(typeof(Camera))]
public class HighlightingEffect : MonoBehaviour
{
	public int stencilZBufferDepth;

	public int _downsampleFactor = 4;

	public int iterations = 2;

	public float blurMinSpread = 0.65f;

	public float blurSpread = 0.25f;

	public float _blurIntensity = 0.3f;

	private int layerMask = 1 << HighlightableObject.highlightingLayer;

	private GameObject go;

	private GameObject shaderCameraGO;

	private Camera shaderCamera;

	private RenderTexture stencilBuffer;

	private Camera refCam;

	private static Shader _blurShader;

	private static Shader _compShader;

	private static Material _blurMaterial;

	private static Material _compMaterial;

	private static Shader blurShader
	{
		get
		{
			if (_blurShader == null)
			{
				_blurShader = Shader.Find("Hidden/Highlighted/Blur");
			}
			return _blurShader;
		}
	}

	private static Shader compShader
	{
		get
		{
			if (_compShader == null)
			{
				_compShader = Shader.Find("Hidden/Highlighted/Composite");
			}
			return _compShader;
		}
	}

	private static Material blurMaterial
	{
		get
		{
			if (_blurMaterial == null)
			{
				_blurMaterial = new Material(blurShader);
				_blurMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return _blurMaterial;
		}
	}

	private static Material compMaterial
	{
		get
		{
			if (_compMaterial == null)
			{
				_compMaterial = new Material(compShader);
				_compMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return _compMaterial;
		}
	}

	public static event HighlightingEventHandler highlightingEvent;

	private void Awake()
	{
		go = base.gameObject;
		refCam = GetComponent<Camera>();
	}

	private void OnDisable()
	{
		if (shaderCameraGO != null)
		{
			Object.DestroyImmediate(shaderCameraGO);
		}
		if ((bool)_blurShader)
		{
			_blurShader = null;
		}
		if ((bool)_compShader)
		{
			_compShader = null;
		}
		if ((bool)_blurMaterial)
		{
			Object.DestroyImmediate(_blurMaterial);
		}
		if ((bool)_compMaterial)
		{
			Object.DestroyImmediate(_compMaterial);
		}
		if (stencilBuffer != null)
		{
			RenderTexture.ReleaseTemporary(stencilBuffer);
			stencilBuffer = null;
		}
	}

	private void Start()
	{
		if (!SystemInfo.supportsImageEffects)
		{
			Debug.LogWarning("HighlightingSystem : Image effects is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!SystemInfo.supportsRenderTextures)
		{
			Debug.LogWarning("HighlightingSystem : RenderTextures is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat.ARGB32))
		{
			Debug.LogWarning("HighlightingSystem : RenderTextureFormat.ARGB32 is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!Shader.Find("Hidden/Highlighted/StencilOpaque").isSupported)
		{
			Debug.LogWarning("HighlightingSystem : HighlightingStencilOpaque shader is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!Shader.Find("Hidden/Highlighted/StencilTransparent").isSupported)
		{
			Debug.LogWarning("HighlightingSystem : HighlightingStencilTransparent shader is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!Shader.Find("Hidden/Highlighted/StencilOpaqueZ").isSupported)
		{
			Debug.LogWarning("HighlightingSystem : HighlightingStencilOpaqueZ shader is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!Shader.Find("Hidden/Highlighted/StencilTransparentZ").isSupported)
		{
			Debug.LogWarning("HighlightingSystem : HighlightingStencilTransparentZ shader is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!blurShader.isSupported)
		{
			Debug.LogWarning("HighlightingSystem : HighlightingBlur shader is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else if (!compShader.isSupported)
		{
			Debug.LogWarning("HighlightingSystem : HighlightingComposite shader is not supported on this platform! Disabling.");
			base.enabled = false;
		}
		else
		{
			blurMaterial.SetFloat("_Intensity", _blurIntensity);
		}
	}

	public void FourTapCone(RenderTexture source, RenderTexture dest, int iteration)
	{
		float value = blurMinSpread + (float)iteration * blurSpread;
		blurMaterial.SetFloat("_OffsetScale", value);
		Graphics.Blit(source, dest, blurMaterial);
	}

	private void DownSample4x(RenderTexture source, RenderTexture dest)
	{
		float value = 1f;
		blurMaterial.SetFloat("_OffsetScale", value);
		Graphics.Blit(source, dest, blurMaterial);
	}

	private void OnPreRender()
	{
		if (!base.enabled || !go.active)
		{
			return;
		}
		if (stencilBuffer != null)
		{
			RenderTexture.ReleaseTemporary(stencilBuffer);
			stencilBuffer = null;
		}
		if (HighlightingEffect.highlightingEvent != null)
		{
			HighlightingEffect.highlightingEvent(true, stencilZBufferDepth > 0);
			stencilBuffer = RenderTexture.GetTemporary((int)base.GetComponent<Camera>().pixelWidth, (int)base.GetComponent<Camera>().pixelHeight, stencilZBufferDepth, RenderTextureFormat.ARGB32);
			if (!shaderCameraGO)
			{
				shaderCameraGO = new GameObject("HighlightingCamera", typeof(Camera));
				shaderCameraGO.GetComponent<Camera>().enabled = false;
				shaderCameraGO.hideFlags = HideFlags.HideAndDontSave;
			}
			if (!shaderCamera)
			{
				shaderCamera = shaderCameraGO.GetComponent<Camera>();
			}
			shaderCamera.CopyFrom(refCam);
			shaderCamera.cullingMask = layerMask;
			shaderCamera.rect = new Rect(0f, 0f, 1f, 1f);
			shaderCamera.renderingPath = RenderingPath.VertexLit;
			shaderCamera.hdr = false;
			shaderCamera.useOcclusionCulling = false;
			shaderCamera.backgroundColor = new Color(0f, 0f, 0f, 0f);
			shaderCamera.clearFlags = CameraClearFlags.Color;
			shaderCamera.targetTexture = stencilBuffer;
			shaderCamera.Render();
			if (HighlightingEffect.highlightingEvent != null)
			{
				HighlightingEffect.highlightingEvent(false, false);
			}
		}
	}

	private void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		if (stencilBuffer == null)
		{
			Graphics.Blit(source, destination);
			return;
		}
		int width = source.width / _downsampleFactor;
		int height = source.height / _downsampleFactor;
		RenderTexture temporary = RenderTexture.GetTemporary(width, height, stencilZBufferDepth, RenderTextureFormat.ARGB32);
		RenderTexture temporary2 = RenderTexture.GetTemporary(width, height, stencilZBufferDepth, RenderTextureFormat.ARGB32);
		DownSample4x(stencilBuffer, temporary);
		bool flag = true;
		for (int i = 0; i < iterations; i++)
		{
			if (flag)
			{
				FourTapCone(temporary, temporary2, i);
			}
			else
			{
				FourTapCone(temporary2, temporary, i);
			}
			flag = !flag;
		}
		compMaterial.SetTexture("_StencilTex", stencilBuffer);
		compMaterial.SetTexture("_BlurTex", (!flag) ? temporary2 : temporary);
		Graphics.Blit(source, destination, compMaterial);
		RenderTexture.ReleaseTemporary(temporary);
		RenderTexture.ReleaseTemporary(temporary2);
		if (stencilBuffer != null)
		{
			RenderTexture.ReleaseTemporary(stencilBuffer);
			stencilBuffer = null;
		}
	}
}
