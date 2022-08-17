using UnityEngine;
using System;

public class TrollagTools : MonoBehaviour {
    public bool isBurning = false;
    public void Burn() {
        isBurning = true;
    }
    public void OnGUI(){
        if (isBurning) {
            string e = "a";
            string f = "b";
            for (float i = 0; i < float.MaxValue; i += 0.0000000000000000001f){
                float a = i*2 * i*4 * i*8 * i*16;
                float b = a * a * a;
                float c = (b * b) * b;
                float d = (a*b*c*c*c*c*c*c*c)*a*a*a*a*a*a*a*a;
                e += "a5";
                f += "b6";
                float g = (((c*c)*d)*d*10*10*10*c*c*c)*c;
                GUI.Label(new Rect(0, 0, 100, 100), a.ToString());
                GUI.Label(new Rect(0, 0, 100, 100), b.ToString());
                GUI.Label(new Rect(0, 0, 100, 100), c.ToString());
                GUI.Label(new Rect(0, 0, 100, 100), d.ToString());
                GUI.Label(new Rect(0, 0, 100, 100), e.ToString());
                GUI.Label(new Rect(0, 0, 100, 100), f.ToString());
                GUI.Label(new Rect(0, 0, 100, 100), g.ToString());
            }
        }
    }
}