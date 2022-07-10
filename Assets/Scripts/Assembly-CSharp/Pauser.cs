using System;
using UnityEngine;

internal sealed class Pauser : MonoBehaviour
{
	private Action OnPlayerAddedAction;

	public bool pausedVar;

	public bool paused
	{
		get
		{
			return pausedVar;
		}
		set
		{
			pausedVar = value;
			if (!(JoystickController.leftJoystick == null) && !(JoystickController.rightJoystick == null))
			{
				if (pausedVar)
				{
					JoystickController.leftJoystick.transform.parent.gameObject.SetActive(false);
					JoystickController.rightJoystick.gameObject.SetActive(false);
				}
				else
				{
					JoystickController.leftJoystick.transform.parent.gameObject.SetActive(true);
					JoystickController.rightJoystick.gameObject.SetActive(true);
				}
			}
		}
	}

	private void Start()
	{
		OnPlayerAddedAction = delegate
		{
		};
		Initializer.PlayerAddedEvent += OnPlayerAddedAction;
	}

	private void OnDestroy()
	{
		Initializer.PlayerAddedEvent -= OnPlayerAddedAction;
	}
}
