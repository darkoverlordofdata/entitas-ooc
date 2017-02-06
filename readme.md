# ShmupWarz

OC allows adding extension method to existing object classes.

One aspect not working is that I cannot cast to an external type from an extend.
So I need to unpack components to work with them:

        position := e position as PositionComponent
        resource := e resource as ResourceComponent
        bounds := e bounds as BoundsComponent


Starting to sound like ground hog day...
What happed to the Vala/Genie version?

It's on hold while Gnome tries to figure out if it's keeping Vala alive.
