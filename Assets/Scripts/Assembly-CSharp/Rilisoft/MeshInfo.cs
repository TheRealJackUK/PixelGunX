using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class MeshInfo
	{
		private readonly HashSet<MeshFilter> _meshFilters = new HashSet<MeshFilter>();

		public bool AddMeshFilter(MeshFilter meshFilter)
		{
			return _meshFilters.Add(meshFilter);
		}

		public IList<MeshFilter> GetRenderers()
		{
			return _meshFilters.ToList();
		}
	}
}
