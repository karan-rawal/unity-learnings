using UnityEngine;

public class FollowPlayer : MonoBehaviour
{
    public Transform transformPlayer;
    public Vector3 offset;

    private void Update()
    {
        if (transformPlayer != null)
        {
            transform.position = transformPlayer.position + offset;
        }
    }
}
