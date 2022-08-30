using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class BackroomsController : MonoBehaviour
{
    public Camera myCamera;

    public GameObject pointsholder;

    public List<GameObject> targetpoints;

    public GameObject[] backroomsGameobjects;

    public List<GameObject> instantiated;

    private GameObject l;

    public Vector3 pointOffset;

    public GameObject deadCollider;

    public int division = 6;

    private int i = 0;

    public void Start() {

    }

    public void TryCreateFromPos(Vector3 pos) {

    }

    private bool isVisible(GameObject obj) {
        Plane[] planes = GeometryUtility.CalculateFrustumPlanes(myCamera);
        bool cansee = false;
        foreach (Transform zhaild in obj.transform) {
            if (GeometryUtility.TestPlanesAABB(planes, zhaild.gameObject.GetComponent<Collider>().bounds)) {
                cansee = true;
            }
        }
        return cansee;
    }

    public void Update() {
        foreach (Camera cam in Resources.FindObjectsOfTypeAll<Camera>()) {
            if ((cam.gameObject.active && cam.targetDisplay == 1) || cam.gameObject.name == "Main Camera") {
                myCamera = cam;
            }
        }
        if (myCamera.gameObject.name.Equals("Main Camera")) {
            
        }else{
            /*pointsholder.transform.position = new Vector3(myCamera.transform.position.x, 0, myCamera.transform.position.z);
            deadCollider.transform.position = new Vector3(myCamera.transform.position.x, -1.48f, myCamera.transform.position.z);*/
        }
        if (GameObject.Find("Player")) {
            Transform plr = GameObject.Find("Player").transform;
            pointsholder.transform.position = new Vector3(plr.position.x, 0, plr.position.z);
            deadCollider.transform.position = new Vector3(plr.position.x, -1.48f, plr.position.z);
        }
        foreach (GameObject targetCamera in targetpoints) {
            if (targetCamera.active) {
                Vector3 yourpos = targetCamera.transform.position;
                Vector3 divvedpos = new Vector3((yourpos.x+pointOffset.x)/division, yourpos.y/division, (yourpos.z+pointOffset.z)/division);
                UnityEngine.Random.InitState((int)((int)(divvedpos.x * divvedpos.x) + (int)(divvedpos.z * divvedpos.z)));
                bool can = true;
                foreach (GameObject loma in instantiated) {
                    if (loma.transform.position == new Vector3((int)((int)(divvedpos.x) * 6), 0, (int)((int)(divvedpos.z) * 6))) {
                        can = false;
                    }
                }
                if (can) {
                    l = GameObject.Instantiate(backroomsGameobjects[(int)UnityEngine.Random.Range(0,5)], new Vector3(0, 0, 0), Quaternion.identity);
                    l.transform.position = new Vector3((int)((int)(divvedpos.x) * 6), 0, (int)((int)(divvedpos.z) * 6));
                    l.transform.parent = transform;
                    instantiated.Add(l);
                }
            }
        }
       /* foreach (GameObject instanti in instantiated) {
            if (!isVisible(instanti))
            {
                instantiated.Remove(instanti);
                GameObject.Destroy(instanti);
            }
        }*/
        foreach (GameObject instanti in instantiated) {
            if (!isVisible(instanti))
            {
                //instantiated.Remove(instanti);
                //GameObject.Destroy(instanti);
                instanti.SetActive(false);
            }else{
                instanti.SetActive(true);
            }
        }
    }
}
