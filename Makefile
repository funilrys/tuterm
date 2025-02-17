PREFIX  ?= /usr/local
VERSION ?= 0.1.0

install:
	@# Inject a __TUTERM_PREFIX variable definition into the tuterm script
	@# Inject a __TUTERM_VERSION variable definition into the tuterm script
	mkdir -p _build
	sed -e "0,/__TUTERM_PREFIX=.*/s::__TUTERM_PREFIX='/${PREFIX}':"   \
		-e "0,/__TUTERM_VERSION=.*/s::__TUTERM_VERSION='${VERSION}':" \
		tuterm > _build/tuterm
	@# Install
	mkdir -p "${DESTDIR}/${PREFIX}/bin" \
			 "${DESTDIR}/${PREFIX}/share/man/man1" \
			 "${DESTDIR}/${PREFIX}/share/tuterm" \
			 "${DESTDIR}/${PREFIX}/share/tuterm/scripts"
	install -Dm755 _build/tuterm    "${DESTDIR}/${PREFIX}/bin/"
	install -Dm644 docs/tuterm.1    "${DESTDIR}/${PREFIX}/share/man/man1/"
	install -Dm644 config.sh        "${DESTDIR}/${PREFIX}/share/tuterm/"
	install -Dm755 example.tut      "${DESTDIR}/${PREFIX}/share/tuterm/"

uninstall:
	rm -rf \
		"${DESTDIR}/${PREFIX}/bin/tuterm" \
		"${DESTDIR}/${PREFIX}/share/man/man1/tuterm.1" \
		"${DESTDIR}/${PREFIX}/share/tuterm"

pacman:
	mkdir -p _build/pacman
	cp PKGBUILD _build/pacman/
	cd _build/pacman; makepkg --skipinteg -f

clean:
	rm -rf _build
	rm -rf demo/*.cast
