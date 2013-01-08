# /etc/puppetlabs/puppet/modules/ntp/manifests/init.pp
class ntp {
  $ntp_servers = $::domain ? {
    'prod.domain.com' => ['ntp1.prod.domain.com','ntp2.prod.domain.com'],
    'dr.domain.com'   => ['ntp1.dr.domain.com','ntp2.dr.domain.com'],
    default           => ['1.pool.ntp.org','2.pool.ntp.org'],
  }

  file { '/etc/ntp.conf':
    ensure  => present,
    content => template('ntp/ntp.conf.erb'),
  }
}
