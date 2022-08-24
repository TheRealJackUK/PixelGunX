using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Boo.Lang;
using UnityEngine;

[Serializable]
public class Move : MonoBehaviour
{
	[Serializable]
	[CompilerGenerated]
	internal sealed class _0024Start_002445 : GenericGenerator<WaitForSeconds>
	{
		[Serializable]
		[CompilerGenerated]
		internal sealed class _0024 : GenericGeneratorEnumerator<WaitForSeconds>, IEnumerator
		{
			internal Move _0024self__002446;

			public _0024(Move self_)
			{
				_0024self__002446 = self_;
			}

			public override bool MoveNext()
			{
				int result;
				switch (_state)
				{
				default:
					result = (Yield(2, new WaitForSeconds(_0024self__002446.smokeDestroyTime)) ? 1 : 0);
					break;
				case 2:
					_0024self__002446.destroyEnabled = true;
					YieldDefault(1);
					goto case 1;
				case 1:
					result = 0;
					break;
				}
				return (byte)result != 0;
			}
		}

		internal Move _0024self__002447;

		public _0024Start_002445(Move self_)
		{
			_0024self__002447 = self_;
		}

		public override IEnumerator<WaitForSeconds> GetEnumerator()
		{
			return new _0024(_0024self__002447);
		}
	}

	public Transform target;

	public float speed;

	public float smokeDestroyTime;

	public ParticleSystem smokeStem;

	public float destroySpeed;

	public float destroySpeedStem;

	private bool destroyEnabled;

	public virtual IEnumerator Start()
	{
		return new _0024Start_002445(this).GetEnumerator();
	}

	public virtual void Update()
	{
		transform.position = Vector3.Lerp(transform.position, target.position, Time.deltaTime * speed);
		if (destroyEnabled)
		{		
		ParticleSystemRenderer psr;
		ParticleSystem.MainModule settings;
		if (destroyEnabled && GetComponent<ParticleSystemRenderer>() != null)
		{
			psr = GetComponent<ParticleSystemRenderer>();
			Color rgba = psr.material.GetColor("_TintColor");
			settings = GetComponent<ParticleSystem>().main;
			ParticleSystem particleRenderer = (ParticleSystem)GetComponent(typeof(ParticleSystem));
			if (!(rgba.a <= 0f))
			{
				rgba.a -= destroySpeed * Time.deltaTime;
			}
			if (!(rgba.a <= 0f))
			{
				rgba.a -= destroySpeedStem * Time.deltaTime;
			}
			settings.startColor = new ParticleSystem.MinMaxGradient( rgba );
					if (!(rgba.a >= 0f))
		{
			UnityEngine.Object.Destroy(transform.root.gameObject);
		}
		}
		}
	}

	public virtual void Main()
	{
	}
}
