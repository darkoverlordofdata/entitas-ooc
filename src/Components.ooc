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
import Entities
/**
 * Entitas Generated Components and Extensions for shmupwarz
 *
 * add your imports above
 * do not edit below this comment
 */
POOL_SIZE := 64

/**
* Component extensions
*/
components := [
    "ActiveComponent",
    "BoundsComponent",
    "BulletComponent",
    "ColorTweenComponent",
    "DestroyComponent",
    "EnemyComponent",
    "ExpiresComponent",
    "HealthComponent",
    "LayerComponent",
    "PlayerComponent",
    "PositionComponent",
    "ResourceComponent",
    "ScaleTweenComponent",
    "ScaleComponent",
    "ScoreComponent",
    "SoundEffectComponent",
    "TextComponent",
    "TintComponent",
    "VelocityComponent",
    "HudComponent",
    "EntityComponent",
    "ComponentsCount"
    ]

Component: enum {
    Active
    Bounds
    Bullet
    ColorTween
    Destroy
    Enemy
    Expires
    Health
    Layer
    Player
    Position
    Resource
    ScaleTween
    Scale
    Score
    SoundEffect
    Text
    Tint
    Velocity
    Hud
    Entity
    ComponentsCount
}


ActiveComponent : class extends IComponent {
    active : Bool = true
    init: func()
}

BoundsComponent : class extends IComponent {
    width : Double 
    height : Double 
    init: func()
}
BulletComponent : class extends IComponent {
    active : Bool = true
    init: func()
}

ColorTweenComponent : class extends IComponent {
    redMin : Double 
    redMax : Double 
    redSpeed : Double 
    greenMin : Double 
    greenMax : Double 
    greenSpeed : Double 
    blueMin : Double 
    blueMax : Double 
    blueSpeed : Double 
    alphaMin : Double 
    alphaMax : Double 
    alphaSpeed : Double 
    redAnimate : Bool 
    greenAnimate : Bool 
    blueAnimate : Bool 
    alphaAnimate : Bool 
    repeat : Bool 
    init: func()
}
DestroyComponent : class extends IComponent {
    active : Bool = true
    init: func()
}

EnemyComponent : class extends IComponent {
    active : Bool = true
    init: func()
}

ExpiresComponent : class extends IComponent {
    delay : Double 
    init: func()
}
HealthComponent : class extends IComponent {
    health : Double 
    maximumHealth : Double 
    init: func()
}
LayerComponent : class extends IComponent {
    ordinal : Layer 
    init: func()
}
PlayerComponent : class extends IComponent {
    active : Bool = true
    init: func()
}

PositionComponent : class extends IComponent {
    x : Double 
    y : Double 
    init: func()
}
ResourceComponent : class extends IComponent {
    path : String 
    sprite : SdlTexture 
    bgd : Bool 
    init: func()
}
ScaleTweenComponent : class extends IComponent {
    min : Double 
    max : Double 
    speed : Double 
    repeat : Bool 
    active : Bool 
    init: func()
}
ScaleComponent : class extends IComponent {
    x : Double 
    y : Double 
    init: func()
}
ScoreComponent : class extends IComponent {
    value : Double 
    init: func()
}
SoundEffectComponent : class extends IComponent {
    effect : Effect 
    init: func()
}
TextComponent : class extends IComponent {
    text : String 
    sprite : SdlTexture 
    init: func()
}
TintComponent : class extends IComponent {
    r : Int 
    g : Int 
    b : Int 
    a : Int 
    init: func()
}
VelocityComponent : class extends IComponent {
    x : Double 
    y : Double 
    init: func()
}
HudComponent : class extends IComponent {
    label : String 
    text : String 
    sprite : SdlTexture 
    init: func()
}
EntityComponent : class extends IComponent {
    entity : Entity 
    init: func()
}


