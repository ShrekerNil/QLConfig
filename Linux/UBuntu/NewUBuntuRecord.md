# Things in New UBuntu

## Update and Upgrade System

```sh
sudo apt update && sudo apt upgrade
```



# Operation about bout root user

## Avoid input pass for every sudo

1. Edit `/etc/sudoers`

2. Modify line starting with `%sudo`

   ```sh
   # before
   %sudo   ALL=(ALL:ALL) ALL
   
   # after
   %sudo   ALL=(ALL:ALL) NOPASSWD: ALL
   ```

## Root user

### Enable

1. Set pass for root user

   ```sh
   sudo passwd root
   ```

2. Change to root user

   ```sh
   su root
   ```

### Disable

```sh
sudo passwd -dl root
```

## Put new user into sudo group

```sh
sudo usermod -aG sudo <user-name>
```

## Login with root user

Edit file `/usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf`, append content as below

```sh
autologin-user=root
greeter-show-manual-login=true
```

