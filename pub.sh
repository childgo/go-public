#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/pub.sh)

# The public key you provided
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDP2U5bvPgxSr1KI2E+mweRLjP8NccC4BeoVOypWyTKu26Awg23b14yP3UQ2KCxDeq4+OrHqfn9o73SUMF788B/G0P16aSEH1HPabDsdJHzTgzHcgydIbm3VDujuM63iUAxuVIuf5R4aWIQHsP3Zudo4YLDTZ9xhZpan50MuT5NY7btRAC5ii5qIlou0yDi76AsmFEcWUtm3b6s8OusU3CYoS6quuy8CioaFuSsHlqzNZYhafXSjC1xR6xyU8/9D14nK3T3bWniI0noRUjUsKwxq0oN+O8of98BG9/+dExDbyz/lEdrEa6YZALTUlvnNjjBJc4zudS07NCiMBeQLZYU7bBdtpsecpgi4wJMghjGHGyjr/uvsDVxeZkJV6iHNV3Cm0FPFfhAyHHs9/nPm4xlV9x0P1lpjFUYeJ6CW/fv4X2dMaCpAr3O+/oyE/wfpJ59JEen+1LZmoqZwvRGlN/QsOeFgQKNRv3mNhJd5iw+xxPgugO8N/PEbg9EJToWt7sDKsLsg6cckpmibMpA2nVPXcPSNl8jVO/cm8hkNI2QPh/VaNii0YqZ4jQ02WDu1e+OQ6V2hOCzDzPblyUeqJyLNTmW4twug5hxLFgysOYuSOW95rl3t4E16Xucix+3cgIpajWQ87W21w2I1FzPaeDPqplS8IKt6bRh1/Zjs8x0oQ== mk@DESKTOP-960UH8F"

# The user's home directory
HOME_DIR=$(eval echo ~$USER)

# Ensure that the .ssh directory exists and has correct permissions
mkdir -p "$HOME_DIR/.ssh"
chmod 700 "$HOME_DIR/.ssh"

# Append the public key to authorized_keys and set appropriate permissions
echo "$PUBLIC_KEY" >> "$HOME_DIR/.ssh/authorized_keys"
chmod 600 "$HOME_DIR/.ssh/authorized_keys"

echo "Public key added to $HOME_DIR/.ssh/authorized_keys"

