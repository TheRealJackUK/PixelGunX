using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Rilisoft;
using System.Reflection;
using System.Linq;

public class DevtestController : MonoBehaviour
{
    public List<string> buttonHandlers;
    public List<ButtonHandler> actualHandlers;

    public ButtonHandler GetButtonHandler(string var1) {
        int var2 = 0;
        foreach (string var3 in buttonHandlers) {
            if (var3 == var1) {
                break;
            }
            var2++;
        }
        return actualHandlers[var2];
    }

    public void Toggle(string var1) {
        if (!Storager.hasKey(var1)) 
        {
            Storager.setInt(var1, 0);
        }
        bool var2 = !(Storager.getInt(var1) == 1 ? true : false);
        int var3 = var2 == true ? 1 : 0;
        Storager.setInt(var1, var3);
        if (var2) 
        {
            UILabel var4 = GetButtonHandler(var1).gameObject.GetComponentInChildren<UILabel>();
            var4.color = new Color(0, 1, 0, 1);
        }
        else
        {
            UILabel var4 = GetButtonHandler(var1).gameObject.GetComponentInChildren<UILabel>();
            var4.color = new Color(1, 0, 0, 1);
        }
    }

    public void Activate(string var1) {
        if (!Storager.hasKey(var1)) 
        {
            Storager.setInt(var1, 0);
        }
        bool var2 = (Storager.getInt(var1) == 1 ? true : false);
        if (var2) 
        {
            UILabel var4 = GetButtonHandler(var1).gameObject.GetComponentInChildren<UILabel>();
            var4.color = new Color(0, 1, 0, 1);
        }
        else
        {
            UILabel var4 = GetButtonHandler(var1).gameObject.GetComponentInChildren<UILabel>();
            var4.color = new Color(1, 0, 0, 1);
        }
    }

    public void infammo(object sender, System.EventArgs e){
        Toggle("infammo");
    }

    public void god(object sender, System.EventArgs e){
        Toggle("god");
    }

    public void firerate(object sender, System.EventArgs e){
        Toggle("firerate");
    }

    void Start()
    {
        for (int var1 = 0; var1 < buttonHandlers.Count; var1++) {
            Activate(buttonHandlers[var1]);
        }
        actualHandlers[0].Clicked += infammo;
        actualHandlers[1].Clicked += god;
        actualHandlers[2].Clicked += firerate;
    }
}
