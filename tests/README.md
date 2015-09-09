
TODO: Update.

# Core Public (`core-public`) - Testing

**Note: Role testing is currently a proof-of-concept and may change significantly.**

To ensure this role works correctly tests **MUST** be written for any role changes, and tested before new versions are released. Both manual and automated methods are used to test this role.

These tests, and their different configurations, aim to cover the most frequent ways a role is used, and in a similar environment. These tests do not aim to cover *all* the ways a role might be used, except for roles deemed important [1].

Three aspects of this role are tested:

1. **Valid role syntax** - as determined by `ansible-playbook --syntax-check`
2. **Functionality** - i.e. does this role do what it claims to 
3. **Idempotency** - i.e. do any changes occur if this role is applied a second time

Tests for these aspects can be split into:

* **Test tasks** - tests each task to ensure it functions correctly, act like unit tests
* **Test playbooks** - combine test tasks for various scenarios, act like integration tests

Test tasks are kept in the `tests/tasks` directory, mirroring the structure of the `tasks` directory within the main role.

A test playbook is used to run these test tasks. This playbook is applied to a number of test VMs, with host variables used to control which features each VM tests.

Playbooks, host variables and other support files are kept in the `tests` directory. Both manual and automated test methods use these playbooks and test tasks, reducing the need for duplication and ensuring both types of test are as similar as possible.

The following role configurations are tested:

1. A node [2] with an updated package cache only
2. A node based on *configuration 1* with a swap file
3. A node based on *configuration 1* with a known host added for `github.com` and a check to ensure a test repository [3] can be cloned successfully
4. A node based on *configuration 1* with minimal configuration of a controller user, which consists of verifying a `.rnd` file is created, only [4]
5. A node based on *configuration 4* with verification the controller user is a member of the `adm` group
6. A node based on *configuration 4* with verification a `.bash_aliases` file is created for the controller user
7. A node based on *configuration 1* with minimal configuration of an app user, which consists of verifying the user exists and a `.rnd` file is created, only
8. A node based on *configuration 7* with verification one or more public keys are added to an `authorized_keys` file for the app user
9. A node based on *configuration 7* with verification a `.bash_aliases` file is created for the app user
10. A combination of configurations *3, 5, 6, 8, 9* [5][6][7]

[1] This may because the role is used by lots of other roles (such as the `core` role) or simply deemed important in its own right.

[2] A 'node' in this context simply refers to a generic Virtual Machine (or cloud equivalent) with no dedicated purpose.

[3] Currently this is the Ansible project repository, though any will suffice.

[4] As creating the user is not within the scope of this role, this is not tested in this role either. See the role(s) responsible for creating the user for associated tests.

[5] *Configuration 2* is not tested within the automated test environment as it does not support creating swap files.

[6] *Configuration 3* is only partially tested within the automated test environment due to its pre-configuration of SSH connections to GitHub making this check meaningless.

[7] This configuration is also used in automated tests, as discussed in the *automated tests* section.

## Automated tests

