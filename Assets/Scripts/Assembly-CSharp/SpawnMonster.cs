using System;
using System.Collections;
using UnityEngine;

public class SpawnMonster : MonoBehaviour
{
	public bool shouldMove = true;

	public bool isCycle;

	public GameObject[] _targetCyclePoints;

	private int _targetIndex;

	private float _minDist = 5f;

	private Vector2 _spawnPoint;

	private float _lastTimeGo = -1f;

	private float _timeForIdle = 2f;

	private Vector3 _targetPoint;

	private Rect _moveBounds;

	private float halbLength = 17f;

	private float _dst;

	private GameObject _modelChild;

	private Sounds _soundClips;

	private UnityEngine.AI.NavMeshAgent _nma;

	public bool ShouldMove
	{
		get
		{
			return shouldMove;
		}
		set
		{
			if (shouldMove != value)
			{
				shouldMove = value;
				if (shouldMove)
				{
					ResetPars();
					SendMessage("Walk");
				}
			}
		}
	}

	private void Awake()
	{
		if (Defs.isCOOP)
		{
			base.enabled = false;
		}
	}

	private void Start()
	{
		_nma = GetComponent<UnityEngine.AI.NavMeshAgent>();
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
		if (!isCycle)
		{
			_spawnPoint = new Vector2(base.transform.position.x, base.transform.position.z);
		}
		ShouldMove = false;
		ShouldMove = true;
		_moveBounds = new Rect(0f - halbLength, 0f - halbLength, halbLength * 2f, halbLength * 2f);
	}

	private void Update()
	{
		if (shouldMove && _lastTimeGo <= Time.time)
		{
			_nma.ResetPath();
			_targetPoint = new Vector3(0f - halbLength + UnityEngine.Random.Range(0f, halbLength * 2f), base.transform.position.y, 0f - halbLength + UnityEngine.Random.Range(0f, halbLength * 2f));
			_lastTimeGo = Time.time + Vector3.Distance(base.transform.position, _targetPoint) / _soundClips.notAttackingSpeed + _timeForIdle;
			base.transform.LookAt(_targetPoint);
			_nma.SetDestination(_targetPoint);
			_nma.speed = _soundClips.notAttackingSpeed;
		}
	}

	private void ResetPars()
	{
		_targetIndex = 0;
		_lastTimeGo = -1f;
	}
}
