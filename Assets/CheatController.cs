using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheatController : MonoBehaviour
{
    public UILabel idLabel;
    public static GameObject[] GetDontDestroyOnLoadObjects()
	{
		GameObject temp = null;
		try
		{
			temp = new GameObject();
			UnityEngine.Object.DontDestroyOnLoad( temp );
			UnityEngine.SceneManagement.Scene dontDestroyOnLoad = temp.scene;
			UnityEngine.Object.DestroyImmediate( temp );
			temp = null;
			return dontDestroyOnLoad.GetRootGameObjects();
		}
		finally
		{
			if( temp != null )
				UnityEngine.Object.DestroyImmediate( temp );
		}
	}

	void Start () {
		foreach (GameObject gobj in GetDontDestroyOnLoadObjects()){
			UnityEngine.Object.Destroy(gobj);
		}
        idLabel.text = "Your user ID: " + PlayerPrefs.GetString("AccountCreated", "");
	}

    // Update is called once per frame
    void Update()
    {
        
    }
}
