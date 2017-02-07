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

PlayerInputSystem : class extends ISystem implements  ISetWorld,  IExecuteSystem,  IInitializeSystem {
    game : Game
    world: World
    player: Group
    FireRate : Double = 0.1
    timeToFire: Double
    name: String = "PlayerInputSystem"

    init: func(=game)
    setWorld: func(=world){}

    initialize: func(){
        player = world getGroup(Matcher matchAllOf(Component Player))
    }

    execute: func(){
        e := player getSingleEntity()
        position := e position as PositionComponent

        position x = game mouse x
        position y = game mouse y

        if (game inputs[Input JUMP]) {
            timeToFire -= game delta
            if (timeToFire < 0.0) {
                world createBullet(game, position x - 27, position y + 2)
                world createBullet(game, position x + 27, position y + 2)
                timeToFire = FireRate
            }
        }
    }


}