So basically this is how to do remote builders, but not good, at all.

On the powerful machine:
```bash
nix build .#big-package
# mkdir -p /mnt/something/nix
nix copy --to file:///mnt/something/nix /nix/store/...big-package-1.2.3
```

Now big-package-1.2.3 and its transitive closure is on the flash drive (actually .narinfo files?)

On the weak machine:
```bash
sudo nix copy --no-check-sigs --all --from file:///run/media/whatever-kde-decides/nix
```
The `--no-check-sigs` + `sudo` is important because only the trusted user can use that flag (otherwise it fails silently (!!)), and the nix store paths are obviously not signed because you just built them on the powerful machine