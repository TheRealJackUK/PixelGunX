using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft.MiniJson;
using UnityEngine;

public class TouchPadInJoystick : MonoBehaviour
{
	public Transform fireSprite;

	public bool _isShooting;

	public InGameGUI inGameGUI;

	public bool isActiveFireButton;

	private Rect _fireRect = default(Rect);

	private bool _shouldRecalcRects;

	private bool _isFirstFrame = true;

	private HungerGameController _hungerGameController;

	private bool _isTraining;

	private bool _joyActive = true;

	private Player_move_c _playerMoveC;

	private IEnumerator ReCalcRects()
	{
		yield return null;
		yield return null;
		CalcRects();
	}

	public void SetJoystickActive(bool active)
	{
		_joyActive = active;
		if (!active)
		{
			_isShooting = false;
		}
	}

	private void OnEnable()
	{
		_isShooting = false;
		if (_shouldRecalcRects)
		{
			StartCoroutine(ReCalcRects());
		}
		_shouldRecalcRects = false;
		StartCoroutine(_SetIsFirstFrame());
	}

	private IEnumerator _SetIsFirstFrame()
	{
		float tm = Time.realtimeSinceStartup;
		do
		{
			yield return null;
		}
		while (Time.realtimeSinceStartup - tm < 0.1f);
		_isFirstFrame = false;
	}

	private IEnumerator Start()
	{
		_isTraining = Defs.IsTraining;
		if (Defs.isHunger)
		{
			_hungerGameController = GameObject.FindGameObjectWithTag("HungerGameController").GetComponent<HungerGameController>();
		}
		PauseNGUIController.PlayerHandUpdated += SetSideAndCalcRects;
		ControlsSettingsBase.ControlsChanged += SetShouldRecalcRects;
		yield return null;
		yield return null;
		CalcRects();
	}

	private void SetSideAndCalcRects()
	{
		SetShouldRecalcRects();
	}

	private void SetShouldRecalcRects()
	{
		_shouldRecalcRects = true;
	}

	private bool IsActiveFireButton()
	{
		if (_isTraining || Defs.isTurretWeapon)
		{
			return false;
		}
		if (Defs.gameSecondFireButtonMode == Defs.GameSecondFireButtonMode.On)
		{
			return true;
		}
		if (Defs.gameSecondFireButtonMode == Defs.GameSecondFireButtonMode.Sniper && _playerMoveC != null && _playerMoveC.isZooming)
		{
			return true;
		}
		return false;
	}

	private void Update()
	{
		if (_playerMoveC == null)
		{
			if (Defs.isMulti && WeaponManager.sharedManager != null && WeaponManager.sharedManager.myPlayer != null)
			{
				_playerMoveC = WeaponManager.sharedManager.myPlayerMoveC;
			}
			else
			{
				GameObject gameObject = GameObject.FindGameObjectWithTag("Player");
				if (gameObject != null)
				{
					_playerMoveC = gameObject.GetComponent<SkinName>().playerMoveC;
				}
			}
		}
		if (!_joyActive)
		{
			_isShooting = false;
			return;
		}
		isActiveFireButton = IsActiveFireButton();
		if (_isShooting && inGameGUI.playerMoveC != null && isActiveFireButton && (!_isTraining || TrainingController.stepTraining >= TrainingController.stepTrainingList["TapToShoot"]) && (!Defs.isHunger || _hungerGameController.isGo))
		{
			inGameGUI.playerMoveC.ShotPressed();
		}
		if (isActiveFireButton != fireSprite.gameObject.activeSelf)
		{
			fireSprite.gameObject.SetActive(isActiveFireButton);
		}
	}

	private void OnPress(bool isDown)
	{
		if (!_joyActive || inGameGUI.playerMoveC == null)
		{
			return;
		}
		if (_fireRect.width.Equals(0f))
		{
			CalcRects();
		}
		if (!_isFirstFrame)
		{
			if (isDown && _fireRect.Contains(UICamera.lastTouchPosition))
			{
				_isShooting = true;
			}
			if (!isDown)
			{
				_isShooting = false;
			}
		}
	}

	private void CalcRects()
	{
		Transform transform = NGUITools.GetRoot(base.gameObject).transform;
		Camera camera = transform.GetChild(0).GetChild(0).GetComponent<Camera>();
		Transform relativeTo = camera.transform;
		float num = 768f;
		float num2 = num * ((float)Screen.width / (float)Screen.height);
		List<object> list = Json.Deserialize(PlayerPrefs.GetString("Controls.Size", "[]")) as List<object>;
		if (list == null)
		{
			list = new List<object>();
			Debug.LogWarning(list.GetType().FullName);
		}
		int[] array = list.Select(Convert.ToInt32).ToArray();
		Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(relativeTo, fireSprite, true);
		float num3 = 60f;
		if (array.Length > 6)
		{
			num3 = (float)array[6] * 0.5f;
		}
		bounds.center += new Vector3(num2 * 0.5f, num * 0.5f, 0f);
		_fireRect = new Rect((bounds.center.x - num3) * Defs.Coef, (bounds.center.y - num3) * Defs.Coef, 2f * num3 * Defs.Coef, 2f * num3 * Defs.Coef);
	}

	private void OnDestroy()
	{
		PauseNGUIController.PlayerHandUpdated -= SetSideAndCalcRects;
		ControlsSettingsBase.ControlsChanged -= SetShouldRecalcRects;
	}
}
