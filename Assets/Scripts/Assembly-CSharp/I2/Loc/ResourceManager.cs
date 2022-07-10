using System;
using System.Collections.Generic;
using UnityEngine;

namespace I2.Loc
{
	public class ResourceManager : MonoBehaviour
	{
		private static ResourceManager mInstance;

		public UnityEngine.Object[] Assets;

		private Dictionary<string, UnityEngine.Object> mResourcesCache = new Dictionary<string, UnityEngine.Object>();

		private bool mCleaningScheduled;

		public static ResourceManager pInstance
		{
			get
			{
				if (mInstance == null)
				{
					mInstance = (ResourceManager)UnityEngine.Object.FindObjectOfType(typeof(ResourceManager));
				}
				if (mInstance == null)
				{
					GameObject gameObject = new GameObject("I2ResourceManager", typeof(ResourceManager));
					gameObject.hideFlags |= HideFlags.HideAndDontSave;
					mInstance = gameObject.GetComponent<ResourceManager>();
				}
				UnityEngine.Object.DontDestroyOnLoad(mInstance.gameObject);
				return mInstance;
			}
		}

		public T GetAsset<T>(string Name) where T : UnityEngine.Object
		{
			T val = FindAsset(Name) as T;
			if ((UnityEngine.Object)val != (UnityEngine.Object)null)
			{
				return val;
			}
			return LoadFromResources<T>(Name);
		}

		private UnityEngine.Object FindAsset(string Name)
		{
			if (Assets != null)
			{
				int i = 0;
				for (int num = Assets.Length; i < num; i++)
				{
					if (Assets[i] != null && Assets[i].name == Name)
					{
						return Assets[i];
					}
				}
			}
			return null;
		}

		public bool HasAsset(UnityEngine.Object Obj)
		{
			if (Assets == null)
			{
				return false;
			}
			return Array.IndexOf(Assets, Obj) >= 0;
		}

		public T LoadFromResources<T>(string Path) where T : UnityEngine.Object
		{
			UnityEngine.Object value;
			if (mResourcesCache.TryGetValue(Path, out value) && value != null)
			{
				return value as T;
			}
			T val = Resources.Load<T>(Path);
			mResourcesCache[Path] = val;
			if (!mCleaningScheduled)
			{
				Invoke("CleanResourceCache", 0.1f);
				mCleaningScheduled = true;
			}
			return val;
		}

		public void CleanResourceCache()
		{
			mResourcesCache.Clear();
			CancelInvoke();
			mCleaningScheduled = false;
		}
	}
}
