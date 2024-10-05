1.) run `get-all-certs.ps1` using Windows PowerShell.
  - note the location of the created `all-certificates` folder.
    
2.) run the following in WSL2.0 Ubuntu:
```
  sudo mv /etc/ssl/certs /etc/ssl/certs.orig
  sudo ln -s '<Linux path to Windows "all-certificates" folder>' /etc/ssl/certs ## e.g. /mnt/c/Users/<your_username>/<...>/
  update-ca-certificates
```
