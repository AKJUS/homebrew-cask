cask "toshiba-color-mfp" do
  version "7.117.3.0,20758"
  sha256 "616138b69108809dd93530b494e1dd65c2deb4c83be742c5f3ce4a1b4fc244f6"

  url "https://business.toshiba.com/downloads/KB/f1Ulds/#{version.csv.second}/TOSHIBA_ColorMFP.dmg.gz"
  name "Toshiba ColorMFP Drivers"
  desc "Drivers for Toshiba ColorMFP devices"
  homepage "https://business.toshiba.com/support"

  livecheck do
    url "https://business.toshiba.com/support/downloads/GetDownloads.jsp?model=e-STUDIO3515AC"
    strategy :json do |json|
      json["drivers"]&.map do |item|
        next unless item["name"]&.include?("MacDC")

        id = item["id"]
        version = item["versionName"]
        next if id.blank? || version.blank?

        "#{version},#{id}"
      end
    end
  end

  no_autobump! because: :requires_manual_review

  pkg "TOSHIBA ColorMFP.pkg"

  uninstall pkgutil: "com.toshiba.pde.x7.colormfp",
            delete:  [
              "/Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP*.gz",
              "/Library/Printers/toshiba",
            ]

  # No zap stanza required
end
