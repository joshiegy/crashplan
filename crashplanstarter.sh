#!/bin/bash
_link() {
  if [[ -L ${2} && $(readlink ${2}) == ${1} ]]; then
    return 0
  fi
  if [[ ! -e ${1} ]]; then
    if [[ -d ${2} ]]; then
      mkdir -p "${1}"
      pushd ${2} &>/dev/null
      find . -type f -exec cp --parents '{}' "${1}/" \;
      popd &>/dev/null
    elif [[ -f ${2} ]]; then
      if [[ ! -d $(dirname ${1}) ]]; then
        mkdir -p $(dirname ${1})
      fi
      cp -f "${2}" "${1}"
    else
      mkdir -p "${1}"
    fi
  fi
  if [[ -d ${2} ]]; then
    rm -rf "${2}"
  elif [[ -f ${2} || -L ${2} ]]; then
    rm -f "${2}"
  fi
  if [[ ! -d $(dirname ${2}) ]]; then
    mkdir -p $(dirname ${2})
  fi
  ln -sf ${1} ${2}
}

# move identity out of container, this prevent having to adopt account every time you rebuild the Docker
_link /config/id /var/lib/crashplan

# move cache directory out of container, this prevents re-synchronization every time you rebuild the Docker
_link /config/cache /crashplan/crashplan/cache

# move log directory out of container
_link /config/log /crashplan/crashplan/log

# move conf directory out of container
if [[ ! -f /config/conf/default.service.xml ]]; then
  rm -rf /config/conf
fi
_link /config/conf /crashplan/crashplan/conf

# move run.conf out of container
# adjust RAM as described here: http://support.code42.com/CrashPlan/Latest/Troubleshooting/CrashPlan_Runs_Out_Of_Memory_And_Crashes
if [[ ! -f /config/bin/run.conf ]]; then
  rm -rf /config/bin
fi
_link /config/bin /crashplan/crashplan/bin

chown -R nobody:users /config
