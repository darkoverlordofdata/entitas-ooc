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
    resource: ResourceComponent
    layer: LayerComponent
    ordinal: Int
    sprites: LinkedList<Entity>
    i: Int

    init: func(=game)
    setWorld: func(=world)


    initialize: func(){
        sprites = game sprites
        active = world getGroup(Matcher matchAllOf(Component Active))
        active onEntityAdded add(func(g : Group, e : Entity, index: Int, component : IComponent) {

            resource = e resource as ResourceComponent
            layer = e layer as LayerComponent
            ordinal = layer ordinal as Int

            // insert into sorted order by layer

            if (sprites size == 0) {
                sprites add(e)
            } else {
                i = 0
                for (s in sprites) {
                    layer = s layer as LayerComponent

                    if (ordinal <= layer ordinal) {
                        sprites add(i, e)
                        return
                    } else {
                        i += 1
                    }
                }
                sprites add(e)
            }
            
        })
    }
}
