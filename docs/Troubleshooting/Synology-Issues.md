---
title: Troubleshooting Synology
description: Troubleshooting issues when using Synology products
---

### ErrNo 13: Access Denied

We have noticed recently a spate of access denied on Synology systems via Portainer or even docker manager. The ErrNo13 is directly related to Synology and it is a simple permission issue. To fix it please do the following:

1. Make sure SSH is enabled on your Synology product. Refer to here if it is not [Enable SSH](https://kb.synology.com/en-uk/DSM/tutorial/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet)
2. Connect to SSH and login as your admin username and password (Same login used to login to DSM web page)
3. Take a note on your user:group you can find this by typing ID when logged into SSH.
4. Type the following commands in the SSH window.

`sudo chown -R user:group /path/to/library`

`sudo chmod -R a=,a+rX,u+w,g+w /path/to/library`

`sudo chown -R user:group /path/to/assets`

`sudo chmod -R a=,a+rX,u+w,g+w /path/to/assets`

`sudo chown -R user:group /path/to/config`

`sudo chmod -R a=,a+rX,u+w,g+w /path/to/config`

You will find the relevant directories in your compose, this is basically the folders where you store your RomM information and we are just resetting permissions. Restart the containers and you should now have no issues scanning information in!

Any issues please ask in the Discord.

Thanks to [Docker IDs - DrFrankenstein](https://drfrankenstein.co.uk/step-2-setting-up-a-restricted-docker-user-and-obtaining-ids/) for the guidance from his blog.
