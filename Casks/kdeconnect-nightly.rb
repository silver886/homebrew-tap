cask "kdeconnect-nightly" do
  version "22.12.3-1266"
  sha256 "cad6019c5951b518cd10e6c24bb50f12277403e897e6cdd3ce533c6e11d28119"

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
