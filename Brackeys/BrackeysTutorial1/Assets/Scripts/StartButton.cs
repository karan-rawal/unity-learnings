﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartButton : MonoBehaviour
{
    public void OnStartButtonClick()
    {
        FindObjectOfType<GameManager>().StartGame();
    }
}
