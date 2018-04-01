# Deluge Docker container for Raspberry Pi
[![](https://images.microbadger.com/badges/image/mjenz/rpi-deluge.svg)](https://microbadger.com/images/mjenz/rpi-deluge "Get your own image badge on microbadger.com")

Deluge 1.3.15-r1 on Alpine 3.7, based on [eana/alpine-deluge](https://github.com/eana/alpine-deluge).

This container is intended to be to used to seed torrents from a Raspberry Pi, with all the files stored on a single external drive.


## Installation
To install as a service:
```
docker run --detach --volume /media/seedbox:/deluge --net=host --restart=unless-stopped --name=deluge mjenz/rpi-deluge
```

If you don't need UPnP, you can lock it down a bit more by replacing `--net=host` with `-p 8112:8112 -p 21021-21060:21021-21060` (plus `-p 58846:58846` if you're using a thin client).


## Usage
You can interact with Deluge in three ways: through the web UI, through a thin client, and through the filesystem.

### Web UI
The web UI is available on port 8112.
The default password is `deluge` (you should change it).

### Thin client
You can use the Deluge GUI as a thin client.
First, go to Preferences -> Interface and disable classic mode.
Then, you can use the Connection Manager to add a connection to this server.
To set up credentials for the remote connection, run `echo "username:pasword:10" >> /media/seedbox/config/auth` (replacing `username` and `password` with the credentials you'd like to log in with).
If you check "Automatically connect to selected host on start-up" and "Do not show this dialog on start-up" then the experience is basically seamless, give or take a bit of network lag.

### Filesystem
The default configuration uses the following folders on the volume:

* `config/` for config files, logs etc.
* `in-progress/` for incomplete downloads
* `downloads/` for completed downloads
* `torrents/` for .torrent files

You can download a torrent from a .torrent file by putting the file into the `torrents/` folder.
You can seed a torrent you've downloaded elsewhere by first copying the data into the `in-progress/` folder and then putting the .torrent file into the `torrents/` folder (you'll have to manually "change storage" as Deluge won't move the files into `downloads` for you for some reason).

