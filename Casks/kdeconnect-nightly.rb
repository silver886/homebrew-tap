cask "kdeconnect-nightly" do
  arch arm: "arm64", intel: "x86_64"

  version "6183"

  on_arm do
    sha256 "e4cf5273c413c647f9dd5314578c00cf2f182d330dc667c772268450b6babc4f"

    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-#{version}-macos-clang-arm64.dmg"
  end
  on_intel do
    sha256 "257deba8231f542b26dde4278cf332c2a9105db6322efdda3968fc137b5b86e9"

    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/kdeconnect-kde-master-#{version}-macos-clang-x86_64.dmg"
  end

  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"

  livecheck do
    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-x86_64/"
    strategy :page_match
    regex(/href=.*?kdeconnect-kde-master-(\d+)-macos-clang-x86_64\.dmg/i)
  end

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
