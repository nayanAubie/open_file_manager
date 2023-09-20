A flutter plugin to open the default file manager app.

## Support
|             | Android | iOS     |
|-------------|---------|---------|
| **Support** | SDK 20+ | iOS 12+ |

## How it works?

### Android
The plugin will show the available file manager apps in the bottom popup and you can select one app to open.
That app will open with the `Download` folder which is a public folder.

### iOS
Plugin will open the `Files` app in iOS. You need to add the following code snippet in `Info.plist` to view your app folder inside `On My iPhone`.
Also, you need to save at least one file to view your app's folder

```xml
<key>UISupportsDocumentBrowser</key>  
<true/>
```
  
## Usage

It's a very simple to use. There is only one line of code!!!
 
 ```dart
 import 'package:open_file_manager/open_file_manager.dart'

openFileManager();
 ```


## Preview

![Open file manager - Android](https://github.com/nayanAubie/open_file_manager/assets/109264909/06d453c4-2ab1-4aa3-99aa-b8ef3db33843)

![Open file manager - iOS](https://github.com/nayanAubie/open_file_manager/assets/109264909/9dd7f9d6-ae6d-4638-8c3e-7ba3bd9badf7)





