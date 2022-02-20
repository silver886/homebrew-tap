cask 'snail' do
  version '1.0.1'
  sha256 'e59e585b9322ea5b32c09a8bdac78b79e171f28f9290361ec2177098ee32a059'

  url "https://github.com/TheMurusTeam/Snail/releases/download/v#{version}/snail-#{version}.zip",
      verified: 'github.com/TheMurusTeam/Snail/'
  name 'Snail'
  desc 'Traffic shaping'
  homepage 'https://www.murusfirewall.com/snail/'
  appcast 'https://github.com/TheMurusTeam/Snail/releases.atom'

  app 'Snail.app'

  zap trash: [
    "/Library/LaunchDaemons/it.murus.snail.helper.plist",
    "/Library/PrivilegedHelperTools/it.murus.snail.helper",
    "~/Library/Application Scripts/it.murus.snail.Launcher",
    "~/Library/Containers/it.murus.snail.Launcher",
    "~/Library/Preferences/it.murus.snail.plist",
  ]
end
