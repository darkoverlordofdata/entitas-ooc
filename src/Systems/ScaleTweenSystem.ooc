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

ScaleTweenSystem : class extends ISystem implements  ISetWorld, IInitializeSystem, IExecuteSystem {
    game : Game
    world: World
    tween: Group

    init: func(=game)
    setWorld: func(=world){}

    initialize: func(){
        tween = world getGroup(Matcher matchAllOf(Component Scale, Component ScaleTween))
    }

    execute: func(){
        delta := game delta
        for (entity in tween entities) {
        // entities := tween getEntities()
        // for (e in 0..entities length) {
            // if (e >= entities length) {
            //     continue
            // }
            // entity := entities[e]
            // if (entity == null) {
            //     continue
            // }

            scale := entity scale as ScaleComponent
            scaleTween := entity scaleTween as ScaleTweenComponent


            x := scale x + scaleTween speed * delta
            y := scale y + scaleTween speed * delta
            active := scaleTween active
            if (x > scaleTween max)  {
                x = scaleTween max
                y = scaleTween max
                active = false
            }
            if (x < scaleTween min) {
                x = scaleTween min
                y = scaleTween min
                active = false
            }
            scale x = x
            scale y = y
            scaleTween active = active
        }
    }

}