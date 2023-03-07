# Prject for Lioffline
this project was created at the request of my friend __Lioffline__.

the project is designed to generate a random position inside the zone
(__polygon__ of __*CollisionPolygon2D*__).

## variables for export

---

* time_range_between_item_spawn

    _type_: **Vector2**

    **default value** is Vector2(1.0,2.0) 

    ### **_Recomendations_**

    
    * **_x must be greater than zero and be the minimum value_**

    * **_y must be greater than zero, greater than or equal to x, and be the maximum value_**

---
* item_deletion_time

    _type_: **float**

    **default value** is 1.0(sec)

    ### **_Recomendations_**

    
    * **_must be greater than zero or or equal to zero** 

        if this parameter is greater than zero, then the scene loaded into the script will be deleted after this time, otherwise it will not be deleted

---
* node_path_to_add_item

    _type_: **Node_Path** (it can be string type)

    **default value** is "" (nothing)

    ### **_Recomendations_**

    
    * **optional field**, if you specify the Path to the node (Node_Path), then the scene loaded into the script will be added to the node (if it exists) located at the address "Node_Path". 
    
        Otherwise, the scene loaded into the script will be located in the parent path of CollisionPolygon2D.

        use the __node.get_path()__ to get the Node_Path

---
* spawn_scene

    _type_: **PackedScene** 

    **default value** is Null

    ### **_Recomendations_**

    * if you do not load a scene from your project ("res://.../scene_name.tscn"), then the program will not show signs of correct work

---
* offset_pos
    _type_: **Vector2**

    **default value** is Vector2.ZERO

    ### **_Recomendations_**
    * **optional field**, just add offset to spawn position of scene

---
## Functions
---
1. _ready() - inital setup for script
2. UpdateSpawnTimer - update local varible "spawn_timer"
3. get_rand_pos_in_Polygon2D() - need two arguments Polygon(PoolVector2Array) and _randomize(bool), second argument is optional
4. _physics_process() - in this function, all the logic of the script is carried out.
---