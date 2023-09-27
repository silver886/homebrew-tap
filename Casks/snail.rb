cask "snail" do
  version "2.0.7"
  sha256 "1104aef8940a47ffb7277ab5db52b29292606619e350f464599c4ef0466d91a2"

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
