using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Boo.Lang;
using UnityEngine;

[Serializable]
public class FireFade : MonoBehaviour
{
	[Serializable]
	[CompilerGenerated]
	internal sealed class _0024Start_002442 : GenericGenerator<WaitForSeconds>
	{
		[Serializable]
		[CompilerGenerated]
		internal sealed class _0024 : GenericGeneratorEnumerator<WaitForSeconds>, IEnumerator
		{
			internal FireFade _0024self__002443;

			public _0024(FireFade self_)
			{
				_0024self__002443 = self_;
			}

			public override bool MoveNext()
			{
				int result;
				switch (_state)
				{
				default:
					result = (Yield(2, new WaitForSeconds(_0024self__002443.smokeDestroyTime)) ? 1 : 0);
					break;
				case 2:
					_0024self__002443.destroyEnabled = true;
					YieldDefault(1);
					goto case 1;
				case 1:
					result = 0;
					break;
				}
				return (byte)result != 0;
			}
		}

		internal FireFade _0024self__002444;

		public _0024Start_002442(FireFade self_)
		{
			_0024self__002444 = self_;
		}

		public override IEnumerator<WaitForSeconds> GetEnumerator()
		{
			return new _0024(_0024self__002444);
		}
	}

	public float smokeDestroyTime;

	public float destroySpeed;

	private bool destroyEnabled;

	public FireFade()
	{
		smokeDestroyTime = 6f;
		destroySpeed = 0.05f;
	}

	public virtual IEnumerator Start()
	{
		return new _0024Start_002442(this).GetEnumerator();
	}

	public virtual void Update()
	{
		if (destroyEnabled)
		{
			ParticleSystem particleRenderer = (ParticleSystem)GetComponent(typeof(ParticleSystem));
			//color.a -= destroySpeed * Time.deltaTime;
		}
	}

	public virtual void Main()
	{
	}
}
