cask "kdeconnect-nightly" do
  arch arm: "arm64", intel: "x86_64"

  version "6388"

  on_arm do
    sha256 "ff29a926373ec7afa1f067bdfafd99317de24f5e5ee74a815c7549e380a99768"

    url "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-arm64/kdeconnect-kde-master-#{version}-macos-clang-arm64.dmg"
  end
  on_intel do
    sha256 "8faaec7d3720aac184a98b2260aec3ed1412d3daed5b269a41cfa83e2aa2c0ab"

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
