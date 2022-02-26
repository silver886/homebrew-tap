class SpotifydConfig < Formula
  desc "Config for spotifyd"
  version "1.0.0"
  homepage "https://github.com/Spotifyd/spotifyd"
  url "https://example.com"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"
  depends_on "spotifyd"

  def install
    system "touch", "brew-keep"
    prefix.install "brew-keep"
  end

  def post_install
    File.open("#{ENV["HOME"]}/.config/spotifyd/spotifyd.conf", "w") { |file| file.write(<<~EOS.strip
      [global]
      username = "{{user_name}}"
      use_keyring = true
      device_name = "{{device_name}}"
      device_type = "computer"
      volume_controller = "softvol"
      initial_volume = "100"
      volume_normalisation = true
      normalisation_pregain = -10
      #on_song_change_hook = "command_to_run_on_playback_events"
      bitrate = 320
      no_audio_cache = true
      zeroconf_port = 57621
      EOS
    ) }
  end

  def caveats
    puts <<~EOS.strip
      Preconfigured config file has installed in `#{ENV["HOME"]}/.config/spotifyd/`.
      Replace `{{user_name}}` and `{{device_name}}` brfore using it.
      If no password was set, use `security add-generic-password -s spotasdfifyd -D rust-keyring -a {{user_name}} -T '' -w` to config one.
    EOS
  end
end
