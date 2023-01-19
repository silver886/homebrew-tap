cask "xplist" do
  version "1.2.47"
  sha256 "0db66080fcbd447cbb14e585d237b327b7c57f4504c7283ef05a2359ecd351c3"

  url "https://github.com/ic005k/Xplist/releases/download/#{version}/Xplist_Mac.dmg"
  appcast "https://github.com/ic005k/Xplist/releases.atom"
  name "Xplist"
  desc "Cross-platform plist editor"
  homepage "https://github.com/ic005k/Xplist"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Xplist.app"

  zap trash: [
    "~/Library/Preferences/com.github-com-ic005k.Xplist.plist",
    "~/Library/Preferences/com.yourcompany.Xplist.plist",
    "~/Library/Preferences/z.Xplist.plist",
    "~/Library/Saved Application State/z.Xplist.savedState",
  ]
end
