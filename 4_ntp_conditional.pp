# /etc/puppetlabs/puppet/modules/ntp/manifests/init.pp
class ntp {

  if $::fqdn != 'bob.internal.net' {
    if $::virtual == 'vmware' {
      $ntp_servers = $::domain ? {
        'prod.domain.com' => ['vcenter1.prod.domain.com'],
        'dr.domain.com'   => ['vcenter1.dr.domain.com'],
      }
    } else {
      if $::virtual == 'kvm' {
        $ntp_servers = $::domain ? {
          'prod.domain.com' => ['kvm1.prod.domain.com'],
          'dr.domain.com'   => ['kvm1.dr.domain.com'],
        }
      } else {
        $ntp_servers = $::domain ? {
          'prod.domain.com' => ['ntp1.prod.domain.com','ntp2.prod.domain.com'],
          'dr.domain.com'   => ['ntp1.dr.domain.com','ntp2.dr.domain.com'],
          default           => ['1.pool.ntp.org','2.pool.ntp.org'],
        }
      }
    }
  else {
    $ntp_servers = ['rogue1.internal.net']
  }

  file { '/etc/ntp.conf':
    ensure  => present,
    content => template('ntp/ntp.conf.erb'),
  }
}
