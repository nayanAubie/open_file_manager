# Open File Manager

A Flutter plugin to open the default **File Manager** 📁 app.

## Platform Support

| Android     | iOS     |
|-------------|---------|
| SDK 21+     | iOS 12+ |

> Use of `AndroidFolderType.other` requires minimum `SDK 26` in Android.

## Features 🚀

- Android:
  - Ability to open `Recent`, `Downloads`, and `Other` folders.
  - For the `Other` folder, you need to specify the **folder path**.

- iOS:
  - Ability to open the app’s **Documents folder** and its **subdirectories**.

---

Please follow the `iOS` platform configuration ⬇️ before jump to the Dart code.

## iOS Configuration

The iOS app can open the app’s Documents folder and its subdirectories if specified.

The plugin will open the `Files` app on iOS. To display your app’s Documents folder under `On My iPhone`, add the following code snippet to your `Info.plist`:

```xml
<key>UISupportsDocumentBrowser</key>  
<true/>
```

> Additionally, you must save at least one file to your app’s Documents folder for it to appear in the Files app.

## Code Implementation 👨‍💻

It's a super simple to implement. Just call the `openFileManager` method and add `androidConfig` for Android and `iosConfig` for iOS.
 
 ```dart
 import 'package:open_file_manager/open_file_manager.dart';

openFileManager(
    androidConfig: AndroidConfig(
        folderType: AndroidFolderType.recent,
    ),
    iosConfig: IosConfig(
        // Path is case-sensitive here.
        folderPath: 'Reports/Sheets',
    ),
);
 ```

 ### Default method without `config`:

 ```dart
 import 'package:open_file_manager/open_file_manager.dart';

 openFileManager();
 ```

If `androidConfig` is not provided, the Android app will open the `Downloads` folder by default.

If `iosConfig` is not provided, the iOS app will open the app's Documents folder by default.

### Open `Other` folder on Android:

To open a specific folder on Android, you need to set `folderType` as `AndroidFolderType.other` and provide the `folderPath` in `AndroidConfig`:

```dart
import 'package:open_file_manager/open_file_manager.dart';

openFileManager(
    androidConfig: AndroidConfig(
        folderType: AndroidFolderType.other,
        folderPath: 'Pictures/Screenshots',
    ),
);
```

The `folderPath` supports the following path formats:

- `Pictures/Screenshots`
- `/storage/emulated/0/Pictures/Screenshots`
- `/storage/243F-4E12/Pictures/Screenshots`

If `folderPath` does not exist, the `Recent` folder will be opened.

## Preview

https://github.com/nayanAubie/open_file_manager/assets/109264909/57ecd7be-a526-45d8-a138-7ca7dcd255ca

https://github.com/nayanAubie/open_file_manager/assets/109264909/862bf858-49f1-4c4d-8c8e-22cbafb1d33c
