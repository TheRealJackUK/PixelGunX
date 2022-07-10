using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

internal sealed class HighAssetsLoader : MonoBehaviour
{
	public static readonly string LightmapsFolder = "Lightmap";

	public static readonly string HighFolder = "High";

	public static readonly string AtlasFolder = "Atlas";

	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
	}

	private void OnLevelWasLoaded(int lev)
	{
		if (Device.isWeakDevice || BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			return;
		}
		string path = ResPath.Combine(ResPath.Combine(LightmapsFolder, HighFolder), Application.loadedLevelName);
		string path2 = ResPath.Combine(ResPath.Combine(AtlasFolder, HighFolder), Application.loadedLevelName);
		Texture2D[] array = Resources.LoadAll<Texture2D>(path);
		if (array != null && array.Length > 0)
		{
			List<Texture2D> list = new List<Texture2D>();
			Texture2D[] array2 = array;
			foreach (Texture2D item in array2)
			{
				list.Add(item);
			}
			list.Sort((Texture2D lightmap1, Texture2D lightmap2) => lightmap1.name.CompareTo(lightmap2.name));
			LightmapData lightmapData = new LightmapData();
			lightmapData.lightmapColor = list[0];
			List<LightmapData> list2 = new List<LightmapData>();
			list2.Add(lightmapData);
			LightmapSettings.lightmaps = list2.ToArray();
		}
		Texture2D[] array3 = Resources.LoadAll<Texture2D>(path2);
		string value = Application.loadedLevelName + "_Atlas";
		if (array3 == null || array3.Length <= 0)
		{
			return;
		}
		Object[] array4 = Object.FindObjectsOfType(typeof(Renderer));
		List<Material> list3 = new List<Material>();
		Object[] array5 = array4;
		for (int j = 0; j < array5.Length; j++)
		{
			Renderer renderer = (Renderer)array5[j];
			if (renderer != null && renderer.sharedMaterial != null && renderer.sharedMaterial.name != null && renderer.sharedMaterial.name.Contains(value) && !list3.Contains(renderer.sharedMaterial))
			{
				list3.Add(renderer.sharedMaterial);
			}
		}
		List<Texture2D> list4 = new List<Texture2D>();
		Texture2D[] array6 = array3;
		foreach (Texture2D item2 in array6)
		{
			list4.Add(item2);
		}
		list3.Sort((Material m1, Material m2) => m1.name.CompareTo(m2.name));
		list4.Sort((Texture2D a1, Texture2D a2) => a1.name.CompareTo(a2.name));
		for (int l = 0; l < Mathf.Min(list3.Count, list4.Count); l++)
		{
			list3[l].mainTexture = list4[l];
		}
	}
}
