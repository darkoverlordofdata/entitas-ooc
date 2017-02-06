


EntityIsNotEnabled: class extends Exception {
    init: func(msg: String) {
        super("Entity is Not Enabled: %s" format(msg))
    }
}
EntityAlreadyHasComponent: class extends Exception {
    init: func(name: String, index: Int) {
        super("Cannot add %s at index %d" format(name, index))
    }
}
EntityDoesNotHaveComponent: class extends Exception {
    init: func(name: String, index: Int) {
        super("Component not found in %s at index %d: %s" format(name, index))
    }
}
EntityIsAlreadyReleased: class extends Exception {
    init: func(id: String, name: String) {
        super("Entity is Already Released %s: %s" format(id, name))
    }
}
SingleEntityException: class extends Exception {
    init: func(count: Int) {
        super("Single Entity Exception found : %d" format(count))
    }
}
MatcherException: class extends Exception {
    init: func(msg: String) {
        super(": %s" format(msg))
    }
}
WorldDoesNotContainEntity: class extends Exception {
    init: func(msg: String) {
        super(": %s" format(msg))
    }
}
