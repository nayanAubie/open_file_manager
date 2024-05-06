package com.aubergine.open_file_manager

import android.app.DownloadManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Environment
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OpenFileManagerPlugin */
class OpenFileManagerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "open_file_manager")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "openFileManager" -> {
                val args = call.arguments as HashMap<*, *>?
                openFileManager(result, args?.get("folderType") as String?)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun openFileManager(result: Result, folderType: String?) {
        try {
            if (folderType == null || folderType == "download") {
                val downloadIntent = Intent(DownloadManager.ACTION_VIEW_DOWNLOADS)
                downloadIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context.startActivity(downloadIntent)
                result.success(true)
            } else if (folderType == "recent") {
                val uri = Environment.getExternalStorageDirectory().absolutePath
                val intent = Intent(Intent.ACTION_OPEN_DOCUMENT)
                intent.setDataAndType(Uri.parse(uri), "*/*")
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context.startActivity(intent)
                result.success(true)
            }
        } catch (e: Exception) {
            result.error("$e", "Unable to open the file manager", "")
        }
    }
}
