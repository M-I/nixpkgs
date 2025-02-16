{ lib, stdenv
, gettext
, fetchurl
, pkg-config
, itstool
, libxml2
, libxslt
, gnome
}:

stdenv.mkDerivation rec {
  pname = "yelp-xsl";
  version = "41.0";

  src = fetchurl {
    url = "mirror://gnome/sources/yelp-xsl/${lib.versions.major version}/${pname}-${version}.tar.xz";
    sha256 = "sha256-yM1kwJO72MXV5H/TiGTpCDG1+c90A1MIcCBvqWY2pKU=";
  };

  nativeBuildInputs = [
    pkg-config
    gettext
    itstool
    libxml2
    libxslt
  ];

  doCheck = true;

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
      attrPath = "gnome.${pname}";
    };
  };

  meta = with lib; {
    homepage = "https://wiki.gnome.org/Apps/Yelp";
    description = "Yelp's universal stylesheets for Mallard and DocBook";
    maintainers = teams.gnome.members;
    license = with licenses; [
      # See https://gitlab.gnome.org/GNOME/yelp-xsl/blob/master/COPYING
      # Stylesheets
      lgpl2Plus
      # Icons, unclear: https://gitlab.gnome.org/GNOME/yelp-xsl/issues/25
      gpl2
      # highlight.js
      bsd3
    ];
    platforms = platforms.unix;
  };
}
