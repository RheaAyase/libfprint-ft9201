#!/bin/bash

set -ouex pipefail

# Ref README.md
echo WIP
exit 0



if [ $(whoami) != 'root' ]; then
  echo 'Please run this script as root.'
  exit 1
fi

RPMLIB="libfprint-ft9201-1.94.6-1.fc40.x86_64.rpm"
RPMD="fprintd-1.90.1-2.fc33.x86_64.rpm"
RPMDP="fprintd-pam-1.90.1-2.fc33.x86_64.rpm"
LATEST="https://github.com/RheaAyase/libfprint-ft9201/releases/download/latest/${RPM}"
KOJI="https://kojipkgs.fedoraproject.org/packages/fprintd/1.90.1/2.fc33/x86_64/"

USEDNF='false'
rpm-ostree --version || USEDNF='true'
if [ $USEDNF == 'true' ]
  wget ${LATEST} && dnf -y swap libfprint ${RPMLIB} && rm ${RPMLIB}
  echo "This script does not fix your fprintd rpm, please download and use fprintd-1.90.1-2.fc33.x86_64.rpm from Koji (and -pam rpm)."
else
  wget ${LATEST} && rpm-ostree override remove libfprint --install ${RPMLIB} && rm ${RPMLIB}
  wget ${KOJI}${RPMD} && wget ${KOJI}${RPMDP} && rpm-ostree override replace ${RPMD} ${RPMDP} && rm ${RPMD} ${RPMDP}
fi

