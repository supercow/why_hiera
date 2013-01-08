# /etc/puppetlabs/puppet/modules/ntp/manifests/init.pp
class ntp (
  $ntp_servers = ['1.pool.ntp.org','2.pool.ntp.org'],
) {
  file { '/etc/ntp.conf':
    ensure  => present,
    content => template('ntp/ntp.conf.erb'),
  }
}
