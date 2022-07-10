using Holoville.HOTween;
using UnityEngine;

internal sealed class TrainingFingerSwipe : MonoBehaviour
{
	public Vector2 arrowDdelta = new Vector3(300f, 0f);

	private Vector3 initialAnchoredPosition;

	private RectTransform rectTransform;

	private Tweener tweener;

	private void Awake()
	{
		rectTransform = GetComponent<RectTransform>();
		initialAnchoredPosition = rectTransform.anchoredPosition;
	}

	private void OnEnable()
	{
		rectTransform.anchoredPosition = initialAnchoredPosition;
		if (tweener != null)
		{
			tweener.Kill();
		}
		tweener = HOTween.To(rectTransform, 1f, new TweenParms().Prop("anchoredPosition", arrowDdelta, true).Ease(EaseType.EaseInQuad).Loops(-1, LoopType.Restart));
	}

	private void Update()
	{
		int completedLoops = tweener.completedLoops;
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
