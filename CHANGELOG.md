# Core Public (`core-public`) - Changelog

## 0.5.1 - December 2014

* Preparing for public release

## 0.5.0 - December 2014

* Adding bash_aliases files for controller and app users (if used)

## 0.4.3 - November 2014

* Removing host file modifications as they didn't do anything useful
* Fixing SSH known hosts support to work with Ansible git module

## 0.4.2 - October 2014

* Correcting changelog dates

## 0.4.1 - October 2014

* Creation of app and configuration of controller user is now optional though enabled by default
* The controller and app users username is now configurable, if enabled
* Preparing role as if it were to be released publicly

## 0.4.0 - October 2014

* Adding hosts file reader script for preserving hosts added using Vagrant host manager plugin.
* Adjusting role for inclusion in BARC

## 0.3.1 - September 2014

* fixing .rnd file suppport as files do not exist initially

## 0.3.0 - September 2014

* setting ownership of .rnd files (used by OpenSSL for key generation) for controller and app

## 0.2.0 - July 2014

* adding support for pre-accepting hosts (e.g. for SSH connections)

## 0.1.1 - July 2014

* disabling apt-get upgrade until problems with guest additions are resolved

## 0.1.0 - June 2014

* initial version
