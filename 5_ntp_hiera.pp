# /etc/puppetlabs/puppet/modules/ntp/manifests/init.pp
class ntp {
  $ntp_servers = hiera('ntp_servers')
  file { '/etc/ntp.conf':
    ensure  => present,
    content => template('ntp/ntp.conf.erb'),
  }
}
