#!/bin/bash

TEMPLATE=@(InstallationPrefix)/share/qcr_env/etc/qcr-env.bash
CUSTOM=/etc/qcr/qcr-env.bash

if [ -e "$CUSTOM" ]; then
  echo "Local qcr-env.bash exists. Skipping..."
  exit 0
fi

if [ ! -d  "/etc/qcr" ]; then
  echo 'Creating QCR configuration directory /etc/qcr...'
  mkdir etc/qcr
fi

echo 'Copying qcr-env.bash to QCR configuration directory /etc/qcr...'
cp $TEMPLATE $CUSTOM;