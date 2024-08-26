default:
	@echo Type \'sudo make install\' or \'sudo make uninstall\'

MODULE=insults
SCRIPT=pam-insult.sh

INSTALL_PATH=/usr/lib/pam.d/$(MODULE)

PAM_CONFIG_DIR=/usr/share/pam-configs/

install: dependencies
	grep -q $(INSTALL_PATH)/$(SCRIPT) src/$(MODULE) # check if the module is consistent with the install paths here
	test -x src/$(SCRIPT)
	test -d $(PAM_CONFIG_DIR)
	mkdir -p $(INSTALL_PATH)
	install src/$(SCRIPT) $(INSTALL_PATH)/$(SCRIPT)
	install src/$(MODULE) $(PAM_CONFIG_DIR)
	/usr/sbin/pam-auth-update --package --enable $(MODULE)

uninstall:
	/usr/sbin/pam-auth-update --package --remove $(MODULE)
	rm -f $(INSTALL_PATH)/$(SCRIPT)
	rmdir $(INSTALL_PATH)

dependencies: /lib/x86_64-linux-gnu/security/pam_exec.so /bin/bash /usr/sbin/pam-auth-update
