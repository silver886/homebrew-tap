cask "snail" do
  version "2.0.6"
  sha256 "37890c22b8ce29d49e6c361203853e0baf6e6889af9c2a8273297bde70d5f4e2"

  url "https://github.com/TheMurusTeam/Snail/releases/download/v#{version}/snail-#{version}.zip",
      verified: "github.com/TheMurusTeam/Snail/"
  name "Snail"
  desc "Traffic shaping"
  homepage "https://www.murusfirewall.com/snail/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :big_sur"

  app "Snail.app"

  zap trash: [
    "/Library/LaunchDaemons/it.murus.snail.helper.plist",
    "/Library/PrivilegedHelperTools/it.murus.snail.helper",
    "~/Library/Application Scripts/it.murus.snail.Launcher",
    "~/Library/Containers/it.murus.snail.Launcher",
    "~/Library/Preferences/it.murus.snail.plist",
  ]
end
