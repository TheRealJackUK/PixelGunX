using System;
using UnityEngine;

[Serializable]
[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("Image Effects/Mobile Bloom V2")]
public class MobileBloom : MonoBehaviour
{
	public float intensity;

	public float threshhold;

	public float blurWidth;

	public bool extraBlurry;

	public Material bloomMaterial;

	private bool supported;

	private RenderTexture tempRtA;

	private RenderTexture tempRtB;

	public MobileBloom()
	{
		intensity = 0.7f;
		threshhold = 0.75f;
		blurWidth = 1f;
	}

	public virtual bool Supported()
	{
		int result;
		if (supported)
		{
			result = 1;
		}
		else
		{
			bool num = SystemInfo.supportsImageEffects;
			if (num)
			{
				num = SystemInfo.supportsRenderTextures;
			}
			if (num)
			{
				num = bloomMaterial.shader.isSupported;
			}
			supported = num;
			result = (supported ? 1 : 0);
		}
		return (byte)result != 0;
	}

	public virtual void CreateBuffers()
	{
		if (!tempRtA)
		{
			tempRtA = new RenderTexture(Screen.width / 4, Screen.height / 4, 0);
			tempRtA.hideFlags = HideFlags.DontSave;
		}
		if (!tempRtB)
		{
			tempRtB = new RenderTexture(Screen.width / 4, Screen.height / 4, 0);
			tempRtB.hideFlags = HideFlags.DontSave;
		}
	}

	public virtual void OnDisable()
	{
		if ((bool)tempRtA)
		{
			UnityEngine.Object.DestroyImmediate(tempRtA);
			tempRtA = null;
		}
		if ((bool)tempRtB)
		{
			UnityEngine.Object.DestroyImmediate(tempRtB);
			tempRtB = null;
		}
	}

	public virtual bool EarlyOutIfNotSupported(RenderTexture source, RenderTexture destination)
	{
		int result;
		if (!Supported())
		{
			enabled = false;
			Graphics.Blit(source, destination);
			result = 1;
		}
		else
		{
			result = 0;
		}
		return (byte)result != 0;
	}

	public virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		CreateBuffers();
		if (!EarlyOutIfNotSupported(source, destination))
		{
			bloomMaterial.SetVector("_Parameter", new Vector4(0f, 0f, threshhold, intensity / (1f - threshhold)));
			float num = 1f / ((float)source.width * 1f);
			float num2 = 1f / ((float)source.height * 1f);
			bloomMaterial.SetVector("_OffsetsA", new Vector4(1.5f * num, 1.5f * num2, -1.5f * num, 1.5f * num2));
			bloomMaterial.SetVector("_OffsetsB", new Vector4(-1.5f * num, -1.5f * num2, 1.5f * num, -1.5f * num2));
			Graphics.Blit(source, tempRtB, bloomMaterial, 1);
			num *= 4f * blurWidth;
			num2 *= 4f * blurWidth;
			bloomMaterial.SetVector("_OffsetsA", new Vector4(1.5f * num, 0f, -1.5f * num, 0f));
			bloomMaterial.SetVector("_OffsetsB", new Vector4(0.5f * num, 0f, -0.5f * num, 0f));
			Graphics.Blit(tempRtB, tempRtA, bloomMaterial, 2);
			bloomMaterial.SetVector("_OffsetsA", new Vector4(0f, 1.5f * num2, 0f, -1.5f * num2));
			bloomMaterial.SetVector("_OffsetsB", new Vector4(0f, 0.5f * num2, 0f, -0.5f * num2));
			Graphics.Blit(tempRtA, tempRtB, bloomMaterial, 2);
			if (extraBlurry)
			{
				bloomMaterial.SetVector("_OffsetsA", new Vector4(1.5f * num, 0f, -1.5f * num, 0f));
				bloomMaterial.SetVector("_OffsetsB", new Vector4(0.5f * num, 0f, -0.5f * num, 0f));
				Graphics.Blit(tempRtB, tempRtA, bloomMaterial, 2);
				bloomMaterial.SetVector("_OffsetsA", new Vector4(0f, 1.5f * num2, 0f, -1.5f * num2));
				bloomMaterial.SetVector("_OffsetsB", new Vector4(0f, 0.5f * num2, 0f, -0.5f * num2));
				Graphics.Blit(tempRtA, tempRtB, bloomMaterial, 2);
			}
			bloomMaterial.SetTexture("_Bloom", tempRtB);
			Graphics.Blit(source, destination, bloomMaterial, 0);
		}
	}

	public virtual void Main()
	{
	}
}
