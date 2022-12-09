cask "snail" do
  version "2.0.5"
  sha256 "aa9cf839a88fff527610cca4acb03173d3fa482c548648c66f352b3d2ea0d05f"

  url "https://github.com/TheMurusTeam/Snail/releases/download/v#{version}/snail-#{version}.zip",
      verified: "github.com/TheMurusTeam/Snail/"
  appcast "https://github.com/TheMurusTeam/Snail/releases.atom"
  name "Snail"
  desc "Traffic shaping"
  homepage "https://www.murusfirewall.com/snail/"

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
