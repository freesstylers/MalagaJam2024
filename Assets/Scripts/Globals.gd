extends Node

var SceneMngr : SceneManager = null 
enum Scene {SPLASH_SCREEN, MENU_SCENE, DRINK_SCENE, PLAY_SCENE}

#CONSTANTS
const MIN_RUNNING_VEL = 20
const MAX_RUNNING_VEL = 200
const MIN_RUNNING_ACCELERATION = 10
const MAX_RUNNING_ACCELERATION = 20
const DEATH_VEL = 100

#SIGNALS
signal get_ready_to_run(drunk_meter)
signal start_running()
signal obstacle_hit(vel_reduction)
signal obstacle_spawned(obstacle)
signal obstacle_avoided()
signal player_lost()

