using System;

namespace Rilisoft
{
	internal sealed class GooglePlayGamesEventArgs : EventArgs
	{
		private string _data;

		private int _slot;

		private bool _succeeded;

		public string Data
		{
			get
			{
				return _data;
			}
		}

		public int Slot
		{
			get
			{
				return _slot;
			}
		}

		public bool Succeeded
		{
			get
			{
				return _succeeded;
			}
		}

		public GooglePlayGamesEventArgs(bool succeeded, int slot, string data)
		{
			_succeeded = succeeded;
			_slot = slot;
			_data = data ?? string.Empty;
		}

		public override string ToString()
		{
			return (!_succeeded) ? "<Failed>" : string.Format("Slot: {0}, Data: “{1}”", _slot, _data);
		}
	}
}
