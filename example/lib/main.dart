import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_manager/open_file_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _androidFolderTypes = [FolderType.recent, FolderType.download];
  var _selectedFolderType = FolderType.download;
  final _subFolderPathCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 32),
            if (Platform.isAndroid) ...[
              const Text(
                'Select Android Folder type',
                style: TextStyle(fontSize: 20),
              ),
              ListView.builder(
                itemCount: _androidFolderTypes.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) => RadioListTile<FolderType>(
                  value: _androidFolderTypes[i],
                  groupValue: _selectedFolderType,
                  title: Text(_androidFolderTypes[i].name),
                  onChanged: (folderType) {
                    if (folderType != null &&
                        folderType != _selectedFolderType) {
                      setState(() => _selectedFolderType = folderType);
                    }
                  },
                ),
              ),
            ],
            if (Platform.isIOS) ...[
              const Text(
                'Write iOS sub-folder path',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _subFolderPathCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Sub folder path (Optional)',
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                openFileManager(
                  androidConfig: AndroidConfig(
                    folderType: _selectedFolderType,
                  ),
                  iosConfig: IosConfig(
                    subFolderPath: _subFolderPathCtrl.text.trim(),
                  ),
                );
              },
              child: const Text('Open File Manager'),
            ),
          ],
        ),
      ),
    );
  }
}
