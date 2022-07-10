using LitJson;
using UnityEngine;

public class AdjustBalls : MonoBehaviour
{
	public void DoSomethingWithTheData(JsonData[] ssObjects)
	{
		OptionalMiddleStruct container = default(OptionalMiddleStruct);
		for (int i = 0; i < ssObjects.Length; i++)
		{
			if (ssObjects[i].Keys.Contains("name"))
			{
				container.name = ssObjects[i]["name"].ToString();
			}
			if (ssObjects[i].Keys.Contains("color"))
			{
				container.color = GetColor(ssObjects[i]["color"].ToString());
			}
			if (ssObjects[i].Keys.Contains("drag"))
			{
				container.drag = float.Parse(ssObjects[i]["drag"].ToString());
			}
			UpdateObjectValues(container);
		}
	}

	private void UpdateObjectValues(OptionalMiddleStruct container)
	{
		GameObject gameObject = GameObject.Find(container.name);
		gameObject.GetComponent<Renderer>().sharedMaterial.color = container.color;
		gameObject.GetComponent<Rigidbody>().drag = container.drag;
	}

	private Color GetColor(string color)
	{
		switch (color)
		{
		case "black":
			return Color.black;
		case "blue":
			return Color.blue;
		case "clear":
			return Color.clear;
		case "cyan":
			return Color.cyan;
		case "gray":
			return Color.gray;
		case "green":
			return Color.green;
		case "grey":
			return Color.grey;
		case "magenta":
			return Color.magenta;
		case "red":
			return Color.red;
		case "white":
			return Color.white;
		case "yellow":
			return Color.yellow;
		default:
			return Color.grey;
		}
	}

	public void ResetBalls()
	{
		OptionalMiddleStruct container = default(OptionalMiddleStruct);
		container.color = Color.white;
		container.drag = 0f;
		string text = "Ball";
		for (int i = 1; i < 4; i++)
		{
			container.name = text + i;
			UpdateObjectValues(container);
		}
	}
}
