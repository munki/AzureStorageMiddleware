This is a proof-of-concept project that builds an Azure Storage middleware plugin for Munki 7.

It is a port of Oliver Kieselbach's Azure Storage middleware:
https://github.com/okieselbach/Munki-Middleware-Azure-Storage

A basic test against a repo hosted on Azure storage was successful (thanks @natewalck).

The middleware plugin must be installed in /usr/local/munki/middleware/, and you need Munki 7.0.0.5139 or later to test.

To build the middleware plugin and an Installer pkg that installs it, cd into this directory and run `./build_pkg.sh`. You will need a recent version of Xcode.