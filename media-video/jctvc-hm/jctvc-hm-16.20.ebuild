# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ ${PV} != *9999* ]]; then
    ESVN_REPO_URI="svn://hevc.kw.bbc.co.uk/svn/jctvc-tmuc/tags/HM-${PV}"
    KEYWORDS="amd64 x86"
else
    ESVN_REPO_URI="svn://hevc.kw.bbc.co.uk/svn/jctvc-hm"
    KEYWORDS=""
fi

inherit subversion

DESCRIPTION="HEVC Test Model"
HOMEPAGE="https://hevc.hhi.fraunhofer.de"
LICENSE="BSD"
SLOT="0"
#IUSE="360_video"

DEPEND="dev-vcs/subversion"

src_prepare() {
	eapply "${FILESDIR}"/${PN}-16.20-gcc8.patch
	default
}

src_compile() {
#        use 360_video && export EXTENSION_360_VIDEO=1
	emake -C build/linux release
}

src_install() {
	cd "${WORKDIR}/${P}/bin" && dobin annexBbytecountStatic convert_NtoMbit_YCbCrStatic TAppDecoderAnalyserStatic TAppDecoderStatic TAppEncoderStatic
        cd "${WORKDIR}/${P}/doc" && dodoc software-manual.pdf
}
