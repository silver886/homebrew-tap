class Aria2Service < Formula
  desc "Service for aria2"
  version "0.0.1"
  homepage "https://aria2.github.io/"
  url "https://example.com"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"
  depends_on "aria2"

  def install
    system "touch", "brew-keep"
    prefix.install "brew-keep"
  end

  service do
    run [HOMEBREW_PREFIX/"bin/aria2c", "--conf", etc/"aria2.conf"]
    keep_alive true
    log_path var/"log/aria2.log"
    error_log_path var/"log/aria2.log"
  end
end
