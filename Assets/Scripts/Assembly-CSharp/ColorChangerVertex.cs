using UnityEngine;

public class ColorChangerVertex : MonoBehaviour
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
		for (int i = 0; i < meshColors.Length; i++)
		{
			float magnitude = mesh.vertices[i].magnitude;
			float r = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad + magnitude));
			float g = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 0.45f + magnitude));
			float b = Mathf.Abs(Mathf.Sin(Time.timeSinceLevelLoad * 1.2f + magnitude));
			Color color = new Color(r, g, b);
			meshColors[i] = color;
		}
		mesh.colors = meshColors;
	}
}
