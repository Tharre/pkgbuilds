# Maintainer: Sven Fischer <sven (at) leiderfischer.de>
# Contributor: Thijs Vermeir <thijsvermeir@gmail.com>

pkgname=eibd
_pkgname=bcusdk
pkgver=0.0.5
pkgrel=6
pkgdesc="Daemon as interface to the EIB / KNX bus"
arch=('i686' 'x86_64' 'arm' 'armv7h')
url="http://www.auto.tuwien.ac.at/~mkoegler/index.php/bcusdk"
license=('GPL')
depends=('pthsem>=2.0.8' 'gcc-libs')
source=(http://www.auto.tuwien.ac.at/~mkoegler/eib/bcusdk_${pkgver}.tar.gz
        eibd.patch eibd.socket eibd.service eibd.conf)
md5sums=('5f81bc4e6bb53564573d573e795a9a5f'
         'b9e50d68138fb74a4d0f6370a720d8fe'
         '82e079c823fa226146ba49b47c76bab7'
         '9919fe034fb3f3b1ad8c45a9daef0dde'
         '815323eebff8bc442c1e653a34e6b0b4')

prepare() {
    cd "${srcdir}/${_pkgname}-${pkgver}"
    patch -p1 -i ${srcdir}/eibd.patch
}

build() {
    cd "${srcdir}/${_pkgname}-${pkgver}"

    ./configure \
        --prefix=/usr \
        --enable-onlyeibd \
        --enable-usb \
        --enable-ft12 \
        --enable-eibnetip \
        --enable-eibnetipserver \
        --enable-eibnetiptunnel

    cd "${srcdir}/${_pkgname}-${pkgver}/common"
    make

    cd "${srcdir}/${_pkgname}-${pkgver}/eibd"
    make
}

package() {
    cd "${srcdir}"
    install -Dm644 eibd.socket eibd.service -t "${pkgdir}/usr/lib/systemd/system"
    install -Dm644 eibd.conf -t "${pkgdir}/etc/conf.d"

    cd "${srcdir}/${_pkgname}-${pkgver}/common"
    make DESTDIR="${pkgdir}" install

    cd "${srcdir}/${_pkgname}-${pkgver}/eibd"
    make DESTDIR="${pkgdir}" install
}
