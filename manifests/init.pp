class sshd {
  class {
    'sshd::setup' : ;
  }

  Class['sshd::setup'] -> Class['sshd']

  define config($value) {
    sshd_config {
      $name :
        value   => $value,
        require => Class['sshd::setup'],
        notify  => Service['sshd'];
    }
  }
}
