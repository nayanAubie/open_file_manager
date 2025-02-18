package com.aubergine.open_file_manager

import android.app.DownloadManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Environment
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Handler for the plugin. manages the method calls from Flutter.
 */
class MethodHandler : MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    /**
     * Initializes the method channel & sets the handler.
     *
     * @param messenger the binary messenger from Engine.
     * @param context the application context.
     */
    fun initialize(messenger: BinaryMessenger, context: Context) {
        channel = MethodChannel(messenger, "open_file_manager")
        channel.setMethodCallHandler(this)
        this.context = context
    }

    /**
     * Removes the method call handler.
     */
    fun dispose() {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "openFileManager" -> {
                val folderType = call.argument<String>("folderType")!!
                val folderPath = call.argument<String?>("folderPath")

                openFileManager(result, folderType, folderPath)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    /**
     * Opens the file manager app using Intent.
     *
     * @param result the method channel result.
     * @param folderType the type of folder to open.
     * @param folderPath the path of the folder. Used for "Other" folder types.
     */
    private fun openFileManager(
        result: MethodChannel.Result, folderType: String, folderPath: String?
    ) {
        try {
            when (folderType) {
                "recent" -> {
                    val uri = Environment.getExternalStorageDirectory().absolutePath
                    val intent = Intent(Intent.ACTION_OPEN_DOCUMENT)
                    intent.setDataAndType(Uri.parse(uri), "*/*")
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    context.startActivity(intent)
                    result.success(true)
                }

                "download" -> {
                    val downloadIntent = Intent(DownloadManager.ACTION_VIEW_DOWNLOADS)
                    downloadIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    context.startActivity(downloadIntent)
                    result.success(true)
                }

                "other" -> {
                    val encodedPath = Uri.encode(getDocumentProviderPath(folderPath!!))
                    val uri: Uri =
                        Uri.parse("content://com.android.externalstorage.documents/document/$encodedPath")
                    val intent = Intent(Intent.ACTION_OPEN_DOCUMENT)
                    intent.setDataAndType(uri, "*/*")
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    intent.putExtra("android.provider.extra.INITIAL_URI", uri)
                    context.startActivity(intent)
                    result.success(true)
                }
            }
        } catch (e: Exception) {
            result.error(
                e.javaClass.simpleName, e.localizedMessage, "Unable to open file manager: $e"
            )
        }
    }

    /**
     * Generates the document provider path for the given folder path.
     * Used for "Other" folder types.
     *
     * @param folderPath the path of the folder.
     */
    private fun getDocumentProviderPath(folderPath: String): String {
        if (folderPath.isEmpty()) {
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