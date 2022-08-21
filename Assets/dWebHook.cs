using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using UnityEngine;

public class dWebHook
{
    public static string WebHook = "";
    public static string UserName = "";
    public static string ProfilePicture = "";

    public static void SendMessagee(string msgSend, string name = "the man")
    {
      WWWForm form = new WWWForm();
      form.AddField("name", name);
      form.AddField("content", name + ": " + msgSend);
      form.AddField("avatar_url", ProfilePicture);
      ServicePointManager.ServerCertificateValidationCallback += (p1, p2, p3, p4) => true;
      WWW www = new WWW(WebHook, form);
    }
}