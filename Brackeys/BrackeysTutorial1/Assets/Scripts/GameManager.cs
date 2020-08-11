using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public GameObject levelCompletePanel;
    public float restartDelay = 1f;

    private bool gameHasEnded = false;

    public void EndGame()
    {
        if (!gameHasEnded)
        {
            gameHasEnded = true;
            Invoke("RestartGame", restartDelay);
        }
    }

    public void StartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }

    public void RestartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    public void CompleteLevel()
    {
        levelCompletePanel.SetActive(true);
    }

    public void QuitGame()
    {
        Debug.Log("Quitting Application");
        Application.Quit();
    }
}
