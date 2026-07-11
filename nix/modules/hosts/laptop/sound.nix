_: {
  flake.nixosModules.sound = _: {
    services = {
      # Enable sound with pipewire.
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    # PulseAudio and PipeWire use this
    security.rtkit.enable = true;
  };
}
