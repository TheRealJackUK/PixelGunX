using System.Reflection;
using System.Runtime.CompilerServices;
using UnityEngine;

public class BulletTrail : MonoBehaviour
{
	public GameObject myTracer;

	public BulletType type;

	public float bulletSpeed = 200f;

	public float DistanceSqr = 10000f;

	protected bool bool_0;

	protected float float_0 = 0.5f;

	protected Transform transform_0;

	protected Vector3 vector3_0 = Vector3.zero;

	protected readonly Vector3 vector3_1 = new Vector3(-10000f, -10000f, -10000f);

	[CompilerGenerated]
	private Vector3 vector3_2;

	[CompilerGenerated]
	private Vector3 vector3_3;

	[CompilerGenerated]
	private Transform transform_1;

	public Vector3 Vector3_0
	{
		[CompilerGenerated]
		get
		{
			return vector3_2;
		}
		[CompilerGenerated]
		set
		{
			vector3_2 = value;
		}
	}

	public Vector3 Vector3_1
	{
		[CompilerGenerated]
		get
		{
			return vector3_3;
		}
		[CompilerGenerated]
		set
		{
			vector3_3 = value;
		}
	}

	public Transform Transform_0
	{
		[CompilerGenerated]
		get
		{
			return transform_1;
		}
		[CompilerGenerated]
		set
		{
			transform_1 = value;
		}
	}

	private void Start()
	{
		transform_0 = myTracer.transform;
		myTracer.SetActive(false);
	}

	public void StartBullet(Quaternion quaternion_0, Transform transform_2, Vector3 vector3_4)
	{
		Transform_0 = transform_2;
		Vector3_0 = transform_2.position;
		Vector3_1 = vector3_4;
		Invoke("RemoveSelf", float_0);
		transform_0.rotation = quaternion_0;
		transform_0.position = Vector3_0;
		vector3_0 = (Vector3_1 - Vector3_0).normalized * bulletSpeed;
		bool_0 = true;
		myTracer.SetActive(true);
	}

	public void StartBullet(Quaternion quaternion_0, Vector3 vector3_4, Vector3 vector3_5)
	{
		Transform_0 = null;
		Vector3_0 = vector3_4;
		Vector3_1 = vector3_5;
		Invoke("RemoveSelf", float_0);
		transform_0.rotation = quaternion_0;
		transform_0.position = Vector3_0;
		vector3_0 = (Vector3_1 - Vector3_0).normalized * bulletSpeed;
		bool_0 = true;
		myTracer.SetActive(true);
	}

	[Obfuscation(Exclude = true)]
	protected virtual void RemoveSelf()
	{
		CancelInvoke("RemoveSelf");
		myTracer.transform.position = vector3_1;
		myTracer.SetActive(false);
		bool_0 = false;
	}

	protected virtual void Update()
	{
		if (bool_0)
		{
			transform_0.position += vector3_0 * Time.deltaTime;
			if (Vector3.SqrMagnitude(Vector3_0 - transform_0.position) >= DistanceSqr)
			{
				RemoveSelf();
			}
		}
	}
}
