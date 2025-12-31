> **Maintainer needed** 
> This middleware was ported from Python to Swift for Munki 7 by Greg Neagle. However, Greg does not actually use this middleware and is not particularly motivated to support it. If you or your organization rely on this middleware, please consider taking over the responsibility for maintaining it.

This is a project that builds an Azure Storage middleware plugin for Munki 7.

It is a port of Oliver Kieselbach's Azure Storage middleware:
https://github.com/okieselbach/Munki-Middleware-Azure-Storage

A basic test against a repo hosted on Azure storage was successful (thanks @natewalck).

This plugin requires Munki 7.0.0.5152 or later.

Configuration is the same as the Python version of this plugin, detailed [here](https://github.com/okieselbach/Munki-Middleware-Azure-Storage#configuration).

You may download an Installer package for the current release of the middleware plugin from the [Releases](https://github.com/munki/AzureStorageMiddleware/releases) section.

To build the middleware plugin and an Installer pkg that installs it, `git clone` this project, `cd` into the project directory, and run `./build_pkg.sh`. You will need a recent version of Xcode.
