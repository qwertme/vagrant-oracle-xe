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
    "vim-nox":
      ensure => installed;
    "ctags":
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
    "/home/vagrant/.ssh/id_rsa":
      source => "puppet:///modules/devtools/id_rsa";
    "/home/vagrant/.ssh/id_rsa.pub":
      source => "puppet:///modules/devtools/id_rsa.pub";
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
      require => [Package["git"], User["vagrant"]],
      user => "vagrant",
      cwd => "/home/vagrant",
      creates => "/home/vagrant/juniperncprompt";
    "install juniperprompt dependencies":
      alias => "install juniperprompt dependencies",
      command => "/usr/bin/python setup.py install",
      require => [File["/home/vagrant/juniperncprompt"]]
      cwd => "/home/vagrant/juniperncprompt/elementtidy-1.0-20050212";
    "clone vim config":
      alias => "clone vim config",
      command => "/usr/bin/git clone https://github.com/qwertme/vim-config.git .vim",
      user => "vagrant",
      require => [Package["git"], User["vagrant"]],
      cwd => "/home/vagrant",
      creates => "/home/vagrant/.vim";
    "init vim submodules":
      command => "/usr/bin/git submodule init && /usr/bin/git submodule update",
      cwd => "/home/vagrant/.vim",
      require => [Package["git"]],
  }
}
