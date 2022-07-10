using Holoville.HOTween;
using UnityEngine;

internal sealed class TrainingArrow : MonoBehaviour
{
	public Vector2 arrowDelta = Vector2.zero;

	private Vector2 initialPosition;

	private RectTransform rectTransform;

	private Tweener tweener;

	private void Init()
	{
		if (rectTransform == null)
		{
			rectTransform = GetComponent<RectTransform>();
			initialPosition = rectTransform.anchoredPosition;
		}
	}

	public void SetAnchoredPosition(Vector3 position)
	{
		Init();
		if (rectTransform != null)
		{
			rectTransform.anchoredPosition = position;
			initialPosition = rectTransform.anchoredPosition;
			if (tweener != null)
			{
				tweener.Kill();
			}
			tweener = HOTween.To(rectTransform, 0.5f, new TweenParms().Prop("anchoredPosition", arrowDelta, true).Loops(-1, LoopType.YoyoInverse));
		}
	}

	private void Awake()
	{
		Init();
	}

	private void OnEnable()
	{
		rectTransform.anchoredPosition = initialPosition;
		if (tweener != null)
		{
			tweener.Kill();
		}
		tweener = HOTween.To(rectTransform, 0.5f, new TweenParms().Prop("anchoredPosition", arrowDelta, true).Loops(-1, LoopType.YoyoInverse));
	}

	private void OnDisable()
	{
		if (tweener != null)
		{
			tweener.Kill();
			tweener = null;
		}
	}
}