/**
* Entity extensions
*/
extend Entity {


    /* Entity: Active methods*/

    /** @type boolean */
    isActive : Bool {
        get { hasComponent(Component Active as Int) }
    }
    /**
     * @param value boolean
     * @return entitas.Entity
     */
    setActive: func(value : Bool) -> This {
        index := Component Active as Int
        c := __activeComponent
        if (value) {
            addComponent(index, c)
        } else {
            removeComponent(index)
        }
        this
    }


    /* Entity: Bounds methods*/

    /** @type Bounds */
    bounds : IComponent {
        get { getComponent(Component Bounds as Int) }
    }
    /** @type boolean */
    hasBounds : Bool {
        get { hasComponent(Component Bounds as Int) }
    }
    clearBoundsComponentPool: func() {
        __boundsComponentPool clear()
    }
    /**
     * @param width Double
     * @param height Double
     * @return entitas.Entity
     */
    addBounds: func(width:Double,height:Double) -> This {
        c := __boundsComponentPool empty?() ? BoundsComponent new() : __boundsComponentPool pop()
        c width = width
        c height = height
        addComponent(Component Bounds as Int, c)
        this
    }
    /**
     * @param width Double
     * @param height Double
     * @return entitas.Entity
     */
    replaceBounds: func(width:Double,height:Double) -> This {
        previousComponent := this hasBounds ? this bounds as BoundsComponent : null
        c := __boundsComponentPool empty?() ? BoundsComponent new() : __boundsComponentPool pop()
        c width = width
        c height = height
        replaceComponent(Component Bounds as Int, c) 
        if (previousComponent != null)
            __boundsComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeBounds: func() -> This {
        c := bounds as BoundsComponent
        removeComponent(Component Bounds as Int) 
        __boundsComponentPool push(c)
        this
    }

    /* Entity: Bullet methods*/

    /** @type boolean */
    isBullet : Bool {
        get { hasComponent(Component Bullet as Int) }
    }
    /**
     * @param value boolean
     * @return entitas.Entity
     */
    setBullet: func(value : Bool) -> This {
        index := Component Bullet as Int
        c := __bulletComponent
        if (value) {
            addComponent(index, c)
        } else {
            removeComponent(index)
        }
        this
    }


    /* Entity: ColorTween methods*/

    /** @type ColorTween */
    colorTween : IComponent {
        get { getComponent(Component ColorTween as Int) }
    }
    /** @type boolean */
    hasColorTween : Bool {
        get { hasComponent(Component ColorTween as Int) }
    }
    clearColorTweenComponentPool: func() {
        __colorTweenComponentPool clear()
    }
    /**
     * @param redMin Double
     * @param redMax Double
     * @param redSpeed Double
     * @param greenMin Double
     * @param greenMax Double
     * @param greenSpeed Double
     * @param blueMin Double
     * @param blueMax Double
     * @param blueSpeed Double
     * @param alphaMin Double
     * @param alphaMax Double
     * @param alphaSpeed Double
     * @param redAnimate Bool
     * @param greenAnimate Bool
     * @param blueAnimate Bool
     * @param alphaAnimate Bool
     * @param repeat Bool
     * @return entitas.Entity
     */
    addColorTween: func(redMin:Double,redMax:Double,redSpeed:Double,greenMin:Double,greenMax:Double,greenSpeed:Double,blueMin:Double,blueMax:Double,blueSpeed:Double,alphaMin:Double,alphaMax:Double,alphaSpeed:Double,redAnimate:Bool,greenAnimate:Bool,blueAnimate:Bool,alphaAnimate:Bool,repeat:Bool) -> This {
        c := __colorTweenComponentPool empty?() ? ColorTweenComponent new() : __colorTweenComponentPool pop()
        c redMin = redMin
        c redMax = redMax
        c redSpeed = redSpeed
        c greenMin = greenMin
        c greenMax = greenMax
        c greenSpeed = greenSpeed
        c blueMin = blueMin
        c blueMax = blueMax
        c blueSpeed = blueSpeed
        c alphaMin = alphaMin
        c alphaMax = alphaMax
        c alphaSpeed = alphaSpeed
        c redAnimate = redAnimate
        c greenAnimate = greenAnimate
        c blueAnimate = blueAnimate
        c alphaAnimate = alphaAnimate
        c repeat = repeat
        addComponent(Component ColorTween as Int, c)
        this
    }
    /**
     * @param redMin Double
     * @param redMax Double
     * @param redSpeed Double
     * @param greenMin Double
     * @param greenMax Double
     * @param greenSpeed Double
     * @param blueMin Double
     * @param blueMax Double
     * @param blueSpeed Double
     * @param alphaMin Double
     * @param alphaMax Double
     * @param alphaSpeed Double
     * @param redAnimate Bool
     * @param greenAnimate Bool
     * @param blueAnimate Bool
     * @param alphaAnimate Bool
     * @param repeat Bool
     * @return entitas.Entity
     */
    replaceColorTween: func(redMin:Double,redMax:Double,redSpeed:Double,greenMin:Double,greenMax:Double,greenSpeed:Double,blueMin:Double,blueMax:Double,blueSpeed:Double,alphaMin:Double,alphaMax:Double,alphaSpeed:Double,redAnimate:Bool,greenAnimate:Bool,blueAnimate:Bool,alphaAnimate:Bool,repeat:Bool) -> This {
        previousComponent := this hasColorTween ? this colorTween as ColorTweenComponent : null
        c := __colorTweenComponentPool empty?() ? ColorTweenComponent new() : __colorTweenComponentPool pop()
        c redMin = redMin
        c redMax = redMax
        c redSpeed = redSpeed
        c greenMin = greenMin
        c greenMax = greenMax
        c greenSpeed = greenSpeed
        c blueMin = blueMin
        c blueMax = blueMax
        c blueSpeed = blueSpeed
        c alphaMin = alphaMin
        c alphaMax = alphaMax
        c alphaSpeed = alphaSpeed
        c redAnimate = redAnimate
        c greenAnimate = greenAnimate
        c blueAnimate = blueAnimate
        c alphaAnimate = alphaAnimate
        c repeat = repeat
        replaceComponent(Component ColorTween as Int, c) 
        if (previousComponent != null)
            __colorTweenComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeColorTween: func() -> This {
        c := colorTween as ColorTweenComponent
        removeComponent(Component ColorTween as Int) 
        __colorTweenComponentPool push(c)
        this
    }

    /* Entity: Destroy methods*/

    /** @type boolean */
    isDestroy : Bool {
        get { hasComponent(Component Destroy as Int) }
    }
    /**
     * @param value boolean
     * @return entitas.Entity
     */
    setDestroy: func(value : Bool) -> This {
        index := Component Destroy as Int
        c := __destroyComponent
        if (value) {
            addComponent(index, c)
        } else {
            removeComponent(index)
        }
        this
    }


    /* Entity: Enemy methods*/

    /** @type boolean */
    isEnemy : Bool {
        get { hasComponent(Component Enemy as Int) }
    }
    /**
     * @param value boolean
     * @return entitas.Entity
     */
    setEnemy: func(value : Bool) -> This {
        index := Component Enemy as Int
        c := __enemyComponent
        if (value) {
            addComponent(index, c)
        } else {
            removeComponent(index)
        }
        this
    }


    /* Entity: Expires methods*/

    /** @type Expires */
    expires : IComponent {
        get { getComponent(Component Expires as Int) }
    }
    /** @type boolean */
    hasExpires : Bool {
        get { hasComponent(Component Expires as Int) }
    }
    clearExpiresComponentPool: func() {
        __expiresComponentPool clear()
    }
    /**
     * @param delay Double
     * @return entitas.Entity
     */
    addExpires: func(delay:Double) -> This {
        c := __expiresComponentPool empty?() ? ExpiresComponent new() : __expiresComponentPool pop()
        c delay = delay
        addComponent(Component Expires as Int, c)
        this
    }
    /**
     * @param delay Double
     * @return entitas.Entity
     */
    replaceExpires: func(delay:Double) -> This {
        previousComponent := this hasExpires ? this expires as ExpiresComponent : null
        c := __expiresComponentPool empty?() ? ExpiresComponent new() : __expiresComponentPool pop()
        c delay = delay
        replaceComponent(Component Expires as Int, c) 
        if (previousComponent != null)
            __expiresComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeExpires: func() -> This {
        c := expires as ExpiresComponent
        removeComponent(Component Expires as Int) 
        __expiresComponentPool push(c)
        this
    }

    /* Entity: Health methods*/

    /** @type Health */
    health : IComponent {
        get { getComponent(Component Health as Int) }
    }
    /** @type boolean */
    hasHealth : Bool {
        get { hasComponent(Component Health as Int) }
    }
    clearHealthComponentPool: func() {
        __healthComponentPool clear()
    }
    /**
     * @param health Double
     * @param maximumHealth Double
     * @return entitas.Entity
     */
    addHealth: func(health:Double,maximumHealth:Double) -> This {
        c := __healthComponentPool empty?() ? HealthComponent new() : __healthComponentPool pop()
        c health = health
        c maximumHealth = maximumHealth
        addComponent(Component Health as Int, c)
        this
    }
    /**
     * @param health Double
     * @param maximumHealth Double
     * @return entitas.Entity
     */
    replaceHealth: func(health:Double,maximumHealth:Double) -> This {
        previousComponent := this hasHealth ? this health as HealthComponent : null
        c := __healthComponentPool empty?() ? HealthComponent new() : __healthComponentPool pop()
        c health = health
        c maximumHealth = maximumHealth
        replaceComponent(Component Health as Int, c) 
        if (previousComponent != null)
            __healthComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeHealth: func() -> This {
        c := health as HealthComponent
        removeComponent(Component Health as Int) 
        __healthComponentPool push(c)
        this
    }

    /* Entity: Layer methods*/

    /** @type Layer */
    layer : IComponent {
        get { getComponent(Component Layer as Int) }
    }
    /** @type boolean */
    hasLayer : Bool {
        get { hasComponent(Component Layer as Int) }
    }
    clearLayerComponentPool: func() {
        __layerComponentPool clear()
    }
    /**
     * @param ordinal Layer
     * @return entitas.Entity
     */
    addLayer: func(ordinal:Layer) -> This {
        c := __layerComponentPool empty?() ? LayerComponent new() : __layerComponentPool pop()
        c ordinal = ordinal
        addComponent(Component Layer as Int, c)
        this
    }
    /**
     * @param ordinal Layer
     * @return entitas.Entity
     */
    replaceLayer: func(ordinal:Layer) -> This {
        previousComponent := this hasLayer ? this layer as LayerComponent : null
        c := __layerComponentPool empty?() ? LayerComponent new() : __layerComponentPool pop()
        c ordinal = ordinal
        replaceComponent(Component Layer as Int, c) 
        if (previousComponent != null)
            __layerComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeLayer: func() -> This {
        c := layer as LayerComponent
        removeComponent(Component Layer as Int) 
        __layerComponentPool push(c)
        this
    }

    /* Entity: Player methods*/

    /** @type boolean */
    isPlayer : Bool {
        get { hasComponent(Component Player as Int) }
    }
    /**
     * @param value boolean
     * @return entitas.Entity
     */
    setPlayer: func(value : Bool) -> This {
        index := Component Player as Int
        c := __playerComponent
        if (value) {
            addComponent(index, c)
        } else {
            removeComponent(index)
        }
        this
    }


    /* Entity: Position methods*/

    /** @type Position */
    position : IComponent {
        get { getComponent(Component Position as Int) }
    }
    /** @type boolean */
    hasPosition : Bool {
        get { hasComponent(Component Position as Int) }
    }
    clearPositionComponentPool: func() {
        __positionComponentPool clear()
    }
    /**
     * @param x Double
     * @param y Double
     * @return entitas.Entity
     */
    addPosition: func(x:Double,y:Double) -> This {
        c := __positionComponentPool empty?() ? PositionComponent new() : __positionComponentPool pop()
        c x = x
        c y = y
        addComponent(Component Position as Int, c)
        this
    }
    /**
     * @param x Double
     * @param y Double
     * @return entitas.Entity
     */
    replacePosition: func(x:Double,y:Double) -> This {
        previousComponent := this hasPosition ? this position as PositionComponent : null
        c := __positionComponentPool empty?() ? PositionComponent new() : __positionComponentPool pop()
        c x = x
        c y = y
        replaceComponent(Component Position as Int, c) 
        if (previousComponent != null)
            __positionComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removePosition: func() -> This {
        c := position as PositionComponent
        removeComponent(Component Position as Int) 
        __positionComponentPool push(c)
        this
    }

    /* Entity: Resource methods*/

    /** @type Resource */
    resource : IComponent {
        get { getComponent(Component Resource as Int) }
    }
    /** @type boolean */
    hasResource : Bool {
        get { hasComponent(Component Resource as Int) }
    }
    clearResourceComponentPool: func() {
        __resourceComponentPool clear()
    }
    /**
     * @param path String
     * @param sprite SdlTexture
     * @param bgd Bool
     * @return entitas.Entity
     */
    addResource: func(path:String,sprite:SdlTexture,bgd:Bool) -> This {
        c := __resourceComponentPool empty?() ? ResourceComponent new() : __resourceComponentPool pop()
        c path = path
        c sprite = sprite
        c bgd = bgd
        addComponent(Component Resource as Int, c)
        this
    }
    /**
     * @param path String
     * @param sprite SdlTexture
     * @param bgd Bool
     * @return entitas.Entity
     */
    replaceResource: func(path:String,sprite:SdlTexture,bgd:Bool) -> This {
        previousComponent := this hasResource ? this resource as ResourceComponent : null
        c := __resourceComponentPool empty?() ? ResourceComponent new() : __resourceComponentPool pop()
        c path = path
        c sprite = sprite
        c bgd = bgd
        replaceComponent(Component Resource as Int, c) 
        if (previousComponent != null)
            __resourceComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeResource: func() -> This {
        c := resource as ResourceComponent
        removeComponent(Component Resource as Int) 
        __resourceComponentPool push(c)
        this
    }

    /* Entity: ScaleTween methods*/

    /** @type ScaleTween */
    scaleTween : IComponent {
        get { getComponent(Component ScaleTween as Int) }
    }
    /** @type boolean */
    hasScaleTween : Bool {
        get { hasComponent(Component ScaleTween as Int) }
    }
    clearScaleTweenComponentPool: func() {
        __scaleTweenComponentPool clear()
    }
    /**
     * @param min Double
     * @param max Double
     * @param speed Double
     * @param repeat Bool
     * @param active Bool
     * @return entitas.Entity
     */
    addScaleTween: func(min:Double,max:Double,speed:Double,repeat:Bool,active:Bool) -> This {
        c := __scaleTweenComponentPool empty?() ? ScaleTweenComponent new() : __scaleTweenComponentPool pop()
        c min = min
        c max = max
        c speed = speed
        c repeat = repeat
        c active = active
        addComponent(Component ScaleTween as Int, c)
        this
    }
    /**
     * @param min Double
     * @param max Double
     * @param speed Double
     * @param repeat Bool
     * @param active Bool
     * @return entitas.Entity
     */
    replaceScaleTween: func(min:Double,max:Double,speed:Double,repeat:Bool,active:Bool) -> This {
        previousComponent := this hasScaleTween ? this scaleTween as ScaleTweenComponent : null
        c := __scaleTweenComponentPool empty?() ? ScaleTweenComponent new() : __scaleTweenComponentPool pop()
        c min = min
        c max = max
        c speed = speed
        c repeat = repeat
        c active = active
        replaceComponent(Component ScaleTween as Int, c) 
        if (previousComponent != null)
            __scaleTweenComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeScaleTween: func() -> This {
        c := scaleTween as ScaleTweenComponent
        removeComponent(Component ScaleTween as Int) 
        __scaleTweenComponentPool push(c)
        this
    }

    /* Entity: Scale methods*/

    /** @type Scale */
    scale : IComponent {
        get { getComponent(Component Scale as Int) }
    }
    /** @type boolean */
    hasScale : Bool {
        get { hasComponent(Component Scale as Int) }
    }
    clearScaleComponentPool: func() {
        __scaleComponentPool clear()
    }
    /**
     * @param x Double
     * @param y Double
     * @return entitas.Entity
     */
    addScale: func(x:Double,y:Double) -> This {
        c := __scaleComponentPool empty?() ? ScaleComponent new() : __scaleComponentPool pop()
        c x = x
        c y = y
        addComponent(Component Scale as Int, c)
        this
    }
    /**
     * @param x Double
     * @param y Double
     * @return entitas.Entity
     */
    replaceScale: func(x:Double,y:Double) -> This {
        previousComponent := this hasScale ? this scale as ScaleComponent : null
        c := __scaleComponentPool empty?() ? ScaleComponent new() : __scaleComponentPool pop()
        c x = x
        c y = y
        replaceComponent(Component Scale as Int, c) 
        if (previousComponent != null)
            __scaleComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeScale: func() -> This {
        c := scale as ScaleComponent
        removeComponent(Component Scale as Int) 
        __scaleComponentPool push(c)
        this
    }

    /* Entity: Score methods*/

    /** @type Score */
    score : IComponent {
        get { getComponent(Component Score as Int) }
    }
    /** @type boolean */
    hasScore : Bool {
        get { hasComponent(Component Score as Int) }
    }
    clearScoreComponentPool: func() {
        __scoreComponentPool clear()
    }
    /**
     * @param value Double
     * @return entitas.Entity
     */
    addScore: func(value:Double) -> This {
        c := __scoreComponentPool empty?() ? ScoreComponent new() : __scoreComponentPool pop()
        c value = value
        addComponent(Component Score as Int, c)
        this
    }
    /**
     * @param value Double
     * @return entitas.Entity
     */
    replaceScore: func(value:Double) -> This {
        previousComponent := this hasScore ? this score as ScoreComponent : null
        c := __scoreComponentPool empty?() ? ScoreComponent new() : __scoreComponentPool pop()
        c value = value
        replaceComponent(Component Score as Int, c) 
        if (previousComponent != null)
            __scoreComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeScore: func() -> This {
        c := score as ScoreComponent
        removeComponent(Component Score as Int) 
        __scoreComponentPool push(c)
        this
    }

    /* Entity: SoundEffect methods*/

    /** @type SoundEffect */
    soundEffect : IComponent {
        get { getComponent(Component SoundEffect as Int) }
    }
    /** @type boolean */
    hasSoundEffect : Bool {
        get { hasComponent(Component SoundEffect as Int) }
    }
    clearSoundEffectComponentPool: func() {
        __soundEffectComponentPool clear()
    }
    /**
     * @param effect Effect
     * @return entitas.Entity
     */
    addSoundEffect: func(effect:Effect) -> This {
        c := __soundEffectComponentPool empty?() ? SoundEffectComponent new() : __soundEffectComponentPool pop()
        c effect = effect
        addComponent(Component SoundEffect as Int, c)
        this
    }
    /**
     * @param effect Effect
     * @return entitas.Entity
     */
    replaceSoundEffect: func(effect:Effect) -> This {
        previousComponent := this hasSoundEffect ? this soundEffect as SoundEffectComponent : null
        c := __soundEffectComponentPool empty?() ? SoundEffectComponent new() : __soundEffectComponentPool pop()
        c effect = effect
        replaceComponent(Component SoundEffect as Int, c) 
        if (previousComponent != null)
            __soundEffectComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeSoundEffect: func() -> This {
        c := soundEffect as SoundEffectComponent
        removeComponent(Component SoundEffect as Int) 
        __soundEffectComponentPool push(c)
        this
    }

    /* Entity: Text methods*/

    /** @type Text */
    text : IComponent {
        get { getComponent(Component Text as Int) }
    }
    /** @type boolean */
    hasText : Bool {
        get { hasComponent(Component Text as Int) }
    }
    clearTextComponentPool: func() {
        __textComponentPool clear()
    }
    /**
     * @param text String
     * @param sprite SdlTexture
     * @return entitas.Entity
     */
    addText: func(text:String,sprite:SdlTexture) -> This {
        c := __textComponentPool empty?() ? TextComponent new() : __textComponentPool pop()
        c text = text
        c sprite = sprite
        addComponent(Component Text as Int, c)
        this
    }
    /**
     * @param text String
     * @param sprite SdlTexture
     * @return entitas.Entity
     */
    replaceText: func(text:String,sprite:SdlTexture) -> This {
        previousComponent := this hasText ? this text as TextComponent : null
        c := __textComponentPool empty?() ? TextComponent new() : __textComponentPool pop()
        c text = text
        c sprite = sprite
        replaceComponent(Component Text as Int, c) 
        if (previousComponent != null)
            __textComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeText: func() -> This {
        c := text as TextComponent
        removeComponent(Component Text as Int) 
        __textComponentPool push(c)
        this
    }

    /* Entity: Tint methods*/

    /** @type Tint */
    tint : IComponent {
        get { getComponent(Component Tint as Int) }
    }
    /** @type boolean */
    hasTint : Bool {
        get { hasComponent(Component Tint as Int) }
    }
    clearTintComponentPool: func() {
        __tintComponentPool clear()
    }
    /**
     * @param r Int
     * @param g Int
     * @param b Int
     * @param a Int
     * @return entitas.Entity
     */
    addTint: func(r:Int,g:Int,b:Int,a:Int) -> This {
        c := __tintComponentPool empty?() ? TintComponent new() : __tintComponentPool pop()
        c r = r
        c g = g
        c b = b
        c a = a
        addComponent(Component Tint as Int, c)
        this
    }
    /**
     * @param r Int
     * @param g Int
     * @param b Int
     * @param a Int
     * @return entitas.Entity
     */
    replaceTint: func(r:Int,g:Int,b:Int,a:Int) -> This {
        previousComponent := this hasTint ? this tint as TintComponent : null
        c := __tintComponentPool empty?() ? TintComponent new() : __tintComponentPool pop()
        c r = r
        c g = g
        c b = b
        c a = a
        replaceComponent(Component Tint as Int, c) 
        if (previousComponent != null)
            __tintComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeTint: func() -> This {
        c := tint as TintComponent
        removeComponent(Component Tint as Int) 
        __tintComponentPool push(c)
        this
    }

    /* Entity: Velocity methods*/

    /** @type Velocity */
    velocity : IComponent {
        get { getComponent(Component Velocity as Int) }
    }
    /** @type boolean */
    hasVelocity : Bool {
        get { hasComponent(Component Velocity as Int) }
    }
    clearVelocityComponentPool: func() {
        __velocityComponentPool clear()
    }
    /**
     * @param x Double
     * @param y Double
     * @return entitas.Entity
     */
    addVelocity: func(x:Double,y:Double) -> This {
        c := __velocityComponentPool empty?() ? VelocityComponent new() : __velocityComponentPool pop()
        c x = x
        c y = y
        addComponent(Component Velocity as Int, c)
        this
    }
    /**
     * @param x Double
     * @param y Double
     * @return entitas.Entity
     */
    replaceVelocity: func(x:Double,y:Double) -> This {
        previousComponent := this hasVelocity ? this velocity as VelocityComponent : null
        c := __velocityComponentPool empty?() ? VelocityComponent new() : __velocityComponentPool pop()
        c x = x
        c y = y
        replaceComponent(Component Velocity as Int, c) 
        if (previousComponent != null)
            __velocityComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeVelocity: func() -> This {
        c := velocity as VelocityComponent
        removeComponent(Component Velocity as Int) 
        __velocityComponentPool push(c)
        this
    }

    /* Entity: Hud methods*/

    /** @type Hud */
    hud : IComponent {
        get { getComponent(Component Hud as Int) }
    }
    /** @type boolean */
    hasHud : Bool {
        get { hasComponent(Component Hud as Int) }
    }
    clearHudComponentPool: func() {
        __hudComponentPool clear()
    }
    /**
     * @param label String
     * @param text String
     * @param sprite SdlTexture
     * @return entitas.Entity
     */
    addHud: func(label:String,text:String,sprite:SdlTexture) -> This {
        c := __hudComponentPool empty?() ? HudComponent new() : __hudComponentPool pop()
        c label = label
        c text = text
        c sprite = sprite
        addComponent(Component Hud as Int, c)
        this
    }
    /**
     * @param label String
     * @param text String
     * @param sprite SdlTexture
     * @return entitas.Entity
     */
    replaceHud: func(label:String,text:String,sprite:SdlTexture) -> This {
        previousComponent := this hasHud ? this hud as HudComponent : null
        c := __hudComponentPool empty?() ? HudComponent new() : __hudComponentPool pop()
        c label = label
        c text = text
        c sprite = sprite
        replaceComponent(Component Hud as Int, c) 
        if (previousComponent != null)
            __hudComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeHud: func() -> This {
        c := hud as HudComponent
        removeComponent(Component Hud as Int) 
        __hudComponentPool push(c)
        this
    }

    /* Entity: Entity methods*/

    /** @type Entity */
    entity : IComponent {
        get { getComponent(Component Entity as Int) }
    }
    /** @type boolean */
    hasEntity : Bool {
        get { hasComponent(Component Entity as Int) }
    }
    clearEntityComponentPool: func() {
        __entityComponentPool clear()
    }
    /**
     * @param entity Entity
     * @return entitas.Entity
     */
    addEntity: func(entity:Entity) -> This {
        c := __entityComponentPool empty?() ? EntityComponent new() : __entityComponentPool pop()
        c entity = entity
        addComponent(Component Entity as Int, c)
        this
    }
    /**
     * @param entity Entity
     * @return entitas.Entity
     */
    replaceEntity: func(entity:Entity) -> This {
        previousComponent := this hasEntity ? this entity as EntityComponent : null
        c := __entityComponentPool empty?() ? EntityComponent new() : __entityComponentPool pop()
        c entity = entity
        replaceComponent(Component Entity as Int, c) 
        if (previousComponent != null)
            __entityComponentPool push(previousComponent)
        this
    }
    /**
     * @returns entitas.Entity
     */
    removeEntity: func() -> This {
        c := entity as EntityComponent
        removeComponent(Component Entity as Int) 
        __entityComponentPool push(c)
        this
    }

}


/** @type Active */
__activeComponent : ActiveComponent
    /** @type Stack<Bounds> */
__boundsComponentPool : Stack<BoundsComponent>

/** @type Bullet */
__bulletComponent : BulletComponent
    /** @type Stack<ColorTween> */
__colorTweenComponentPool : Stack<ColorTweenComponent>

/** @type Destroy */
__destroyComponent : DestroyComponent

/** @type Enemy */
__enemyComponent : EnemyComponent
    /** @type Stack<Expires> */
__expiresComponentPool : Stack<ExpiresComponent>
    /** @type Stack<Health> */
__healthComponentPool : Stack<HealthComponent>
    /** @type Stack<Layer> */
__layerComponentPool : Stack<LayerComponent>

/** @type Player */
__playerComponent : PlayerComponent
    /** @type Stack<Position> */
__positionComponentPool : Stack<PositionComponent>
    /** @type Stack<Resource> */
__resourceComponentPool : Stack<ResourceComponent>
    /** @type Stack<ScaleTween> */
__scaleTweenComponentPool : Stack<ScaleTweenComponent>
    /** @type Stack<Scale> */
__scaleComponentPool : Stack<ScaleComponent>
    /** @type Stack<Score> */
__scoreComponentPool : Stack<ScoreComponent>
    /** @type Stack<SoundEffect> */
__soundEffectComponentPool : Stack<SoundEffectComponent>
    /** @type Stack<Text> */
__textComponentPool : Stack<TextComponent>
    /** @type Stack<Tint> */
__tintComponentPool : Stack<TintComponent>
    /** @type Stack<Velocity> */
__velocityComponentPool : Stack<VelocityComponent>
    /** @type Stack<Hud> */
__hudComponentPool : Stack<HudComponent>
    /** @type Stack<Entity> */
__entityComponentPool : Stack<EntityComponent>


initPools: func(){
    /* Preallocate component pools*/

    __activeComponent = ActiveComponent new()
    __boundsComponentPool = Stack<BoundsComponent> new()
    for(i in 1..POOL_SIZE) 
        __boundsComponentPool push(BoundsComponent new())

    __bulletComponent = BulletComponent new()
    __colorTweenComponentPool = Stack<ColorTweenComponent> new()
    for(i in 1..POOL_SIZE) 
        __colorTweenComponentPool push(ColorTweenComponent new())

    __destroyComponent = DestroyComponent new()

    __enemyComponent = EnemyComponent new()
    __expiresComponentPool = Stack<ExpiresComponent> new()
    for(i in 1..POOL_SIZE) 
        __expiresComponentPool push(ExpiresComponent new())
    __healthComponentPool = Stack<HealthComponent> new()
    for(i in 1..POOL_SIZE) 
        __healthComponentPool push(HealthComponent new())
    __layerComponentPool = Stack<LayerComponent> new()
    for(i in 1..POOL_SIZE) 
        __layerComponentPool push(LayerComponent new())

    __playerComponent = PlayerComponent new()
    __positionComponentPool = Stack<PositionComponent> new()
    for(i in 1..POOL_SIZE) 
        __positionComponentPool push(PositionComponent new())
    __resourceComponentPool = Stack<ResourceComponent> new()
    for(i in 1..POOL_SIZE) 
        __resourceComponentPool push(ResourceComponent new())
    __scaleTweenComponentPool = Stack<ScaleTweenComponent> new()
    for(i in 1..POOL_SIZE) 
        __scaleTweenComponentPool push(ScaleTweenComponent new())
    __scaleComponentPool = Stack<ScaleComponent> new()
    for(i in 1..POOL_SIZE) 
        __scaleComponentPool push(ScaleComponent new())
    __scoreComponentPool = Stack<ScoreComponent> new()
    for(i in 1..POOL_SIZE) 
        __scoreComponentPool push(ScoreComponent new())
    __soundEffectComponentPool = Stack<SoundEffectComponent> new()
    for(i in 1..POOL_SIZE) 
        __soundEffectComponentPool push(SoundEffectComponent new())
    __textComponentPool = Stack<TextComponent> new()
    for(i in 1..POOL_SIZE) 
        __textComponentPool push(TextComponent new())
    __tintComponentPool = Stack<TintComponent> new()
    for(i in 1..POOL_SIZE) 
        __tintComponentPool push(TintComponent new())
    __velocityComponentPool = Stack<VelocityComponent> new()
    for(i in 1..POOL_SIZE) 
        __velocityComponentPool push(VelocityComponent new())
    __hudComponentPool = Stack<HudComponent> new()
    for(i in 1..POOL_SIZE) 
        __hudComponentPool push(HudComponent new())
    __entityComponentPool = Stack<EntityComponent> new()
    for(i in 1..POOL_SIZE) 
        __entityComponentPool push(EntityComponent new())

}
