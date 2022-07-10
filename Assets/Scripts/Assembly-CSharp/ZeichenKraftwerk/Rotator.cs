using UnityEngine;

namespace ZeichenKraftwerk
{
	public sealed class Rotator : MonoBehaviour
	{
		public Vector3 eulersPerSecond = new Vector3(0f, 0f, 1f);

		private Transform myTransform;

		public void Start()
		{
			myTransform = base.transform;
		}

		private void Update()
		{
			myTransform.Rotate(eulersPerSecond * RealTime.deltaTime);
		}
	}
}
