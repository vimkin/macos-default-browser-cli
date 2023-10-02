prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	swift package plugin --allow-writing-to-package-directory swiftformat --swiftversion 5.9
	swift build -c release --disable-sandbox

install: build
	install -d $(bindir)
	install ".build/release/DefaultBrowserCLIApp" "$(bindir)/default-browser"

uninstall:
	rm -rf "$(bindir)/default-browser"

clean:
	rm -rf .build
