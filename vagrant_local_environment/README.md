# Vagrant Devstack Multi-Node

This is an environment build using Ansible, Vagrant, and VirtualBox to create an environment suitable for development, testing, and evaluation os OpenStack. In order to make use of this environment, some software will need to be installed on your computer. The computer you use for this should have at least 16Gb of RAM and a CPU that has at least 2 cores. This can be setup on hosts with a variety of operating systems.
# Environment Build Instructions
## macOS
_Gatekeeper will block virtualbox from installing. All you have to do is go into Security & Privacy of System Preferences and click Allow under the General tab and rerun installation._

Keep in mind that VirtualBox does not run on M1 mac machines, so this only works with Intel based macs at the time of writing this.

##### Install all at once with the command below:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && xcode-select --install &&brew install ansible ; brew install python ; brew cask install vagrant ; brew cask install VirtualBox ; brew cask install virtualbox-extension-pack ; vagrant plugin install vagrant-guest_ansible
```

##### Alternatively, you can install everything individually below.
- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html) - (`brew cask install vagrant`)
    - Vagrant Plugin - `vagrant plugin install vagrant-guest_ansible`
- [Install the Latest Version of Virtualbox](https://www.virtualbox.org/wiki/Downloads) (`brew cask install VirtualBox`)
    - Virtual Box Extension Pack (`brew cask install virtualbox-extension-pack`)

##### Once the above software is installed. Do the following if you're running the environment on Mac:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/OpenCloudJedi/OpenInfra2023.git`
3. Change to the `OpenInfra2023` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

## CentOS/RHEL - Install all at once by Copy/Pasting the below command into your terminal as root.
_NOTE - If it's been awhile since you've run yum update, do that first. Reboot if the kernel was updated. There may be some dependencies errors but don't be alarmed as this won't stop the environment from working._

_NOTE2 - If you receive an error for an ansible guest vagrant plugin, DO NOT worry, as there are two different plugins related to Ansible and only one needs to be installed._
##### For CentoOS/RHEL7 (Continue below for RHEL 8 specific script)
```
systemctl stop packagekit; yum install -y epel-release && yum install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel libguestfs-tools-c ; mkdir ~/Vagrant ; cd ~/Vagrant ; curl -o  vagrant_2.2.6_x86_64.rpm https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm && yum install -y vagrant_2.2.6_x86_64.rpm && vagrant plugin install vagrant-guest_ansible ; vagrant plugin install vagrant-guest-ansible ; wget -O /etc/yum.repos.d/virtualbox.repo wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo ; yum install -y VirtualBox-6.0 && systemctl start packagekit
```
##### If you're using RHEL 8, use the script below:
```
systemctl stop packagekit; dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm ; dnf install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel libguestfs-tools-c ; mkdir ~/Vagrant ; cd ~/Vagrant ; curl -o  vagrant_2.2.6_x86_64.rpm https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm && dnf install -y vagrant_2.2.6_x86_64.rpm && vagrant plugin install vagrant-guest_ansible ; wget -O /etc/yum.repos.d/virtualbox.repo wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo ; dnf install -y VirtualBox-6.0 && /usr/lib/virtualbox/vboxdrv.sh setup ; usermod -a -G vboxusers root ; systemctl start packagekit
```
##### Also, install the Virtualbox extension pack below
- [Install the Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

##### Once the above software is installed. Do the following if you're running the environment on Linux:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `https://github.com/OpenCloudJedi/OpenInfra2023.git`
3. Change to the `OpenInfra2023` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

## Windows
- If using Windows:
- [Install Microsoft C++ Visual 2019](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170)
- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html)
- [Install the Latest Version of Virtualbox and Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)
- Then install the following vagrant plugin via PowerShell as Administrator `vagrant plugin install vagrant-guest_ansible` 


##### Once the above software is installed. Do the following if you're running the environment on Windows:
1. Create a separate `~/bin` directory and `cd` to it using the same PowerShell/Terminal as Administrator/Root.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Use your browser of choice and navigate to https://github.com/OpenCloudJedi/OpenInfra2023, press the green “Clone or download” button then the “Download ZIP” button. Or use Github Desktop (See below).
3. Once downloaded, unzip the file and move it to the directory you created earlier, `~/bin` in the above example.
4. Use PowerShell/Terminal as Administrator/Root again and cd to the `~/bin/OpenInfra2023-main` directory then run `vagrant up` to deploy the environment. (It will take the longest to deploy the first time only, this is because the Vagrant system downloads the base image only the first time.


## Debian/Ubuntu
_NOTE - If it's been awhile since you've run apt update, do that first. Reboot if the kernel was updated._

##### Install all at once by Copy/Pasting the below command into your terminal as root.
```
sudo snap install ruby ; sudo apt install ruby-bundler git -y; wget -c https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb ; sudo dpkg -i vagrant_2.2.6_x86_64.deb ; wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - ; wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - ; sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"; sudo apt update; sudo apt install -y virtualbox ; vagrant plugin install vagrant-guest_ansible
```
##### Also, install the Virtualbox extension pack below
- [Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

##### Once the above software is installed. Do the following if you're running the environment on Linux:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/OpenCloudJedi/OpenInfra2023.git`
3. Change to the `OpenInfra2023` directory that is now in your `~/bin` directory and then cd into the OS directory you want to deploy.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)


## (Recommended) Install Github Desktop to make pulling down changes easier
_NOTE this requires a free Github account_
1. Navigate to https://desktop.github.com/ and download Github Desktop.
2. Create or sign in to your account.
3. Click "Clone a repository from the Internet" and enter "OpenCloudJedi/OpenInfra2023" and choose a location then "Clone".
4. You are also able to easily pull changes when they're made available.

## Notable commands to control the environment:
- `vagrant up` - Boots and provisions the environment
- `vagrant destroy -f` - Shuts down and destroys the vm and wipes all data on it.
- `vagrant up --provision` - Builds the servers that were destroyed and runs provisioning scripts again

If you want you can create a snapshot of your machine that get reset and then restore that snapshot to quickly start over. This is significantly faster than a full reset. 
1. First bring up the environment fully and make sure the provisioning script ran (The ansible part after the machine boots up)
2. Make a snapshot of the vm
- `vagrant snapshot create Controller Controller`
3. After completing your work or in the case you broke your machine, try restoring the images back the vm (make sure you are in the project directory before attempting this ie. ~/bin/LinuxPlus-main/CentOS )
- `vagrant snapshot restore Controller Controller`

## Other Useful Information:
You can also use the VirtualBox console to interact with the VMs or through a terminal. The first time you run the vagrant up command, it will download the OS images for later use. In other words, it will take longest the first time around but will be faster when it is deployed again. You can run `vagrant destroy -f` to destroy your environment at anytime. **This will erase everything**. This environment is meant to be reuseable, If you run the `vagrant up` command after destroying the environment, the OS image will already be downloaded and environment will deploy faster then the first time. Deployment should take around 15 minutes depending on the speed of your computer and internet connection.  Everything should be provided that you would normally need for testing and evaluating OpenStack on your own.

## Included systems:
- Controller
- ComputeNode (Both Controller and ComputeNode are on the same network, so they can communicate with each other.)

## System Details:
> Controller
- 192.168.42.11
> ComputeNode
- 192.168.42.12