Currently [Semaphore CI](https://semaphoreci.com/) is used for automated testing of this role. It is linked to this role's repository and will trigger on each commit to configured branches, which are currently:

* [Develop](https://semaphoreci.com/antarctica/ansible-core-public/branches/develop)

When triggered a single test configuration [1] will be run [2].

Current automated test status:

[![Build Status](https://semaphoreci.com/api/v1/projects/371134e7-8b49-49c0-904f-aa05f0f0fa1e/533438/badge.svg)](https://semaphoreci.com/antarctica/ansible-core-public)

See the [automated testing environment](https://semaphoreci.com/antarctica/ansible-core-public) for test history, configuration and documentation.

[1] It is currently only possible to test a single configuration, as we cannot wipe the test VM during the test process.
[2] This configuration is indicated and described in the main *testing* section.

## Manual tests

Manual tests are more complete than the automated tests, testing all the test configurations [1]. Consequently, these tests are slower and more time consuming to run than automated tests. The use of Ansible and simple shell scripts aims to reduce this effort/complexity as far as is practical.

Two environments, local and remote, are available for manual testing. Some types of test, for example testing SSL with tools such as SSL Labs, can only be performed using the remote environment.

[1] These configurations are described in the main *testing* section.

### Requirements

#### All environments

* [Mac OS X](https://www.apple.com/uk/osx/)
* [NMap](http://nmap.org/) `brew cask install nmap` [1]
* [Git](http://git-scm.com/) `brew install git`
* [Ansible](http://www.ansible.com) `brew install ansible`
* You have a [private key](https://help.github.com/articles/generating-ssh-keys/) `id_rsa`
and [public key](https://help.github.com/articles/generating-ssh-keys/) `id_rsa.pub` in `~/.ssh/` 

[1] `nmap` is needed to determine if you access internal resources (such as Stash).

#### Manual testing - local

* [VMware Fusion](http://vmware.com/fusion) `brew cask install vmware-fusion`
* [Vagrant](http://vagrantup.com) `brew cask install vagrant`
* Vagrant plugins:
    * [Vagrant VMware](http://www.vagrantup.com/vmware) `vagrant plugin install vagrant-vmware-fusion`
    * [Host manager](https://github.com/smdahlen/vagrant-hostmanager) `vagrant plugin install vagrant-hostmanager`
    * [Vagrant triggers](https://github.com/emyl/vagrant-triggers) `vagrant plugin install vagrant-triggers`
* You have an entry like [1] in your `~/.ssh/config`
* You have a [self signed SSL certificate for local use](https://gist.github.com/felnne/25c220a03f8f39663a5d), with the
certificate assumed at, `tests/provisioning/certificates/v.m/v.m.tls.crt`, and private key at `tests/provisioning/certificates/v.m/v.m.tls.key`

[1] SSH config entry

```shell
Host *.v.m
    ForwardAgent yes
    User app
    IdentityFile ~/.ssh/id_rsa
    Port 22
```

#### Manual testing - remote

* [Terraform](terraform.io) `brew cask install terraform` (minimum version: 6.0)
* [Rsync](https://rsync.samba.org/) `brew install rsync`
* You have an entry like [1] in your `~/.ssh/config`
* An environment variable: `TF_VAR_digital_ocean_token=XXX` set,
where `XXX` is your DigitalOcean personal access token - used by Terraform
* An environment variable: `TF_VAR_ssh_fingerprint=XXX` set,
 where `XXX` is [your public key fingerprint](https://gist.github.com/felnne/596d2bf11842a0cf64d6) - used by Terraform
* You have the `*.web.nerc-bas.ac.uk` wildcard SSL certificate, with the
certificate assumed at, `tests/provisioning/certificates/star.web.nerc-bas.ac.uk/star.web.nerc-bas.ac.uk-certificate-including-trust-chain.crt`, and private key at `tests/provisioning/certificates/star.web.nerc-bas.ac.uk/star.web.nerc-bas.ac.uk.key`

[1] SSH config entry

```shell
Host *.web.nerc-bas.ac.uk
    ForwardAgent yes
    User app
    IdentityFile ~/.ssh/id_rsa
    Port 22
```

### Setup

#### All environments

It is assumed you are in the root of this role.

```shell
cd tests
```

#### Manual testing - local

VMs are powered by VMware, managed using Vagrant and configured by Ansible.

```shell
$ vagrant up
```

Vagrant will automatically configure the localhost hosts file for infrastructure it creates on your behalf:

| Name                                      | Points To                    | FQDN                                            | Notes                             |
| ----------------------------------------- | ---------------------------- | ----------------------------------------------- | --------------------------------- |
| barc-core-test-bare                       | *computed value*             | `barc-core-test-bare.v.m`                       | The VM's private IP address       |
| barc-core-test-swap                       | *computed value*             | `barc-core-test-swap.v.m`                       | The VM's private IP address       |
| barc-core-test-known-hosts                | *computed value*             | `barc-core-test-known-hosts.v.m`                | The VM's private IP address       |
| barc-core-test-controller-user-bare       | *computed value*             | `barc-core-test-controller-user-bare.v.m`       | The VM's private IP address       |
| barc-core-test-controller-user-adm-group  | *computed value*             | `barc-core-test-controller-user-adm-group.v.m`  | The VM's private IP address       |
| barc-core-test-controller-user-bash-alias | *computed value*             | `barc-core-test-controller-user-bash-alias.v.m` | The VM's private IP address       |
| barc-core-test-app-user-bare              | *computed value*             | `barc-core-test-app-user-bare.v.m`              | The VM's private IP address       |
| barc-core-test-app-user-authorized-keys   | *computed value*             | `barc-core-test-app-user-authorized-keys.v.m`   | The VM's private IP address       |
| barc-core-test-app-user-bash-alias        | *computed value*             | `barc-core-test-app-user-bash-alias.v.m`        | The VM's private IP address       |

Note: Vagrant managed VMs also have a second, host-guest only, network for management purposes not documented here.

#### Manual testing - remote

VMs are powered by DigitalOcean, managed using Terraform and configured by Ansible.

```shell
$ terraform get
$ terraform apply
```

Terraform will automatically configure DNS records for infrastructure it creates on your behalf:

| Kind      | Name                                               | Points To                                                               | FQDN                                                                    | Notes                                             |
| --------- | -------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------- | ------------------------------------------------- |
| **A**     | barc-core-test-bare.internal                       | *computed value*                                                        | `barc-core-test-bare.internal.web.nerc-bas.ac.uk`                       | The VM's private IP address                       |
| **A**     | barc-core-test-bare.external                       | *computed value*                                                        | `barc-core-test-bare.external.web.nerc-bas.ac.uk`                       | The VM's public IP address                        |
| **CNAME** | barc-core-test-bare                                | `barc-core-test-bare.external.web.nerc-bas.ac.uk`                       | `barc-core-test-bare.web.nerc-bas.ac.uk`                                | A pointer for the default address                 |
| **A**     | barc-core-test-swap.internal                       | *computed value*                                                        | `barc-core-test-swap.internal.web.nerc-bas.ac.uk`                       | The VM's private IP address                       |
| **A**     | barc-core-test-swap.external                       | *computed value*                                                        | `barc-core-test-swap.external.web.nerc-bas.ac.uk`                       | The VM's public IP address                        |
| **CNAME** | barc-core-test-swap                                | `barc-core-test-swap.external.web.nerc-bas.ac.uk`                       | `barc-core-test-swap.web.nerc-bas.ac.uk`                                | A pointer for the default address                 |
| **A**     | barc-core-test-known-hosts.internal                | *computed value*                                                        | `barc-core-test-known-hosts.internal.web.nerc-bas.ac.uk`                | The VM's private IP address                       |
| **A**     | barc-core-test-known-hosts.external                | *computed value*                                                        | `barc-core-test-known-hosts.external.web.nerc-bas.ac.uk`                | The VM's public IP address                        |
| **CNAME** | barc-core-test-known-hosts                         | `barc-core-test-known-hosts.external.web.nerc-bas.ac.uk`                | `barc-core-test-known-hosts.web.nerc-bas.ac.uk`                         | A pointer for the default address                 |
| **A**     | barc-core-test-controller-user-bare.internal       | *computed value*                                                        | `barc-core-test-controller-user-bare.internal.web.nerc-bas.ac.uk`       | The VM's private IP address                       |
| **A**     | barc-core-test-controller-user-bare.external       | *computed value*                                                        | `barc-core-test-controller-user-bare.external.web.nerc-bas.ac.uk`       | The VM's public IP address                        |
| **CNAME** | barc-core-test-controller-user-bare                | `barc-core-test-controller-user-bare.external.web.nerc-bas.ac.uk`       | `barc-core-test-controller-user-bare.web.nerc-bas.ac.uk`                | A pointer for the default address                 |
| **A**     | barc-core-test-controller-user-adm-group.internal  | *computed value*                                                        | `barc-core-test-controller-user-adm-group.internal.web.nerc-bas.ac.uk`  | The VM's private IP address                       |
| **A**     | barc-core-test-controller-user-adm-group.external  | *computed value*                                                        | `barc-core-test-controller-user-adm-group.external.web.nerc-bas.ac.uk`  | The VM's public IP address                        |
| **CNAME** | barc-core-test-controller-user-adm-group           | `barc-core-test-controller-user-adm-group.external.web.nerc-bas.ac.uk`  | `barc-core-test-controller-user-adm-group.web.nerc-bas.ac.uk`           | A pointer for the default address                 |
| **A**     | barc-core-test-controller-user-bash-alias.internal | *computed value*                                                        | `barc-core-test-controller-user-bash-alias.internal.web.nerc-bas.ac.uk` | The VM's private IP address                       |
| **A**     | barc-core-test-controller-user-bash-alias.external | *computed value*                                                        | `barc-core-test-controller-user-bash-alias.external.web.nerc-bas.ac.uk` | The VM's public IP address                        |
| **CNAME** | barc-core-test-controller-user-bash-alias          | `barc-core-test-controller-user-bash-alias.external.web.nerc-bas.ac.uk` | `barc-core-test-controller-user-bash-alias.web.nerc-bas.ac.uk`          | A pointer for the default address                 |
| **A**     | barc-core-test-app-user-bare.internal              | *computed value*                                                        | `barc-core-test-app-user-bare.internal.web.nerc-bas.ac.uk`              | The VM's private IP address                       |
| **A**     | barc-core-test-app-user-bare.external              | *computed value*                                                        | `barc-core-test-app-user-bare.external.web.nerc-bas.ac.uk`              | The VM's public IP address                        |
| **CNAME** | barc-core-test-app-user-bare                       | `barc-core-test-app-user-bare.external.web.nerc-bas.ac.uk`              | `barc-core-test-app-user-bare.web.nerc-bas.ac.uk`                       | A pointer for the default address                 |
| **A**     | barc-core-test-app-user-authorized-keys.internal   | *computed value*                                                        | `barc-core-test-app-user-authorized-keys.internal.web.nerc-bas.ac.uk`   | The VM's private IP address                       |
| **A**     | barc-core-test-app-user-authorized-keys.external   | *computed value*                                                        | `barc-core-test-app-user-authorized-keys.external.web.nerc-bas.ac.uk`   | The VM's public IP address                        |
| **CNAME** | barc-core-test-app-user-authorized-keys            | `barc-core-test-app-user-authorized-keys.external.web.nerc-bas.ac.uk`   | `barc-core-test-app-user-authorized-keys.web.nerc-bas.ac.uk`            | A pointer for the default address                 |
| **A**     | barc-core-test-app-user-bash-alias.internal        | *computed value*                                                        | `barc-core-test-app-user-bash-alias.internal.web.nerc-bas.ac.uk`        | The VM's private IP address                       |
| **A**     | barc-core-test-app-user-bash-alias.external        | *computed value*                                                        | `barc-core-test-app-user-bash-alias.external.web.nerc-bas.ac.uk`        | The VM's public IP address                        |
| **CNAME** | barc-core-test-app-user-bash-alias                 | `barc-core-test-app-user-bash-alias.external.web.nerc-bas.ac.uk`        | `barc-core-test-app-user-bash-alias.web.nerc-bas.ac.uk`                 | A pointer for the default address                 |

Note: Terraform cannot provision VMs itself due to [this issue](https://github.com/hashicorp/terraform/issues/1178),
therefore these tasks need to be performed manually:

```shell
$ ansible-galaxy install https://github.com/antarctica/ansible-prelude,v0.1.2 --roles-path=provisioning/roles_bootstrap  --no-deps --force
$ ansible-playbook -i provisioning/local provisioning/prelude.yml
$ ansible-playbook -i provisioning/testing-remote provisioning/bootstrap-digitalocean.yml
```

### Usage

#### Manual testing - local

Use this shell script to run all test phases automatically:

```shell
$ ./tests/run-local-tests.sh
```

Alternatively run each phase separately:

```shell
# Check syntax:
$ ansible-playbook -i provisioning/testing-local provisioning/site-test.yml --syntax-check

# Apply playbook:
$ ansible-playbook -i provisioning/testing-local provisioning/site-test.yml

# Apply again to check idempotency:
$ ansible-playbook -i provisioning/testing-local provisioning/site-test.yml
```

Note: The use of `#` in the above indicates a comment, not a root shell.

#### Manual testing - remote

Use this shell script to run all test phases automatically:

```shell
$ ./tests/run-remote-tests.sh
```

Alternatively run each phase separately:

```shell
# Check syntax:
$ ansible-playbook -i provisioning/testing-remote provisioning/site-test.yml --syntax-check

# Apply playbook:
$ ansible-playbook -i provisioning/testing-remote provisioning/site-test.yml

# Apply again to check idempotency:
$ ansible-playbook -i provisioning/testing-remote provisioning/site-test.yml
```

Note: The use of `#` in the above indicates a comment, not a root shell.

### Clean up

#### Manual testing - local

```shell
$ vagrant destroy
```

#### Manual testing - remote

```shell
$ terraform destroy
```
