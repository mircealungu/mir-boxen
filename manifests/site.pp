

require boxen::environment
require homebrew
require skype
require onepassword
require wget
require transmit
require sequel_pro
require quicksilver
require sublime_text_2
#require utorrent
require omnigraffle::pro
require sysctl


Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  #include dnsmasq
  include git
  include hub
  #include gcc
  #include nginx
  
  #mysql, and postgres fail miserably...
  #include mysql
  #include postgresql
  

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  #Mir: commented out node and ruby
  # node versions
  #include nodejs::v0_6
  #include nodejs::v0_8
  #include nodejs::v0_10

  # default ruby versions
  #include ruby::1_8_7
  #include ruby::1_9_2
  #include ruby::1_9_3
  #include ruby::2_0_0

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
