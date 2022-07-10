using System;
using System.Reflection;
using Rilisoft;
using UnityEngine;

internal sealed class AddCamFX : MonoBehaviour
{
	private void Start()
	{
		if (Device.isWeakDevice || Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.WP8Player || (BuildSettings.BuildTarget == BuildTarget.Android && !Device.GpuRatingIsAtLeast(4)))
		{
			return;
		}
		GameObject gameObject = GameObject.FindGameObjectWithTag("CamFX");
		if (!(gameObject != null) || !(gameObject.GetComponent<CamFXSetting>().CamFX != null))
		{
			return;
		}
		Component[] components = gameObject.GetComponent<CamFXSetting>().CamFX.GetComponents<Component>();
		Component[] array = components;
		foreach (Component component in array)
		{
			if (component.GetType() != typeof(Camera) && component.GetType() != typeof(Transform))
			{
				CopyComponent(component, base.gameObject);
			}
		}
		Debug.Log("_camFXComponents" + components);
	}

	private Component CopyComponent(Component original, GameObject destination)
	{
		Type type = original.GetType();
		Component component = destination.AddComponent(type);
		FieldInfo[] fields = type.GetFields();
		FieldInfo[] array = fields;
		foreach (FieldInfo fieldInfo in array)
		{
			fieldInfo.SetValue(component, fieldInfo.GetValue(original));
		}
		return component;
	}
}
