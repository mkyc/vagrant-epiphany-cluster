# -*- mode: ruby -*-
# vi: set ft=ruby :

cfg = {
  :router_ip => "192.168.88.1",
  :router_ip6 => "fe80::1", 
  :ip_base => "192.168.88.",
  :box => "centos/7", 
  :bridge_name => "en0: Wi-Fi (Wireless)", 
  :locale => "en_US.UTF-8", 
  :bootstrap_global_file => "bootstrap.sh"
}

boxes = [
  {
    :name => "Epiphany Repo", 
    :hostname => "repo",
    :ip => cfg[:ip_base] + "99",
    :box => "vc7e070r",
    :memory => 1024,
    :cpus => 1, 
    :bootstrap_file => "bootstrap_repo.sh"
  },
  {
    :name => "Kubernetes Master", 
    :hostname => "kmaster",
    :ip => cfg[:ip_base] + "100",
    :box => cfg[:box],
    :memory => 2048,
    :cpus => 2, 
    :bootstrap_file => "bootstrap_master.sh"
  },
  {
    :name => "Kubernetes Node 1", 
    :hostname => "knode1",
    :ip => cfg[:ip_base] + "101",
    :box => cfg[:box],
    :memory => 2048,
    :cpus => 2, 
    :bootstrap_file => "bootstrap_node.sh"
  }, 
  {
    :name => "Kubernetes Node 2", 
    :hostname => "knode2",
    :ip => cfg[:ip_base] + "102",
    :box => cfg[:box],
    :memory => 2048,
    :cpus => 2, 
    :bootstrap_file => "bootstrap_node.sh"
  }
]

Vagrant.configure("2") do |config|

  ENV['LC_ALL'] = cfg[:locale]

  config.vagrant.plugins = ["vagrant-hostmanager"]
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = false
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  
  config.vm.provision "shell", path: cfg[:bootstrap_global_file]

  # default router
  config.vm.provision "shell",
  run: "always",
  inline: "ip route add default via #{cfg[:router_ip]}"

  # delete default gw on eth0
  config.vm.provision "shell",
  run: "always",
  inline: "eval `ip route show | awk '{ if ($5 ==\"eth0\" && $3 != \"0.0.0.0\") print \"ip route delete default via \" $3 \" dev \" $5; }'`"

  boxes.each do |machine|
    config.vm.define machine[:hostname] do |m|
      m.vm.box = machine[:box]
      m.vm.hostname = machine[:hostname]
      m.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--audio", "none"]
        v.name = machine[:name]
        v.memory = machine[:memory]
        v.cpus = machine[:cpus]
      end
      m.vm.network "public_network", ip: machine[:ip], bridge: cfg[:bridge_name]
      m.hostmanager.aliases = %W(#{machine[:hostname]}.local.com #{machine[:hostname]}.local)

      m.vm.provision "shell", path: machine[:bootstrap_file]
    end
  end

  config.vm.provision "shell", path: "setup_ssh.sh", privileged: false

  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    # in virtualbox 0 is nat network
    if vm.name && vm.ssh_info
    `vagrant ssh #{vm.name} -c "hostname -I"`.split()[1]
    end
  end
end
