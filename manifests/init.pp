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

    # Default value (for bare package names)
    $default = {'ensure' => 'installed'}

    # Limit list of packages by OS Family
    $packages = $pkg_list[ $facts['os']['family'] ]

    # Find keys without a value and add default value
    $sane_pkg_list = $packages.map |$key, $val| {
        if $val { [ $key, $val ] }
        else { [ $key, $default ] }
    }.convert_to(Hash)

    # Ensure packages
    ensure_packages( $sane_pkg_list, {'ensure' => 'installed'} )

}

