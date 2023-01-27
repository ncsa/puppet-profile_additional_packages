#/bin/bash

# puppet-profile_additional_packages-packages_without_params.sh: Managed by Puppet

# usage: "$0" pkg1 pkg2 pkg3 ...

# installs only the packages that are not already installed and logs those to syslog

OUTPUT_FILE="/root/puppet-profile_additional_packages-packages_without_params.out"

if [ 0 -eq "$#" ]; then
  /usr/bin/logger -t puppet-profile_additional_packages -p local4.info "script called with no args [no pkg list]"
  exit 1
fi

/usr/bin/rm -f ${OUTPUT_FILE}
/usr/bin/rpm -q $* | /usr/bin/grep 'is not installed' | /usr/bin/awk '{print $2}' > ${OUTPUT_FILE}
# if the file exists and is NOT zero size
if [ -f ${OUTPUT_FILE} ] && [ -s ${OUTPUT_FILE} ]; then
  install_packages=`/usr/bin/cat ${OUTPUT_FILE} | tr '\n' ' '`
  /usr/bin/logger -t puppet-profile_additional_packages -p local4.info "installing ${install_packages}"
  /usr/bin/yum -d 0 -e 1 -y install ${install_packages}
fi
