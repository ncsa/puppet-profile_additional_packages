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

The goal is that no paramters are required to be set. The default paramters should work for most NCSA deployments out of the box.

## Reference

See: [REFERENCE.md](REFERENCE.md)

## Limitations

n/a

## Development

This Common Puppet Profile is managed by NCSA for internal usage.
