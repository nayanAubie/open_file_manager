A flutter plugin to open the default file manager app.

## Support
|             | Android     | iOS     |
|-------------|-------------|---------|
| **Support** | SDK 20+ *   | iOS 12+ |

- The `Other` folder feature requires SDK 26 and above on Android.

## How it works?

### Android
The `Android` app can open either `Recent` folder, `Download` folder, or `Other` folder.
The plugin will show the available file manager apps in the bottom popup and you can select one app to open.
That app will open with the given folder in selected app.

### iOS
The `iOS` app can open app's document folder and it's sub directory if provided.
Plugin will open the `Files` app in iOS. You need to add the following code snippet in `Info.plist` to view your app's document folder inside `On My iPhone`.
Also, you need to save at least one file to view your app's folder.

```xml
<key>UISupportsDocumentBrowser</key>  
<true/>
```

## Usage

It's a very simple to use. Just call the below method and add `config` if required.
 
 ```dart
 import 'package:open_file_manager/open_file_manager.dart'

openFileManager(
    androidConfig: AndroidConfig(
        folderType: FolderType.recent,
    ),
    iosConfig: IosConfig(
        // Path is case-sensitive here.
        subFolderPath: 'Pictures/Screenshots',
    ),
);
 ```

 - If `androidConfig` doesn't provided, Android app will open `Download` folder by default.
 - If `iosConfig` doesn't provided, iOS app will open app's document folder by default.

### Open `Other` folder on Android

To open `Other` folder on Android, you can use the following code snippet:

```dart
import 'package:open_file_manager/open_file_manager.dart';

openFileManager(
    androidConfig: AndroidConfig(
        folderType: FolderType.other,
        folderPath: 'Pictures/Screenshots',
    ),
);
```

The `folderPath` supports the following path formats:

- `Pictures/Screenshots`
- `/storage/emulated/0/Pictures/Screenshots`
- `/storage/243F-4E12/Pictures/Screenshots`

If `folderPath` is not provided or does not exist, the `Recent` folder will be opened.

## Preview

https://github.com/nayanAubie/open_file_manager/assets/109264909/57ecd7be-a526-45d8-a138-7ca7dcd255ca

https://github.com/nayanAubie/open_file_manager/assets/109264909/862bf858-49f1-4c4d-8c8e-22cbafb1d33c
