<p align="center">
  <img width="256" height="256" src="../demo/assets/admob.png">
</p>

# ![](../addon/icon.png?raw=true) Android Admob Plugin

Enables AdMob functionality on Godot apps that are exported to the Android platform and allows 
displaying of Admob ads.

_For iOS version, visit https://github.com/cengiz-pz/godot-ios-admob-plugin ._

This branch contains the latest version of the plugin, which contains breaking changes to the plugin
interface. The original version of the plugin can be found on the
[Release 1.0 branch](https://github.com/cengiz-pz/godot-android-admob-plugin/tree/release-1.0).

## ![](../addon/icon.png?raw=true) Prerequisites
Follow instructions on the following page to create a custom Android gradle build
- [Create custom Android gradle build](https://docs.godotengine.org/en/stable/tutorials/export/android_gradle_build.html)

Create an AdMob account at the following link:
- [Google AdMob](https://admob.google.com/)
- create an app in AdMob console
- [create ad(s)](https://support.google.com/admob/answer/6173650?hl=en) for your app via the AdMob console
- if needed, [create consent form(s)](https://support.google.com/admob/answer/10113207?hl=en) for your app via the AdMob console

## ![](../addon/icon.png?raw=true) Usage

[Usage documentation](../README.md#usage)

## ![](../addon/icon.png?raw=true) Troubleshooting

### Missing APP ID
If your game crashes due to missing APP ID, then make sure that you enter your Admob APP ID in the Admob node and pay attention to the [Android Export section](#android-export).

### ADB logcat
`adb logcat` is one of the best tools for troubleshooting unexpected behavior
- use `$> adb logcat | grep 'godot'` on Linux
	- `adb logcat *:W` to see warnings and errors
	- `adb logcat *:E` to see only errors
	- `adb logcat | grep 'godot|somethingElse'` to filter using more than one string at the same time
- use `#> adb.exe logcat | select-string "godot"` on powershell (Windows)

Also check out:
https://docs.godotengine.org/en/stable/tutorials/platform/android/android_plugin.html#troubleshooting

<br/><br/>

---
# ![](../addon/icon.png?raw=true) Credits
Based on [Shin-NiL](https://github.com/Shin-NiL)'s [Godot Admob Plugin](https://github.com/Shin-NiL/Godot-Android-Admob-Plugin)

Developed by [Cengiz](https://github.com/cengiz-pz)

Original repository: [Godot Android Admob Plugin](https://github.com/cengiz-pz/godot-android-admob-plugin)

<br/><br/>

---
# ![](../addon/icon.png?raw=true) Tutorials
The following is a video tutorial by [16BitDev](https://www.youtube.com/@16bitdev) that covers the whole process of setting up Admob for your Godot app on Android.

[![Watch the video](https://img.youtube.com/vi/V9_Gpy0R3RE/0.jpg)](https://www.youtube.com/watch?v=V9_Gpy0R3RE)

<br/><br/>

___

# ![](../addon/icon.png?raw=true) Contribution

This section provides information on how to build the plugin for contributors.

<br/>

___

## ![](../addon/icon.png?raw=true) Prerequisites

- [Install AndroidStudio](https://developer.android.com/studio)

<br/>

___

## ![](../addon/icon.png?raw=true) Building plugin

There are two ways to build this plugin for the Android platform.

## ![](../addon/icon.png?raw=true) Android Studio

- Load the gradle project under the `android` directory into `Android Studio`
	- select build variant (debug or release)
	- select the `Assemble Project` item of `Build Menu`.

## ![](../addon/icon.png?raw=true) Bash Script

- Create a `local.properties` file under the `android` that contains the `sdk.dir` value.
	- ie. `sdk.dir=/usr/lib/android-sdk`
- Run build script with `-a` option from project root.
	- ie. `./script/build.sh -ca` for debug build.
	- or `./script/build.sh -car` for release build.

## ![](../addon/icon.png?raw=true) Creating a release archive

There are two ways to create a release archive for this plugin targeting the Android platform.

*_Prior to creating the archive, make sure that both the `debug` and `release` build variants have been built._

## ![](../addon/icon.png?raw=true) Android Studio

- From `Android Studio`
	- run the `packageDistribution` gradle task.

## ![](../addon/icon.png?raw=true) Bash Script

- Run build script with `-z` option from project root.
	- ie. `./script/build.sh -z`

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
