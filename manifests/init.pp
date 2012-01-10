class sshd {
  include sshd::setup

  define config($value) {
    sshd_config {
      $name :
        value   => $value,
        require => Class['sshd::setup'],
        notify  => Service['sshd'];
    }
  }
}
