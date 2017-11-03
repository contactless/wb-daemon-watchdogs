all:

install:
	mkdir -p $(DESTDIR)/usr/share/wb-daemon-watchdogs/
	install -m 0755 check_wbrules.sh $(DESTDIR)/usr/share/wb-daemon-watchdogs
	install -m 0755 check_confed.sh $(DESTDIR)/usr/share/wb-daemon-watchdogs
