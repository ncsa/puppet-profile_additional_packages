# @summary Install additional packages as specified in Hiera
#
# Install additional packages as specified in Hiera
#
# @param pkg_list Hash of package names to install
#   Keys must be an OS Family name
#   Values must be a Hash of the format:
#       Key = package name
#           A package name can be prefixed with "-" to remove it from the list.
#           In this way, a higher level hiera layer can remove a package added
#           by a lower, common layer.
#
#       Value (optional):
#           1. <EMPTY> in which case, the package will be installed
#           2. <HASH> conataining valid attributes for the 
#              "package" native puppet resource type
#
# @example
#   include profile_additional_packages
#
# @example
#   ---
#   profile_additional_packages::pkg_list:
#     RedHat:
#       'bash-completion':
#           ensure: absent
#       'gcc-c++':
#       'net-tools':
#           ensure: installed
#       'bindutils':
#           ensure: 17.1.19
class profile_additional_packages (
  Hash $pkg_list,
) {
  # Limit list of packages by OS Family
  $packages = $pkg_list[ $facts['os']['family']]

  if $packages =~ Hash[String[1], Data, 1] {
    if $facts['os']['family'] == 'RedHat' {
      # INSTALL REDHAT PACKAGES WITHOUT PARAMS IN ONE TRANSACTION
      $script_name='puppet-profile_additional_packages-packages_without_params.sh'

      file { "/root/scripts/${script_name}":
        ensure  => 'file',
        mode    => '0740',
        owner   => 'root',
        group   => 'root',
        source  => "puppet:///modules/${module_name}/root/scripts/${script_name}",
        require => File['/root/scripts'],
      }

      # Find keys without a value and install those packages
      # via exec/'yum install' (single yum transaction)
      $packages_without_params = $packages.filter |$key, $val| {
        empty($val)
      }.keys.join(' ')
      exec { 'install_packages_without_params':
        command => "/root/scripts/${script_name} ${packages_without_params}",
        unless  => "/usr/bin/rpm -q ${packages_without_params}",
      }
    }

    # Process ALL keys using ensure_packages:
    # - those that DO have values need to pass those to
    #   Yum and be handled individually;
    # - those that do NOT have values should already be
    #   handled by the above exec, but we can still specify
    #   them here without causing any problem and they will
    #   be attempted again here if something went wrong with
    #   with the exec

    # Default value (for bare package names)
    $default = { 'ensure' => 'installed' }

    # Find keys without a value and add default value
    $sane_pkg_list = $packages.map |$key, $val| {
      if $val {[$key, $val] }
      else {[$key, $default] }
    }.convert_to(Hash)

    ensure_packages( $sane_pkg_list )
  }
}
