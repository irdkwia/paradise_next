# Paradise Netplay / EXTensions

## What is it?

Paradise NEXT is a set of script/data edits that lets you play
some of the planned, but scrapped, features from paradise.

This also includes some local multiplayer mode features.

Note: unused multiplayer features are relatively instable and may cause crashes.
This was created for research purposes, even though it's somewhat playable.

## How to install mod

To install this mod on Citra see https://citra-emu.org/help/feature/game-modding/

Copy the contents of this repo to your `<Title ID>` mod directory.


## Features

### Present in the original game but scrapped

#### Stones and Spikes

This is a facility (internally named `shop_special_merchant_throw`)
which functions like `Berries and Seeds` and `Wonder Orbs` special shops,
and that, as intended, lets you buy throwable items and sell them at a higher price than usual.

This shop would have had three levels as other special shops, each level letting you access to
better throwables.

It is quite functional but missing some basic elements (see Appendix: Unused Facilities section),
as well as a proper intro in `script/menu_shop_special_merchant.lua`
(only ones for `Berries and Seeds` and `Wonder Orbs` are defined here).

Funnily, they dummied out every strings related to it, except the `Help` string, which has been
translated in all languages, and from which we can infer the actual shop's name based on the
other special shop help text.

The help text for Berries and Seeds starts with:
`Here at [SHOP_NAME], I deal only in\nBerries and seeds.`

The one for Stones and Spikes starts with:
`Here at [SHOP_NAME], I deal only in\nstones and spikes.`

#### Multiplayer Paradise Data Transfer

Wireless local multiplayer is probably one of Gates' features that suffered from cut contents
the mode.

If you have played Gates' multiplayer mode once, you would know that what you can do is
essentially be stuck in Paradise Center and do challenge mission with friends.

You can't actually go to the other paradise areas, as there is a check that prevents you from
doing that (located in script `script/usual/system/para_mode_free.lua`).

However, going past this check makes you enter paradise area, and...
Surprise! If you are a guest, you're not in *your* paradise, but indeed in *your friend's*
paradise, with *his* facilities accessible to you.

That means the game actually transfers the host paradise data to other guests.

All that for what? Nothing in the released game because you can't go past the check.

And that's only the beginning...

#### Paradise Facility Locking

With free paradise roaming comes another feature for shops management in multiplayer mode:
shop locking.

If you talk to a shopkeeper in a facility, your other friends will not be able to until
you are done.

This is especially useful for special shops, where you can only purchase an item once...
~~Ah yes, that also means you can steal your friend's paradise shops as a guest but that's another story.~~

Also, it is not confirmed as it can be an issue with Citra and network, but talking to
a facility as a guest can freeze the game, which seems to be caused by shop locking.

That would explain why they scrapped it, but again, that could just be on Citra's end, because it seemed
to be more likely to happen when players were farther to each other (in the world network).

#### Sunken Treasure Multiplayer

Probably one of the biggest things after paradise itself, Sunken Treasure has a multiplayer mode
that is (almost) fully functional, where you can all dive in the same pit with each player
controlling a different Starmie. At the end all players receive all treasures.

This mode also lets you choose the depth between 20, 30 and 50, something that should also have
been in single player mode, but removed and set to 50 likely because it's the only
interesting one to get the most treasures.

In addition, Beartic Slide should also have had a multiplayer mode, but this one is not
fully implemented and crashes upon entering.

### Added/tweaked features

To make things work, Paradise NEXT introduced some tweaks, listed below:
- The check preventing from going to paradise areas has been replaced by a custom message.
- Some checks have been added to facilities that wouldn't work properly in multiplayer mode:
  Farms cannot be accessed by guests, Dig Shop dungeons cannot be accessed at all as well as
  Beartic slide.
- There is also a check preventing facilities board access, because the game would theoretically
  let you build/upgrade a facility, but this is not transfered to other players, and (even worse)
  if you are the guest these changes would be basically lost when leaving
- Sunken Treasure is missing some strings for it to work, and a check was added to prevent game
  matching if a guest is not in one of the paradise areas, as minigames are only able to spawn
  players back in one of the paradise areas when returning from the minigame.
- Incorrect spawn when returning to Paradise Center is fixed.
- Sunken Treasure keep tracks of some info about your divings of your current play session (that is, not saved upon saving your game)
  and would have had a feature letting you see that, but was removed probably because it was only
  interesting in multiplayer mode, where you can dive indefinitely; the record screen (showing that info)
  has been added back but the layout is not the same as the one planned for the game

## Appendix: Unused Facilities

Also, as an update on scrapped facilities, there are 6 planned but scrapped to various degrees.

All have an internal ID and are associated to 3 strings in `message/shop.bin` that are , though most only contain "UNUSED"

(Note: it is possible to know that because the japanese version of the game includes a `message_debug` directory 
which contain files that maps each string hash to an string identifier, which give more explcit info on the string's content)

All of these shops are missing their facility data in `script/script_paradise_data.bin`, which contains (among other things)
a list of shops sorted by id and storing info about string hashes used for name and description, carpenter level to build
this shop and for each level the model ID to use, and materials/money to build it.

- `minigame_dungeon_diver`:
  what is known as Lone Diver, has its own shop model that can be loaded using `PARA_SHOP_DIVER` as a shop model ID.
  Also has its own icon and a valid shop script `script/menu/menu_minigame_dungeon_diver.lua`, but is missing
  a call to this script function `OpenMinigameDungeonDiverMenu` in function `script/paradise/paradise_land_action.lua > ParadiseLandPush_LAND_SHOP_STAFF_minigame_dungeon_diver`
  and an entry to import it in `menu_main.lua`. Also the biggest problem is that the C++ class `DUNGEON_DIVER`, which implements the actual minigame is missing/has been removed.
- `shop_dispatch`:
  not much is known about this shop, it doesn't even have its own lua script BUT, at least it has a unique shop icon
- `shop_rare_rescue`:
  probably the shop with the less info we have on it, that is nothing else than its internal ID itself (and UNUSED description strings)
- `shop_special_merchant_throw`: 
  what is Stones and Spikes in this mod
- `shop_special_product`:
  not much is known about this shop, it has an empty lua script at `script/menu/menu_shop_special_product.lua` but no special shop icon
- `shop_treasure_map`:
  has an empty lua script at `script/menu/menu_shop_treasure.lua` and a special shop icon. It's interesting to mention that this
  shop also have its connector `script/paradise/paradise_land_action.lua > ParadiseLandPush_LAND_SHOP_STAFF_shop_treasure_map` which calls
  the function `OpenTreasureMenu` that should have been in `script/menu/menu_shop_treasure.lua` and the game actually tries to
  import that function in `menu_main.lua` as its name is mentioned in the define tables
  It's also worth mentioning that one section of `script/script_paradise_data.bin` contains some of this shop data (as the contained
  japanese string imply), though without further context is quite meaningless
