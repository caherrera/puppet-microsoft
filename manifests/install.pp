# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include microsoft::install
class microsoft::install {
  include apt

  $ver = "${facts['os']['release']['mayor']}.${facts['os']['release']['minor']}"
  $deb = '/tmp/packages-microsoft-prod.deb'

  archive { $deb:
    ensure => present,
    source => "https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb",
    user   => 0,
    group  => 0,
  }

  package { 'packages-microsoft-prod':
    provider => dpkg,
    ensure   => installed,
    source   => '/tmp/packages-microsoft-prod.deb',
    require  => Archive[$deb]
  }
}
