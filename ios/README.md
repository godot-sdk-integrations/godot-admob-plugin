<p align="center">
  <img width="256" height="256" src="../demo/assets/admob-ios.png">
</p>

---
# ![](../addon/icon.png?raw=true) iOS Admob Plugin

Enables AdMob functionality on Godot apps that are exported to the iOS platform and allows 
displaying of Admob ads.

_For Android version, visit https://github.com/cengiz-pz/godot-android-admob-plugin ._

## ![](../addon/icon.png?raw=true) Prerequisites
Follow instructions on the following page to prepare for iOS export:
- [Exporting for iOS](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html)

Create an AdMob account at the following link:
- [Google AdMob](https://admob.google.com/)
- create an app in AdMob console
- [create ad(s)](https://support.google.com/admob/answer/6173650?hl=en) for your app via the AdMob console
- if needed, [create consent form(s)](https://support.google.com/admob/answer/10113207?hl=en) for your app via the AdMob console

## ![](../addon/icon.png?raw=true) Usage

[Usage documentation](../README.md#usage)


## ![](../addon/icon.png?raw=true) App Tracking Transparency
App Tracking Transparency, or ATT for short, is Apple's opt-in privacy framework that requires all iOS apps to ask users for permission to share their data. This is done in the form of a popup where users can either consent or deny tracking.

* To enable ATT in your app
	- Enter a descriptive text that will be displayed on the ATT dialog in your `Admob` node's `att_text`field.
	- Call `Admob` node's `request_tracking_authorization()` method.
	- Handle `Admob` node's `tracking_authorization_granted` and `tracking_authorization_denied` signals.
* If the user initially rejects the tracking request, then later on you can check if the user changed their mind and allow them to change their decision by opening the system app settings using the `Admob` node's `open_app_settings()` method.


## ![](../addon/icon.png?raw=true) Troubleshooting

### Missing APP ID
If your game crashes due to missing APP ID, then make sure that you enter your Admob APP ID in the Admob node and pay attention to the [iOS Export section](#ios-export).

### XCode logs
XCode logs are one of the best tools for troubleshooting unexpected behavior. View XCode logs while running your game to troubleshoot any issues.

### Troubleshooting guide
Refer to Godot's [Troubleshooting Guide](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html#troubleshooting).

<br/><br/>

---
# ![](../addon/icon.png?raw=true) Credits
Developed by [Cengiz](https://github.com/cengiz-pz)

Based on [Godot iOS Plugin Template](https://github.com/cengiz-pz/godot-ios-plugin-template)

Original repository: [Godot iOS Admob Plugin](https://github.com/cengiz-pz/godot-ios-admob-plugin)

<br/><br/>

___

# ![](../addon/icon.png?raw=true) Contribution

This section provides information on how to build the plugin for contributors.

<br/>

___

## ![](../addon/icon.png?raw=true) Prerequisites

- [Install SCons](https://scons.org/doc/production/HTML/scons-user/ch01s02.html)
- [Install CocoaPods](https://guides.cocoapods.org/using/getting-started.html)

<br/>

___

## ![](../addon/icon.png?raw=true) Build

- Run `./script/build.sh -A <godot version>` initially to run a full build
- Run `./script/build.sh -cgA <godot version>` to clean, redownload Godot, and rebuild
- Run `./script/build.sh -ca` to clean and build without redownloading Godot
- Run `./script/build.sh -cb -z4.0` to clean and build plugin without redownloading Godot and package in a zip archive as version 4.0
- Run `./script/build.sh -h` for more information on the build script

<br/>

___

## ![](../addon/icon.png?raw=true) Install Script

- Run `./script/install.sh -t <target directory> -z <path to zip file>` install plugin to a Godot project.
- Example `./script/install.sh -t demo -z bin/release/AdmobPlugin-v4.0.zip` to install to demo app.

<br/>

___

## ![](../addon/icon.png?raw=true) Git addon submodule


### ![](../addon/icon.png?raw=true) Creating

- `git submodule add -b main --force --name addon https://github.com/cengiz-pz/godot-admob-addon.git addon`

### ![](../addon/icon.png?raw=true) Updating

- Remove `addon` directory
- Run `git submodule update --remote --merge`

<br/>

___

## ![](../addon/icon.png?raw=true) Libraries

Library archives will be created in the `bin/release` directory.

<br/><br/>

---
# ![](../addon/icon.png?raw=true) All Plugins

| Plugin | Android | iOS |
| :---: | :--- | :--- |
| Notification Scheduler | https://github.com/cengiz-pz/godot-android-notification-scheduler-plugin | https://github.com/cengiz-pz/godot-ios-notification-scheduler-plugin |
| Admob | https://github.com/cengiz-pz/godot-android-admob-plugin | https://github.com/cengiz-pz/godot-ios-admob-plugin |
| Deeplink | https://github.com/cengiz-pz/godot-android-deeplink-plugin | https://github.com/cengiz-pz/godot-ios-deeplink-plugin |
| Share | https://github.com/cengiz-pz/godot-android-share-plugin | https://github.com/cengiz-pz/godot-ios-share-plugin |
| In-App Review | https://github.com/cengiz-pz/godot-android-inapp-review-plugin | https://github.com/cengiz-pz/godot-ios-inapp-review-plugin |
