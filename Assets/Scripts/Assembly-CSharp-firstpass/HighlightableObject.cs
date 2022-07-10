using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HighlightableObject : MonoBehaviour
{
	private class HighlightingRendererCache
	{
		public Renderer rendererCached;

		public GameObject goCached;

		private Material[] sourceMaterials;

		private Material[] replacementMaterials;

		private List<int> transparentMaterialIndexes;

		public HighlightingRendererCache(Renderer rend, Material[] mats, Material sharedOpaqueMaterial, bool writeDepth)
		{
			rendererCached = rend;
			goCached = rend.gameObject;
			sourceMaterials = mats;
			replacementMaterials = new Material[mats.Length];
			transparentMaterialIndexes = new List<int>();
			for (int i = 0; i < mats.Length; i++)
			{
				Material material = mats[i];
				if (material == null)
				{
					continue;
				}
				string tag = material.GetTag("RenderType", true);
				if (tag == "Transparent" || tag == "TransparentCutout")
				{
					Material material2 = new Material((!writeDepth) ? transparentShader : transparentZShader);
					if (material.HasProperty("_MainTex"))
					{
						material2.SetTexture("_MainTex", material.mainTexture);
						material2.SetTextureOffset("_MainTex", material.mainTextureOffset);
						material2.SetTextureScale("_MainTex", material.mainTextureScale);
					}
					material2.SetFloat("_Cutoff", (!material.HasProperty("_Cutoff")) ? transparentCutoff : material.GetFloat("_Cutoff"));
					replacementMaterials[i] = material2;
					transparentMaterialIndexes.Add(i);
				}
				else
				{
					replacementMaterials[i] = sharedOpaqueMaterial;
				}
			}
		}

		public void SetState(bool state)
		{
			rendererCached.sharedMaterials = ((!state) ? sourceMaterials : replacementMaterials);
		}

		public void SetColorForTransparent(Color clr)
		{
			for (int i = 0; i < transparentMaterialIndexes.Count; i++)
			{
				replacementMaterials[transparentMaterialIndexes[i]].SetColor("_Outline", clr);
			}
		}
	}

	private const float doublePI = (float)Math.PI * 2f;

	public static int highlightingLayer = 7;

	private static float constantOnSpeed = 4.5f;

	private static float constantOffSpeed = 4f;

	private static float transparentCutoff = 0.5f;

	private List<HighlightingRendererCache> highlightableRenderers;

	private int[] layersCache;

	private bool materialsIsDirty = true;

	private bool currentState;

	private Color currentColor;

	private bool transitionActive;

	private float transitionValue;

	private float flashingFreq = 2f;

	private bool once;

	private Color onceColor = Color.red;

	private bool flashing;

	private Color flashingColorMin = new Color(0f, 1f, 1f, 0f);

	private Color flashingColorMax = new Color(0f, 1f, 1f, 1f);

	private bool constantly;

	private Color constantColor = Color.yellow;

	private bool occluder;

	private bool zWrite;

	private readonly Color occluderColor = new Color(0f, 0f, 0f, 0.005f);

	private Material _opaqueMaterial;

	private Material _opaqueZMaterial;

	private static Shader _opaqueShader;

	private static Shader _transparentShader;

	private static Shader _opaqueZShader;

	private static Shader _transparentZShader;

	private Material highlightingMaterial
	{
		get
		{
			return (!zWrite) ? opaqueMaterial : opaqueZMaterial;
		}
	}

	private Material opaqueMaterial
	{
		get
		{
			if (_opaqueMaterial == null)
			{
				_opaqueMaterial = new Material(opaqueShader);
				_opaqueMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return _opaqueMaterial;
		}
	}

	private Material opaqueZMaterial
	{
		get
		{
			if (_opaqueZMaterial == null)
			{
				_opaqueZMaterial = new Material(opaqueZShader);
				_opaqueZMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return _opaqueZMaterial;
		}
	}

	private static Shader opaqueShader
	{
		get
		{
			if (_opaqueShader == null)
			{
				_opaqueShader = Shader.Find("Hidden/Highlighted/StencilOpaque");
			}
			return _opaqueShader;
		}
	}

	public static Shader transparentShader
	{
		get
		{
			if (_transparentShader == null)
			{
				_transparentShader = Shader.Find("Hidden/Highlighted/StencilTransparent");
			}
			return _transparentShader;
		}
	}

	private static Shader opaqueZShader
	{
		get
		{
			if (_opaqueZShader == null)
			{
				_opaqueZShader = Shader.Find("Hidden/Highlighted/StencilOpaqueZ");
			}
			return _opaqueZShader;
		}
	}

	private static Shader transparentZShader
	{
		get
		{
			if (_transparentZShader == null)
			{
				_transparentZShader = Shader.Find("Hidden/Highlighted/StencilTransparentZ");
			}
			return _transparentZShader;
		}
	}

	private void OnEnable()
	{
		StartCoroutine(EndOfFrame());
		HighlightingEffect.highlightingEvent += UpdateEventHandler;
	}

	private void OnDisable()
	{
		StopAllCoroutines();
		HighlightingEffect.highlightingEvent -= UpdateEventHandler;
		if (highlightableRenderers != null)
		{
			highlightableRenderers.Clear();
		}
		layersCache = null;
		materialsIsDirty = true;
		currentState = false;
		currentColor = Color.clear;
		transitionActive = false;
		transitionValue = 0f;
		once = false;
		flashing = false;
		constantly = false;
		occluder = false;
		zWrite = false;
		if ((bool)_opaqueMaterial)
		{
			UnityEngine.Object.DestroyImmediate(_opaqueMaterial);
		}
		if ((bool)_opaqueZMaterial)
		{
			UnityEngine.Object.DestroyImmediate(_opaqueZMaterial);
		}
	}

	public void ReinitMaterials()
	{
		materialsIsDirty = true;
	}

	public void RestoreMaterials()
	{
		Debug.LogWarning("HighlightingSystem : RestoreMaterials() is obsolete. Please use ReinitMaterials() instead.");
		ReinitMaterials();
	}

	public void OnParams(Color color)
	{
		onceColor = color;
	}

	public void On()
	{
		once = true;
	}

	public void On(Color color)
	{
		onceColor = color;
		On();
	}

	public void FlashingParams(Color color1, Color color2, float freq)
	{
		flashingColorMin = color1;
		flashingColorMax = color2;
		flashingFreq = freq;
	}

	public void FlashingOn()
	{
		flashing = true;
	}

	public void FlashingOn(Color color1, Color color2)
	{
		flashingColorMin = color1;
		flashingColorMax = color2;
		FlashingOn();
	}

	public void FlashingOn(Color color1, Color color2, float freq)
	{
		flashingFreq = freq;
		FlashingOn(color1, color2);
	}

	public void FlashingOn(float freq)
	{
		flashingFreq = freq;
		FlashingOn();
	}

	public void FlashingOff()
	{
		flashing = false;
	}

	public void FlashingSwitch()
	{
		flashing = !flashing;
	}

	public void ConstantParams(Color color)
	{
		constantColor = color;
	}

	public void ConstantOn()
	{
		constantly = true;
		transitionActive = true;
	}

	public void ConstantOn(Color color)
	{
		constantColor = color;
		ConstantOn();
	}

	public void ConstantOff()
	{
		constantly = false;
		transitionActive = true;
	}

	public void ConstantSwitch()
	{
		constantly = !constantly;
		transitionActive = true;
	}

	public void ConstantOnImmediate()
	{
		constantly = true;
		transitionValue = 1f;
		transitionActive = false;
	}

	public void ConstantOnImmediate(Color color)
	{
		constantColor = color;
		ConstantOnImmediate();
	}

	public void ConstantOffImmediate()
	{
		constantly = false;
		transitionValue = 0f;
		transitionActive = false;
	}

	public void ConstantSwitchImmediate()
	{
		constantly = !constantly;
		transitionValue = ((!constantly) ? 0f : 1f);
		transitionActive = false;
	}

	public void OccluderOn()
	{
		occluder = true;
	}

	public void OccluderOff()
	{
		occluder = false;
	}

	public void OccluderSwitch()
	{
		occluder = !occluder;
	}

	public void Off()
	{
		once = false;
		flashing = false;
		constantly = false;
		transitionValue = 0f;
		transitionActive = false;
	}

	public void Die()
	{
		UnityEngine.Object.Destroy(this);
	}

	private void InitMaterials(bool writeDepth)
	{
		currentState = false;
		zWrite = writeDepth;
		highlightableRenderers = new List<HighlightingRendererCache>();
		MeshRenderer[] componentsInChildren = GetComponentsInChildren<MeshRenderer>();
		CacheRenderers(componentsInChildren);
		SkinnedMeshRenderer[] componentsInChildren2 = GetComponentsInChildren<SkinnedMeshRenderer>();
		CacheRenderers(componentsInChildren2);
		Renderer[] componentsInChildren3 = GetComponentsInChildren<Renderer>();
		CacheRenderers(componentsInChildren3);
		currentState = false;
		materialsIsDirty = false;
		currentColor = Color.clear;
	}

	private void CacheRenderers(Renderer[] renderers)
	{
		for (int i = 0; i < renderers.Length; i++)
		{
			Material[] sharedMaterials = renderers[i].sharedMaterials;
			if (sharedMaterials != null)
			{
				highlightableRenderers.Add(new HighlightingRendererCache(renderers[i], sharedMaterials, highlightingMaterial, zWrite));
			}
		}
	}

	private void SetColor(Color c)
	{
		if (!(currentColor == c))
		{
			if (zWrite)
			{
				opaqueZMaterial.SetColor("_Outline", c);
			}
			else
			{
				opaqueMaterial.SetColor("_Outline", c);
			}
			for (int i = 0; i < highlightableRenderers.Count; i++)
			{
				highlightableRenderers[i].SetColorForTransparent(c);
			}
			currentColor = c;
		}
	}

	private void UpdateColors()
	{
		if (currentState)
		{
			if (occluder)
			{
				SetColor(occluderColor);
			}
			else if (once)
			{
				SetColor(onceColor);
			}
			else if (flashing)
			{
				Color color = Color.Lerp(flashingColorMin, flashingColorMax, 0.5f * Mathf.Sin(Time.realtimeSinceStartup * flashingFreq * ((float)Math.PI * 2f)) + 0.5f);
				SetColor(color);
			}
			else if (transitionActive)
			{
				Color color2 = new Color(constantColor.r, constantColor.g, constantColor.b, constantColor.a * transitionValue);
				SetColor(color2);
			}
			else if (constantly)
			{
				SetColor(constantColor);
			}
		}
	}

	private void PerformTransition()
	{
		if (transitionActive)
		{
			float num = ((!constantly) ? 0f : 1f);
			if (transitionValue == num)
			{
				transitionActive = false;
			}
			else if (Time.timeScale != 0f)
			{
				float num2 = Time.deltaTime / Time.timeScale;
				transitionValue += ((!constantly) ? (0f - constantOffSpeed) : constantOnSpeed) * num2;
				transitionValue = Mathf.Clamp01(transitionValue);
			}
		}
	}

	private void UpdateEventHandler(bool trigger, bool writeDepth)
	{
		if (trigger)
		{
			if (zWrite != writeDepth)
			{
				materialsIsDirty = true;
			}
			if (materialsIsDirty)
			{
				InitMaterials(writeDepth);
			}
			currentState = once || flashing || constantly || transitionActive || occluder;
			if (!currentState)
			{
				return;
			}
			UpdateColors();
			PerformTransition();
			if (highlightableRenderers != null)
			{
				layersCache = new int[highlightableRenderers.Count];
				for (int i = 0; i < highlightableRenderers.Count; i++)
				{
					GameObject goCached = highlightableRenderers[i].goCached;
					layersCache[i] = goCached.layer;
					goCached.layer = highlightingLayer;
					highlightableRenderers[i].SetState(true);
				}
			}
		}
		else if (currentState && highlightableRenderers != null)
		{
			for (int j = 0; j < highlightableRenderers.Count; j++)
			{
				highlightableRenderers[j].goCached.layer = layersCache[j];
				highlightableRenderers[j].SetState(false);
			}
		}
	}

	private IEnumerator EndOfFrame()
	{
		while (base.enabled)
		{
			yield return new WaitForEndOfFrame();
			once = false;
		}
	}
}
