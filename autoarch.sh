#!/bin/sh

usage() {
    cat <<EOF
usage: autoarch.sh [hostname]
It's assuming you do this from an archiso. Otherwise, pass your current hostname.
Your hostname must be inside the file inventory under [arch_desktops] with the ip_address=127.0.0.1.
And adjust host_vars/[your_hostname] while you're at it.
EOF
    return 0
}

[ -z "$1" ] && (usage; exit 0)

SYS_MOUNT="/mnt/arch_root"
alias SYS_CHROOT="arch-chroot $SYS_MOUNT"
AP_PARAMS='-vv --accept-host-key -i inventory --url "https://github.com/daniel-ts/autoarch-ansible.git"'

if hostname "$1"; then
    ansible-pull $AP_PARAMS AutoarchBase.yml \
	&& SYS_CHROOT ansible-pull $AP_PARAMS AutoarchSystemConfig.yml \
	&& SYS_CHROOT ansible-pull $AP_PARAMS AutoarchDesktop.yml
fi
