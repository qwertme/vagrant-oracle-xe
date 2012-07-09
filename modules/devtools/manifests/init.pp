class devtools {
  package {
    "git":
      ensure => installed;
    "build-essential":
      ensure => installed;
    "python-all-dev":
      ensure => installed;
    "gcc-4.4-multilib":
      ensure => installed;
    "tmux":
      ensure => installed;
    "ubuntu-desktop":
      ensure => installed;
    "virtualbox-guest-x11":
      ensure => installed;
    "icedtea6-plugin":
      ensure => installed;
    "ia32-libs":
      ensure => installed;
  }

  rvm_system_ruby {
    "ruby-1.9.2-p290":
      ensure => "present",
      default_use => true;
    "ruby-1.8.7-p357":
      ensure => "present",
      default_use => true;
  }

  file {
    "/home/vagrant/vpn.tgz":
      source => "puppet:///modules/devtools/vpn.tgz";
  }

  exec {
    "untar vpn":
      alias => "untar vpn",
      command => "/bin/tar xzf vpn.tgz",
      require => [Package["ia32-libs"], File["/home/vagrant/vpn.tgz"]],
      cwd => "/home/vagrant",
      user => root,
      creates => "/home/vagrant/.juniper_networks";
    "clone juniperprompt":
      alias => "clone juniperprompt",
      command => "/usr/bin/git clone https://github.com/crimsonknave/juniperncprompt.git",
      require => [Package["git"]],
      cwd => "/home/vagrant",
      creates => "/home/vagrant/juniperncprompt";
    "install juniperprompt dependencies":
      alias => "install juniperprompt dependencies",
      command => "/usr/bin/python setup.py install",
      require => [File["/home/vagrant/juniperncprompt"]]
      cwd => "/home/vagrant/juniperncprompt/elementtidy-1.0-20050212";
  }
}
