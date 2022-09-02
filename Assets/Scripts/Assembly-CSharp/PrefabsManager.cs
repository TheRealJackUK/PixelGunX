using UnityEngine;
using System;
using UnityEngine.Rendering.PostProcessing;

public class PrefabsManager : MonoBehaviour {
    
    public static PrefabsManager instance;
    public string curScene = string.Empty;
    public Material weeze;
    public GameObject ppv;
    public static string the = string.Empty;
    
    void Awake() {
        the = Application.version;
        instance = this;
        the = Application.version;
        ppv = GameObject.Instantiate(Resources.Load<GameObject>("PPV"), new Vector3(0, 0, 0), Quaternion.identity);
        DontDestroyOnLoad(gameObject);
        DontDestroyOnLoad(ppv);
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
            if (PlayerPrefs.GetInt("isExploring") == 1) {
                GameObject.Instantiate(Resources.Load<GameObject>("ExploreCamera"), new Vector3(0, 0, 0), Quaternion.identity);
            }
            if (curScene == "LevelComplete" || curScene == "ChooseLevel")
            {
                return;
            }
            //GameObject.Instantiate(Resources.Load<GameObject>("PPV"), new Vector3(0, 0, 0), Quaternion.identity);
            //if (Application.isPlaying) {
                bool lo = false;
                foreach (GameObject gobj in Resources.FindObjectsOfTypeAll<GameObject>()){
                    if (gobj.GetComponent<PostProcessVolume>()){
                        if (!gobj.name.Contains("(Clone)") && !gobj.name.Contains("Camera")){
                            lo = true;
                        }
                    }
                }
                if (Application.loadedLevelName == "AppCenter" || Application.loadedLevelName == "Loading" || Application.loadedLevelName == "PromScene"){
                    lo = true;
                }
                if (!lo){
                    ppv.SetActive(true);
                    foreach (GameObject gobj in Resources.FindObjectsOfTypeAll<GameObject>()){
                        if (!gobj.name.Contains("(Clone)") && !gobj.name.Contains("Camera")){
                            bool jugf = false;
                            foreach (GameObject c in GetDontDestroyOnLoadObjects()) {
                                if (gobj.name.Equals(c)) {
                                    jugf = true;
                                }
                            }
                            if (!jugf){
                                if (!LayerMask.LayerToName(gobj.layer).ToLower().Contains("ngui") && !LayerMask.LayerToName(gobj.layer).ToLower().Contains("label") && !LayerMask.LayerToName(gobj.layer).ToLower().Contains("skin") && !LayerMask.LayerToName(gobj.layer).ToLower().Contains("game") && !LayerMask.LayerToName(gobj.layer).ToLower().Contains("star") && !LayerMask.LayerToName(gobj.layer).ToLower().Contains("shine") && !LayerMask.LayerToName(gobj.layer).ToLower().Contains("exp")){
                                    gobj.layer = 29;
                                }
                            }
                        }
                    }
                    // GameObject.Instantiate(Resources.Load<GameObject>("PPV"), new Vector3(0, 0, 0), Quaternion.identity);
                }else{
                    ppv.SetActive(false);
                }
            //}
            foreach (GameObject gobj in Resources.FindObjectsOfTypeAll<GameObject>()){
                if (gobj.GetComponent<PostProcessVolume>()){
                    try {
                        bool bloom = Storager.getInt("bloom", false) == 1;
                        bool ao = Storager.getInt("ao", false) == 1;
                        bool cg = Storager.getInt("cg", false) == 1;
                        bool mb = Storager.getInt("mb", false) == 1;
                        PostProcessVolume volume = gobj.GetComponent<PostProcessVolume>();
                        // Type type = abc.GetType().GetGenericArguments()[0];
                        UnityEngine.Rendering.PostProcessing.Bloom bloomLayer;
                        volume.profile.TryGetSettings(out bloomLayer);
                        bloomLayer.enabled.value = bloom;
                        UnityEngine.Rendering.PostProcessing.AmbientOcclusion aoLayer;
                        volume.profile.TryGetSettings(out aoLayer);
                        aoLayer.enabled.value = ao;
                        UnityEngine.Rendering.PostProcessing.ColorGrading cgLayer;
                        volume.profile.TryGetSettings(out cgLayer);
                        cgLayer.enabled.value = cg;
                        UnityEngine.Rendering.PostProcessing.MotionBlur mbLayer;
                        volume.profile.TryGetSettings(out mbLayer);
                        mbLayer.enabled.value = mb;
                    } catch (Exception e){
                        UnityEngine.Debug.LogWarning("error while setting pp: "+ e.Message);
                    }
                }
            }
            /*foreach (Camera gobj in Resources.FindObjectsOfTypeAll<Camera>()){
                if (gobj.GetComponent<PostProcessLayer>()){*/
        }
    }
    
    public Material getWeeze() {
        return weeze;
    }
}