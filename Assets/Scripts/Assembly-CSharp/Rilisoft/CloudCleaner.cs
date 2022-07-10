using System;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class CloudCleaner
	{
		private static CloudCleaner _instance;

		public static CloudCleaner Instance
		{
			get
			{
				if (_instance == null)
				{
					_instance = new CloudCleaner();
				}
				return _instance;
			}
		}

		public void CleanSlot(int slot)
		{
		}

		public void CleanSavedGameFile(string filename)
		{
			if (string.IsNullOrEmpty(filename))
			{
				throw new ArgumentException("Filename should not be empty", filename);
			}
			else
			{
				Debug.LogWarning("Saved game client is null.");
			}
		}

		public void OnStateLoaded(bool success, int slot, byte[] data)
		{
			string message = string.Format("CloudCleaner.OnStateLoaded(success: {0}, slot: {1}, data: {2}).", success, slot, data);
			Debug.Log(message);
		}

		public byte[] OnStateConflict(int slot, byte[] localData, byte[] serverData)
		{
			string message = string.Format("CloudCleaner.OnStateConflict(slot: {0}, localData: {1}, serverData: {2}).", slot, localData, serverData);
			Debug.Log(message);
			return new byte[0];
		}

		public void OnStateSaved(bool success, int slot)
		{
			string message = string.Format("CloudCleaner.OnStateSaved(success: {0}, slot: {1}).", success, slot);
			Debug.Log(message);
		}
	}
}
