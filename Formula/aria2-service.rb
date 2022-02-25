class Aria2Service < Formula
  desc "Service for aria2"
  version "0.0.1"
  homepage "https://aria2.github.io/"
  url "https://example.com"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"
  depends_on "aria2"

  def install
    s=[('0'..'9'), ('A'..'Z'), ('a'..'z')].map(&:to_a).flatten
    pass=50.times.map { s[rand(s.length)] }.join
    File.open('config', 'w') { |file| file.write("""
###########
# General #
###########

dir=${HOME}/Downloads

input-file=#{etc}/aria2.session
save-session=#{etc}/aria2.session
save-session-interval=60

console-log-level=notice

disk-cache=64M
file-allocation=falloc
enable-mmap=true

continue=true
max-concurrent-downloads=8

##################
# HTTP(S)/(S)FTP #
##################

max-connection-per-server=16
split=16
min-split-size=8M
stream-piece-selector=geom

###########
# HTTP(S) #
###########

user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:97.0) Gecko/20100101 Firefox/97.0
referer=*
http-no-cache=true

##############
# BitTorrent #
##############

follow-torrent=true
seed-time=0
listen-port=51413

enable-dht=true
enable-dht6=true
dht-listen-port=6969

bt-max-peers=0
enable-peer-exchange=true
peer-id-prefix=-TR3000-
peer-agent=Transmission/3.00

bt-hash-check-seed=true
bt-seed-unverified=true
bt-save-metadata=true

#######
# RPC #
#######

enable-rpc=true
rpc-listen-port=6800
rpc-listen-all=false
rpc-allow-origin-all=true
rpc-secret=#{pass}
""".strip) }
        inreplace "somefile.cfg", /look[for]what?/, "replace by #{bin}/tool"
    etc.install "aria2.conf"
    puts "RPC secret is: #{pass}"
    system "touch", "brew-keep"
    prefix.install "brew-keep"
  end

  service do
    run [HOMEBREW_PREFIX/"bin/aria2c", "--conf", etc/"aria2.conf"]
    keep_alive true
    working_dir HOMEBREW_PREFIX
    log_path var/"log/aria2.log"
    error_log_path var/"log/aria2.log"
  end
end
