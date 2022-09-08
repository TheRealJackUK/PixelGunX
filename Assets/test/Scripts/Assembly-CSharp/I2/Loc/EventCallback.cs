using System;
using UnityEngine;

namespace I2.Loc
{
	[Serializable]
	public class EventCallback
	{
		public MonoBehaviour Target;
		public string MethodName;
	}
}
