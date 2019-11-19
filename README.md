# flutter_diary

Flutter Diary Application

>flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons.yaml


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


System directories

Method	Result
Environment.getDataDirectory()	/data
Environment.getDownloadCacheDirectory()	/cache
Environment.getRootDirectory()	/system
External storage directories

Method	Result
Environment.getExternalStorageDirectory()	/storage/sdcard0
Environment.getExternalStoragePublicDirectory(DIRECTORY_ALARMS)	/storage/sdcard0/Alarms
Environment.getExternalStoragePublicDirectory(DIRECTORY_DCIM)	/storage/sdcard0/DCIM
Environment.getExternalStoragePublicDirectory(DIRECTORY_DOWNLOADS)	/storage/sdcard0/Download
Environment.getExternalStoragePublicDirectory(DIRECTORY_MOVIES)	/storage/sdcard0/Movies
Environment.getExternalStoragePublicDirectory(DIRECTORY_MUSIC)	/storage/sdcard0/Music
Environment.getExternalStoragePublicDirectory(DIRECTORY_NOTIFICATIONS)	/storage/sdcard0/Notifications
Environment.getExternalStoragePublicDirectory(DIRECTORY_PICTURES)	/storage/sdcard0/Pictures
Environment.getExternalStoragePublicDirectory(DIRECTORY_PODCASTS)	/storage/sdcard0/Podcasts
Environment.getExternalStoragePublicDirectory(DIRECTORY_RINGTONES)	/storage/sdcard0/Ringtones
Application directories

Method	Result
getCacheDir()	/data/data/package/cache
getFilesDir()	/data/data/package/files
getFilesDir().getParent()	/data/data/package
Application External storage directories

Method	Result
getExternalCacheDir()	/storage/sdcard0/Android/data/package/cache
getExternalFilesDir(null)	/storage/sdcard0/Android/data/package/files
getExternalFilesDir(DIRECTORY_ALARMS)	/storage/sdcard0/Android/data/package/files/Alarms
getExternalFilesDir(DIRECTORY_DCIM)	/storage/sdcard0/Android/data/package/files/DCIM
getExternalFilesDir(DIRECTORY_DOWNLOADS)	/storage/sdcard0/Android/data/package/files/Download
getExternalFilesDir(DIRECTORY_MOVIES)	/storage/sdcard0/Android/data/package/files/Movies
getExternalFilesDir(DIRECTORY_MUSIC)	/storage/sdcard0/Android/data/package/files/Music
getExternalFilesDir(DIRECTORY_NOTIFICATIONS)	/storage/sdcard0/Android/data/package/files/Notifications
getExternalFilesDir(DIRECTORY_PICTURES)	/storage/sdcard0/Android/data/package/files/Pictures
getExternalFilesDir(DIRECTORY_PODCASTS)	/storage/sdcard0/Android/data/package/files/Podcasts
getExternalFilesDir(DIRECTORY_RINGTONES)	/storage/sdcard0/Android/data/package/files/Ringtones