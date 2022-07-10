using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("Image Effects/Glow Threshold")]
public class GlowThresholdEffect : MonoBehaviour
{
	public float glowThreshold = 0.25f;

	public float glowIntensity = 1.5f;

	public int blurIterations = 3;

	public float blurSpread = 0.7f;

	public Color glowTint = new Color(1f, 1f, 1f, 0f);

	private static string compositeMatString = "Shader \"GlowCompose\" {\n\tProperties {\n\t\t_Color (\"Glow Amount\", Color) = (1,1,1,1)\n\t\t_MainTex (\"\", RECT) = \"white\" {}\n\t}\n\tSubShader {\n\t\tPass {\n\t\t\tZTest Always Cull Off ZWrite Off Fog { Mode Off }\n\t\t\tBlend One One\n\t\t\tSetTexture [_MainTex] {constantColor [_Color] combine constant * texture DOUBLE}\n\t\t}\n\t}\n\tFallback off\n}";

	private static Material m_CompositeMaterial;

	private static string blurMatString = "Shader \"GlowConeTap\" {\n\tProperties {\n\t\t_Color (\"Blur Boost\", Color) = (0,0,0,0.25)\n\t\t_MainTex (\"\", RECT) = \"white\" {}\n\t}\n\tSubShader {\n\t\tPass {\n\t\t\tZTest Always Cull Off ZWrite Off Fog { Mode Off }\n\t\t\tSetTexture [_MainTex] {constantColor [_Color] combine texture * constant alpha}\n\t\t\tSetTexture [_MainTex] {constantColor [_Color] combine texture * constant + previous}\n\t\t\tSetTexture [_MainTex] {constantColor [_Color] combine texture * constant + previous}\n\t\t\tSetTexture [_MainTex] {constantColor [_Color] combine texture * constant + previous}\n\t\t}\n\t}\n\tFallback off\n}";

	private static Material m_BlurMaterial;

	public Shader downsampleShader;

	private Material m_DownsampleMaterial;

	protected static Material compositeMaterial
	{
		get
		{
			if (m_CompositeMaterial == null)
			{
				m_CompositeMaterial = new Material(compositeMatString);
				m_CompositeMaterial.hideFlags = HideFlags.HideAndDontSave;
				m_CompositeMaterial.shader.hideFlags = HideFlags.HideAndDontSave;
			}
			return m_CompositeMaterial;
		}
	}

	protected static Material blurMaterial
	{
		get
		{
			if (m_BlurMaterial == null)
			{
				m_BlurMaterial = new Material(blurMatString);
				m_BlurMaterial.hideFlags = HideFlags.HideAndDontSave;
				m_BlurMaterial.shader.hideFlags = HideFlags.HideAndDontSave;
			}
			return m_BlurMaterial;
		}
	}

