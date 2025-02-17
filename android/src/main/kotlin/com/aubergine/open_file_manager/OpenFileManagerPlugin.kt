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
                openFileManager(
                    result,
                    args?.get("folderType") as String?,
                    args?.get("folderPath") as String?,
                )
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun openFileManager(result: Result, folderType: String?, folderPath: String?) {
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
            } else if (folderType == "other") {
                val path = getPath(folderPath)
                val encodedPath = Uri.encode(path)
                val uri: Uri =
                    Uri.parse("content://com.android.externalstorage.documents/document/$encodedPath")
                val intent = Intent(Intent.ACTION_OPEN_DOCUMENT)
                intent.setDataAndType(uri, "*/*")
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                intent.putExtra("android.provider.extra.INITIAL_URI", uri)
                context.startActivity(intent)
                result.success(true)
            }
        } catch (e: Exception) {
            result.error("$e", "Unable to open the file manager", "")
        }
    }

    private fun getPath(folderPath: String?): String {
        if (folderPath == null || folderPath.isEmpty()) {
            return "primary:recent"
        }

        val primaryPrefix = Environment.getExternalStorageDirectory().absolutePath
        val regex = Regex("^/storage/([A-Za-z0-9-]+)/?(.*)")

        return when {
            folderPath.startsWith(primaryPrefix) -> {
                "primary:${folderPath.removePrefix(primaryPrefix)}"
            }

            regex.matches(folderPath) -> {
                val matchResult = regex.find(folderPath)
                matchResult?.let {
                    val storageId = it.groups[1]?.value
                    val remainingPath = it.groups[2]?.value
                    "$storageId:${remainingPath}"
                } ?: "primary:$folderPath"
            }

            else -> {
                "primary:$folderPath"
            }
        }
    }
}
