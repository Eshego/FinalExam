using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    [SerializeField]
    public float speed;
    void Update()
    {
        Move();
    }
    void Move()
    {
        float horMove = Input.GetAxis("Horizontal");
        float vertMove = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(-horMove, 0, -vertMove);
        transform.Translate(movement * speed * Time.deltaTime, Space.World);
    }
}
