contain reboot
# manage reboot
class profile::reboot {
  if $facts['uptime_seconds'] < 120 {
    $rebootallowed = true
  } else  {
    $rebootallowed = false
  }
  notify { 'title':
    message => $rebootallowed
  }
  reboot { 'finished':
    message => 'puppet reboot - apply mode finished',
    apply   => 'finished',
    timeout => 5,
    onlyif  => $rebootallowed
  }
  reboot { 'immediately':
    message => 'puppet reboot - apply mode immediately',
    apply   => 'immediately',
    timeout => 5,
    onlyif  => $rebootallowed
  }
}
