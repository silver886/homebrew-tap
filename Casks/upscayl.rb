cask "upscayl" do
  version "2.0.1"
  sha256 "13ccea5608c1e5bf88035b6614b86b00b910b6d7567a99a236b01ac10b0ef9a1"

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
