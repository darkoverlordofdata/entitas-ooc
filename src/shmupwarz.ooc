use sdl2
import os/Time
import math
import sdl2/[Core, Event, Image, TTF]
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


windowSize := (0, 0, 640, 720) as SdlRect 	

main: func (argc: Int, argv: CString*) {

	SDL init(SDL_INIT_EVERYTHING)
    TTF init()

	window := SDL createWindow(
		"ShmupWarz",
		SDL_WINDOWPOS_UNDEFINED,
		SDL_WINDOWPOS_UNDEFINED,
		windowSize w, windowSize h, SDL_WINDOW_SHOWN)
	
	renderer := SDL createRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)
    game := Game new(renderer)
	mark1 := Time microsec() as Double / 1000000
	mark2 := 0.0
	delta := 0.0
	frame := 0
	fps := 60

	t1 := 0.0
	t2 := 0.0
	k := 0
	f := 0
	a := 0.0

	while (!game inputs[Input QUIT]) {
		// try {

			game handleEvents()

			mark2 = Time microsec() as Double / 1000000
			delta = mark2 - mark1
			if (delta < 0) delta = delta + 1.0

			t1 = Time microsec() as Double / 1000000
			game update(delta)
			t1 = (Time microsec()  as Double / 1000000) - t1
			if (t1 < 0) t1 = t1 + 1.0
			k = k + 1

			if (mark2 <= mark1) {
				fps = k
				k = 0

			}
			mark1 = mark2
			Time sleepMilli(3)
			game draw(fps, a)


			f = f + 1
			t2 = t2 + t1
			if (f % 1000 == 0) {
				a = t2 as Double / 1000.0
				"%f" printfln(a)
				t2 = 0
			}

		// } catch (ex: Exception) {
		// 	"ERR %s" printfln(ex message)
		// }
	}
	
	SDL destroyRenderer(renderer)
	SDL destroyWindow(window)
	SDL quit()
}

