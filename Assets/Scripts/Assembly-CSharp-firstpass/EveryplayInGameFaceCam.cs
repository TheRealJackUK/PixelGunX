using UnityEngine;

public class EveryplayInGameFaceCam : MonoBehaviour
{
	public Material targetMaterial;

	public int textureSideWidth = 128;

	public TextureFormat textureFormat = TextureFormat.RGBA32;

	public TextureWrapMode textureWrapMode;

	private Texture defaultTexture;

	private Texture2D targetTexture;

	private void Awake()
	{
		targetTexture = new Texture2D(textureSideWidth, textureSideWidth, textureFormat, false);
		targetTexture.wrapMode = textureWrapMode;
		if ((bool)targetMaterial && (bool)targetTexture)
		{
			defaultTexture = targetMaterial.mainTexture;
			Everyplay.FaceCamSetTargetTexture(targetTexture);
			Everyplay.FaceCamSessionStarted += OnSessionStart;
			Everyplay.FaceCamSessionStopped += OnSessionStop;
		}
	}

	private void OnSessionStart()
	{
		if ((bool)targetMaterial && (bool)targetTexture)
		{
			targetMaterial.mainTexture = targetTexture;
		}
	}

	private void OnSessionStop()
	{
		targetMaterial.mainTexture = defaultTexture;
	}

	private void OnDestroy()
	{
		Everyplay.FaceCamSessionStarted -= OnSessionStart;
		Everyplay.FaceCamSessionStopped -= OnSessionStop;
	}
}
