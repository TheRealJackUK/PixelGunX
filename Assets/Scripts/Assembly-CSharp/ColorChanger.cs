using UnityEngine;

public class ColorChanger : MonoBehaviour
{
	private Mesh mesh;

	private Color[] meshColors;

	private void Start()
	{
		mesh = GetComponent<MeshFilter>().mesh;
		meshColors = new Color[mesh.vertices.Length];
	}

	private void Update()
	{
		float num = base.transform.position.magnitude / 3f;
		float r = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad + num));
		float g = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 0.45f + num));
		float b = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 1.2f + num));
		Color color = new Color(r, g, b);
		for (int i = 0; i < meshColors.Length; i++)
		{
			meshColors[i] = color;
		}
		mesh.colors = meshColors;
	}
}
