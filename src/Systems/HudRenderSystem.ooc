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

HudRenderSystem : class extends ISystem implements  ISetWorld,  IExecuteSystem,  IInitializeSystem {

    ACTIVE_ENTITIES : String  = "Active entities:         %s"
    TOTAL_RETAINED : String   = "Total reusable:          %s"
    TOTAL_REUSABLE : String   = "Total retained:          %s"

    game : Game
    world: World
    activeEntities: SdlTexture
    totalRetained: SdlTexture
    totalReusable: SdlTexture

    count: Entity
    retained: Entity
    reusable: Entity

    lastCount: Int
    lastRetained: Int
    lastReusable: Int

    init: func(=game)
    setWorld: func(=world)

    initialize: func(){

        lastCount = world count
        lastReusable = world reusableEntitiesCount
        lastRetained = world retainedEntitiesCount
    
        count = world createHud(game, 0, 40, ACTIVE_ENTITIES, "%3d" format(world count))
        retained = world createHud(game, 0, 60, TOTAL_RETAINED, "%3d" format(world reusableEntitiesCount))
        reusable = world createHud(game, 0, 80, TOTAL_REUSABLE, "%3d" format(world retainedEntitiesCount))
        

    }

    execute: func(){

        if (lastCount != world count) {
            str := ACTIVE_ENTITIES format("%3d" format(world count))
            surface := game hudFont renderUTF8Solid(str, (0xff, 0xff, 0xff, 0xff) as SdlColor)
            sprite := SDL createTextureFromSurface(game renderer, surface)

            bounds := count bounds as BoundsComponent
            resource := count resource as ResourceComponent
            bounds width = surface@ w
            bounds height = surface@ h            
            resource sprite = sprite
            lastCount = world count
        }

        if (lastReusable != world reusableEntitiesCount) {

            str := TOTAL_RETAINED format("%3d" format(world reusableEntitiesCount))
            surface := game hudFont renderUTF8Solid(str, (0xff, 0xff, 0xff, 0xff) as SdlColor)
            sprite := SDL createTextureFromSurface(game renderer, surface)

            bounds := reusable bounds as BoundsComponent
            resource := reusable resource as ResourceComponent
            bounds width = surface@ w
            bounds height = surface@ h            
            resource sprite = sprite
            lastReusable = world reusableEntitiesCount
        }

        if (lastRetained != world retainedEntitiesCount) {

            str := TOTAL_REUSABLE format("%3d" format(world retainedEntitiesCount))
            surface := game hudFont renderUTF8Solid(str, (0xff, 0xff, 0xff, 0xff) as SdlColor)
            sprite := SDL createTextureFromSurface(game renderer, surface)

            bounds := retained bounds as BoundsComponent
            resource := retained resource as ResourceComponent
            bounds width = surface@ w
            bounds height = surface@ h            
            resource sprite = sprite
            lastRetained = world retainedEntitiesCount
        }

    }

    // createText: func(str: String, val: Int) -> SdlTexture {
    //     text := game font renderUTF8Solid(str format(val), (0, 0, 0, 0) as SdlColor)
    //     SDL createTextureFromSurface(game renderer, text)
    // }

}