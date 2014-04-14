Reading Raw Images
==================

-   [ImageMagick](http://www.imagemagick.org/) supports [most RAW formats](http://www.imagemagick.org/script/formats.php#supported) and provides [Python bindings](http://www.imagemagick.org/script/api.php#python).

-   [GraphicsMagick](http://www.graphicsmagick.org/) is the swiss army knife of image processing. GraphicsMagick is originally derived from ImageMagick 5.5.2 as of November 2002 but has been completely independent of the ImageMagick project since then.

-   [dcraw](http://www.cybercom.net/~dcoffin/dcraw/) is a raw image decoder written in C supporting [many cameras](http://www.cybercom.net/~dcoffin/dcraw/#cameras).

-   [LibRaw](http://www.libraw.org/) is a library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others) with [C++ API](http://www.libraw.org/docs/API-overview-eng.html).

By default, `dcraw` alters the image brightness which we do not expect. Edit: `dcraw` has an option `-W` to disable auto brightening.

GraphicsMagick uses `dcraw` as a delegate. To change the settings, run `gm convert -list delegate` to find the path of your `delegates.mgk`, add options `-6 -W -o 2` to the line for `dcraw` in that file. `-6` for 16-bit depth, `-W` to disable auto brightening and `-o 2` for Adobe RGB color space.

ImageMagick uses `ufraw-batch` as the delegate, whose default exposure compensation is set to 0, thus having no issue.

*RAW Decoding Speed*.
`dcraw` is fast. `gm` is fast because it uses `dcraw` as a delegate. `im` is much slower.

FAQ
---

**Q:** delegate failed \`"ufraw-batch"

**A:** Your `ufraw-batch` is too old. Update it with `apt-get install ufraw`.
