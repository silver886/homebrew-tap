require "etc"

class SpotifydConfig < Formula
  desc "Config for spotifyd"
  version "1.0.1"
  homepage "https://github.com/Spotifyd/spotifyd"
  url "https://example.com/index.html"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"
  depends_on "spotifyd"

  @@config_file_dir = File.join(Etc.getpwuid.dir, ".config", "spotifyd")
  @@config_file_name = "spotifyd.conf"

  def extract_config
    user_name = ""
    device_name = ""
    if File.file?(File.join(@@config_file_dir, @@config_file_name))
      File.open(File.join(@@config_file_dir, @@config_file_name)).each do |line|
        user_name_match = line.match(/^username *= *"(?<user_name>.*)"$/)
        user_name = user_name_match[:user_name] if user_name_match
        device_name_match = line.match(/^device_name *= *"(?<device_name>.*)"$/)
        device_name = device_name_match[:device_name] if device_name_match
      end
    end
    return user_name, device_name
  end

  def install
    touch prefix/"brew-keep"

    touch etc/@@config_file_name

    user_name, device_name = extract_config
    user_name = "{{user_name}}" if user_name.empty?
    device_name = "{{device_name}}" if device_name.empty?

    time = Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
    mv etc/@@config_file_name, etc/"#{@@config_file_name}.bak.#{time}", force: true
    File.open(etc/@@config_file_name, "w").write("""
[global]
username = \"#{user_name}\"
use_keyring = true
device_name = \"#{device_name}\"
device_type = \"computer\"
volume_controller = \"softvol\"
initial_volume = \"100\"
volume_normalisation = true
normalisation_pregain = -10
#on_song_change_hook = \"command_to_run_on_playback_events\"
bitrate = 320
no_audio_cache = true
zeroconf_port = 57621
""".strip)
  end

  def caveats
    messages = []

    user_name, device_name = extract_config
    messages << "Replace `{{user_name}}` in #{File.join(@@config_file_dir, @@config_file_name)}." if user_name.empty?
    messages << "Replace `{{device_name}}` in #{File.join(@@config_file_dir, @@config_file_name)}." if device_name.empty?

    messages << "If no password was set, use `security add-generic-password -s spotasdfifyd -D rust-keyring -a #{if user_name.empty? then "{{user_name}}" else user_name end} -T '' -w` to config one."

    if !File.file?(File.join(@@config_file_dir, @@config_file_name)) || "#{File.realpath(File.join(@@config_file_dir, @@config_file_name))}" != "#{etc/@@config_file_name}"
      messages << <<~EOS.strip
        Manually execute the following commands to apply the new configuration.
        ln -s #{etc}/#{@@config_file_name} #{File.join(@@config_file_dir, @@config_file_name)}
      EOS
    end

    return messages.join("\n\n")
  end
end
