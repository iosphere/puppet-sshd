# This class will ensure SSH is setup, configured and running.
class sshd::setup {
  service {
    "sshd":
      enable => true,
      ensure => running,
      hasrestart => true,
      hasstatus => true,
      require => Package["openssh-server"]
  }

  case $operatingsystem {
    ubuntu, debian : {
      $client_package = 'openssh-client'
    }
    centos, redhat : {
      $client_package = 'openssh'
    }
  }

  package {
    "openssh-server" :
      ensure => installed;

    $client_package : 
      ensure => installed;
  }
}
