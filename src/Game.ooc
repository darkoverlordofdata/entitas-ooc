use sdl2
import math
import sdl2/[Core, Event, Image, TTF, RW]
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
import Entities
import Components
import Game

Point2d: cover {
    x: Double
    y: Double
}

Vector2d: cover {
    x: Double
    y: Double
}

Input: enum {   
    /* User Input */
    NONE        = 0
    LEFT        = 1
    RIGHT       = 2
    JUMP        = 3
    RESTART     = 4
    QUIT        = 5
}

Game: class {
    font: TTFFont
    rawFont: RWops
    evt : SdlEvent
    renderer: SdlRenderer
    mouse: Point2d 
    inputs: Bool[]
    world: World
    player: PlayerInputSystem
    sprites: LinkedList<Entity>

    FONT_TTF:String = "/home/bruce/ooc/demo/res/fonts/OpenDyslexic-Bold.otf"

    init: func(=renderer) {
        sprites = LinkedList<SdlTexture> new()
        font = TTFFont new(FONT_TTF, 28)
        if (!font) {
            Exception new("Font can not be loaded!") throw()
        }
        inputs = Bool[6] new()
        initPools()
        world = World new(components) 
        world add(MovementSystem new(this))
        world add(player = PlayerInputSystem new(this))
        world add(SoundEffectSystem new(this))
        world add(CollisionSystem new(this))
        world add(ExpiringSystem new(this))
        world add(EntitySpawningTimerSystem new(this))
        world add(ColorTweenSystem new(this))
        world add(ScaleTweenSystem new(this))
        world add(RemoveOffscreenShipsSystem new(this))
        world add(ViewManagerSystem new(this))
        world add(RenderPositionSystem new(this))
        // world add(HealthRenderSystem(this))
        // world add(HudRenderSystem new(this))
        // world add(DestroySystem new(this))
        world initialize()
        world createBackground(this)
        // world createPlayer()
        
    }

    drawSprite: func(e: Entity) {
        w := (e hasScale != 0) ? e getBounds() width * e getScale() x : e getBounds() width
        h := (e hasScale != 0) ? e getBounds() height * e getScale() y : e getBounds() height
        x := e getPosition() x - w / 2
        y := e getPosition() y - h / 2
        if (e hasTint) {
            SDL setTextureColorMod(e getResource() sprite, e getTint() r, e getTint() g, e getTint() b)
        }
        SDL renderCopy(renderer, e getResource() sprite, null, (x, y, w, h) as SdlRect&)
        
    }

    draw: func(fps: Int)  {		
        SDL setRenderDrawColor(renderer, 0x00, 0x00, 0x00, 0xff)
		SDL renderClear(renderer)
        for (i in 0..sprites size) {
            drawSprite(sprites[i])            
        }

        text := font renderUTF8Solid(fps toString(), (0xff, 0xff, 0xff, 0xff) as SdlColor)
        texture := SDL createTextureFromSurface(renderer, text)
        SDL renderCopy(renderer, texture, null, (5, 5, 56, 28) as SdlRect&)
		SDL renderPresent(renderer)
    }

    update: func(delta: Double) {
        world execute()
    }

    handleEvents: func {
		while (SdlEvent poll(evt&)) {
			match(evt type) {
			case SDL_QUIT =>
                inputs[Input QUIT] = true
			case SDL_KEYDOWN =>
                inputs[toInput(evt key keysym scancode)] = true
			case SDL_KEYUP =>
                inputs[toInput(evt key keysym scancode)] = false
			case SDL_MOUSEBUTTONUP =>
                inputs[Input JUMP] = false
			case SDL_MOUSEBUTTONDOWN =>
                mouse x = evt motion x
                mouse y = evt motion y
                inputs[Input JUMP] = true
			case SDL_MOUSEMOTION =>
                mouse x = evt motion x
                mouse y = evt motion y
			}
		}

    }

    toInput: func(key: Int) -> Input {
        match key {            
            case SDL_SCANCODE_LEFT => Input LEFT
            case SDL_SCANCODE_RIGHT => Input RIGHT
            case SDL_SCANCODE_UP => Input JUMP
            case SDL_SCANCODE_Z => Input JUMP
            case SDL_SCANCODE_R => Input RESTART
            case SDL_SCANCODE_Q => Input QUIT
            case => Input NONE
        }
    }
}

