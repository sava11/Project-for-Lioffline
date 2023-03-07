#this code was created by Destro(Not a user) for Lioffline
#My Github - github.com/sava11

extends CollisionPolygon2D
export(Vector2)var time_range_between_item_spawn=Vector2(1.0,2.0)
export(float,0,9999)var item_deletion_time=1.0
export(NodePath)var node_path_to_add_item=""
export(PackedScene)var spawn_scene = null
export(Vector2)var offset_pos=Vector2.ZERO
var rnd=RandomNumberGenerator.new()
var spawn_timer=0
var deletion_timer=[]
func _ready():
	if time_range_between_item_spawn.x<=0 and time_range_between_item_spawn.y<=0:
		set_physics_process(false)
	UpdateSpawnTimer()
func UpdateSpawnTimer():
	spawn_timer=rnd.randf_range(time_range_between_item_spawn.x,time_range_between_item_spawn.y)
func get_rand_pos_in_Polygon2D(Polygon:PoolVector2Array,_randomize:bool=false):
	var finded=false
	if _randomize:
		randomize()
	rnd.seed=randi()
	var pos=Vector2.ZERO
	var minPoint=Polygon[0]
	var maxPoint=Polygon[0]
	for vec in Polygon:
		if minPoint.x>vec.x:
			minPoint.x=vec.x
		if minPoint.y>vec.y:
			minPoint.y=vec.y
		if maxPoint.x<vec.x:
			maxPoint.x=vec.x
		if maxPoint.y<vec.y:
			maxPoint.y=vec.y
	while finded==false:
		pos=Vector2(rnd.randf_range(minPoint.x,maxPoint.x),rnd.randf_range(minPoint.y,maxPoint.y))
		if Geometry.is_point_in_polygon(pos, Polygon):
			finded=true
	return pos


func _physics_process(delta):
	spawn_timer-=delta#Another way is: move_toward(spawn_timer,0,TIME_SPEED*delta) #*TIME_SPEED its your float/int value
	for time_and_time in deletion_timer:
		time_and_time[0]-=delta#Another way is: move_toward(spawn_timer,0,TIME_SPEED*delta) #*TIME_SPEED its your float/int value
		if time_and_time[0]<=0:
			time_and_time[1].queue_free()
			deletion_timer.remove(deletion_timer.find(time_and_time))
			
			
			
	if spawn_timer<=0 and spawn_scene!=null:
		var item=spawn_scene.instance()
		
		#Here you can set options that are used before the _ready() function is called. (this is used for initial setup)
		
		if get_node_or_null(node_path_to_add_item)!=null:
			get_node(node_path_to_add_item).call_deferred("add_child",item)
		else:
			get_parent().call_deferred("add_child",item)
			
		#You can set another parameters here, like as global_position or another Node object parametrs
		
		item.global_position=get_rand_pos_in_Polygon2D(polygon,true)+global_position+offset_pos
		
		UpdateSpawnTimer()
		if item_deletion_time>0:#I used this condition so that you can control the self-deletion of the scene
			deletion_timer.append([item_deletion_time,item])
			
