using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using UnityEngine;

namespace Rilisoft
{
	internal static class SslUtils
	{
		internal static bool ValidateServerCertificate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
		{
			if (sslPolicyErrors != 0)
			{
				Debug.LogWarning("SslPolicyError:    " + sslPolicyErrors);
			}
			return true;
		}

		internal static IEnumerable<string> ReadStreamRoutine(Stream stream)
		{
			List<byte> data = new List<byte>(5000);
			byte[] buffer = new byte[128];
			while (true)
			{
				IAsyncResult ar = stream.BeginRead(buffer, 0, buffer.Length, null, null);
				while (!ar.IsCompleted)
				{
					yield return null;
				}
				int bytesReadCount = stream.EndRead(ar);
				if (bytesReadCount <= 0)
				{
					break;
				}
				for (int i = 0; i < bytesReadCount; i++)
				{
					data.Add(buffer[i]);
				}
			}
			string s = Encoding.UTF8.GetString(data.ToArray());
			yield return s ?? string.Empty;
		}
	}
}
