class ColimaService < Formula
  desc "Service for colima"
  version "1.0.0"
  homepage "https://github.com/abiosoft/colima/"
  url "https://example.com/index.html"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"
  depends_on "colima"

  def install
    File.open("colima-service", "w").write("""
#!/usr/bin/env sh
colima start
while true; do
  sleep 86400
done
""".strip)
    chmod 0755, "colima-service"
    bin.install "colima-service"
  end

  service do
    run [bin/"colima-service"]
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/colima.log"
    error_log_path var/"log/colima.log"
  end
end
