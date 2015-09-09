
TODO: Update

# Core Public (`core-public`)

[![Build Status](https://semaphoreci.com/api/v1/projects/371134e7-8b49-49c0-904f-aa05f0f0fa1e/533438/badge.svg)](https://semaphoreci.com/antarctica/ansible-core-public)

**Part of the BAS Ansible Role Collection (BARC)**

Performs standard configuration of a node

## Overview

TODO: Update

* Sets system hostname and FQDN via `ANXS.hostname` role.
* Updates package lists (`apt-get update`).
* Configures SSH to pre-trust some hosts by adding their host keys to `ssh_known_hosts`, this is controlled by `core_ssh_known_hosts`.
* Optionally adds a 'controller' user to the "adm" group to allow log files to be read without requiring sudo - this is performed by default and assumes a user named 'controller' exists.
* Unless disabled, creates a new OS user, 'app' for performing non-privileged actions (such as creating directories within an uploads directory) and can be safely used by applications such as a web server.
* If enabled, the `authorized_keys` file for the app user is set to contain any file in the `core_app_user_authorized_keys_directory` directory.
* Optionally creates an empty 'bash_aliases' file for the 'controller', and if enabled, the 'app' user accounts - this is performed by default.
* Optionally creates a swap file of a specific size if needed.
* Optionally copies and secures access to an SSL private key if needed.

## Availability

TODO: Update

This role is designed for public use only.

Note: Internal users should use the `core` role rather than this one.

## Quality Assurance

This role uses manual and automated testing to ensure the features offered by this role work as advertised. See the `tests/README.md` file for more information.

[![Build Status](https://semaphoreci.com/api/v1/projects/371134e7-8b49-49c0-904f-aa05f0f0fa1e/533438/badge.svg)](https://semaphoreci.com/antarctica/ansible-core-public)

## Usage

### Requirements

#### Ansible Galaxy

* [ANXS.hostname](https://galaxy.ansible.com/list#/roles/528)

#### Other requirements

* As of version **1.0.0** any OS this role is applied to **MUST** ensure:

* Passwordless sudo is enabled for the "sudo" group 
* SSH Agent Forwarding is preserved when using sudo.

The following combinations of roles and OS images implement these requirements:

* `bootstrap-vagrant` bootstrapping role with the [antarctica/trusty](https://atlas.hashicorp.com/antarctica/boxes/trusty) base box
* `bootstrap-esxi` bootstrapping role with the Ubuntu Trusty OVA as a template [1]
* `bootstrap-digitalocean` bootstrapping role using the relevant DigitalOcean image [2]

* Public keys for the `authorized_keys` file of the app user

Each key should be a separate file contained in the path set by the `core_user_app_authorized_keys_directory` variable.

[1] See the [BAS Packer Templates](https://stash.ceh.ac.uk/projects/BASPACK/repos/packer-templates) for more information.

#### Variables

TODO: Update - these values are outdated.

* `core_controller_user_username`
	* The username of the controller user, used for management tasks, if enabled
	* This variable **MUST** represent a valid UNIX user.
	* Default: "controller"
* `core_controller_user_enabled`
	* If "true" a user for management tasks, termed a controller user, will be configured
    * This is a binary variable and **MUST** be set to either "true" or "false" (without quotes).
	* Default: "true"
* `core_controller_user_create_bash_aliases`
    * If "true" an empty "bash_aliases" file will be created for the controller user.
    * Bash is configured to load this file automatically if it exists.
    * This is a binary variable and **MUST** be set to either "true" or "false" (without quotes).
    * Default: "true"
* `core_controller_user_add_to_adm_group`
    * If "true" the user presented by the `` variable will be added to the "adm" group, which allows access to log files
    * This is a binary variable and **MUST** be set to either "true" or "false" (without quotes).
    * Default: "true"
* `core_app_user_username`
	* The username of the app user, used for day to day tasks, if enabled
	* This variable **MUST** be a valid unix username
	* Default: "app"
* `core_app_user_enabled`
	* If "true" a user for day to day tasks, termed an app user, will be created
    * This is a binary variable and **MUST** be set to either "true" or "false" (without quotes).
	* Default: "true"
* `core_app_user_authorized_keys_directory`
    * The path, relative to where this role is installed, to the directory that contains the public key files to be added to the app user's `authorized_keys` file.
	* This variable **MUST** point to a directory, it **MUST NOT** include a trailing `/`.
	* Default: "../../../public_keys"
* `core_app_user_create_bash_aliases`
    * If "true" an empty "bash_aliases" file will be created for the app user
    * Bash is configured to load this file automatically if it exists.
    * This is a binary variable and **MUST** be set to either "true" or "false" (without quotes).
    * Default: true
* `core_ssh_known_hosts`
	* An array of trusted SSH host keys to be added to the OS `ssh_known_hosts` file.
	* This is a workaround for ssh-keyscan not working correctly.
    * To add to this list:
        * start with a clean `~/.ssh/known_hosts` file
        * connect to host and approve connection (keys will be added to `~/.ssh/known_hosts` automatically)
        * copy the lines of `~/.ssh/known_hosts` to this file (i.e. line1 = first line, there should only be two lines)
        * add a suitable comment (host, date added to this file)
    * Default: [Array]  (empty)
* `core_swap_file_enabled`
    * Whether or not to create a swap file
    * This is a binary variable and **MUST** be set to either "true" or "false" (without quotes).
    * Default: "false"
* `core_swap_file_size`
    * If enabled, the size of the swap file in MB
    * This variable **MUST** be an integer value and **MUST NOT** include a size prefix (i.e. "1204" not "1204MB")
    * Default: "1024"
* `core_swap_file_path`
    * If enabled, the location to store the swap file
    * This variable **MUST** be a valid, writeable, path, you **SHOULD NOT** change the default value.
    * Default: "/var/swap.1"
* `core_ssl_private_key_enabled`
    * If "true" a SSL private key will be copied from a source to a destination with root only permissions applied
    * This is a binary variable and **MUST** be set to either "true" or "false" (without quotes).
    * Default: "false"
* `core_ssl_private_key_source_path`
    * If enabled, the path on the Ansible host to the directory holding the SSL private key
    * This variable can be an absolute or relative path but **MUST NOT** contain a trailing slash
    * Default: "../../../certificates/domain"
* `core_ssl_private_key_source_file`
    * If enabled, the file name and extension of the SSL private key within the directory specified by `core_ssl_private_key_source_path`
    * By convention this file **SHOULD** use a `.key` extension
    * Default: "certificate.key"
* `core_ssl_private_key_destination_path`
    * If enabled, the path on the machine where the SSL private key will be stored
    * This variable **MUST** be a valid, writeable, path.
    * By default this variable uses the Debian convention for SSL private keys, it **SHOULD NOT** be changed.
    * Default: "/etc/ssl/private"
* `core_ssl_private_key_destination_file`
    * The file name and extension the SSL private key will be stored in within the directory specified by `core_ssl_private_key_destination_path`
    * This variable **MUST** be a valid UNIX file name,
    * By convention this file **SHOULD** use a `.key` extension
    * Default: "certificate.key"

## Contributing

This project welcomes contributions, see `CONTRIBUTING` for our general policy.

## Developing

### Committing changes

The [Git flow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow/) workflow is used to manage development of this package.

Discrete changes should be made within *feature* branches, created from and merged back into *develop* (where small one-line changes may be made directly).

When ready to release a set of features/changes create a *release* branch from *develop*, update documentation as required and merge into *master* with a tagged, [semantic version](http://semver.org/) (e.g. `v1.2.3`).

After releases the *master* branch should be merged with *develop* to restart the process. High impact bugs can be addressed in *hotfix* branches, created from and merged into *master* directly (and then into *develop*).

### Issue tracking

Issues, bugs, improvements, questions, suggestions and other tasks related to this package are managed through the BAS Web & Applications Team Jira project ([BASWEB](https://jira.ceh.ac.uk/browse/BASWEB)).

## License

Copyright 2015 NERC BAS. Licensed under the MIT license, see `LICENSE` for details.
