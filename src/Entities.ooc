use sdl2
import math
import math/Random
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
import Systems/CollisionSystem
import Systems/ColorTweenSystem
import Systems/EntitySpawningTimerSystem
import Systems/ExpiringSystem
import Systems/HealthRenderSystem
import Systems/MovementSystem
import Systems/PlayerInputSystem
import Systems/RemoveOffscreenShipsSystem
import Systems/RenderPositionSystem
import Systems/ScaleTweenSystem
import Systems/SoundEffectSystem
import Systems/ViewManagerSystem
import Components
import Game

Tau: Double = 3.14159 * 2.0
windowSize := (0, 0, 720, 640) as SdlRect 	
RES: String = "/home/bruce/ooc/shmupwarz/res/images"

Enemy: enum {
    Enemy1
    Enemy2
    Enemy3
}

Layer: enum {
    DEFAULT
    BACKGROUND
    TEXT
    LIVES
    MINES
    ENEMY1
    ENEMY2
    ENEMY3
    PLAYER
    BULLET
    PARTICLE
    EXPLOSION
    BANG
    HUD
}

Effect: enum {
    PEW
    ASPLODE
    SMALLASPLODE
}

getPath: func(name: String) -> String {
    match name {
        case "background" => RES+"/background.png"
        case "player" => RES+"/fighter.png"
        case "bullet" => RES+"/bullet.png"
        case "particle" => RES+"/star.png"
        case "explosion" => RES+"/explosion.png"
        case "bang" => RES+"/explosion.png"
        case "enemy1" => RES+"/enemy1.png"
        case "enemy2" => RES+"/enemy2.png"
        case "enemy3" => RES+"/enemy3.png"

    }
}
getLayer: func(name: String) -> Layer {
    match name {
        case "background" => Layer BACKGROUND
        case "player" => Layer PLAYER
        case "bullet" => Layer BULLET
        case "particle" => Layer PARTICLE
        case "explosion" => Layer EXPLOSION
        case "bang" => Layer BANG
        case "enemy1" => Layer ENEMY1
        case "enemy2" => Layer ENEMY2
        case "enemy3" => Layer ENEMY3

    }
}
extend World {

    createCore: func(game: Game, name: String, x: Double=0.0, y:Double=0.0) -> Entity {
        surface := SDLImage load(getPath(name))
        texture := SDL createTextureFromSurface(game renderer, surface)
        SDL setTextureBlendMode(texture, SDL_BLENDMODE_BLEND)
        
        this createEntity(name
            ) addPosition(x, y
            ) addResource(getPath(name), texture, getLayer(name) != Layer BACKGROUND
            ) addBounds(surface@ w, surface@ h
            ) addLayer(getLayer(name))

    }

    createBackground: func(game:Game) -> Entity {
        this createCore(game, "background"
            ) addScale(2, 2
            ) setActive(true)
        
    }

    createPlayer: func(game:Game) -> Entity {
        this createCore(game, "player"
            ) setPlayer(true
            ) addHealth(100, 100
            ) addVelocity(0, 0
            ) setActive(true)
    }


    /**
    *  Create Bullet
    */
    createBullet: func(game: Game, x : Double, y : Double) -> Entity {
        this createCore(game, "bullet", x, y
            ) setBullet(true
            ) addHealth(1, 1
            ) addVelocity(0, -800
            ) addTint(0xAD, 0xFF, 0x2F, 255
            ) addExpires(1
            ) addSoundEffect(Effect PEW
            ) setActive(true)
    }
    /**
    *  Create Particle
    */
    createParticle: func(game: Game, x : Double, y : Double) -> Entity {
        radians := Random random() * Tau
        magnitude := Random randInt(0, 200)
        velocityX := magnitude * cos(radians)
        velocityY := magnitude * sin(radians)
        scale := Random randInt(1, 10) as Double / 10

        this createCore(game, "particle", x, y
            ) addVelocity(velocityX, velocityY
            ) addExpires(1.0
            ) addScale(scale, scale
            ) addTint(0xFA, 0xFA, 0xD2, 255
            ) setActive(true)
    }
    /**
    *  Create Explosion
    */
    createExplosion: func(game: Game, x: Double, y: Double) -> Entity {
        this createCore(game, "explosion", x, y
            ) addExpires(1.0
            ) addScale(0.5, 0.5
            ) addSoundEffect(Effect ASPLODE
            ) addScaleTween(0.001, 0.5, -3, false, true
            ) addTint(0xFA, 0xFA, 0xD2, 255
            ) setActive(true)
    }

    createBang: func(game: Game, x: Double, y: Double) -> Entity {
        this createCore(game, "bang", x, y
            ) addExpires(1.0
            ) addScale(0.2, 0.2
            ) addSoundEffect(Effect SMALLASPLODE
            ) addScaleTween(0.001, 0.2, -2, false, true
            ) addTint(0xEE, 0xE8, 0xAA, 255
            ) setActive(true)
    }

    createEnemy1: func(game: Game) -> Entity {
        x := Random randInt(0, windowSize w)
        y := windowSize h/2 - 200

        this createCore(game, "enemy1", x, y
            ) setEnemy(true
            ) addHealth(10, 10
            ) addVelocity(0, 40
            ) setActive(true)
    }

    createEnemy2: func(game: Game) -> Entity {
        x := Random randInt(0, windowSize w)
        y := windowSize h/2 - 100

        this createCore(game, "enemy2", x, y
            ) setEnemy(true
            ) addHealth(20, 20
            ) addVelocity(0, 30
            ) setActive(true)
    }

    createEnemy3: func(game: Game) -> Entity {
        x := Random randInt(0, windowSize w)
        y := windowSize h/2 - 50
        
        this createCore(game, "enemy3", x, y
            ) setEnemy(true
            ) addHealth(60, 60
            ) addVelocity(0, 20
            ) setActive(true)
    }

    createText: func(game: Game, text: String, entity: Entity) -> Entity {
        surface := game hudFont renderUTF8Solid(text, (0xff, 0xff, 0x00, 0xff) as SdlColor)
        sprite := SDL createTextureFromSurface(game renderer, surface)

        this createEntity("text"
            ) addPosition(0, 0
            ) addResource("", sprite, false
            ) addBounds(surface@ w, surface@ h
            ) addLayer(Layer HUD
            ) addText(text, null
            ) setActive(true)

        
    }

    createHud: func(game: Game, x: Double, y: Double, label: String, text: String) -> Entity {
        surface := game hudFont renderUTF8Solid(label format(text), (0xff, 0xff, 0xff, 0xff) as SdlColor)
        sprite := SDL createTextureFromSurface(game renderer, surface)

        this createEntity("hud"
            ) addPosition(x, y
            ) addBounds(surface@ w, surface@ h
            ) addLayer(Layer HUD
            ) addHud(label, text, null
            ) addResource("", sprite, false
            ) setActive(true)

    }
}

