# manage services
class profile::services {
  lookup('services', Hash, 'hash').each | String $servicename, Hash $attributes | {
    service { $servicename:
      ensure  => if $attributes['ensure'] { $attributes['ensure'] } else { 'present' },
      enable  => if $attributes['enable'] { $attributes['enable'] },
      require => if $attributes['requirements'] { $attributes['requirements'] } else { [] },
      notify  => Reboot['immediately']
    }
  }
}
