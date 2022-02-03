# love-mapcell
A partially-random map engine for Love2D

## Why???
I spent money on Tilesetter and wanted to make use of it, and all the Tiled implementations broke for me. Basically it takes the JSON output of Tilesetter and draws based off of that.

This is nowhere near done, I just got something functional that can draw pictures based off of the output so it's going on here

## Requirements
lunajson + cargo

## Usage
be sure to include a good ol `require('mapcell')` firstly, and ensure that lunajson and cargo are installed

create a new map: 
```
local map = MapCell.new(cargo.path.to.the.folder)

map:drawCell(0,0)
```

the .png and .json from Tilesetter need to be named "src.png" and "json.json" for it to function correctly without modification. Also, there needs to be two layers in tilesetter, "bkg" for the actual background drawing, and "funct" for *future plans*

Uh yeah I guess try it out. I'll update this as stuff goes on
