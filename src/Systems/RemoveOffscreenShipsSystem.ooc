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

RemoveOffscreenShipsSystem : class extends ISystem implements  ISetWorld, IInitializeSystem, IExecuteSystem {
    game : Game
    world: World
    other: Group
    position: PositionComponent

    init: func(=game)
    setWorld: func(=world){}

    initialize: func(){
        other = world getGroup(Matcher matchAllOf(Component Velocity))
    }

    execute: func(){
        for (entity in other entities) {
            if (entity isPlayer) continue
            if (entity isDestroy) continue
            
            position = entity position as PositionComponent

            if (position y > windowSize h) {
                entity setDestroy(true)
                continue
            }

            if (position y < 0) {
                entity setDestroy(true)
                continue
            }

            if (position x > windowSize w) {
                entity setDestroy(true)
                continue
            }

            if (position x < 0) {
                entity setDestroy(true)
                continue
            }
        }
    }


}