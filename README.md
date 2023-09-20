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

https://github.com/nayanAubie/open_file_manager/assets/109264909/8d4997c7-1dd7-4716-952c-fdcb2ed8b767

https://github.com/nayanAubie/open_file_manager/assets/109264909/f5cc61e2-3f7c-4415-b802-e0229ed0974e


