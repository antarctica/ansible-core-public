# Core Public (`core-public`)

**Part of the BAS Ansible Role Collection (BARC)**

Performs standard configuration of a node

## Overview

* Updates package lists (`apt-get update`)
* Configures sudo to support agent forwarding when in a sudo session (this applies when sudoing to root only).
* Configures SSH to pre-trust some hosts by adding their host keys to `ssh_known_hosts`, this is controlled by `core_ssh_known_hosts`.
* Optionally, creates a new OS user, 'app' for performing day to tasks and can be safely used by 'applications' such as a web server. Designed for use from the terminal and when using automated tools (such as ansible). The `authorized_keys` file for the user is set to contain any file in the `core_app_user_authorized_keys_directory` directory.
* Optionally creates an empty 'bash_aliases' file for the 'controller', and if enabled, the 'app' user accounts - this is performed by default.
* Optionally creates a swap file of a specific size if needed.

## Availability

This role is designed for public use only.

Note: Internal users should use the `core` role rather than this one.

## Usage

### Requirements

#### Other requirements

* Public keys which should be added to the `authorized_keys` file of the app user, each key should be a separate file. Keys should be contained in  `core_app_user_authorized_keys_directory`.

#### Variables

* `core_controller_user_username`
	* The username of the controller user, used for management tasks, if enabled
	* This variable **must** be a valid unix username
	* Default: "controller"
* `core_controller_user_enabled`
	* If "true" a user for management tasks, termed a controller user, will be configured.
	* Default: true
* `core_controller_user_create_bash_aliases`
    * If "true" an empty "bash_aliases" file will be created for the controller user.
    * Bash is configured to load this file automatically if it exists.
    * Default: true
* `core_app_user_username`
	* The username of the app user, used for day to day tasks, if enabled
	* This variable **must** be a valid unix username
	* Default: "app"
* `core_app_user_enabled`
	* If "true" a user for day to day tasks, termed an app user, will be created.
	* Default: true
* `core_app_user_authorized_keys_directory`
	* Path relative to where this role is installed to the directory that contains files for the `authorized_keys` file of the app user.
	* This variable **must** point to a directory, it **must not** include a trailing `/`.
	* Default: "../../../public_keys"
* `core_app_user_create_bash_aliases`
    * If "true" an empty "bash_aliases" file will be created for the app user.
    * Bash is configured to load this file automatically if it exists.
    * Default: true
* `core_ssh_known_hosts`
	* An array of trusted SSH host keys to be added to `ssh_known_hosts`.
	* This is a workaround for ssh-keyscan not working correctly.
    * To add to this list:
        * start with a clean `~/.ssh/known_hosts` file
        * connect to host and approve connection (keys will be added to `~/.ssh/known_hosts` automatically)
        * copy the lines of `~/.ssh/known_hosts` to this file (i.e. line1 = first line, there should only be two lines)
        * add a suitable comment (host, date added to this file)
    * Default: [Array]  (empty)
* `core_swap_file_enabled`
    * Whether or not to create a swap file
    * Default: false
* `core_swap_file_size`
    * Size of the swap file in MB
    * This variable **must** be an integer value without a size prefix (i.e. "1204" not "1204MB")
    * Default: "1024"
* `core_swap_file_path`
    * Location to store the swap file
    * This variable **must** be a valid file location (i.e. that is writable) and is recommended not to be changed.
    * Default: "/var/swap.1"

## Contributing

This project welcomes contributions, see `CONTRIBUTING` for our general policy.

## Developing

### Committing changes

The [Git flow](https://github.com/fzaninotto/Faker#formatters) workflow is used to manage development of this package.

Discrete changes should be made within *feature* branches, created from and merged back into *develop* (where small one-line changes may be made directly).

When ready to release a set of features/changes create a *release* branch from *develop*, update documentation as required and merge into *master* with a tagged, [semantic version](http://semver.org/) (e.g. `v1.2.3`).

After releases the *master* branch should be merged with *develop* to restart the process. High impact bugs can be addressed in *hotfix* branches, created from and merged into *master* directly (and then into *develop*).

### Issue tracking

Issues, bugs, improvements, questions, suggestions and other tasks related to this package are managed through the BAS Web & Applications Team Jira project ([BASWEB](https://jira.ceh.ac.uk/browse/BASWEB)).

## License

Copyright 2014 NERC BAS. Licensed under the MIT license, see `LICENSE` for details.