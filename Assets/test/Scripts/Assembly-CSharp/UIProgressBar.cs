using UnityEngine;
using System.Collections.Generic;

public class UIProgressBar : UIWidgetContainer
{
	public enum FillDirection
	{
		LeftToRight = 0,
		RightToLeft = 1,
		BottomToTop = 2,
		TopToBottom = 3,
	}

	public Transform transform_0;
	[SerializeField]
	protected UIWidget uiwidget_0;
	[SerializeField]
	protected UIWidget uiwidget_1;
	[SerializeField]
	protected float float_0;
	[SerializeField]
	protected FillDirection fillDirection_0;
	public int int_0;
	public List<EventDelegate> list_0;
}
