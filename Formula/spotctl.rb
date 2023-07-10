class Spotctl < Formula
  desc "CLI for Spotify"
  homepage "https://github.com/jingweno/spotctl"
  url "https://github.com/jingweno/spotctl/releases/download/v#{version}/darwin-amd64-#{version}.tar.gz"
  version "1.0.1"
  sha256 "a0276bd0c0fb65e7b24885f17d3547276dcf9b059b9507abe51edfa5f5388f89"

  def install
    bin.install "spotctl"
  end
end
