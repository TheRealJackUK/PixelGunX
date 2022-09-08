using UnityEngine;
using AnimationOrTween;
using System.Collections.Generic;

public class UIPlayTween : MonoBehaviour
{
	public GameObject tweenTarget;
	public int tweenGroup;
	public Trigger trigger;
	public Direction playDirection;
	public bool resetOnPlay;
	public bool resetIfDisabled;
	public EnableCondition ifDisabledOnPlay;
	public DisableCondition disableWhenFinished;
	public bool includeChildren;
	public List<EventDelegate> onFinished;
	[SerializeField]
	private GameObject gameObject_0;
	[SerializeField]
	private string string_0;
}
