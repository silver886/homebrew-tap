cask "snail" do
  version "4.0"
  sha256 "74a75b21eb6b9179c35164156b916fd7a6af9957a3e941a1129d99c4423018a6"

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
