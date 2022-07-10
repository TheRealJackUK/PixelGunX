using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Rilisoft.MiniJson;

namespace Rilisoft
{
	internal sealed class ListLoadedListener : StateLoadedListenerBase
	{
		protected override string HandleStateConflict(int slot, string localDataString, string serverDataString)
		{
			IEnumerable enumerable = Json.Deserialize(localDataString) as IEnumerable;
			if (enumerable == null)
			{
				enumerable = new string[0];
			}
			IEnumerable enumerable2 = Json.Deserialize(serverDataString) as IEnumerable;
			if (enumerable2 == null)
			{
				enumerable2 = new string[0];
			}
			List<string> obj = enumerable.OfType<string>().Concat(enumerable2.OfType<string>()).Distinct()
				.ToList();
			return Json.Serialize(obj);
		}
	}
}
