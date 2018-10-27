#!/usr/bin/env bash

# Determine OS version
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')

SUBMIT_DIAGNOSTIC_DATA_TO_APPLE=FALSE
SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS=FALSE

if [[ ${osvers} -eq 10 ]]; then
	VERSIONNUMBER=4
elif [[ ${osvers} -ge 11 ]]; then
	VERSIONNUMBER=5
fi

if [[ ${osvers} -ge 10 ]]; then

	CRASHREPORTER_SUPPORT="/Library/Application Support/CrashReporter"

	if [ ! -d "${CRASHREPORTER_SUPPORT}" ]; then
		mkdir "${CRASHREPORTER_SUPPORT}"
		chmod 775 "${CRASHREPORTER_SUPPORT}"
		chown root:admin "${CRASHREPORTER_SUPPORT}"
	fi

	/usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory AutoSubmit -boolean ${SUBMIT_DIAGNOSTIC_DATA_TO_APPLE}
	/usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory AutoSubmitVersion -int ${VERSIONNUMBER}
	/usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory ThirdPartyDataSubmit -boolean ${SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS}
	/usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory ThirdPartyDataSubmitVersion -int ${VERSIONNUMBER}
	/bin/chmod a+r "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory.plist
	/usr/sbin/chown root:admin "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory.plist

fi
