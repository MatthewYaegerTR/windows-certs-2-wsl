1.) run `get-all-certs.ps1` using Windows PowerShell.
  - note the location of the created `all-certificates` folder.
    
2.) run the following in WSL2.0 Ubuntu:
```
  sudo mv /etc/ssl/certs /etc/ssl/certs.orig
  sudo ln -s /<path to Windows "all-certificates" folder> /etc/ssl/certs # note: you can see your windows filesystem in WSL by navigating to /mnt/c. from there, find the all-certificates folder you created in Windows.
  update-ca-certificates
```
