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

ViewManagerSystem : class extends ISystem implements  ISetWorld,  IInitializeSystem {
    game : Game
    world: World
    active: Group

    init: func(=game)
    setWorld: func(=world)


    initialize: func(){
        active = world getGroup(Matcher matchAllOf(Component Active))
        active onEntityAdded add(func(g : Group, e : Entity, index: Int, component : IComponent) {
            //"%s added to %s" printfln(e name, group toString())

            scale : ScaleComponent
            layer : LayerComponent
            ordinal : Int = 0

            res := component as ResourceComponent

            game sprites add(e)


            if (e hasScale) {

            }

            if (e hasLayer) {

            }

            if (e hasTint) {

            }
        })
    }
}