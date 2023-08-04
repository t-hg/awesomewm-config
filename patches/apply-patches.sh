#!/usr/bin/env bash

patch -N -b -u /usr/share/awesome/lib/beautiful/theme_assets.lua -i taglist_squares_unsel_thickness.patch
patch -N -b -u /usr/share/awesome/lib/awful/widget/taglist.lua -i taglist_squares_urgent.patch
