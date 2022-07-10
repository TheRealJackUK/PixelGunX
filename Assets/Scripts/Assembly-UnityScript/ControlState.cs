using System;

[Serializable]
public enum ControlState
{
	WaitingForFirstTouch,
	WaitingForSecondTouch,
	MovingCharacter,
	WaitingForMovement,
	ZoomingCamera,
	RotatingCamera,
	WaitingForNoFingers
}
