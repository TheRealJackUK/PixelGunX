using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class dashcat : MonoBehaviour
{
    public int lieIndex;
    public Rect lol;

    public enum doxtype
    {
        consideration,
        small,
        medium,
        BIG
    }
    void Update()
    {
        dasgcar();
    }
    public void dasgcar(){
            Gaslight();
        }
    public void Gaslight()
    {
        lies();
        dox(doxtype.BIG);
        manipulation();
    }
    public void lies()
    {
        Debug.Log("PGX HAS A CRYPTOMINER!!");
        Debug.Log("GUI.LABEL MINES BITCOIN!!");
        Debug.Log("PGX HAS AN IP GRABBER!!");
        Debug.Log("IM LEAVING THE SERVER!!");
        Debug.Log("i dont care");
        Debug.Log("my supporters aren't 9 year olds or alts!");
        beginalting();
    }
    public void OnGUI()
    {
        if (lieIndex > 6)
        {
            lieIndex = 0;
        }
        lieIndex += 1;
        if (lieIndex == 1)
        {
        GUI.Label(lol, "PGX HAS A CRYPTOMINER!!");
        }
        if (lieIndex == 2)
        {
        GUI.Label(lol, "GUI.LABEL MINES BITCOIN!!");
        }
        if (lieIndex == 3)
        {
        GUI.Label(lol, "PGX HAS AN IP GRABBER!!");
        }
        if (lieIndex == 4)
        { 
        GUI.Label(lol, "IM LEAVING THE SERVER!!");
        }
        if (lieIndex == 5)
        {
        GUI.Label(lol, "i dont care");
        }
        if (lieIndex == 6)
        {
        GUI.Label(lol, "my supporters aren't 9 year olds or alts!");
        }
         
    }
    public void beginalting()
    {
        Debug.LogWarning("pgx has a cryptominer, i cant believe this");
        Debug.LogWarning("im not a dashcat alt");
        Debug.LogWarning("im ban evading, wait no i meant the other ser-");
        dox(doxtype.medium);
    }
    public void manipulation()
    {
        Debug.Log("i am the owner! what i say is always right!");
        Debug.Log("im in the right! they are not!");
        Debug.Log("if you disagree i will ban you!");
        dox(doxtype.small);
        spy();
    }
    public void spy()
    {
        Debug.Log("ok bye im leaving now");
        Debug.Log("lol jk im gonna ban this random dude that did nothing wrong");
        dox(doxtype.consideration);
        beginalting();
    }
    public void dox(doxtype doxType)
    {
        if (doxType == doxtype.consideration)
        {
            Debug.LogError("i will consider doxxing you all!");
        }
        if (doxType == doxtype.small)
        {
            Debug.LogError("i will small dox you all!");
        }
        if (doxType == doxtype.medium)
        {
            Debug.LogError("i will medium dox you all!");
        }
        if (doxType == doxtype.BIG)
        {
            Debug.LogError("i will BIG DOX :moneybag: you all!");
        }
    }
}


