
# AWS_NDN_GW_Network
This repository contains all the Ansible configuration files and playbook for 
firing up an NDN Testbed on Amazon AWS
Right now it is a very small Testbed, with two nodes running on instances that
were started manually through the AWS Console. Coming soon, a dynamic inventory 
version to run a node in each of the 14 AWS regions around the world.

One big question left to answer: How to handle the certificate management system?
 
Files to edit:
host_vars/UBUNTU_GW1    : change value for ansible_host to address of host to be installed.
                        : change value for ansible_user to username that should be used for ssh and installations.
                        :      that user must have sudo privileges
host_vars/UBUNTU_GW2    : same as UBUNTU_GW1
host_vars/<other GWs>   : add other GWs as needed

ubuntuGatewayInventory  : change value for ansible_ssh-private_key_file to point to your private key.
                        :      host being installed should have public key in ~/.ssh/authorized_keys
                        : add other GWs as needed
                        : One of the GWs needs to be designated as the testbed trust anchor:  testbed_cert_root=UBUNTU_GW1
                        : One of the GWs needs to be designated as the NLSR trust anchor:      nlsr_cert_root=UBUNTU_GW1


For Ubuntu 14.04 do this:
> ansible-playbook -i ubuntuGatewayInventory ubuntu_gateway.yml

Since it does not have python installed as /usr/bin/python
for Ubuntu 16.04 you may need to run like this the first time:
> ansible-playbook -e 'ansible_python_interpreter=/usr/bin/python3' -i ubuntuGatewayInventory ubuntu_gateway.yml

After the first successful run of the playbook, python 2.7 should also be installed
and you can drop the -e '    ' option.



