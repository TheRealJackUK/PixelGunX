using UnityEngine;
using System;

namespace engine.unity
{
	public class BaseWindow : MonoBehaviour
	{
		[Serializable]
		public class ChildPanel
		{
			public UIPanel Panel;
			public int RelativeZ;
		}

		public ChildPanel[] ChildPanels;
	}
}
