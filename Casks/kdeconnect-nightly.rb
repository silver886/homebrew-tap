cask "kdeconnect-nightly" do
  version "23.04.0-1286"
  sha256 "d0000ae5c783de39828656e67be5f324d377235487fd37f2608a6959c1188c56"

  url "https://binary-factory.kde.org/view/MacOS/job/kdeconnect-kde_Release_macos/#{version.sub(/.*-/, "")}/artifact/kdeconnect-kde-#{version}-macos-clang-x86_64.dmg"
  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"

  livecheck do
    url "https://binary-factory.kde.org/view/MacOS/job/kdeconnect-kde_Release_macos/lastStableBuild/artifact/"
    strategy :page_match
    regex(/href=.*?kdeconnect-kde[._-]v?(\d+(?:[.-]\d+)+)-macos-clang-x86_64\.dmg/i)
  end

  app "kdeconnect-indicator.app", target: "KDE Connect.app"
  binary "#{appdir}/KDE Connect.app/Contents/MacOS/kdeconnect-cli",
         target: "kdeconnect"

  uninstall quit: "org.kde.kdeconnect"

  zap trash: [
    "~/Library/Application Support/kpeoplevcard",
    "~/Library/Caches/kdeconnect.sms",
    "~/Library/Preferences/kdeconnect",
    "~/Library/Preferences/kdeconnect_runcommand",
    "~/Library/Preferences/kdeconnect_sendnotifications",
    "~/Library/Preferences/kdeconnect_share",
    "~/Library/Preferences/org.kde.kdeconnect.plist",
  ]
end
