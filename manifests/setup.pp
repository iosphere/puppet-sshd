# This class will ensure SSH is setup, configured and running.
class sshd::setup {
  case $operatingsystem {
    ubuntu, debian : {
      $client_package = 'openssh-client'
      $service_name = 'ssh'
    }
    centos, redhat : {
      $client_package = 'openssh'
      $service_name = 'sshd'
    }
  }

  if ($operatingsystem == 'ubuntu') and ($operatingsystemrelease == '16.04') {
    service {
      "sshd":
        name       => $service_name,
        enable     => true,
        ensure     => running,
        hasrestart => true,
        hasstatus  => true,
        provider   => 'systemd',
        require    => Package['openssh-server']
    }
  } else {
    # Debian
    service {
      "sshd":
        name       => $service_name,
        enable     => true,
        ensure     => running,
        hasrestart => true,
        hasstatus  => true,
        require    => Package['openssh-server']
    }
  }

  package {
    "openssh-server" :
      ensure => installed;

    $client_package : 
      ensure => installed;
  }
}
