using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Boo.Lang;
using UnityEngine;
using UnityScript.Lang;

[Serializable]
public class DestroyRubble : MonoBehaviour
{
	[Serializable]
	[CompilerGenerated]
	internal sealed class _0024Start_002438
	{
		[Serializable]
		[CompilerGenerated]
		internal sealed class _0024
		{
			internal int _0024i_002439;

			internal DestroyRubble _0024self__002440;

			public _0024(DestroyRubble self_)
			{
				_0024self__002440 = self_;
			}

			public bool MoveNext1()
			{
				return false;
			}
		}

		internal DestroyRubble _0024self__002441;

		public _0024Start_002438(DestroyRubble self_)
		{
			_0024self__002441 = self_;
		}
	}

	public float maxTime;

	public ParticleSystem[] particleEmitters;

	public float time;

	public DestroyRubble()
	{
		maxTime = 3f;
	}

	public virtual void Main()
	{
	}
}
