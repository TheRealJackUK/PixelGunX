using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class MaterialInfo
	{
		private readonly HashSet<Renderer> _renderers = new HashSet<Renderer>();

		public bool AddRenderer(Renderer renderer)
		{
			return _renderers.Add(renderer);
		}

		public IList<Renderer> GetRenderers()
		{
			return _renderers.ToList();
		}
	}
}
