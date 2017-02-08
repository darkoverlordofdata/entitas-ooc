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


ooc	        vala
0.001907	0.003665 avge per 1000
0.002977	0.003552
0.002947	0.003787
0.00288	        0.003928
0.002044	0.003575
0.002783	0.003291
0.002542	0.004047
0.00276	        0.003322
0.003035	0.003354
0.003009	0.003347
========        ========
0.0026884	0.0035868 avg

Performance is virtually identical.
33% faster than vala. That will even out as the feature set fills out on the ooc version.
