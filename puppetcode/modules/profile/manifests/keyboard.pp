# define keyboard layout
class profile::keyboard {
  file { '/etc/vconsole.conf':
    content => "KEYMAP=${lookup('keyboard', String)}",
    # epp('modules/profile/templates/keyboard.epp', {
    #   'layout' => lookup('keyboard', String),
    # }),
  }
}
