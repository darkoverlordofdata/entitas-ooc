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

        for (enemy in enemyGroup entities) {
            for (bullet in bulletGroup entities) {
                ep := enemy position as PositionComponent
                eb := enemy bounds as BoundsComponent
                bp := bullet position as PositionComponent
                bd := bullet bounds as BoundsComponent
                if (intersects((ep x, ep y, eb width, eb height) as SdlRect, (bp x, bp y, bd width, bd height) as SdlRect)) {
                    // handleCollision(enemy, bullet)
                    "Bang!" print()
                }
            }
        }
    }

    /** 
     *  Rect methods are missing from the sdl2-ooc bindings
     */
    intersects: func(r1: SdlRect, r2: SdlRect) -> Bool {
        // "(%d,%d,%d,%d) (%d,%d,%d,%d)" printfln(r1 x, r1 y, r1 w, r1 h, r2 x, r2 y, r2 w, r2 h)
        return ((r1 x < r2 x + r2 w) && 
                (r1 x + r1 w > r2 x) && 
                (r1 y < r2 y + r2 h) && 
                (r1 y + r1 h > r2 y)) 
    }

    handleCollision: func(enemy: Entity, bullet: Entity) {
        bp := bullet position as PositionComponent
        bh := bullet health as HealthComponent
        eh := enemy health as HealthComponent

        world createBang(game, bp x, bp y)
        bullet setActive(false)
        for (i in 0..4) world createParticle(game, bp x, bp y)
        if (eh maximumHealth != 0) {
            eh health -= bh health 
            if (eh health <= 0) {
                world createExplosion(game, bp x, bp y)
                enemy setActive(false)
            }
        }
    }
    
}