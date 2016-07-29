# Class: keepalived::params
#
# Parameters for the keepalived module.
#
class keepalived::params {

  $service = 'keepalived'
  $confdir = '/etc/keepalived'


  # We can't use osfamily since Gentoo's is 'Linux'
  case $::operatingsystem {
    'Gentoo': {
      $package           = 'sys-cluster/keepalived'
      $sysconfdir        = 'conf.d'
      $service_hasstatus = true
      $service_restart = "/sbin/service ${service} reload"
    }
    'RedHat','Fedora','CentOS','Scientific','Amazon': {
      $package           = 'keepalived'
      $sysconfdir        = 'sysconfig'
      $service_hasstatus = true
      $service_restart = "/sbin/service ${service} reload"
    }

    'Debian', 'Ubuntu': {
      $package           = 'keepalived'
      $sysconfdir        = undef
      if ( $::operatingsystem  == 'Ubuntu' and versioncmp($::operatingsystemrelease,'16.04') >= 0 ) {
        $service_restart = "/bin/systemctl reload keepalived"
        $service_hasstatus = true
      } else {
        $service_restart = "/sbin/service ${service} reload"
        $service_hasstatus = false
      }
    }
    default: {
      $package           = 'keepalived'
      $sysconfdir        = undef
      $service_hasstatus = true
      $service_restart = "/sbin/service ${service} reload"
    }
  }

}
