using System;

namespace Rilisoft
{
	internal sealed class MessageEventArgs : EventArgs
	{
		public Message Message { get; set; }
	}
}