	protected Material downsampleMaterial
	{
		get
		{
			if (m_DownsampleMaterial == null)
			{
				m_DownsampleMaterial = new Material(downsampleShader);
				m_DownsampleMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return m_DownsampleMaterial;
		}
	}

	protected void OnDisable()
	{
		if ((bool)m_CompositeMaterial)
		{
			Object.DestroyImmediate(m_CompositeMaterial.shader);
			Object.DestroyImmediate(m_CompositeMaterial);
		}
		if ((bool)m_BlurMaterial)
		{
			Object.DestroyImmediate(m_BlurMaterial.shader);
			Object.DestroyImmediate(m_BlurMaterial);
		}
		if ((bool)m_DownsampleMaterial)
		{
			Object.DestroyImmediate(m_DownsampleMaterial);
		}
	}

	protected void Start()
	{
		if (!SystemInfo.supportsImageEffects)
		{
			base.enabled = false;
			return;
		}
		if (downsampleShader == null)
		{
			Debug.Log("No downsample shader assigned! Disabling glow.");
			base.enabled = false;
			return;
		}
		if (!blurMaterial.shader.isSupported)
		{
			base.enabled = false;
		}
		if (!compositeMaterial.shader.isSupported)
		{
			base.enabled = false;
		}
		if (!downsampleMaterial.shader.isSupported)
		{
			base.enabled = false;
		}
	}

	public void FourTapCone(RenderTexture source, RenderTexture dest, int iteration)
	{
		RenderTexture.active = dest;
		blurMaterial.SetTexture("_MainTex", source);
		float offsetX = (0.5f + (float)iteration * blurSpread) / (float)source.width;
		float offsetY = (0.5f + (float)iteration * blurSpread) / (float)source.height;
		GL.PushMatrix();
		GL.LoadOrtho();
		for (int i = 0; i < blurMaterial.passCount; i++)
		{
			blurMaterial.SetPass(i);
			Render4TapQuad(dest, offsetX, offsetY);
		}
		GL.PopMatrix();
	}

	private void DownSample4x(RenderTexture source, RenderTexture dest)
	{
		downsampleMaterial.SetFloat("_GlowThreshold", glowThreshold);
		downsampleMaterial.color = new Color(glowTint.r, glowTint.g, glowTint.b, glowTint.a / 4f);
		ImageEffects.BlitWithMaterial(downsampleMaterial, source, dest);
	}

	private void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		glowThreshold = Mathf.Clamp(glowThreshold, 0f, 1f);
		glowIntensity = Mathf.Clamp(glowIntensity, 0f, 10f);
		blurIterations = Mathf.Clamp(blurIterations, 0, 30);
		blurSpread = Mathf.Clamp(blurSpread, 0.5f, 1f);
		RenderTexture temporary = RenderTexture.GetTemporary(source.width / 4, source.height / 4, 0);
		RenderTexture temporary2 = RenderTexture.GetTemporary(source.width / 4, source.height / 4, 0);
		DownSample4x(source, temporary);
		float num = Mathf.Clamp01((glowIntensity - 1f) / 4f);
		blurMaterial.color = new Color(1f, 1f, 1f, 0.25f + num);
		bool flag = true;
		for (int i = 0; i < blurIterations; i++)
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
		ImageEffects.Blit(source, destination);
		if (flag)
		{
			BlitGlow(temporary, destination);
		}
		else
		{
			BlitGlow(temporary2, destination);
		}
		RenderTexture.ReleaseTemporary(temporary);
		RenderTexture.ReleaseTemporary(temporary2);
	}

	public void BlitGlow(RenderTexture source, RenderTexture dest)
	{
		compositeMaterial.color = new Color(1f, 1f, 1f, Mathf.Clamp01(glowIntensity));
		ImageEffects.BlitWithMaterial(compositeMaterial, source, dest);
	}

	private static void Render4TapQuad(RenderTexture dest, float offsetX, float offsetY)
	{
		GL.Begin(7);
		Vector2 vector = Vector2.zero;
		if (dest != null)
		{
			vector = dest.GetTexelOffset() * 0.75f;
		}
		Set4TexCoords(vector.x, vector.y, offsetX, offsetY);
		GL.Vertex3(0f, 0f, 0.1f);
		Set4TexCoords(1f + vector.x, vector.y, offsetX, offsetY);
		GL.Vertex3(1f, 0f, 0.1f);
		Set4TexCoords(1f + vector.x, 1f + vector.y, offsetX, offsetY);
		GL.Vertex3(1f, 1f, 0.1f);
		Set4TexCoords(vector.x, 1f + vector.y, offsetX, offsetY);
		GL.Vertex3(0f, 1f, 0.1f);
		GL.End();
	}

	private static void Set4TexCoords(float x, float y, float offsetX, float offsetY)
	{
		GL.MultiTexCoord2(0, x - offsetX, y - offsetY);
		GL.MultiTexCoord2(1, x + offsetX, y - offsetY);
		GL.MultiTexCoord2(2, x + offsetX, y + offsetY);
		GL.MultiTexCoord2(3, x - offsetX, y + offsetY);
	}
}
