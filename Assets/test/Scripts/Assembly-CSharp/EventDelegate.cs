using System;
using UnityEngine;

[Serializable]
public class EventDelegate
{
	[Serializable]
	public class Parameter
	{
		public Object obj;
		public string field;
	}

	[SerializeField]
	private MonoBehaviour monoBehaviour_0;
	[SerializeField]
	private string string_0;
	[SerializeField]
	private Parameter[] parameter_0;
	public bool oneShot;
}
