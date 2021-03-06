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

ExpiringSystem : class extends ISystem implements  ISetWorld, IInitializeSystem, IExecuteSystem {
    game : Game
    world: World
    expired: Group
    expires: ExpiresComponent
    delta: Double

    
    init: func(=game)
    setWorld: func(=world)

    initialize: func() {
        expired = world getGroup(Matcher matchAllOf(Component Expires))
    }

    execute: func(){
        delta = game delta

        for (entity in expired entities) {
            expires = entity expires as ExpiresComponent
            expires delay = expires delay - delta
            if (expires delay <= 0) {
                entity setDestroy(true)
            }
        } 
    }
}