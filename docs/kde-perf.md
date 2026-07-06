There are some existing performance regressions that have persisted in nixpkgs for a long time. The overlays/kde.nix overlay applies a patch for one of them, but I'm not entirely convinced that I'm getting the best possible performance out of this machine with NixOS and nixpkgs.

Here's some github issues references:
1. "KDE applications are slow in Plasma" (https://github.com/NixOS/nixpkgs/issues/363068) describes that KDE is slower than GNOME in NixOS. Currently still open from 2024.12.7
2. "Excessively long environment variables in KDE plasma" (https://github.com/NixOS/nixpkgs/issues/126590) claims that the issue is rooted in certain environment variables like XDG_DATA_DIRS being excessively long (due to NixOS quirks) and the fact's interaction with some QT behavior (which KDE uses). This seems to imply that all QT based apps will suffer from the same performance regression. This would indicate that KDE is slower in NixOS than in other OSes. Currently still open from 2021.6.11

The mbleichner overlay patch I applied sounds kind of similar to "Solution (-1)" from this issue: https://github.com/NixOS/nixpkgs/issues/21345