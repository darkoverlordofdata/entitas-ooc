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
    parent: EntityComponent
    parentEnt: Entity
    parentPos: PositionComponent
    parentHlt: HealthComponent
    position: PositionComponent
    health: HealthComponent
    text: TextComponent
    resource: ResourceComponent
    bounds: BoundsComponent
    pct: String
    
    init: func(=game)
    setWorld: func(=world){}

    initialize: func(){
        group = world getGroup(Matcher matchAllOf(Component Text, Component Entity))
    }

    execute: func(){
        for (entity in group entities) {
            position = entity position as PositionComponent
            text = entity text as TextComponent
            parent = entity entity as EntityComponent
            resource = entity resource as ResourceComponent
            bounds = entity bounds as BoundsComponent

            parentEnt = parent entity as Entity
            parentPos = parentEnt position as PositionComponent
            parentHlt = parentEnt health as HealthComponent

            position x = parentPos x
            position y = parentPos y

            p := (parentHlt health/parentHlt maximumHealth*100.0) as Int
            if (p < 2) {
                entity setDestroy(true)
            } else {
                pct = "%d%%" format(p)
                if (pct != text text) {
                    surface := game hudFont renderUTF8Solid(pct, (0xff, 0xff, 0x00, 0xff) as SdlColor)
                    sprite := SDL createTextureFromSurface(game renderer, surface)
                    
                    bounds width = surface@ w
                    bounds height = surface@ h
                    resource sprite = sprite
                    text text = pct
                
                }
            }
        }
    }
            
            // pct = "%d%%" format(health.health/health.maximumHealth*100.0)


            // if (pct == text.text) {
            //     sprite = text.sprite
            //     if (sprite == null) {
            //         sprite = new Sprite.text(text.text, Sdx.app.font, sdx.graphics.Color.Lime)
            //         sprite.centered = false
            //         text.sprite = sprite
            //     }
            // } else {
            //     text.text = pct
            //     text.sprite = null
            //     sprite = new Sprite.text(text.text, Sdx.app.font, sdx.graphics.Color.LimeGreen)
            //     sprite.centered = false
            //     text.sprite = sprite
            // }
            // sprite.x = position.x
            // sprite.y = position.y
            // Sdx.app.onetime.add(sprite)

            

    



}