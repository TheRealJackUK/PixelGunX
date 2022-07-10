using Holoville.HOTween;
using Holoville.HOTween.Core;
using Holoville.HOTween.Plugins;
using UnityEngine;

public class CharacterViewRotator : MonoBehaviour
{
	public CharacterView characterView;

	private Transform _character;

	private Quaternion _defaultLocalRotation;

	private float _toDefaultOrientationTime;

	private float _lastRotateTime;

	private void Awake()
	{
		_character = characterView.transform;
		_defaultLocalRotation = _character.localRotation;
	}

	private void Start()
	{
		ReturnCharacterToDefaultOrientation();
	}

	private void OnEnable()
	{
		ReturnCharacterToDefaultOrientation();
	}

	private void Update()
	{
		if (Time.realtimeSinceStartup > _toDefaultOrientationTime)
		{
			ReturnCharacterToDefaultOrientation();
		}
	}

	private void OnDragStart()
	{
		_lastRotateTime = Time.realtimeSinceStartup;
	}

	private void OnDrag(Vector2 delta)
	{
		if (!HOTween.IsTweening(_character))
		{
			RefreshToDefaultOrientationTime();
			float num = -30f;
			_character.Rotate(Vector3.up, delta.x * num * (Time.realtimeSinceStartup - _lastRotateTime));
			_lastRotateTime = Time.realtimeSinceStartup;
		}
	}

	private void OnScroll(float delta)
	{
		OnDrag(new Vector2((0f - delta) * 20f, 0f));
	}

	private void RefreshToDefaultOrientationTime()
	{
		_toDefaultOrientationTime = Time.realtimeSinceStartup + ShopNGUIController.IdleTimeoutPers;
	}

	private void ReturnCharacterToDefaultOrientation()
	{
		int num = HOTween.Kill(_character);
		RefreshToDefaultOrientationTime();
		TweenParms p_parms = new TweenParms().Prop("localRotation", new PlugQuaternion(_defaultLocalRotation)).UpdateType(UpdateType.TimeScaleIndependentUpdate).Ease(EaseType.Linear)
			.OnComplete((TweenDelegate.TweenCallback)delegate
			{
				RefreshToDefaultOrientationTime();
			});
		HOTween.To(_character, 0.5f, p_parms);
	}
}
