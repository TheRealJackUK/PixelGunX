using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

internal sealed class MessagesController : MonoBehaviour
{
	private const string ActionAddress = "http://oldpg3d.7m.pl/~pgx/newaction.php";

	private bool _cancellationToken = true;

	private readonly Dictionary<string, List<Rilisoft.Message>> _incomingMessages = new Dictionary<string, List<Rilisoft.Message>>();

	private readonly Dictionary<string, List<Rilisoft.Message>> _outgoingMessages = new Dictionary<string, List<Rilisoft.Message>>();

	private static MessagesController _instance;

	public IDictionary<string, List<Rilisoft.Message>> IncomingMessages
	{
		get
		{
			return _incomingMessages;
		}
	}

	public IDictionary<string, List<Rilisoft.Message>> OutgoingMessages
	{
		get
		{
			return _outgoingMessages;
		}
	}

	public static MessagesController Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = UnityEngine.Object.FindObjectOfType<MessagesController>();
				if (_instance == null)
				{
					GameObject gameObject = new GameObject("MessagesController");
					_instance = gameObject.AddComponent<MessagesController>();
					UnityEngine.Object.DontDestroyOnLoad(gameObject);
				}
			}
			return _instance;
		}
	}

	public void ReceiveMessages(string receiverId)
	{
		if (string.IsNullOrEmpty(receiverId))
		{
			return;
		}
		Action<WWW> callback = delegate(WWW download)
		{
			if (!string.IsNullOrEmpty(download.error))
			{
				Debug.LogWarning("Error while receiving messages: " + download.error);
			}
			else
			{
				string text = URLs.Sanitize(download);
				if (!string.IsNullOrEmpty(text))
				{
					if (Application.isEditor)
					{
						Debug.Log("ReceiveMessages(): " + text);
					}
					IList list = Json.Deserialize(text) as IList;
					if (list != null && list.Count != 0)
					{
						IEnumerable<Dictionary<string, object>> enumerable = list.OfType<Dictionary<string, object>>();
						if (enumerable != null && enumerable.Any())
						{
							Dictionary<string, List<Rilisoft.Message>> dictionary = new Dictionary<string, List<Rilisoft.Message>>();
							foreach (Dictionary<string, object> item in enumerable)
							{
								try
								{
									string text2 = item["who"] as string;
									if (!string.IsNullOrEmpty(text2))
									{
										string senderName = null;
										Dictionary<string, object> value;
										object value2;
										if (FriendsController.sharedController.playersInfo.TryGetValue(text2, out value) && value.TryGetValue("player", out value2))
										{
											Dictionary<string, object> dictionary2 = value2 as Dictionary<string, object>;
											if (dictionary2 != null && dictionary2.Any())
											{
												senderName = dictionary2["nick"] as string;
											}
										}
										DateTimeOffset result = DateTimeOffset.UtcNow;
										object value3;
										if (item.TryGetValue("time", out value3))
										{
											DateTimeOffset.TryParse(value3 as string, out result);
										}
										Rilisoft.Message message = new Rilisoft.Message
										{
											SenderName = senderName,
											SenderId = text2,
											Text = (item["message"] as string),
											Timestamp = result
										};
										List<Rilisoft.Message> value4;
										if (!dictionary.TryGetValue(text2, out value4))
										{
											value4 = new List<Rilisoft.Message>();
											dictionary.Add(text2, value4);
										}
										if (Application.isEditor)
										{
											Debug.Log("ReceiveMessages(): Added message from " + message.SenderId);
										}
										value4.Add(message);
										goto IL_0274;
									}
								}
								catch (KeyNotFoundException ex)
								{
									StringBuilder stringBuilder = new StringBuilder(ex.ToString());
									if (ex.Data != null)
									{
										stringBuilder.AppendLine();
										foreach (DictionaryEntry datum in ex.Data)
										{
											stringBuilder.AppendFormat("{0}: {1}\n", datum.Key, datum.Value);
										}
									}
									Debug.LogWarning(stringBuilder.ToString());
									goto IL_0274;
								}
								continue;
								IL_0274:
								foreach (KeyValuePair<string, List<Rilisoft.Message>> item2 in dictionary)
								{
									List<Rilisoft.Message> list2 = new List<Rilisoft.Message>(item2.Value.OrderBy((Rilisoft.Message m) => m.Timestamp));
									int num = 0;
									foreach (Rilisoft.Message item3 in list2)
									{
										item3.Timestamp = DateTimeOffset.UtcNow + TimeSpan.FromMilliseconds(num++);
									}
									item2.Value.Clear();
									item2.Value.AddRange(list2);
								}
								foreach (KeyValuePair<string, List<Rilisoft.Message>> item4 in dictionary)
								{
									List<Rilisoft.Message> value5;
									if (!_incomingMessages.TryGetValue(item4.Key, out value5))
									{
										value5 = item4.Value;
										_incomingMessages.Add(item4.Key, value5);
									}
									else
									{
										value5.AddRange(item4.Value);
									}
								}
							}
						}
					}
				}
			}
		};
		StartCoroutine(ReceiveMessagesCoroutine(receiverId, callback));
	}

	public void SaveOutgoingMessage(string receiverId, Rilisoft.Message message)
	{
		if (!string.IsNullOrEmpty(receiverId))
		{
			List<Rilisoft.Message> value;
			if (!_outgoingMessages.TryGetValue(receiverId, out value))
			{
				value = new List<Rilisoft.Message>();
				_outgoingMessages.Add(receiverId, value);
			}
			value.Add(message);
		}
	}

	public void SendChatMessage(string senderId, string receiverId, string message)
	{
		if (string.IsNullOrEmpty(senderId) || string.IsNullOrEmpty(receiverId) || string.IsNullOrEmpty(message))
		{
			return;
		}
		Action<WWW> callback = delegate(WWW download)
		{
			if (!string.IsNullOrEmpty(download.error))
			{
				Debug.LogWarning("Error while sending message: " + download.error);
			}
			else
			{
				string text = URLs.Sanitize(download);
				if (!string.IsNullOrEmpty(text) && text.Equals("fail", StringComparison.InvariantCultureIgnoreCase))
				{
					Debug.LogWarning("SendMessages failed.");
				}
			}
		};
		StartCoroutine(SendMessageCoroutine(senderId, receiverId, message, callback));
	}

	public void ScheduleReceivingMessages(string receiverId)
	{
		if (!string.IsNullOrEmpty(receiverId))
		{
			_cancellationToken = false;
			StartCoroutine(RefreshIncomingMessagesCoroutine(receiverId));
		}
	}

	public void UnscheduleReceivingMessages()
	{
		_cancellationToken = true;
	}

	public void SaveCurrentState()
	{
		Func<Rilisoft.Message, Dictionary<string, string>> selector = (Rilisoft.Message m) => new Dictionary<string, string>
		{
			{ "message", m.Text },
			{
				"timestamp",
				m.Timestamp.DateTime.ToString("o")
			},
			{ "who", m.SenderName }
		};
		if (_incomingMessages != null && _incomingMessages.Count > 0)
		{
			int count = Math.Max(0, _incomingMessages.Count - 10);
			StringBuilder stringBuilder = new StringBuilder("{ ");
			foreach (KeyValuePair<string, List<Rilisoft.Message>> incomingMessage in _incomingMessages)
			{
				List<Dictionary<string, string>> obj = incomingMessage.Value.Skip(count).Select(selector).ToList();
				stringBuilder.AppendFormat("\"{0}\": {1}, ", incomingMessage.Key, Json.Serialize(obj));
			}
			stringBuilder.Remove(stringBuilder.Length - 2, 2);
			stringBuilder.Append(" }");
			PlayerPrefs.SetString("IncomingMessages", stringBuilder.ToString());
		}
		if (_outgoingMessages == null || _outgoingMessages.Count <= 0)
		{
			return;
		}
		int count2 = Math.Max(0, _outgoingMessages.Count - 10);
		StringBuilder stringBuilder2 = new StringBuilder("{ ");
		foreach (KeyValuePair<string, List<Rilisoft.Message>> outgoingMessage in _outgoingMessages)
		{
			List<Dictionary<string, string>> obj2 = outgoingMessage.Value.Skip(count2).Select(selector).ToList();
			stringBuilder2.AppendFormat("\"{0}\": {1}, ", Json.Serialize(obj2));
		}
		stringBuilder2.Remove(stringBuilder2.Length - 2, 2);
		stringBuilder2.Append(" }");
		PlayerPrefs.SetString("OutgoingMessages", stringBuilder2.ToString());
	}

	private void DumpCurrentState()
	{
		SaveCurrentState();
		_incomingMessages.Clear();
		_outgoingMessages.Clear();
	}

	private static void LoadCurrentState(string key, IDictionary<string, List<Rilisoft.Message>> dict)
	{
		if (!Storager.hasKey(key))
		{
			Storager.setString(key, "{}", false);
		}
		string @string = Storager.getString(key, false);
		Dictionary<string, object> dictionary = Json.Deserialize(@string) as Dictionary<string, object>;
		if (dictionary == null || dictionary.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<string, object> item in dictionary)
		{
			List<Rilisoft.Message> value = new List<Rilisoft.Message>();
			Dictionary<string, string> dictionary2 = item.Value as Dictionary<string, string>;
			if (dictionary2 != null)
			{
				DateTimeOffset result = default(DateTimeOffset);
				string value2;
				if (dictionary2.TryGetValue("timestamp", out value2))
				{
					DateTimeOffset.TryParse("timestamp", out result);
				}
				string value3 = string.Empty;
				dictionary2.TryGetValue("who", out value3);
				string value4 = string.Empty;
				dictionary2.TryGetValue("message", out value4);
				Rilisoft.Message message = new Rilisoft.Message();
				message.SenderId = value3;
				message.Text = value4;
				message.Timestamp = result;
				Rilisoft.Message message2 = message;
				dict.Add(item.Key, value);
			}
		}
	}

	private IEnumerator ReceiveMessagesCoroutine(string receiverId, Action<WWW> callback)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "get_all_messages");
		form.AddField("id", receiverId);
		form.AddField("uniq_id", FriendsController.sharedController.id);
		form.AddField("auth", FriendsController.Hash("get_all_messages"));
		WWW download = new WWW("http://oldpg3d.7m.pl/~pgx/newaction.php", form);
		yield return download;
		callback(download);
	}

	private IEnumerator RefreshIncomingMessagesCoroutine(string receiverId)
	{
		while (!_cancellationToken)
		{
			ReceiveMessages(receiverId);
			yield return new WaitForSeconds(5f);
		}
	}

	private IEnumerator SendMessageCoroutine(string senderId, string receiverId, string message, Action<WWW> callback)
	{
		WWWForm form = new WWWForm();
		form.AddField("action", "send_message");
		form.AddField("who", senderId);
		form.AddField("whom", receiverId);
		form.AddField("message", message);
		form.AddField("uniq_id", FriendsController.sharedController.id);
		form.AddField("auth", FriendsController.Hash("send_message"));
		if (Application.isEditor)
		{
			Debug.Log(string.Format("Sender: {0}, Receiver: {1}, Message: {2}", senderId, receiverId, message));
		}
		WWW download = new WWW("http://oldpg3d.7m.pl/~pgx/newaction.php", form);
		yield return download;
		callback(download);
	}

	private void Start()
	{
		LoadCurrentState("IncomingMessages", _incomingMessages);
		LoadCurrentState("OutgoingMessages", _outgoingMessages);
	}

	private void OnApplicationQuit()
	{
		DumpCurrentState();
	}

	private void OnApplicationPause(bool pause)
	{
		if (pause)
		{
			SaveCurrentState();
		}
	}

	private void OnDestroy()
	{
		DumpCurrentState();
	}
}
