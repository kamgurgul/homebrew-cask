cask "cpu-info" do
  version "1.4.3"
  sha256 "61863a0586edc7ff3299d68eb811f4703b789f9055ba118c5161caea1ac57a63"

  url "https://github.com/kamgurgul/cpu-info/releases/download/jvm-#{version}/CPU-Info-macos-x64-#{version}.dmg"
  name "CPU-Info"
  desc "Provides information about device hardware and software"
  homepage "https://github.com/kamgurgul/cpu-info"

  livecheck do
    url :url
    regex(/^jvm[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: ">= :monterey"

  app "CPU-Info.app"

  zap trash: "~/Library/Preferences/CPU-Info"

  caveats do
    requires_rosetta
  end
end
