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

HealthRenderSystem : class extends ISystem implements  ISetWorld,  IExecuteSystem,  IInitializeSystem {
    game : Game
    world: World
    group: Group
    //parent: EntityComponent
    parentEnt: Entity
    parentPos: PositionComponent
    parentHlt: HealthComponent
    position: PositionComponent
    health: HealthComponent
    text: TextComponent
    resource: ResourceComponent
    bounds: BoundsComponent
    pct: String
    p: Int
    
    init: func(=game)
    setWorld: func(=world)

    initialize: func(){
        group = world getGroup(Matcher matchAllOf(Component Text))
    }

    execute: func(){
        for (entity in group entities) {
            // try {
                if (!entity hasPosition) continue
                position = entity position as PositionComponent
                // "position (%f,%f)" printfln(position x, position y)
                resource = entity resource as ResourceComponent
                // "resource (%s)" printfln(resource path)
                bounds = entity bounds as BoundsComponent
                // "bounds (%f, %f)" printfln(bounds width, bounds height)
                text = entity text as TextComponent
                // "text (%s)" printfln(text text)
                // parent = entity entity as EntityComponent
                // parentEnt = parent entity as Entity
                // if (!parentEnt isEnabled)  {
                //     // "%d" printfln(parentEnt isEnabled)
                //     entity setDestroy(true)
                //     //world destroyEntity(parentEnt)
                //     continue
                // }
                // parentPos = parentEnt position as PositionComponent
                // parentHlt = parentEnt health as HealthComponent

                // position x = parentPos x
                // position y = parentPos y

                // p = (parentHlt health/parentHlt maximumHealth*100.0) as Int
                // if (p < 2) {
                //     parentEnt removeEntity()
                //     entity setDestroy(true)
                // } else {
                //     pct = "%d%%" format(p)
                //     if (pct != text text) {
                //         surface := game hudFont renderUTF8Solid(pct, (0xff, 0xff, 0x00, 0xff) as SdlColor)
                //         sprite := SDL createTextureFromSurface(game renderer, surface)
                        
                //         bounds width = surface@ w
                //         bounds height = surface@ h
                //         resource sprite = sprite
                //         text text = pct
                    
                //     }
                // }
                
            // } catch (ex: Exception) {
            //     "ERR %s\n%s" printfln(ex message, entity toString())
            // }
        }
    }
}