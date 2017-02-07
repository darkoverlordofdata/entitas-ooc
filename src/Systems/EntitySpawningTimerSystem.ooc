use sdl2
import math
import sdl2/[Core, Event, Image]
import structs/ArrayList
import structs/LinkedList
import structs/Stack
import entitas/Entity
import entitas/Exceptions
import entitas/Group
import entitas/Interfaces
import entitas/Matcher
import entitas/World
import entitas/events/EntityChanged
import entitas/events/EntityReleased
import entitas/events/GroupChanged
import entitas/events/GroupsChanged
import entitas/events/GroupUpdated
import entitas/events/WorldChanged
import entitas/events/ComponentReplaced
import Components
import Entities
import Game

Timers: enum {
    /* Spawn enemy timers */
    TIMER1      = 2
    TIMER2      = 7
    TIMER3      = 13
}

EntitySpawningTimerSystem : class extends ISystem implements  ISetWorld,  IExecuteSystem,  IInitializeSystem {
    game : Game
    world: World

    Timer1: Double = 2.0
    Timer2: Double = 7.0
    Timer3: Double = 13.0


    enemyT1: Double = Timer1 as Double 
    enemyT2: Double = Timer2 as Double
    enemyT3: Double = Timer3 as Double

    init: func(=game)
    setWorld: func(=world){}


    initialize: func(){}

    execute: func(){
        delta := game delta
        spawn := func(t: Double, e: Enemy) -> Double {
            d := t-delta
            if (d<0) {
                return match e {
                    case Enemy Enemy1 =>
                        world createEnemy1(game)
                        Timer1 
                    case Enemy Enemy2 =>
                        world createEnemy2(game)
                        Timer2 
                    case Enemy Enemy3 =>
                        world createEnemy3(game)
                        Timer3 
                    case => 0
                }
            } else return d
        }
        enemyT1 = spawn(enemyT1, Enemy Enemy1)
        enemyT2 = spawn(enemyT2, Enemy Enemy2)
        enemyT3 = spawn(enemyT3, Enemy Enemy3)
        
    }



}