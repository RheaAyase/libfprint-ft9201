#!/bin/bash

set -ouex pipefail

DIR="$(pwd)"
SPECNAME="libfprint-ft9201.spec"
SPEC="${HOME}/rpmbuild/SPECS/${SPECNAME}"
RPM="libfprint-ft9201-1.94.6-1.fc40.x86_64.rpm"

cp ${SPECNAME} ${SPEC}

cd ${HOME}/rpmbuild/SOURCES
spectool -g ${SPEC} && rpmbuild -ba ${SPEC} && cp ${HOME}/rpmbuild/RPMS/x86_64/${RPM} ${DIR}/
ls -lah ${DIR}/${RPM}

