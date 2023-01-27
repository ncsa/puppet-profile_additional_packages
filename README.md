# profile_additional_packages

![pdk-validate](https://github.com/ncsa/puppet-profile_additional_packages/workflows/pdk-validate/badge.svg)
![yamllint](https://github.com/ncsa/puppet-profile_additional_packages/workflows/yamllint/badge.svg)

NCSA Common Puppet Profiles - Install Additional Packages

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with profile_additional_packages](#setup)
    * [What profile_additional_packages affects](#what-profile_additional_packages-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with profile_additional_packages](#beginning-with-profile_additional_packages)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This puppet profile customizes a host depending on the virtualization hypervisor type in use.

## Setup

Include profile_additional_packages in a puppet profile file:
```
include ::profile_additional_packages
```

## Usage

The goal is that no parameters are required to be set. The default parameters should work for most NCSA deployments out of the box.

But note that packages are specified in Hiera like this:
```yaml
profile_additional_packages::pkg_list:
  "RedHat":
    "htop":
    "mailx":  # needed for Slurm and various other things
    "mc":
      ensure: "absent"
    "slurm-slurmrestd":
      install_options:
        - "--disablerepo": "epel"
```
The above shows packages to be installed on Red Hat clients.

Packages specified as empty hashes (htop, mailx) will be installed
all together by a single dnf transaction (for the sake of speed).
But note that the rpm command is used to test whether or not they
are installed. It is important to list the actual package name that
dnf finally installs. E.g., 'dnf install createrepo' will install
createrepo_c on Red Hat 8. It is successfully installed from dnf's
perspective, but rpm will say that it is not installed.

Packages specified as non-empty hashes will be installed with
ensure_packages and any key/value data for each package is passed
to the package resource. These are necessarily processed individually
by Puppet. Packages specified as empty hashes will also be attempted
with ensure_packages as a backup method.

## Reference

See: [REFERENCE.md](REFERENCE.md)

## Limitations

n/a

## Development

This Common Puppet Profile is managed by NCSA for internal usage.
