# pam-insult

A KISS way to insult users that mistype their passwords. Inspired by sudo.

## Instructions for Debian/Ubuntu

Run:
    sudo make install

This will add pam-insult to your system and add to /etc/pam.d/common-auth:

    auth [default=ignore]   pam_exec.so stdout quiet /usr/lib/pam.d/insults/pam-insult.sh

You can disable/re-enable this PAM module with pam-auth-update, *do not* edit /etc/pam.d/common-auth directly.

## Manual installation

You have to be comfortable editing /etc/pam.d files; this README is too short to give an overview of that.

Note that this module is 'auth' type module, so please be careful to not misconfigure this so that it will lock you
out of your system or just wave everybody through. It should be placed in a spot where all authentication methods have
been tried, but before `pam_deny` (although it can replace `pam_deny`). Its result should be ignored.
