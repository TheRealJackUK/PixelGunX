using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointGenerator : MonoBehaviour
{
    public GameObject pointPrefab;
    public int size;
    public BackroomsController backrooms;

    public void Start() {
        for (int i = 0; i < size+1; i++) {
            for (int mx = -size; mx < size+1; mx++) {
                for (int mz = -size; mz < size+1; mz++) {
                    GameObject funny = GameObject.Instantiate(pointPrefab, new Vector3(0, 0, 0), Quaternion.identity);
                    funny.transform.position = new Vector3(mx*6, 0, mz*6);
                    funny.transform.parent = transform;
                    backrooms.targetpoints.Add(funny);
                }
            }
        }
    }
}
