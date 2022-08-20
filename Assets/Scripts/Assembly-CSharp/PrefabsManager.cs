using UnityEngine;
using System;
using UnityEngine.Rendering.PostProcessing;

public class PrefabsManager : MonoBehaviour {
    
    public static PrefabsManager instance;
    public string curScene = string.Empty;
    public Material weeze;
    
    void Awake() {
        instance = this;
        DontDestroyOnLoad(gameObject);
    }

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

    public void FixedUpdate(){
        if (Application.loadedLevelName != curScene){
            curScene = Application.loadedLevelName;
            //GameObject.Instantiate(Resources.Load<GameObject>("PPV"), new Vector3(0, 0, 0), Quaternion.identity);
            //if (Application.isPlaying) {
                bool lo = false;
                /*foreach (GameObject gobj in Resources.FindObjectsOfTypeAll<GameObject>()){
                    if (gobj.GetComponent<PostProcessVolume>()){
                        lo = true;
                    }
                }*/
                /*if (curScene == "AppCenter" || curScene == "Loading" || curScene == "PromScene"){
                    lo = true;
                }*/
                if (!lo){
                    foreach (GameObject gobj in Resources.FindObjectsOfTypeAll<GameObject>()){
                        if (!gobj.name.Contains("(Clone)") && !gobj.name.Contains("Camera")){
                            bool jugf = false;
                            foreach (GameObject c in GetDontDestroyOnLoadObjects()) {
                                if (gobj.name.Equals(c)) {
                                    jugf = true;
                                }
                            }
                            if (!jugf){
                                if (gobj.layer == 0) {
                                    gobj.layer = 29;
                                }
                            }
                        }
                    }
                    GameObject.Instantiate(Resources.Load<GameObject>("PPV"), new Vector3(0, 0, 0), Quaternion.identity);
                }
            //}
            foreach (GameObject gobj in Resources.FindObjectsOfTypeAll<GameObject>()){
                if (gobj.GetComponent<PostProcessVolume>()){
                    bool bloom = Storager.getInt("bloom", false) == 1;
                    bool ao = Storager.getInt("ao", false) == 1;
                    bool cg = Storager.getInt("cg", false) == 1;
                    bool mb = Storager.getInt("mb", false) == 1;
                    PostProcessVolume volume = gobj.GetComponent<PostProcessVolume>();
                    // Type type = abc.GetType().GetGenericArguments()[0];
                    UnityEngine.Rendering.PostProcessing.Bloom bloomLayer;
                    volume.profile.TryGetSettings(out bloomLayer);
                    bloomLayer.enabled.value = bloom;
                    AmbientOcclusion aoLayer;
                    volume.profile.TryGetSettings(out aoLayer);
                    aoLayer.enabled.value = ao;
                    ColorGrading cgLayer;
                    volume.profile.TryGetSettings(out cgLayer);
                    cgLayer.enabled.value = cg;
                    UnityEngine.Rendering.PostProcessing.MotionBlur mbLayer;
                    volume.profile.TryGetSettings(out mbLayer);
                    mbLayer.enabled.value = mb;
                }
            }
        }
    }
    
    public Material getWeeze() {
        return weeze;
    }
}