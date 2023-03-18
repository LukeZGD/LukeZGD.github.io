#!/bin/bash
dpkg-scanpackages -m debs > Packages
rm Packages.bz2
bzip2 -k Packages
