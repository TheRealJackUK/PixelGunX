using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestingRandomBullshit : MonoBehaviour
{
    void Start()
    {
        WWWForm form = new WWWForm();
		form.AddField("action", "create_player");
		form.AddField("platform", "lu");
		form.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
		string hash = "lmao";
		form.AddField("auth", hash);
		form.AddField("token", "tooken");
		WWW download = new WWW("http://oldpg3d.7m.pl/~pgx/newaction.php", form);
        while (!download.isDone){

        }
        Debug.LogWarning(download.text);
    }
}
