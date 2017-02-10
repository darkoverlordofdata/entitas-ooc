import structs/ArrayList
import structs/LinkedList
import structs/List

import entitas/Interfaces
import entitas/Entity
import entitas/Exceptions
import entitas/Group
import entitas/Matcher
import entitas/World

EntityChangedListener : class {
    id: static Int = 0
    event: Func (Entity, Int, IComponent)
    init: func(=event) {
        id = This id
        This id = id+1
    }
}


EntityChanged : class {

    _listeners : List<EntityChangedListener> = LinkedList<EntityChangedListener> new()

    init: func()

    add: func(event : Func (Entity, Int, IComponent)) -> Int {
        listener := EntityChangedListener new(event)
        _listeners add(listener)
        listener id
    }

    remove: func(eventId: Int) {
        for (listener in _listeners) 
            if (listener id == eventId) {
                _listeners remove(listener)
                return
            }
    }
    clear: func() {
        _listeners = LinkedList<EntityChangedListener> new()
    }

    dispatch: func(e : Entity, index : Int, component : IComponent) {

        // list_iter gets errors, possibly due to deletions
        // explicit looping and guard statements fix it up

        for (l in 0.._listeners size) {
            if (l >= _listeners size) {
                "EntityChangedListener is short" println()
                continue
            }
            listener := _listeners[l]
            if (listener == null) {
                "EntityChangedListener is null" println()
                continue
            }
            listener event(e, index, component)
        }
        
        // for (listener in _listeners)
        //     listener event(e, index, component)
    }

}