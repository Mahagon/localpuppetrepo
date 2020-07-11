# install/uninstall/update programs
class profile::packages {
  lookup('packages', Hash, 'hash').each | String $packagename, Hash $attributes | {
    package { $packagename:
      ensure   => if $attributes['ensure'] { $attributes['ensure'] } else { 'latest' },
      provider => if $attributes['provider'] { $attributes['provider'] } else { 'pacman' },
    }
  }
}
