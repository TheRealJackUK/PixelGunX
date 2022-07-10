using System;

namespace Rilisoft
{
	public class VerificationEventArgs : EventArgs
	{
		public VerificationErrorCode ErrorCode { get; set; }

		public int SentNonce { get; set; }

		public string SentPackageName { get; set; }

		public string ReceivedPackageName { get; set; }

		public int ReceivedNonce { get; set; }

		public ResponseCode ReceivedResponseCode { get; set; }

		public long ReceivedTimestamp { get; set; }

		public string ReceivedUserId { get; set; }

		public int ReceivedVersionCode { get; set; }
	}
}
