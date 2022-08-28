using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class BackroomsController : MonoBehaviour
{
    public Camera targetCamera;

    public GameObject[] backroomsGameobjects;

    private GameObject[] instantiated;

    public GameObject l;

    public void Start() {
        int i = 0;
        instantiated = new GameObject[backroomsGameobjects.Length];
        foreach (GameObject lmao in backroomsGameobjects) {
            instantiated[i] = GameObject.Instantiate(lmao, new Vector3(0, 9, 0), Quaternion.identity);
            i++;
        }
    }

    public void Update() {
        for (int eks = -3; eks < 3; eks++)
        {
            for (int zed = -3; zed < 3; zed++)
            {
                Vector3 yourpos = targetCamera.transform.position;
                Vector3 divvedpos = new Vector3((yourpos.x+eks*6)/6, yourpos.y/6, (yourpos.z+zed*6)/6);
                UnityEngine.Random.InitState((int)((int)(divvedpos.x) + (int)(divvedpos.z)));
                foreach (GameObject lmao in instantiated) {
                    lmao.transform.position = new Vector3(0, 9, 0);
                }
                l = instantiated[(int)UnityEngine.Random.Range(0,5)];
                l.transform.position = new Vector3((int)((int)(divvedpos.x) * 6), 0, (int)((int)(divvedpos.z) * 6));
            }
        }
    }
}
