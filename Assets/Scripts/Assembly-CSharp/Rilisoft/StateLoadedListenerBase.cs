using System.Text;
using System.Threading.Tasks;
using UnityEngine;

namespace Rilisoft
{
	internal abstract class StateLoadedListenerBase
	{
		public void OnStateLoaded(bool success, int slot, byte[] data)
		{
			if (data == null)
			{
				data = new byte[0];
			}
			GooglePlayGamesEventArgs googlePlayGamesEventArgs = new GooglePlayGamesEventArgs(success, slot, Encoding.UTF8.GetString(data, 0, data.Length));
			Debug.Log("OnStateLoaded: " + googlePlayGamesEventArgs);
		}

		public byte[] OnStateConflict(int slot, byte[] localData, byte[] serverData)
		{
			if (localData == null)
			{
				localData = new byte[0];
			}
			string @string = Encoding.UTF8.GetString(localData, 0, localData.Length);
			if (serverData == null)
			{
				serverData = new byte[0];
			}
			string string2 = Encoding.UTF8.GetString(serverData, 0, serverData.Length);
			string text = HandleStateConflict(slot, @string, string2);
			GooglePlayGamesEventArgs googlePlayGamesEventArgs = new GooglePlayGamesEventArgs(true, slot, text);
			Debug.Log("OnStateConflict: " + googlePlayGamesEventArgs);
			return Encoding.UTF8.GetBytes(text);
		}

		public void OnStateSaved(bool success, int slot)
		{
			GooglePlayGamesEventArgs googlePlayGamesEventArgs = new GooglePlayGamesEventArgs(success, slot, string.Empty);
			Debug.Log("OnStateSaved: " + googlePlayGamesEventArgs);
		}

		protected abstract string HandleStateConflict(int slot, string localDataString, string serverDataString);
	}
}
