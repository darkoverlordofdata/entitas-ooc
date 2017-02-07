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

DestroySystem : class extends ISystem implements  ISetWorld,  IExecuteSystem,  IInitializeSystem {
    game : Game
    world: World
    group: Group

    init: func(=game)
    setWorld: func(=world)

    initialize: func(){
        group = world getGroup(Matcher matchAllOf(Component Destroy))
    }

    /* remove the entity from the games sprites list */
    execute: func(){
        entities := group getEntities()
        delta := game delta

        for (i in 0..entities length) {
            e := entities[i]
            world destroyEntity(e)
            game sprites remove(e)
        }
    }

}