#!/usr/bin/env bash

# Most of the settings where found here: https://github.com/jackiesingh/Mac-OSX-STIG
# We improved this BSD 3 clause licensed stuff and tweak it to fit for our needs

# The system must prohibit the reuse of passwords to 15 iterations.
pwpolicy -n /Local/Default -setglobalpolicy "usingHistory=15"

# System files and directories must not have uneven access permissions.
chmod -R 755 /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin

# All network services daemon files must not have extended ACLs.
chmod -N /usr/sbin/*

# System log files must not have extended ACLs, except as needed to support authorized software.
chmod -N /var/log/*

# Manual page files must have mode 0644 or less permissive.
chmod 0644 /usr/share/man

# All manual page files must not have extended ACLs.
chmod -N /usr/share/man/*

# All library files must not have extended ACLs.
chmod -N /usr/lib/*

# The /etc/resolv.conf file must be group-owned by root, bin, sys, or system.
chown root:wheel /etc/resolv.conf

# The /etc/resolv.conf file must have mode 0644 or less permissive.
chmod 644 /etc/resolv.conf

# The /etc/resolv.conf file must not have an extended ACL.
chmod -N /etc/resolv.conf

# The /etc/hosts file must be group-owned by root, bin, sys, or system.
chown root:wheel /etc/hosts

# The /etc/hosts file must have mode 0644 or less permissive.
chmod 644 /etc/hosts

# The /etc/hosts file must not have an extended ACL.
chmod -N /etc/hosts

# The /etc/passwd file must be group-owned by root, bin, sys, or system.
chown root:wheel /etc/passwd

# The /etc/passwd file must have mode 0644 or less permissive.
chmod 644 /etc/passwd

# The /etc/passwd file must not have an extended ACL.
chmod -N /etc/passwd

# The /etc/group file must not have an extended ACL.
chmod -N /etc/group

# The /etc/group file must be group-owned by root, bin, sys, or system.
chown root:wheel /etc/group

# The /etc/group file must have mode 0644 or less permissive.
chmod 644 /etc/group

# All global initialization files must have mode 0644 or less permissive.
chmod 644 /etc/bashrc
chmod 644 /etc/csh.cshrc
chmod 644 /etc/csh.login
chmod 644 /etc/csh.logout
chmod 644 /etc/profile

# All global initialization files must be owned by root.
chown root:wheel /etc/bashrc
chown root:wheel /etc/csh.cshrc
chown root:wheel /etc/csh.login
chown root:wheel /etc/csh.logout
chown root:wheel /etc/profile

# There must be no .netrc files on the system.
find / -name .netrc -exec rm {} \;

# System audit logs must be owned by root.
#chown root /etc/audit file

# The cron.allow file must not have an extended ACL.
chmod -N /etc/cron.allow

# The cron.allow file must not have an extended ACL.
chmod -N /etc/cron.allow

# The cron.deny file must not have an extended ACL.
chmod -N /private/var/at/cron.deny

# The cron.allow file must be group-owned by root, bin, sys, or cron.
chgrp wheel /private/var/at/cron.allow

# The cron.deny file must be group-owned by root, bin, sys, or cron.
chgrp wheel /private/var/at/cron.deny

# The "at" directory must have mode 0755 or less permissive.
chmod 755 /var/at

# The "at" directory must be owned by root, bin, or sys.
chown root /var/at

# The at.allow file must be owned by root, bin, or sys.
# Optional - this may or may not exist in OS X as opposed to at.deny
chown root /var/at/at.allow

# The at.deny file must be owned by root, bin, or sys.
chown root /var/at/at.deny

# The services file must be group-owned by root, bin, sys, or system.
chown root:wheel /etc/services

# The services file must have mode 0644 or less permissive.
chmod 0644 /etc/services

# The services file must not have an extended ACL.
chmod -N /etc/services

# The rsh daemon must not be running.
# Typically excluded due to no rsh daemon included default on OS X
defaults write /System/Library/LaunchDaemons/com.apple.uucp Disabled 1

# The rexec daemon must not be running.
# Typically excluded due to no exec daemon included default on OS X
defaults write/System/Library/LaunchDaemons/rexec Disabled

# The telnet daemon must not be running.
defaults write /System/Library/LaunchDaemons/telnet Disabled

# The traceroute command must be group-owned by sys, bin, root, or system.
chown root:wheel /usr/sbin/traceroute

# The traceroute file must have mode 0700 or less permissive.
chmod 700 /usr/sbin/traceroute

# The traceroute file must not have an extended ACL.
chmod -N /usr/sbin/traceroute

# The aliases file must be group-owned by root, sys, bin, or system.
chgrp wheel /etc/aliases

# The alias file must not have an extended ACL.
chmod -N /etc/aliases

# The system must not use .forward files.
find / -name .forward -exec rm {} \;

# The system must not have the UUCP service active.
defaults read /System/Library/LaunchDaemons/com.apple.uucp Disabled

# The /etc/syslog.conf file must not have an extended ACL.
chmod -N /etc/syslog.conf

# The /etc/syslog.conf file must be group-owned by root, bin, sys, or system.
chown root:wheel /etc/syslog.conf

# The /etc/smb.conf file must be owned by root.
chown root /etc/smb.conf

# The /etc/smb.conf file must have mode 0644 or less permissive.
chmod 644 /etc/smb.conf

# The /etc/smb.conf file must not have an extended ACL.
chmod -N /etc/smb.conf

# The AppleTalk protocol must be disabled or not installed.
grep 'install appletalk /bin/true' /etc/modprobe.conf /etc/modprobe.d/* && echo "install appletalk /bin/true" >>/etc/modprobe.conf

# If the system is using LDAP for authentication or account information the /etc/ldap.conf [or equivalent] file must have mode 0644 or less permissive.
chmod 644 /etc/ldap.conf

# If the system is using LDAP for authentication or account information, the /etc/ldap.conf [or equivalent] file must be group-owned by root, bin, sys, or system.
chown root:wheel /etc/ldap.conf

# If the system is using LDAP for authentication or account information, the /etc/ldap.conf [or equivalent] file must not have an extended ACL.
chgrp wheel /etc/audit

# Infrared [IR] support must be removed.
#rm -rf /System/Library/Extensions/AppleIRController.kext
#touch /System/Library/Extensions

# Wi-Fi support software must be disabled.
#rm -rf /System/Library/Extensions/AppleAirPort.kext
#rm -rf /System/Library/Extensions/AppleAirPort2.kext
#rm -rf /System/Library/Extensions/AppleAirPortFW.kext
#touch /System/Library/Extensions

# Bluetooth support software must be disabled.
#rm -rf /System/Library/Extensions/IOBluetoothFamily.kext
#rm -rf /System/Library/Extensions/IOBluetoothHIDDriver.kext
#touch /System/Library/Extensions

# Access warning for the command line must be present.
defaults write com.apple.loginwindow LoginwindowText "This is a NET-Experts.net system.

This resource, including all related equipment, networks and network devices, are provided for authorized NET-Experts.net use. NET-Experts.net ICT systems may be monitored for all lawful purposes, including to ensure authorized use, for management of the system, to facilitate protection against unauthorized access and to verify security procedures and operational procedures. The monitoring on this system may include audits by authorized NET-Experts.net personnel to test or verify the validity, security and survivability of this system. During monitoring information may be examined, recorded, copied and used for authorized purposes. All information placed on or sent to this system may be subject to such monitoring procedures. Use of this NET-Experts.net ICT system, authorized or unauthorized, constitutes consent to this policy and the policies and procedures set forth by NET-Experts.net. Evidence of unauthorized use collected during monitoring may be used for criminal prosecution by NET-Experts.net staff, legal counsel and law enforcement agencies."

echo "This is a NET-Experts.net system.

This resource, including all related equipment, networks and network devices, are provided for authorized NET-Experts.net use. NET-Experts.net ICT systems may be monitored for all lawful purposes, including to ensure authorized use, for management of the system, to facilitate protection against unauthorized access and to verify security procedures and operational procedures. The monitoring on this system may include audits by authorized NET-Experts.net personnel to test or verify the validity, security and survivability of this system. During monitoring information may be examined, recorded, copied and used for authorized purposes. All information placed on or sent to this system may be subject to such monitoring procedures. Use of this NET-Experts.net ICT system, authorized or unauthorized, constitutes consent to this policy and the policies and procedures set forth by NET-Experts.net. Evidence of unauthorized use collected during monitoring may be used for criminal prosecution by NET-Experts.net staff, legal counsel and law enforcement agencies." >/etc/motd

# usage must be restricted to a single terminal, and for only one instance at a time.
echo "Defaults tty_tickets" >>/etc/sudoers
echo "Defaults timestamp_timeout=0" >>/etc/sudoers

# The default global umask setting must be changed.
#echo "umask 027" >> /etc/launchd.conf

# The MobileMe preference pane must be removed from System Preferences.
rm -R "/System/Library/PreferencePanes/MobileMe.prefPane"
rm -R "/System/Library/PreferencePanes/Internet.prefPane"
touch /System/Library/PreferencePanes

# The setuid bit must be removed from the System Preferences.app file.
chmod 775 "/Applications/System Preferences.app/Contents/Resources/installAssistant"

# The setuid bit must be removed from the ODBC Admin tool.
chmod 755 "/Applications/Utilities/ODBC Administrator.app/Contents/Resources/iodbcadmintool"

# Setuid bit must be removed from Apple Remote Desktop
chmod 755 "/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/MacOS/ARDAgent"

# Setuid bit must be removed from WebDAV Web Services.
chmod 755 "/System/Library/Extensions/webdav_fs.kext/Contents/Resources/load_webdav"

# The setuid bit must be removed from Apple File Protocol.
chmod 755 "/System/Library/Filesystems/AppleShare/afpLoad"

# The setuid bit must be removed from Apple File Protocol Sharing.
chmod 711 "/System/Library/Filesystems/AppleShare/check_afp.app/Contents/MacOS/check_afp"

# Remove Setuid bit must be removed from dumpemacs.
chmod 555 /usr/libexec/dumpemacs

# Setuid bit must be removed from XGrid.
chmod 555 /usr/libexec/xgrid/IdleTool

# Setuid bit from Hosting VPN Services must be removed.
chmod 555 /usr/sbin/vpnd

# Setuid bit must be removed from Network Configuration.
chmod 555 /sbin/route

# The setuid bit must be removed from the IPC Statistics.
chmod 511 /usr/bin/ipcs

# The setuid bit from Remote Access [unsecure] must be removed.
chmod 555 /bin/rcp

# The setuid bit from rlogin must be removed.
chmod 555 /usr/bin/rlogin

# The setuid bit from Remote Access [unsecure] must be removed.
chmod 555 /usr/bin/rsh

# The setuid bit from System Activity Reporting must be removed.
chmod 555 /usr/lib/sa/sadc

# The Auto Update feature must be disabled.
#softwareupdate --schedule off

# Permission for system logs must be set.
chmod 555 /etc/security/audit_warn

# Security auditing must be enabled.
echo "AUDIT=YES" >>/etc/hostconfig

# All files and directories must have a valid group owner.
find / -nogroup -print0 | xargs -0 chgrp staff

# All files and directories must have a valid owner.
find / -nouser -print0 | xargs -0 chown macadmin

# All network services daemon files must have mode 0755 or less permissive.
find /usr/sbin -type f -perm +022 -print0 | xargs -0 chmod go-w

# All system command files must have mode 0755 or less permissive.
find /usr/bin -type f -perm +022 -print0 | xargs -0 chmod go-w

# All system command files must not have extended ACLs.
#chmod -N /path/to/file

# All system files, programs, and directories must be owned by a system account.
#chown root /usr/bin/filename

# System files, programs, and directories must be group-owned by a system group.
#chgrp wheel /usr/bin/filename

# System log files must have mode 0640 or less permissive.
chmod -R 0640 /var/log*

# Library files must have mode 0755 or less permissive.
chmod -R 0755 /usr/lib

# User home directories must not have extended ACLs.
chmod -R -N /Users

# Hardening for /tmp
chmod 1777 /tmp
chown root /tmp

# Audio recording support software must be disabled.
#rm -rf "/System/Library/Extensions/AppleOnboardAudio.kext"
#rm -rf "/System/Library/Extensions/AppleUSBAudio.kext"
#rm -rf "/System/Library/Extensions/AppleDeviceTreeUpdater.kext"
#rm -rf "/System/Library/Extensions/IOAudioFamily.kext"
#rm -rf "/System/Library/Extensions/VirtualAudioDriver.kext"
#touch "/System/Library/Extensions"

# Video recording support software must be disabled.
#rm -rf "/System/Library/Extensions/Apple_iSight.kext"
#rm -rf "/System/Library/Extensions/IOUSBFamily.kext/Contents/Plugins/AppleUSBVideoSupport.kext"
#touch "/System/Library/Extensions"

# Check the "Require password to unlock each System Preferences pane" checkbox in System Preferences: Security
/usr/libexec/PlistBuddy -c 'set rights:system.preferences:shared bool false' '/etc/authorization'

# Run the command below with root privileges to enable OS X updates
/usr/bin/defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool TRUE
