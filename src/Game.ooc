use sdl2
import math
import sdl2/[Core, Event, Image, TTF, RW]
import structs/ArrayList
import structs/LinkedList
import structs/List
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
import Systems/DestroySystem
import Systems/EntitySpawningTimerSystem
import Systems/ExpiringSystem
import Systems/HealthRenderSystem
import Systems/HudRenderSystem
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
    hudFont: TTFFont
    rawFont: RWops
    evt : SdlEvent
    renderer: SdlRenderer
    mouse: Point2d 
    inputs: Bool[]
    world: World
    sprites: LinkedList<Entity> = LinkedList<Entity> new()
    delta: Double

    strFps: String = ""
    textFps: SdlSurface*
    textureFps: SdlTexture
    lastFps: Int

    strSlice: String = ""
    textSlice: SdlSurface*
    textureSlice: SdlTexture
    lastSlice: Double
    

    FONT_TTF:String = "/home/bruce/ooc/demo/res/fonts/OpenDyslexic-Bold.otf"

    init: func(=renderer) {
        //sprites = ArrayList<Entity> new()
        font = TTFFont new(FONT_TTF, 28)
        if (!font) {
            Exception new("Font can not be loaded!") throw()
        }
        hudFont = TTFFont new(FONT_TTF, 14)
        inputs = Bool[6] new()
        initPools()
        world = World new(components) 
        world add(DestroySystem new(this))
        world add(ViewManagerSystem new(this))
        world add(MovementSystem new(this))
        world add(PlayerInputSystem new(this))
        world add(SoundEffectSystem new(this))
        world add(CollisionSystem new(this))
        world add(ExpiringSystem new(this))
        world add(EntitySpawningTimerSystem new(this))
        world add(ColorTweenSystem new(this))
        world add(ScaleTweenSystem new(this))
        world add(RemoveOffscreenShipsSystem new(this))
        world add(RenderPositionSystem new(this))
        //world add(HealthRenderSystem new(this))
        world add(HudRenderSystem new(this))
        world initialize()
        world createBackground(this)
        world createPlayer(this)
        
    }

    /**
     * draw
     * 
     * draw a single entity
     *
     * @param entity to draw
     */
    draw: func ~entity(e: Entity) {
        position := e position as PositionComponent
        resource := e resource as ResourceComponent
        bounds := e bounds as BoundsComponent

        (w, h) := (0.0, 0.0)
        if (e hasScale) {
            scale := e scale as ScaleComponent
            w = bounds width * scale x
            h = bounds height * scale y
            // w = ((bounds width as Double) * scale x) as Int
            // h = ((bounds height as Double) * scale y) as Int
        } else {
            (w, h) = (bounds width, bounds height)
        }
        x := (resource bgd) ? position x - w / 2.0 : position x
        y := (resource bgd) ? position y - h / 2.0 : position y
        if (e hasTint) {
            tint := e tint as TintComponent
            SDL setTextureColorMod(resource sprite, tint r, tint g, tint b)
        }
        SDL renderCopy(renderer, resource sprite, null, (x as Int, y as Int, w as Int, h as Int) as SdlRect&)
        
    }

    /**
     * draw
     * 
     * draw a frame
     *
     * @param fps frame per second
     * @param slice avg ms per frame
     */
    draw: func ~frame(fps: Int, slice: Double)  {		
        SDL setRenderDrawColor(renderer, 0x00, 0x00, 0x00, 0xff)
		SDL renderClear(renderer)

        for (sprite in sprites) draw(sprite)

        if (fps != lastFps) {
            strFps = "%2d" format(fps)
            textFps = font renderUTF8Solid(strFps, (0xff, 0xff, 0xff, 0xff) as SdlColor)
            textureFps = SDL createTextureFromSurface(renderer, textFps)
            lastFps = fps
        }
        if (textureFps != null)    
            SDL renderCopy(renderer, textureFps, null, (5, 5, 54, 28) as SdlRect&)

        if (fps != lastSlice) {
            strSlice = "%f" format(slice)
            textSlice = font renderUTF8Solid(strSlice, (0xff, 0xff, 0xff, 0xff) as SdlColor)
            textureSlice = SDL createTextureFromSurface(renderer, textSlice)
            lastSlice = slice
        }
        if (textureSlice != null)    
            SDL renderCopy(renderer, textureSlice, null, (70, 10, 114, 28) as SdlRect&)

		SDL renderPresent(renderer)
    }

    update: func(delta: Double) {
        this delta = delta
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

