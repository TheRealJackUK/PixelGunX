using System;

namespace Rilisoft
{
	internal sealed class Message
	{
		public string SenderId { get; set; }

		public string SenderName { get; set; }

		public DateTimeOffset Timestamp { get; set; }

		public string Text { get; set; }
	}
}
