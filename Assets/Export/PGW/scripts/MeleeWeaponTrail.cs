using System.Collections.Generic;
using UnityEngine;

public class MeleeWeaponTrail : MonoBehaviour
{
	public class Point
	{
		public float float_0;

		public Vector3 vector3_0;

		public Vector3 vector3_1;

		public bool bool_0;
	}

	[SerializeField]
	private bool bool_0 = true;

	[SerializeField]
	private float float_0;

	[SerializeField]
	private Material material_0;

	[SerializeField]
	private float float_1 = 1f;

	[SerializeField]
	private Color[] color_0;

	[SerializeField]
	private float[] float_2;

	[SerializeField]
	private float float_3 = 0.1f;

	[SerializeField]
	private float float_4 = 10f;

	[SerializeField]
	private float float_5 = 3f;

	[SerializeField]
	private bool bool_1;

	[SerializeField]
	private int int_0 = 4;

	[SerializeField]
	private Transform transform_0;

	[SerializeField]
	private Transform transform_1;

	private List<Point> list_0 = new List<Point>();

	private List<Point> list_1 = new List<Point>();

	private GameObject gameObject_0;

	private Mesh mesh_0;

	private Vector3 vector3_0;

	private Vector3 vector3_1;

	private Vector3 vector3_2;

	private bool bool_2 = true;

	public bool Boolean_0
	{
		set
		{
			bool_0 = value;
		}
	}

	private void Start()
	{
		vector3_0 = base.transform.position;
		gameObject_0 = new GameObject("Trail");
		gameObject_0.transform.parent = null;
		gameObject_0.transform.position = Vector3.zero;
		gameObject_0.transform.rotation = Quaternion.identity;
		gameObject_0.transform.localScale = Vector3.one;
		gameObject_0.AddComponent(typeof(MeshFilter));
		gameObject_0.AddComponent(typeof(MeshRenderer));
		gameObject_0.GetComponent<Renderer>().material = material_0;
		mesh_0 = new Mesh();
		mesh_0.name = base.name + "TrailMesh";
		gameObject_0.GetComponent<MeshFilter>().mesh = mesh_0;
	}

	private void OnDisable()
	{
		Object.Destroy(gameObject_0);
	}

