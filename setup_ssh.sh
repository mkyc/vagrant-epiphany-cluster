#!/bin/bash

echo [SetupSSH: Begin]
#check for private key for vm-vm comm
[ -f /vagrant/id_rsa_vagrant ] || {
  echo [SetupSSH: Generate ssh keys]
  ssh-keygen -t rsa -f /vagrant/id_rsa_vagrant -q -N '' -C vagrant@local
}
[ -f /home/vagrant/.ssh/id_rsa ] || {
  echo [SetupSSH: Copy private key to .ssh directory]
  cp /vagrant/id_rsa_vagrant /home/vagrant/.ssh/id_rsa
}
grep 'vagrant@local' ~/.ssh/authorized_keys &>/dev/null || {
  echo [SetupSSH: Add public key to authorised keys]
  cat /vagrant/id_rsa_vagrant.pub >> /home/vagrant/.ssh/authorized_keys
}
echo [SetupSSH: Eclude all hosts from host checking]
cat > /home/vagrant/.ssh/config <<EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
echo [SetupSSH: Fix .ssh directory permissions]
chmod -R go= /home/vagrant/.ssh
echo [SetupSSH: End]