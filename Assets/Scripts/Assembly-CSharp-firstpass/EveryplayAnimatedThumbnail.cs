using System.Collections;
using UnityEngine;

public class EveryplayAnimatedThumbnail : MonoBehaviour
{
	private EveryplayThumbnailPool thumbnailPool;

	private Renderer mainRenderer;

	private Texture defaultTexture;

	private int currentIndex;

	private bool transitionInProgress;

	private float blend;

	private void Awake()
	{
		mainRenderer = GetComponent<Renderer>();
	}

	private void Start()
	{
		thumbnailPool = (EveryplayThumbnailPool)Object.FindObjectOfType(typeof(EveryplayThumbnailPool));
		if ((bool)thumbnailPool)
		{
			defaultTexture = mainRenderer.material.mainTexture;
			ResetThumbnail();
		}
		else
		{
			Debug.Log("Everyplay thumbnail pool not found or no material was defined!");
		}
	}

	private void OnDestroy()
	{
		StopTransitions();
	}

	private void OnDisable()
	{
		StopTransitions();
	}

	private void ResetThumbnail()
	{
		currentIndex = -1;
		StopTransitions();
		blend = 0f;
		mainRenderer.material.SetFloat("_Blend", blend);
		if (mainRenderer.material.mainTexture != defaultTexture)
		{
			mainRenderer.material.mainTextureScale = Vector2.one;
			mainRenderer.material.mainTexture = defaultTexture;
		}
	}

	private IEnumerator CrossfadeTransition()
	{
		while (blend < 1f && transitionInProgress)
		{
			blend += 0.1f;
			mainRenderer.material.SetFloat("_Blend", blend);
			yield return new WaitForSeconds(0.025f);
		}
		mainRenderer.material.mainTexture = mainRenderer.material.GetTexture("_MainTex2");
		mainRenderer.material.mainTextureScale = mainRenderer.material.GetTextureScale("_MainTex2");
		blend = 0f;
		mainRenderer.material.SetFloat("_Blend", blend);
		transitionInProgress = false;
	}

	private void StopTransitions()
	{
		transitionInProgress = false;
		StopAllCoroutines();
	}

	private void Update()
	{
		if (!thumbnailPool || transitionInProgress)
		{
			return;
		}
		if (thumbnailPool.availableThumbnailCount > 0)
		{
			if (currentIndex < 0)
			{
				currentIndex = 0;
				mainRenderer.material.mainTextureScale = thumbnailPool.thumbnailScale;
				mainRenderer.material.mainTexture = thumbnailPool.thumbnailTextures[currentIndex];
			}
			else if (thumbnailPool.availableThumbnailCount > 1 && Time.frameCount % 50 == 0)
			{
				currentIndex++;
				if (currentIndex >= thumbnailPool.availableThumbnailCount)
				{
					currentIndex = 0;
				}
				mainRenderer.material.SetTextureScale("_MainTex2", thumbnailPool.thumbnailScale);
				mainRenderer.material.SetTexture("_MainTex2", thumbnailPool.thumbnailTextures[currentIndex]);
				transitionInProgress = true;
				StartCoroutine("CrossfadeTransition");
			}
		}
		else if (currentIndex >= 0)
		{
			ResetThumbnail();
		}
	}
}
