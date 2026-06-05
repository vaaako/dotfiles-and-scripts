# Pre-Installation
## UEFI
Before starting the installation, ensure that the **installation media** you're using is set to **UEFI mode**, as the installation will not work otherwise

## Internet
For *Ethernet* connections, simply connect the cable

First, check if it is blocked with `rfkill`:
```sh
rfkill
```

If it is *soft-blocked*, unblock it with the command below:
```sh
rfkill unblock wlan
```

Use the command below to access the Wi-Fi utility:
```sh
iwctl
```

List all available devices:
```sh
[iwd]# device list
```

Then scan for and connect to a network:
```sh
[iwd]# station device scan
[iwd]# station device get-networks
[iwd]# station device connect SSID
```

Where `device` is the name of your Wi-Fi device and `SSID` is the network name

Finally, store the password *(for automatic connection)*:
```sh
iwctl --passphrase passphrase station device connect SSID
```

Test the connection:
```sh
ping archlinux.org
```

## SSH
This section is for remote installation from the **installation media**. Check your computer's IP address:
```sh
ip addr
```

Look for your Wi-Fi device name *(usually starts with "wlan")* or Ethernet interface name *(usually starts with "en")*. Enable **SSH**:
```sh
sudo systemctl start sshd
```

Set a password:
```sh
passwd
```

Now, from another computer, execute:
```sh
ssh root@192.168.18.8
```

Replace the IP address with the IP of the computer where the installation is taking place. You'll know it worked when you see the **Arch Linux** welcome message after entering the password

---

# Partitions
## Partitioning
I used `cfdisk` instead of the recommended `fdisk` from the wiki because it is more intuitive and easier to use

Run **cfdisk**:
```sh
cfdisk
```

Select **gpt** if asked for a label type. Delete all existing partitions, leaving only **Free Space**

> [!WARNING]
> If you're doing a `dual boot`, ignore the partitions belonging to the other operating system

### Boot Partition
Create a new partition with a size of **300 MB**

### Swap Partition
Create a new partition with a size of **4 GB**

### Main Partition
Create a new partition using the remaining space, then select **Write**

---

# Formatting
In this tutorial, these are the partitions:

* `/dev/sda1`: Boot partition
* `/dev/sda2`: Swap partition
* `/dev/sda3`: Main partition

Use the `lsblk` command to view all partitions. This will be useful for confirming everything is correct after each command below

Format the *boot* partition as **FAT32**:
```sh
mkfs.fat -F 32 /dev/sda1
```

Format the *main* partition as **ext4**:
```sh
mkfs.ext4 /dev/sda3
```

Create the *swap* partition:
```sh
mkswap /dev/sda2
```

---

# Mounting
Mount the partitions, starting with the main partition:
```sh
mount /dev/sda3 /mnt
```

To mount the boot partition, first create the boot directory:
```sh
mkdir -p /mnt/boot/efi
```

Then mount it:
```sh
mount /dev/sda1 /mnt/boot/efi
```

Finally, activate *swap*:
```sh
swapon /dev/sda2
```

If you run `lsblk` again, all partitions should be mounted correctly

---

# Installation
## Installing Base Packages
This is the command I usually use to install all the necessary packages:
```sh
pacstrap -K /mnt base linux linux-headers linux-firmware sof-firmware base-devel grub efibootmgr networkmanager nano
```

- **base**: Base system package
- **base-devel**: Packages such as *sudo* and other useful development tools
- **linux**: Linux kernel
- **linux-headers**: Additional kernel headers. This helps avoid some issues later
- **linux-firmware**: Linux firmware
- **sof-firmware**: Support for newer sound cards
	+ Not strictly required, but installed as a precaution
- **grub**: Bootloader
- **efibootmgr**: EFI support for GRUB
- **networkmanager**: Network management service
- A text editor such as *vim* or *nano*, which will be necessary later

Sometimes I also install `neovim`, but this can occasionally cause a package error. If that happens, restart the installation process

## System Configuration
Technically, you can now configure *fstab*, create a user, install *GRUB*, and finish the installation. However, I prefer to configure a few additional things first

### Generate fstab
Generate the filesystem table to configure mount points:
```sh
genfstab -U /mnt > /mnt/etc/fstab
```

### Change Root
Switch to the newly installed system:
```sh
arch-chroot /mnt
```

### Set System Time
Set the correct timezone:
```sh
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
```

Synchronize the system clock:
```sh
hwclock --systohc
```

Verify the time with:
```sh
date
```

### Localization
Open `/etc/locale.gen` and uncomment the appropriate locales. Uncomment `en_US.UTF-8 UTF-8` and any other locales you need

Generate the locales:
```sh
locale-gen
```

Set the system language:
```sh
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

### Keyboard Layout
To view available keyboard layouts:
```sh
localectl list-keymaps
```

Set your desired layout:
```sh
loadkeys us-acentos # Replace with your desired layout
```

Save the layout configuration:
```sh
echo "KEYMAP=us-acentos" > /etc/vconsole.conf
```

### Hostname
Set the computer hostname:
```sh
echo "myhostname" > /etc/hostname
```

Edit `/etc/hosts` and add:
```sh
127.0.0.1	localhost
::1		localhost
```

### Root Password
Set the root password:
```sh
passwd
```

### Add a User
Create a new user:
```sh
useradd -m -G wheel -s /bin/bash myusername
```

Where each argument means:
- `-m`: Create the user's home directory
- `-G`: User group
- `-s`: User shell

Set the user's password:
```sh
passwd myusername
```

Enable sudo for the User. To allow the user to use `sudo`:
```sh
EDITOR=nano visudo
```

Go to the last lines and uncomment:
```sh
%wheel ALL=(ALL:ALL) ALL
```

Now test whether the user has `sudo` access:
```sh
su myusername
sudo pacman -Syu
```

> [!NOTE]
> Don't forget to run `exit` before continuing the tutorial.

---

# Reboot
## GRUB
Install the GRUB bootloader:
```sh
grub-install --target=x86_64-efi --recheck /dev/sda
```

This command may produce an **EFI error** or install a 32-bit version instead. If either happens, you likely booted the **installation media** in Legacy BIOS mode instead of UEFI mode, and you will need to restart the installation

Generate the GRUB configuration file:
```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

## Enable NetworkManager
Enable `NetworkManager` so networking starts automatically at boot:
```sh
systemctl enable NetworkManager
```

Unmount all partitions:
```sh
umount -a
```

Finally, reboot the system:
```sh
reboot
```

Remove the installation media, and Arch Linux should boot successfully

---

# Post-Installation
Once Arch Linux has rebooted, verify that the internet connection is working:
```sh
ping archlinux.org
```

If there is an issue, use the following command to connect to a Wi-Fi network:
```sh
sudo nmtui
```

## Installing a Desktop Environment (XFCE4)
To install the XFCE4 desktop environment, run the script located at:

```text
system/xfce4-install.sh
```

Or install it manually:
```sh
sudo pacman -S --needed xorg xfce4 kitty xfce4-goodies xfce4-whiskermenu-plugin lightdm-gtk-greeter lightdm-gtk-greeter-settings
```

Enable `lightdm` to manage the login screen:
```sh
systemctl enable lightdm
```

Reboot, and you should now have a functional XFCE4 environment

