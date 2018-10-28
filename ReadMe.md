# png-d

Self-contained D bindings to [libpng](http://www.libpng.org/pub/png/libpng.html)-1.6.

Dub is configured such as if libpng is found on system (in a compatible version)
the installed version will be used.
Otherwise, libpng-1.6.35 will be downloaded, extracted, built from source and used
in place.
