using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomThingController : MonoBehaviour
{
    public GameObject HitmarkerController;
    public void Awake()
    {
        DontDestroyOnLoad(base.gameObject);
    }
}
