using System.Collections;
using UnityEngine;

[ExecuteInEditMode]
public class EveryplayAnimatedThumbnailOnGUI : MonoBehaviour
{
	public Texture defaultTexture;

	public Rect pixelInset = new Rect(10f, 10f, 256f, 196f);

	private EveryplayThumbnailPool thumbnailPool;

	private int currentIndex;

	private bool transitionInProgress;

	private float blend;

	private Texture bottomTexture;

	private Vector2 bottomTextureScale;

	private Vector2 topTextureScale;

	private Texture topTexture;

	private void Awake()
	{
		bottomTexture = defaultTexture;
	}

	private void Start()
	{
		thumbnailPool = (EveryplayThumbnailPool)Object.FindObjectOfType(typeof(EveryplayThumbnailPool));
		if ((bool)thumbnailPool)
		{
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
		bottomTextureScale = Vector2.one;
		bottomTexture = defaultTexture;
	}

	private IEnumerator CrossfadeTransition()
	{
		while (blend < 1f && transitionInProgress)
		{
			blend += 0.1f;
			yield return new WaitForSeconds(0.025f);
		}
		bottomTexture = topTexture;
		bottomTextureScale = topTextureScale;
		blend = 0f;
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
				bottomTextureScale = thumbnailPool.thumbnailScale;
				bottomTexture = thumbnailPool.thumbnailTextures[currentIndex];
			}
			else if (thumbnailPool.availableThumbnailCount > 1 && Time.frameCount % 50 == 0)
			{
				currentIndex++;
				if (currentIndex >= thumbnailPool.availableThumbnailCount)
				{
					currentIndex = 0;
				}
				topTextureScale = thumbnailPool.thumbnailScale;
				topTexture = thumbnailPool.thumbnailTextures[currentIndex];
				transitionInProgress = true;
				StartCoroutine("CrossfadeTransition");
			}
		}
		else if (currentIndex >= 0)
		{
			ResetThumbnail();
		}
	}

	private void OnGUI()
	{
		if (Event.current.type.Equals(EventType.Repaint))
		{
			if ((bool)bottomTexture)
			{
				GUI.DrawTextureWithTexCoords(new Rect(pixelInset.x, pixelInset.y, pixelInset.width, pixelInset.height), bottomTexture, new Rect(0f, 0f, bottomTextureScale.x, bottomTextureScale.y));
			}
			if ((bool)topTexture && blend > 0f)
			{
				Color color = GUI.color;
				GUI.color = new Color(color.r, color.g, color.b, blend);
				GUI.DrawTextureWithTexCoords(new Rect(pixelInset.x, pixelInset.y, pixelInset.width, pixelInset.height), topTexture, new Rect(0f, 0f, topTextureScale.x, topTextureScale.y));
				GUI.color = color;
			}
		}
	}
}
