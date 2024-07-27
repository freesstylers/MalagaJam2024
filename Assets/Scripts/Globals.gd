extends Node

var SceneMngr : SceneManager = null 
enum Scene {SPLASH_SCREEN, MAIN_SCENE, PLAY_SCENE, OTHER_SCENE}

#CONSTANTS
const MIN_RUNNING_VEL = 10
const MAX_RUNNING_VEL = 200
const MIN_RUNNING_ACCELERATION = 1
const MAX_RUNNING_ACCELERATION = 10

#SIGNALS
signal get_ready_to_run(drunk_meter)
signal start_running()
signal obstacle_hit(vel_reduction)
signal obstacle_spawned(obstacle)
signal obstacle_avoided(points_won)
signal player_lost()

