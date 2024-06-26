# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`profile_additional_packages`](#profile_additional_packages): Install additional packages as specified in Hiera

## Classes

### <a name="profile_additional_packages"></a>`profile_additional_packages`

Install additional packages as specified in Hiera

#### Examples

##### 

```puppet
include profile_additional_packages
```

##### 

```puppet
---
profile_additional_packages::pkg_list:
  RedHat:
    'bash-completion':
        ensure: absent
    'gcc-c++':
    'net-tools':
        ensure: installed
    'bindutils':
        ensure: 17.1.19
```

#### Parameters

The following parameters are available in the `profile_additional_packages` class:

* [`pkg_list`](#-profile_additional_packages--pkg_list)

##### <a name="-profile_additional_packages--pkg_list"></a>`pkg_list`

Data type: `Hash`

Hash of package names to install
Keys must be an OS Family name
Values must be a Hash of the format:
    Key = package name
        A package name can be prefixed with "-" to remove it from the list.
        In this way, a higher level hiera layer can remove a package added
        by a lower, common layer.

    Value (optional):
        1. <EMPTY> in which case, the package will be installed
        2. <HASH> conataining valid attributes for the
           "package" native puppet resource type

