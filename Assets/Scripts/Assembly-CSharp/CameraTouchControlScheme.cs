using UnityEngine;

public abstract class CameraTouchControlScheme
{
	protected Vector2 _deltaPosition;

	public Vector2 DeltaPosition
	{
		get
		{
			return _deltaPosition;
		}
	}

	public virtual void OnPress(bool isDown)
	{
	}

	public virtual void OnDrag(Vector2 delta)
	{
	}

	public virtual void OnUpdate()
	{
	}

	public void ResetDelta()
	{
		_deltaPosition = Vector2.zero;
	}

	public abstract void Reset();

	public abstract void ApplyDeltaTo(Vector2 deltaPosition, Transform yawTransform, Transform pitchTransform, float sensitivity, bool invert);
}
