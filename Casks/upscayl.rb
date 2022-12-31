cask "upscayl" do
  version "1.5.5"
  sha256 "b59907c12db7cdcbe237bfae5818ef2bb43ec0bf15c3c7f0384dff4e82fc6984"

  url "https://github.com/upscayl/upscayl/releases/download/v#{version}/Upscayl-#{version}-mac.dmg",
      verified: "github.com/upscayl/upscayl/"
  appcast "https://github.com/upscayl/upscayl/releases.atom"
  name "Upscayl"
  desc "Free and Open Source AI Image Upscaler"
  homepage "https://upscayl.github.io/"

  app "Upscayl.app"

  zap trash: [
    "~/Library/Application Support/Upscayl",
    "~/Library/Preferences/org.upscayl.app.plist",
    "~/Library/Saved Application State/org.upscayl.app.savedState",
  ]
end
