using System;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("NGUI/Interaction/Center Scroll View on Child")]
public class UICenterOnChild : MonoBehaviour
{
	public delegate void OnCenterCallback(GameObject centeredObject);

	public float springStrength = 8f;

	public float nextPageThreshold;

	public SpringPanel.OnFinished onFinished;

	public OnCenterCallback onCenter;

	private UIScrollView mScrollView;

	private GameObject mCenteredObject;

	public GameObject centeredObject
	{
		get
		{
			return mCenteredObject;
		}
	}

	private void Start()
	{
		Recenter();
	}

	private void OnEnable()
	{
		if ((bool)mScrollView)
		{
			mScrollView.centerOnChild = this;
			Recenter();
		}
	}

	private void OnDisable()
	{
		if ((bool)mScrollView)
		{
			mScrollView.centerOnChild = null;
		}
	}

	private void OnDragFinished()
	{
		if (base.enabled)
		{
			Recenter();
		}
	}

	private void OnValidate()
	{
		nextPageThreshold = Mathf.Abs(nextPageThreshold);
	}

	[ContextMenu("Execute")]
	public void Recenter()
	{
		if (mScrollView == null)
		{
			mScrollView = NGUITools.FindInParents<UIScrollView>(base.gameObject);
			if (mScrollView == null)
			{
				Debug.LogWarning(string.Concat(GetType(), " requires ", typeof(UIScrollView), " on a parent object in order to work"), this);
				base.enabled = false;
				return;
			}
			if ((bool)mScrollView)
			{
				mScrollView.centerOnChild = this;
				UIScrollView uIScrollView = mScrollView;
				uIScrollView.onDragFinished = (UIScrollView.OnDragNotification)Delegate.Combine(uIScrollView.onDragFinished, new UIScrollView.OnDragNotification(OnDragFinished));
			}
			if (mScrollView.horizontalScrollBar != null)
			{
				UIProgressBar horizontalScrollBar = mScrollView.horizontalScrollBar;
				horizontalScrollBar.onDragFinished = (UIProgressBar.OnDragFinished)Delegate.Combine(horizontalScrollBar.onDragFinished, new UIProgressBar.OnDragFinished(OnDragFinished));
			}
			if (mScrollView.verticalScrollBar != null)
			{
				UIProgressBar verticalScrollBar = mScrollView.verticalScrollBar;
				verticalScrollBar.onDragFinished = (UIProgressBar.OnDragFinished)Delegate.Combine(verticalScrollBar.onDragFinished, new UIProgressBar.OnDragFinished(OnDragFinished));
			}
		}
		if (mScrollView.panel == null)
		{
			return;
		}
		Transform transform = base.transform;
		if (transform.childCount == 0)
		{
			return;
		}
		Vector3[] worldCorners = mScrollView.panel.worldCorners;
		Vector3 vector = (worldCorners[2] + worldCorners[0]) * 0.5f;
		Vector3 velocity = mScrollView.currentMomentum * mScrollView.momentumAmount;
		Vector3 vector2 = NGUIMath.SpringDampen(ref velocity, 9f, 2f);
		Vector3 vector3 = vector - vector2 * 0.01f;
		float num = float.MaxValue;
		Transform target = null;
		int index = 0;
		int num2 = 0;
		int i = 0;
		int childCount = transform.childCount;
		int num3 = 0;
		for (; i < childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (child.gameObject.activeInHierarchy)
			{
				float num4 = Vector3.SqrMagnitude(child.position - vector3);
				if (num4 < num)
				{
					num = num4;
					target = child;
					index = i;
					num2 = num3;
				}
				num3++;
			}
		}
		if (nextPageThreshold > 0f && UICamera.currentTouch != null && mCenteredObject != null && mCenteredObject.transform == transform.GetChild(index))
		{
			Vector3 vector4 = UICamera.currentTouch.totalDelta;
			vector4 = base.transform.rotation * vector4;
			float num5 = 0f;
			switch (mScrollView.movement)
			{
			case UIScrollView.Movement.Horizontal:
				num5 = vector4.x;
				break;
			case UIScrollView.Movement.Vertical:
				num5 = vector4.y;
				break;
			default:
				num5 = vector4.magnitude;
				break;
			}
			if (Mathf.Abs(num5) > nextPageThreshold)
			{
				UIGrid component = GetComponent<UIGrid>();
				if (component != null && component.sorting != 0)
				{
					List<Transform> childList = component.GetChildList();
					if (num5 > nextPageThreshold)
					{
						target = ((num2 <= 0) ? ((!(GetComponent<UIWrapContent>() == null)) ? childList[childList.Count - 1] : childList[0]) : childList[num2 - 1]);
					}
					else if (num5 < 0f - nextPageThreshold)
					{
						target = ((num2 >= childList.Count - 1) ? ((!(GetComponent<UIWrapContent>() == null)) ? childList[0] : childList[childList.Count - 1]) : childList[num2 + 1]);
					}
				}
				else
				{
					Debug.LogWarning("Next Page Threshold requires a sorted UIGrid in order to work properly", this);
				}
			}
		}
		CenterOn(target, vector);
	}

	private void CenterOn(Transform target, Vector3 panelCenter)
	{
		if (target != null && mScrollView != null && mScrollView.panel != null)
		{
			Transform cachedTransform = mScrollView.panel.cachedTransform;
			mCenteredObject = target.gameObject;
			Vector3 vector = cachedTransform.InverseTransformPoint(target.position);
			Vector3 vector2 = cachedTransform.InverseTransformPoint(panelCenter);
			Vector3 vector3 = vector - vector2;
			if (!mScrollView.canMoveHorizontally)
			{
				vector3.x = 0f;
			}
			if (!mScrollView.canMoveVertically)
			{
				vector3.y = 0f;
			}
			vector3.z = 0f;
			SpringPanel.Begin(mScrollView.panel.cachedGameObject, cachedTransform.localPosition - vector3, springStrength).onFinished = onFinished;
		}
		else
		{
			mCenteredObject = null;
		}
		if (onCenter != null)
		{
			onCenter(mCenteredObject);
		}
	}

	public void CenterOn(Transform target)
	{
		if (mScrollView != null && mScrollView.panel != null)
		{
			Vector3[] worldCorners = mScrollView.panel.worldCorners;
			Vector3 panelCenter = (worldCorners[2] + worldCorners[0]) * 0.5f;
			CenterOn(target, panelCenter);
		}
	}
}
