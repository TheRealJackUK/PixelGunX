using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using WebSocketSharp;

public class WebSocket
{
	private Uri mUrl;

	private WebSocketSharp.WebSocket m_Socket;

	private Queue<byte[]> m_Messages = new Queue<byte[]>();

	private bool m_IsConnected;

	private string m_Error;

	public bool Connected
	{
		get
		{
			return m_IsConnected;
		}
	}

	public string Error
	{
		get
		{
			return m_Error;
		}
	}

	public WebSocket(Uri url)
	{
		mUrl = url;
		string scheme = mUrl.Scheme;
		if (!scheme.Equals("ws") && !scheme.Equals("wss"))
		{
			throw new ArgumentException("Unsupported protocol: " + scheme);
		}
	}

	public void SendString(string str)
	{
		Send(Encoding.UTF8.GetBytes(str));
	}

	public string RecvString()
	{
		byte[] array = Recv();
		if (array == null)
		{
			return null;
		}
		return Encoding.UTF8.GetString(array);
	}

	public IEnumerator Connect()
	{
		m_Socket = new WebSocketSharp.WebSocket(mUrl.ToString(), "GpBinaryV16");
		m_Socket.OnMessage += delegate(object sender, MessageEventArgs e)
		{
			m_Messages.Enqueue(e.RawData);
		};
		m_Socket.OnOpen += delegate
		{
			m_IsConnected = true;
		};
		m_Socket.OnError += delegate(object sender, ErrorEventArgs e)
		{
			m_Error = e.Message + ((e.Exception != null) ? (" / " + e.Exception) : string.Empty);
		};
		m_Socket.ConnectAsync();
		while (!m_IsConnected && m_Error == null)
		{
			yield return 0;
		}
	}

	public void Send(byte[] buffer)
	{
		m_Socket.Send(buffer);
	}

	public byte[] Recv()
	{
		if (m_Messages.Count == 0)
		{
			return null;
		}
		return m_Messages.Dequeue();
	}

	public void Close()
	{
		m_Socket.Close();
	}
}