	private void Update()
	{
		if (bool_0 && float_0 != 0f)
		{
			float_0 -= Time.deltaTime;
			if (float_0 == 0f)
			{
				float_0 = -1f;
			}
			if (float_0 < 0f)
			{
				bool_0 = false;
			}
		}
		if (!bool_0 && list_0.Count == 0 && bool_1)
		{
			Object.Destroy(gameObject_0);
			Object.Destroy(base.gameObject);
		}
		if (!Camera.main)
		{
			return;
		}
		float magnitude = (vector3_0 - base.transform.position).magnitude;
		if (bool_0)
		{
			if (magnitude > float_3)
			{
				bool flag = false;
				if (list_0.Count < 3)
				{
					flag = true;
				}
				else
				{
					Vector3 from = list_0[list_0.Count - 2].vector3_1 - list_0[list_0.Count - 3].vector3_1;
					Vector3 to = list_0[list_0.Count - 1].vector3_1 - list_0[list_0.Count - 2].vector3_1;
					if (Vector3.Angle(from, to) > float_5 || magnitude > float_4)
					{
						flag = true;
					}
				}
				if (flag)
				{
					Point point = new Point();
					point.vector3_0 = transform_0.position;
					point.vector3_1 = transform_1.position;
					point.float_0 = Time.time;
					list_0.Add(point);
					vector3_0 = base.transform.position;
					if (list_0.Count == 1)
					{
						list_1.Add(point);
					}
					else if (list_0.Count > 1)
					{
						for (int i = 0; i < 1 + int_0; i++)
						{
							list_1.Add(point);
						}
					}
					if (list_0.Count == 4)
					{
						IEnumerable<Vector3> collection = Interpolate.NewCatmullRom(new Vector3[4]
						{
							list_0[list_0.Count - 4].vector3_1,
							list_0[list_0.Count - 3].vector3_1,
							list_0[list_0.Count - 2].vector3_1,
							list_0[list_0.Count - 1].vector3_1
						}, int_0, false);
						IEnumerable<Vector3> collection2 = Interpolate.NewCatmullRom(new Vector3[4]
						{
							list_0[list_0.Count - 4].vector3_0,
							list_0[list_0.Count - 3].vector3_0,
							list_0[list_0.Count - 2].vector3_0,
							list_0[list_0.Count - 1].vector3_0
						}, int_0, false);
						List<Vector3> list = new List<Vector3>(collection);
						List<Vector3> list2 = new List<Vector3>(collection2);
						float from2 = list_0[list_0.Count - 4].float_0;
						float to2 = list_0[list_0.Count - 1].float_0;
						for (int j = 0; j < list.Count; j++)
						{
							int num = list_1.Count - (list.Count - j);
							if (num > -1 && num < list_1.Count)
							{
								Point point2 = new Point();
								point2.vector3_0 = list2[j];
								point2.vector3_1 = list[j];
								point2.float_0 = Mathf.Lerp(from2, to2, (float)j / (float)list.Count);
								list_1[num] = point2;
							}
						}
					}
				}
				else
				{
					list_0[list_0.Count - 1].vector3_0 = transform_0.position;
					list_0[list_0.Count - 1].vector3_1 = transform_1.position;
					list_1[list_1.Count - 1].vector3_0 = transform_0.position;
					list_1[list_1.Count - 1].vector3_1 = transform_1.position;
				}
			}
			else
			{
				if (list_0.Count > 0)
				{
					list_0[list_0.Count - 1].vector3_0 = transform_0.position;
					list_0[list_0.Count - 1].vector3_1 = transform_1.position;
				}
				if (list_1.Count > 0)
				{
					list_1[list_1.Count - 1].vector3_0 = transform_0.position;
					list_1[list_1.Count - 1].vector3_1 = transform_1.position;
				}
			}
		}
		if (!bool_0 && bool_2 && list_0.Count > 0)
		{
			list_0[list_0.Count - 1].bool_0 = true;
		}
		bool_2 = bool_0;
		List<Point> list3 = new List<Point>();
		foreach (Point item in list_0)
		{
			if (Time.time - item.float_0 > float_1)
			{
				list3.Add(item);
			}
		}
		foreach (Point item2 in list3)
		{
			list_0.Remove(item2);
		}
		list3 = new List<Point>();
		foreach (Point item3 in list_1)
		{
			if (Time.time - item3.float_0 > float_1)
			{
				list3.Add(item3);
			}
		}
		foreach (Point item4 in list3)
		{
			list_1.Remove(item4);
		}
		List<Point> list4 = list_1;
		if (list4.Count > 1)
		{
			Vector3[] array = new Vector3[list4.Count * 2];
			Vector2[] array2 = new Vector2[list4.Count * 2];
			int[] array3 = new int[(list4.Count - 1) * 6];
			Color[] array4 = new Color[list4.Count * 2];
			for (int k = 0; k < list4.Count; k++)
			{
				Point point3 = list4[k];
				float num2 = (Time.time - point3.float_0) / float_1;
				Color color = Color.Lerp(Color.white, Color.clear, num2);
				if (color_0 != null && color_0.Length > 0)
				{
					float num3 = num2 * (float)(color_0.Length - 1);
					float num4 = Mathf.Floor(num3);
					float num5 = Mathf.Clamp(Mathf.Ceil(num3), 1f, color_0.Length - 1);
					float t = Mathf.InverseLerp(num4, num5, num3);
					if (num4 >= (float)color_0.Length)
					{
						num4 = color_0.Length - 1;
					}
					if (num4 < 0f)
					{
						num4 = 0f;
					}
					if (num5 >= (float)color_0.Length)
					{
						num5 = color_0.Length - 1;
					}
					if (num5 < 0f)
					{
						num5 = 0f;
					}
					color = Color.Lerp(color_0[(int)num4], color_0[(int)num5], t);
				}
				float num6 = 0f;
				if (float_2 != null && float_2.Length > 0)
				{
					float num7 = num2 * (float)(float_2.Length - 1);
					float num8 = Mathf.Floor(num7);
					float num9 = Mathf.Clamp(Mathf.Ceil(num7), 1f, float_2.Length - 1);
					float t2 = Mathf.InverseLerp(num8, num9, num7);
					if (num8 >= (float)float_2.Length)
					{
						num8 = float_2.Length - 1;
					}
					if (num8 < 0f)
					{
						num8 = 0f;
					}
					if (num9 >= (float)float_2.Length)
					{
						num9 = float_2.Length - 1;
					}
					if (num9 < 0f)
					{
						num9 = 0f;
					}
					num6 = Mathf.Lerp(float_2[(int)num8], float_2[(int)num9], t2);
				}
				Vector3 vector = point3.vector3_1 - point3.vector3_0;
				array[k * 2] = point3.vector3_0 - vector * (num6 * 0.5f);
				array[k * 2 + 1] = point3.vector3_1 + vector * (num6 * 0.5f);
				array4[k * 2] = (array4[k * 2 + 1] = color);
				float x = (float)k / (float)list4.Count;
				array2[k * 2] = new Vector2(x, 0f);
				array2[k * 2 + 1] = new Vector2(x, 1f);
				if (k > 0)
				{
					array3[(k - 1) * 6] = k * 2 - 2;
					array3[(k - 1) * 6 + 1] = k * 2 - 1;
					array3[(k - 1) * 6 + 2] = k * 2;
					array3[(k - 1) * 6 + 3] = k * 2 + 1;
					array3[(k - 1) * 6 + 4] = k * 2;
					array3[(k - 1) * 6 + 5] = k * 2 - 1;
				}
			}
			mesh_0.Clear();
			mesh_0.vertices = array;
			mesh_0.colors = array4;
			mesh_0.uv = array2;
			mesh_0.triangles = array3;
		}
		else
		{
			mesh_0.Clear();
		}
	}
}
