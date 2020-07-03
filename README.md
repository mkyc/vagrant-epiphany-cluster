# Local epiphany infrastructure with Vagrant

Notes

Sooner or later you will notice `vc7e070r` box in configuration. To build that create epiphany repository machine separatelly. (TODO: add link) 

# Project Content

Add Vagrant project
 
 - Vagrantfile with machines configuration map in first part of code, and `Vagrant.configure` in second part
 - bootstrap shell files used to provide some custom commands to machines (look at boxes configuration map)
 - private and public key files to allow intercommunication between machines (with setup_ssh.sh file using it)

# Materials used to prepare this

- https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html#config-ssh-private_key_path
- https://gist.github.com/kikitux/86a0bd7b78dca9b05600264d7543c40d
- https://bitbucket.org/exxsyseng/k8s_ubuntu/src/master/
- https://github.com/devopsgroup-io/vagrant-hostmanager
- https://stackoverflow.com/a/33789603
