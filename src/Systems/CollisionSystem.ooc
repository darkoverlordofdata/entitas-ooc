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

CollisionSystem : class extends ISystem implements  ISetWorld,  IExecuteSystem,  IInitializeSystem {
    game : Game
    world: World
    enemyGroup: Group
    bulletGroup: Group
    name: String = "CollisionSystem"

    init: func(=game)
    setWorld: func(=world){}



    initialize: func(){
        enemyGroup = world getGroup(Matcher matchAllOf(Component Enemy))
        bulletGroup = world getGroup(Matcher matchAllOf(Component Bullet))
    }

    execute: func(){

        // enemies := enemyGroup getEntities()
        // bullets := bulletGroup getEntities()

        // for (e in 0..enemies length) {
        //     if (e >= enemies length) {
        //         continue
        //     }
        //     enemy := enemies[e]
        //     if (enemy == null) {
        //         continue
        //     }
        //     for (b in 0..bullets length) {
        //         if (b >= bullets length) {
        //             continue
        //         }
        //         bullet := bullets[b]
        //         if (bullet == null) {
        //             continue
        //         }
        //     }
        // }

        for (enemy in enemyGroup entities) {
            for (bullet in bulletGroup entities) {
                // if (!bullet hasBounds) continue
                // if (!bullet hasPosition) continue
                // if (!enemy hasBounds) continue
                // if (!enemy hasPosition) continue
                ep := enemy position as PositionComponent
                eb := enemy bounds as BoundsComponent
                bp := bullet position as PositionComponent
                bd := bullet bounds as BoundsComponent
                if (bp y < 0 || bp x < 0) {
                    continue
                }
                if (intersects((ep x as Int, ep y as Int, eb width, eb height) as SdlRect, (bp x as Int, bp y as Int, bd width, bd height) as SdlRect)) {
                    handleCollision(enemy, bullet)
                }
            }
        }
    }

    /** 
     *  Rect methods are missing from the sdl2-ooc bindings
     */
    intersects: func(r1: SdlRect, r2: SdlRect) -> Bool {
        return ((r1 x < r2 x + r2 w) && 
                (r1 x + r1 w > r2 x) && 
                (r1 y < r2 y + r2 h) && 
                (r1 y + r1 h > r2 y)) 
    }

    handleCollision: func(enemy: Entity, bullet: Entity) {
        // if (!bullet hasBounds) return 
        // if (!bullet hasHealth) return
        // if (!enemy hasHealth) return
        // if (!bullet hasHealth) return
        // "Bang!" print()
        bp := bullet position as PositionComponent
        bh := bullet health as HealthComponent
        eh := enemy health as HealthComponent

        world createBang(game, bp x, bp y)
        bullet setDestroy(true)
        for (i in 0..4) world createParticle(game, bp x, bp y)
        if (eh maximumHealth != 0) {
            eh health -= bh health 
            if (eh health <= 0) {
                if (enemy isDestroy) return
                world createExplosion(game, bp x, bp y)
                enemy setDestroy(true)
            }
        }
    }
}