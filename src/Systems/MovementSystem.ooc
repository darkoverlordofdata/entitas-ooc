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

MovementSystem : class extends ISystem implements  ISetWorld, IInitializeSystem, IExecuteSystem {
    game : Game
    world: World
    group: Group
    position: PositionComponent
    velocity: VelocityComponent
    delta: Double

    init: func(=game)
    setWorld: func(=world)


    initialize: func() {
        group = world getGroup(Matcher matchAllOf(Component Velocity))
    }

    execute: func(){
        delta = game delta

        for (entity in group entities) {
            if (entity isEnabled) {
                position = entity position as PositionComponent
                velocity = entity velocity as VelocityComponent

                position x = position x + velocity x * delta
                position y = position y + velocity y * delta

            }
        }
    }
}
