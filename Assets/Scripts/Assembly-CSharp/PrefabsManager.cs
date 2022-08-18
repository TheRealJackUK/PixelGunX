using UnityEngine;
using System;
using UnityEngine.Rendering.PostProcessing;

public class PrefabsManager : MonoBehaviour {
    
    public static PrefabsManager instance;
    public string curScene = "";
    public Material weeze;
    
    void Awake() {
        instance = this;
        DontDestroyOnLoad(gameObject);
    }

    public void Update(){
        
        if (Application.loadedLevelName != curScene){
            curScene = Application.loadedLevelName;
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