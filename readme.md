# ShmupWarz

### ooc vs vala
faster compile time
more understandable compiler output
more fluent
easy to read

### dependancies
libraries written using ooc may be consumed from source rather than as binary.
This reduces dependancies. No extra dll/so for entitas or libsdx
I could use gcc to append resources to the exe. 
The only dependancy then is the sdl libs, no need for appimage or flatpak


### extend
OOC allows adding extension method to existing object classes.
I cannot cast to an external type from an extend.
So I need to unpack components to work with them:

        position := e position as PositionComponent
        resource := e resource as ResourceComponent
        bounds := e bounds as BoundsComponent

In most cases, I would be caching these anyway for performance


### Performance



ooc	        vala	        nim	        scala	        fsharp
0.001599	0.003665	0.002157	0.009821	0.000434
0.002211	0.003552	0.003744	0.009488	0.000749
0.002336	0.003787	0.003610	0.009006	0.001001
0.002737	0.003928	0.003375	0.008735	0.001405
0.002556	0.003575	0.003305	0.008365	0.001913
0.002606	0.003291	0.003783	0.007986	0.001974
0.002609	0.004047	0.003533	0.007624	0.002111
0.002563	0.003322	0.003357	0.007325	0.001859
0.003080	0.003354	0.003385	0.006917	0.002503
0.003568	0.003347	0.003166	0.006587	0.002564
========        ========        ========        =========       ========
0.002586	0.003586	0.003331	0.008185	0.001651

avg usec per 10,000 frames:

fsharp  0.001651
ooc     0.002586
nim     0.003331	
vala	0.003586	
scala   0.008185	
