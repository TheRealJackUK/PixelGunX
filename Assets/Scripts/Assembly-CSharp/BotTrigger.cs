using System;
using System.Collections;
using UnityEngine;

public class BotTrigger : MonoBehaviour
{
	public bool shouldDetectPlayer = true;

	private bool _entered;

	private BotAI _eai;

	private GameObject _player;

	private Player_move_c _playerMoveC;

	private GameObject _modelChild;

	private Sounds _soundClips;

	private Transform myTransform;

	private void Awake()
	{
		if (Defs.isCOOP)
		{
			base.enabled = false;
		}
	}

	private void Start()
	{
		myTransform = base.transform;
		IEnumerator enumerator = base.transform.GetEnumerator();
		try
		{
			if (enumerator.MoveNext())
			{
				Transform transform = (Transform)enumerator.Current;
				_modelChild = transform.gameObject;
			}
		}
		finally
		{
			IDisposable disposable = enumerator as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
		_soundClips = _modelChild.GetComponent<Sounds>();
		_eai = GetComponent<BotAI>();
		_player = GameObject.FindGameObjectWithTag("Player");
		if (_player != null)
		{
			_playerMoveC = _player.GetComponent<SkinName>().playerMoveC;
		}
	}

	private void Update()
	{
		if (!shouldDetectPlayer)
		{
			return;
		}
		if (!_entered)
		{
			GameObject gameObject = GameObject.FindGameObjectWithTag("Turret");
			if (gameObject != null && gameObject.GetComponent<TurretController>() != null && (gameObject.GetComponent<TurretController>().isKilled || !gameObject.GetComponent<TurretController>().isRun))
			{
				gameObject = null;
			}
			float num = ((!(gameObject != null)) ? 1E+09f : Vector3.Distance(myTransform.position, gameObject.transform.position));
			bool flag = gameObject != null && num <= _soundClips.detectRadius;
			float num2 = Vector3.Distance(myTransform.position, _player.transform.position);
			bool flag2 = !_playerMoveC.isInvisible && num2 <= _soundClips.detectRadius;
			Transform transform = null;
			if (flag2 && flag)
			{
				transform = ((!(num2 < num)) ? gameObject.transform : _player.transform);
			}
			else
			{
				if (flag2)
				{
					transform = _player.transform;
				}
				if (flag)
				{
					transform = gameObject.transform;
				}
			}
			if (transform != null)
			{
				_eai.SetTarget(transform, true);
				_entered = true;
			}
		}
		else if (_eai.Target == null || (_eai.Target.CompareTag("Player") && (_playerMoveC.isInvisible || (_entered && Vector3.SqrMagnitude(base.transform.position - _player.transform.position) > _soundClips.detectRadius * _soundClips.detectRadius))) || (_eai.Target.CompareTag("Turret") && _eai.Target.GetComponent<TurretController>().isKilled && _eai.Target.GetComponent<TurretController>().isRun))
		{
			_eai.SetTarget(null, false);
			_entered = false;
		}
	}
}
