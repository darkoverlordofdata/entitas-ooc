import math
import structs/ArrayList
import structs/LinkedList
import structs/List
import structs/HashMap

import Entity
import Exceptions
import Group
import Interfaces
import Matcher
import World
import events/EntityChanged
import events/EntityReleased
import events/GroupChanged
import events/GroupsChanged
import events/GroupUpdated
import events/WorldChanged
import events/ComponentReplaced

GroupEventType: enum  {
    OnEntityAdded
    OnEntityRemoved
    OnEntityAddedOrRemoved
}

Matcher: class implements IAllOfMatcher, IAnyOfMatcher, INoneOfMatcher {
 
    uniqueId: static Int

    id: String { get { _id } }
    indices: Int[] { get { 
        if (_indices length == 0)
            _indices = mergeIndices()
        _indices
    }}
    allOfIndices: Int[] { get { _allOfIndices } }
    anyOfIndices: Int[] { get { _anyOfIndices } }
    noneOfIndices: Int[] { get { _noneOfIndices } }
    
    _id                 : String
    _name               : String
    _indices            : Int[]
    _toStringCache      : String
    _allOfIndices       : Int[]
    _anyOfIndices       : Int[]
    _noneOfIndices      : Int[]

    getId: func() -> String {
        _id
    }
    getIndices: func() -> Int[] {
        mergeIndices()
    }


    init: func {
        Matcher uniqueId += 1
        _id = "%d" format(Matcher uniqueId)
    }

    /**
     * Matches anyOf the components/indices specified
     * @params Array<entitas IMatcher>|Array<number> args
     * @returns entitas Matcher
     */
    anyOf: func(args : Int[]) -> IAnyOfMatcher {
        _anyOfIndices = distinctIndices(args)
        _indices = Int[0] new()
        this

    }

    /**
     * Matches noneOf the components/indices specified
     * @params Array<entitas IMatcher>|Array<number> args
     * @returns entitas Matcher
     */
    noneOf: func(args : Int[]) -> INoneOfMatcher {
        _noneOfIndices = distinctIndices(args)
        _indices = Int[0] new()
        this
    }

    /**
     * Check if the entity matches this matcher
     * @param entitas Entity entity
     * @returns boolean
     */
    matches: func(entity : Entity) -> Bool {
        matchesAllOf := _allOfIndices length == 0 ? true : entity hasComponents(_allOfIndices)
        matchesAnyOf := _anyOfIndices length == 0 ? true : entity hasAnyComponent(_anyOfIndices)
        matchesNoneOf := _noneOfIndices length == 0 ? true : !entity hasAnyComponent(_noneOfIndices)
        matchesAllOf && matchesAnyOf && matchesNoneOf
    }
    /**
     * Merge list of component indices
     * @returns Array<number>
     */
    mergeIndices: func() -> Int[] {

        indicesList := Int[_allOfIndices length+_anyOfIndices length+_noneOfIndices length] new()
        index := 0

        for (i in 0.._allOfIndices length) {
            indicesList[index] = _allOfIndices[i]
            index += 1
        }

        for (i in 0.._anyOfIndices length) {
            indicesList[index] = _anyOfIndices[i]
            index += 1
        }

        for (i in 0.._noneOfIndices length) {
            indicesList[index] = _noneOfIndices[i]
            index += 1
        }
            
        distinctIndices(indicesList)
    }

    /**
     * toString representation of this matcher
     * @returns string
     */
    toString: func() -> String {
        if (_toStringCache == null) {
            sb := ""
            if (_allOfIndices length > 0) {
                sb += "AllOf("
                sb += componentsToString(_allOfIndices)
                sb += ")"
            }
            if (_anyOfIndices length > 0) {
                if (_allOfIndices length > 0) {
                    sb += " "
                }
                sb += "AnyOf("
                sb += componentsToString(_anyOfIndices)
                sb += ")"
            }
            if (_noneOfIndices length > 0) {
                sb += " NoneOf("
                sb += componentsToString(_noneOfIndices)
                sb += ")"
            }
            if (sb == "" ) sb = "Empty"
            _toStringCache = sb
        }
        _toStringCache
    }

    componentsToString: static func(indexArray : Int[]) -> String {
        sb := ""
        for (index in 0..indexArray length)
            sb += World components[indexArray[index]-1] replaceAll("Component", "")
        sb
    }

    listToArray: static func(l : List<Int>) -> Int[] {
        a := Int[l size] new()
        for (i in 0..l size) {
            index := l[i]
            a[i] = index
        }
            // a[i] = l[i]
        a
    }
    /**
     * Get the set if distinct (non-duplicate) indices from a list
     * @param Array<number> indices
     * @returns Array<number>
     */
    distinctIndices: static func(indices : Int[]) -> Int[] {
        indicesSet := HashMap<Int, Bool> new()
        result := LinkedList<Int> new()

        for (i in 0..indices length) {
            index := indices[i]
            if (!indicesSet contains?(index)) {
                result add(index)
            }
            indicesSet[index] = true
        }
        l := listToArray(result)
        l
    }
    /**
     * Merge all the indices of a set of Matchers
     * @param Array<IMatcher> matchers
     * @returns Array<number>
     */
    merge: static func(matchers : Matcher[]) -> Int[] {
        indices := LinkedList<Int> new()

        for (i in 0..matchers length-1) {
            matcher := matchers[i]
            if (matcher getIndices() length != 1)
                //raise new Exception ECS("MatcherException - %s", matcher toString())
                MatcherException new(matcher toString()) throw()

            index := matcher getIndices()[0]
            indices add(index)
        }
        listToArray(indices)
    }
    /*
     * Matches allOf the components/indices specified
     * @params Array<entitas IMatcher>|Array<number> args
     * @returns entitas Matcher
     */
     //

    matchAllOf: static func ~vararg(args : ...) -> Matcher {
        a := LinkedList<Int> new()
        args each(|arg|
            match arg {
                case i : Int => a add(i) // pass
                case => // force int
                    i := arg as Int
                    // check if it has an int value in range of the enum
                    if (i >= 0 && i <World components length) {
                        a add(arg as Int)
                    } else {
                        MatcherException new("unsupprted type in vararg") throw()
                    }
            }
        )
        matchAllOf~ary(listToArray(a))    
    }

    matchAllOf: static func ~ary(args : Int[]) -> Matcher {
        matcher := Matcher new()
        matcher _allOfIndices = distinctIndices(args)
        matcher
    }
    /**
     * Matches anyOf the components/indices specified
     * @params Array<entitas IMatcher>|Array<number> args
     * @returns entitas Matcher
     */
    matchAnyOf: static func(args : Int[]) -> Matcher {
        matcher := Matcher new()
        matcher _anyOfIndices = distinctIndices(args)
        matcher
    }


}