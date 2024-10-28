# SNES Development

This is the code based on SNES development tutorials by Wesley Aptekar-Cassels using their [GitHub code](https://github.com/WesleyAC/snes-dev/) and [accompanying tutorials on their blog](https://blog.wesleyac.com/posts/snes-dev-1-getting-started).

## Change Log

* [Used DMA to load background in addition to character map and OAM](https://github.com/kokoza/snes-dev/commit/ef8b2b156c38bedec1d2e8be3ac5c7ac4f8e4664#diff-70b4420e73c383519f631737ef4cb31e83dd64c1b58fe28f7495322ad8ec779e) (lines 219-236)
* [Changed to Mode 1](https://github.com/kokoza/snes-dev/commit/ff97584fe7906905e8b045f85b713a74cecbe73f) for [4bpp background](https://snes.nesdev.org/wiki/Backgrounds)
* [Used local labels to move character horizontally and vertically](https://github.com/kokoza/snes-dev/commit/f7c9c625a00e1611d29445be5829808e5d7c6639)
* [Replaced cheap local label with procs in main loop](https://github.com/kokoza/snes-dev/commit/e0fa56953f075e9cb563aa617be3bd7c58b7ca42) to keep main loop tidy
