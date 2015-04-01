# Core Public (`core-public`) - Changelog

## 0.9.3 - April 2015

* Fixing incorrect validation of SSH config file

## 0.9.2 - April 2015

* Fixing support for agent forwarding in sudoers file

## 0.9.1 - March 2015

* Fixing tasks to prevent unnecessary change reporting

## 0.9.0 - March 2015

* Adding Hostname support via ANXS dependency

## 0.8.0 - March 2015

* Adding SSL private key copy support

## 0.7.2 - January 2015

* Fixing handling of a pre-existing swap file

## 0.7.1 - January 2015

* Dummy entry to keep versioning between core and core-public roles the same

## 0.7.0 - January 2015

* Adding swap file support

## 0.6.0 - January 2015

* Fixing agent forwarding when used with root sudo sessions

## 0.5.2 - December 2014

* Adding compatibility with Ansible Galaxy

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

* fixing .rnd file support as files do not exist initially

## 0.3.0 - September 2014

* setting ownership of .rnd files (used by OpenSSL for key generation) for controller and app

## 0.2.0 - July 2014

* adding support for pre-accepting hosts (e.g. for SSH connections)

## 0.1.1 - July 2014

* disabling apt-get upgrade until problems with guest additions are resolved

## 0.1.0 - June 2014

* initial version
