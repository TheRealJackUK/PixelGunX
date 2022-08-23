using System.Collections;
using System.Collections.Generic;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using UnityEngine;
using System;

public class ChatWebhook : MonoBehaviour {
	public string webhookUrl;
	public static ChatWebhook instance;

	public void Start() {
		DontDestroyOnLoad(gameObject);
		instance = this;
	}

	public bool MyRemoteCertificateValidationCallback(System.Object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
	{
		bool isOk = true;
		return isOk;
	}

	public void SendMessagee(string message, string name) {
		//dcWeb.ProfilePicture = "https://static.giantbomb.com/uploads/original/4/42381/1196379-gas_mask_respirator.jpg";
		dWebHook.UserName = name;
		dWebHook.WebHook = webhookUrl;
		ServicePointManager.ServerCertificateValidationCallback += (p1, p2, p3, p4) => true;
		dWebHook.SendMessagee(message, name);
	}
}
