# open_file_manager
  
A flutter plugin to open default file manager app.

## How it works?

### Android
Plugin will shows the available file manager apps in bottom popup and you can select one app to open.
That app will open with `Download` folder that is public folder.

### iOS
Plugin will open `Files` app in iOS. you need to add following code snippet in `Info.plist` to view your app folder inside `On My iPhone`.
Also you need to save at least one file to view your app's folder

```xml
<key>UISupportsDocumentBrowser</key>  
<true/>
```
  
## Usage  
It's a very simple to use. there is only one line of code!!!
 
 ```dart
 import 'package:open_file_manager/open_file_manager.dart'

openFileManager();
 ```
