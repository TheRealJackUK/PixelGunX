using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Criminal : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(criminal());
    }
    public IEnumerator criminal()
    {
        yield return new WaitForSeconds(18f);
        Application.Quit();
        Debug.Log("Criminal.");
    }
}
