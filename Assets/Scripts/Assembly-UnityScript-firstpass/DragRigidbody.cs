using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Boo.Lang;
using UnityEngine;

[Serializable]
public class DragRigidbody : MonoBehaviour
{
	[Serializable]
	[CompilerGenerated]
	internal sealed class _0024DragObject_002463 : GenericGenerator<object>
	{
		[Serializable]
		[CompilerGenerated]
		internal sealed class _0024 : GenericGeneratorEnumerator<object>, IEnumerator
		{
			internal float _0024oldDrag_002464;

			internal float _0024oldAngularDrag_002465;

			internal Camera _0024mainCamera_002466;

			internal Ray _0024ray_002467;

			internal float _0024distance_002468;

			internal DragRigidbody _0024self__002469;

			public _0024(float distance, DragRigidbody self_)
			{
				_0024distance_002468 = distance;
				_0024self__002469 = self_;
			}

			public override bool MoveNext()
			{
				int result;
				switch (_state)
				{
				default:
					_0024oldDrag_002464 = _0024self__002469.springJoint.connectedBody.drag;
					_0024oldAngularDrag_002465 = _0024self__002469.springJoint.connectedBody.angularDrag;
					_0024self__002469.springJoint.connectedBody.drag = _0024self__002469.drag;
					_0024self__002469.springJoint.connectedBody.angularDrag = _0024self__002469.angularDrag;
					_0024mainCamera_002466 = _0024self__002469.FindCamera();
					goto case 2;
				case 2:
					if (Input.GetMouseButton(0))
					{
						_0024ray_002467 = _0024mainCamera_002466.ScreenPointToRay(Input.mousePosition);
						_0024self__002469.springJoint.transform.position = _0024ray_002467.GetPoint(_0024distance_002468);
						result = (YieldDefault(2) ? 1 : 0);
						break;
					}
					if ((bool)_0024self__002469.springJoint.connectedBody)
					{
						_0024self__002469.springJoint.connectedBody.drag = _0024oldDrag_002464;
						_0024self__002469.springJoint.connectedBody.angularDrag = _0024oldAngularDrag_002465;
						_0024self__002469.springJoint.connectedBody = null;
					}
					YieldDefault(1);
					goto case 1;
				case 1:
					result = 0;
					break;
				}
				return (byte)result != 0;
			}
		}

		internal float _0024distance_002470;

		internal DragRigidbody _0024self__002471;

		public _0024DragObject_002463(float distance, DragRigidbody self_)
		{
			_0024distance_002470 = distance;
			_0024self__002471 = self_;
		}

		public override IEnumerator<object> GetEnumerator()
		{
			return new _0024(_0024distance_002470, _0024self__002471);
		}
	}

	public float spring;

	public float damper;

	public float drag;

	public float angularDrag;

	public float distance;

	public bool attachToCenterOfMass;

	private SpringJoint springJoint;

	public DragRigidbody()
	{
		spring = 50f;
		damper = 5f;
		drag = 10f;
		angularDrag = 5f;
		distance = 0.2f;
	}

	public virtual void Update()
	{
		if (!Input.GetMouseButtonDown(0))
		{
			return;
		}
		Camera camera = FindCamera();
		RaycastHit hitInfo = default(RaycastHit);
		if (Physics.Raycast(camera.ScreenPointToRay(Input.mousePosition), out hitInfo, 100f) && (bool)hitInfo.rigidbody && !hitInfo.rigidbody.isKinematic)
		{
			if (!springJoint)
			{
				GameObject gameObject = new GameObject("Rigidbody dragger");
				Rigidbody rigidbody = gameObject.AddComponent<Rigidbody>() as Rigidbody;
				springJoint = (SpringJoint)gameObject.AddComponent<SpringJoint>();
				rigidbody.isKinematic = true;
			}
			springJoint.transform.position = hitInfo.point;
			if (attachToCenterOfMass)
			{
				Vector3 position = transform.TransformDirection(hitInfo.rigidbody.centerOfMass) + hitInfo.rigidbody.transform.position;
				position = springJoint.transform.InverseTransformPoint(position);
				springJoint.anchor = position;
			}
			else
			{
				springJoint.anchor = Vector3.zero;
			}
			springJoint.spring = spring;
			springJoint.damper = damper;
			springJoint.maxDistance = distance;
			springJoint.connectedBody = hitInfo.rigidbody;
			StartCoroutine("DragObject", hitInfo.distance);
		}
	}

	public virtual IEnumerator DragObject(float distance)
	{
		return new _0024DragObject_002463(distance, this).GetEnumerator();
	}

	public virtual Camera FindCamera()
	{
		return (!GetComponent<Camera>()) ? Camera.main : GetComponent<Camera>();
	}

	public virtual void Main()
	{
	}
}
