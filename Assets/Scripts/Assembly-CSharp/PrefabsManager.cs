using UnityEngine;
using System;

public class PrefabsManager : MonoBehaviour {
    
    public static PrefabsManager instance;
    
    public Material weeze;
    
    void Awake() {
        instance = this;
        DontDestroyOnLoad(gameObject);
    }
    
    public Material getWeeze() {
        return weeze;
    }
}