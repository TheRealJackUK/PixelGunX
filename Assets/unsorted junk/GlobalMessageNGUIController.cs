using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GlobalMessageNGUIController : MonoBehaviour
{
    public UIPanel mainPanel;
    public UILabel usernameLabel;
    public UILabel messageLabel;

    IEnumerator TestForGM() {
        /*string prevName = PlayerPrefs.GetString("lastGMName").Trim();
        string prevMsg = PlayerPrefs.GetString("lastGMMsg").Trim();
        WWW a = new WWW("https://oldpg3d.7m.pl/~pgx/msg");
        WWW b = new WWW("https://oldpg3d.7m.pl/~pgx/name");
        for (;;) {
            if (a.isDone && b.isDone) {
                break;
            }
        }
        string name = b.text.Trim();
        string msg = a.text.Trim();
        if ((prevName.Equals(name)) && (prevMsg.Equals(msg))) {
            //Debug.LogError("recieved message from " + b.text + " saying " + a.text + " BUT " + prevName + " == " + b.text + " and " + prevMsg + " == " + a.text);
        }else{
            PlayerPrefs.SetString("lastGMName", b.text.Trim());
            PlayerPrefs.SetString("lastGMMsg", a.text.Trim());
            usernameLabel.text = "Global message from " + b.text + ":";
            messageLabel.text = a.text;
            //Debug.LogError("recieved message from " + b.text + " saying " + a.text);
            StartCoroutine(FoundGM());
        }
        yield return new WaitForSeconds(2);
        StartCoroutine(TestForGM());*/
        yield break;
    }

    IEnumerator FoundGM() {
        //mainPanel.gameObject.SetActive(true);
        yield return new WaitForSeconds(4);
        mainPanel.gameObject.SetActive(false);
        yield break;
    }

    void Start() {
        mainPanel.gameObject.SetActive(false);
        DontDestroyOnLoad(gameObject);
        StartCoroutine(TestForGM());
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.V)) {
            GameObject.Instantiate(Resources.Load<GameObject>("DevtestMenu"), new Vector3(0, 0, 0), Quaternion.identity);
        }
    }
}
