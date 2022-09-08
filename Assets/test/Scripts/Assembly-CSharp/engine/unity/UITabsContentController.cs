using UnityEngine;
using System.Collections.Generic;

namespace engine.unity
{
	public class UITabsContentController : MonoBehaviour
	{
		public Color activeTabColor;
		public Color inactiveTabColor;
		public UITab defaultTab;
		public bool activateDefaultOnStart;
		public List<UITab> tabs;
		public List<UITabContent> contents;
	}
}
