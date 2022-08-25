using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GlobalMessageNGUIController : MonoBehaviour
{
    public UIPanel mainPanel;
    public UILabel usernameLabel;
    public UILabel messageLabel;

    IEnumerator TestForGM() {
        string prevName = PlayerPrefs.GetString("lastGMName");
        string prevMsg = PlayerPrefs.GetString("lastGMMsg");
        WWW a = new WWW("https://oldpg3d.7m.pl/~pgx/msg");
        WWW b = new WWW("https://oldpg3d.7m.pl/~pgx/name");
        yield return new WaitForSeconds(1);
        if (prevName.Trim() != b.text.Trim() && prevMsg.Trim() != a.text.Trim()) {
            PlayerPrefs.SetString("lastGMName", b.text.Trim());
            PlayerPrefs.SetString("lastGMMsg", a.text.Trim());
            usernameLabel.text = "Global message from " + b.text + ":";
            messageLabel.text = a.text;
            Debug.LogError("recieved message from " + b.text + " saying " + a.text);
            StartCoroutine(FoundGM());
        }
        yield return new WaitForSeconds(2);
        StartCoroutine(TestForGM());
        yield break;
    }

    IEnumerator FoundGM() {
        mainPanel.gameObject.SetActive(true);
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
        
    }
}
