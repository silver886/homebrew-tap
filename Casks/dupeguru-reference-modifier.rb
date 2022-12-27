cask "dupeguru-reference-modifier" do
  version "0.3.0"
  sha256 "c5ec47e3fc94bae1a39237a665fc6dcdb4d20eaa279bf0fd8cdbd2f3598642cc"

  url "https://github.com/silver886/dupeguru-reference-modifier/releases/download/v#{version}/dupeGuru.Reference.Modifier-amd64.zip"
  appcast "https://github.com/silver886/dupeguru-reference-modifier/releases.atom"
  name "dupeGuru Reference Modifier"
  desc "Quicker way to change the reference file in dupeGuru by name"
  homepage "https://github.com/silver886/dupeguru-reference-modifier"

  app "dupeGuru Reference Modifier.app"

  zap trash: [
    "~/Library/Saved Application State/io.leoliu.dupeguru-reference-modifier.savedState",
  ]
end
