extends Node

var SceneMngr : SceneManager = null 
enum Scene {SPLASH_SCREEN, MAIN_SCENE, PLAY_SCENE, OTHER_SCENE}

#CONSTANTS
const MIN_RUNNING_VEL = 100
const MAX_RUNNING_VEL = 200
const MIN_RUNNING_ACCELERATION = 0
const MAX_RUNNING_ACCELERATION = 0

#SIGNALS
signal get_ready_to_run()
signal start_running()
signal player_hit(vel_reduction)
signal obstacle_avoided(points_won)
signal player_lost()

