package com.aubergine.open_file_manager

import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * This is the main entry point for the Flutter plugin.
 */
class OpenFileManagerPlugin : FlutterPlugin {
    private lateinit var methodHandler: MethodHandler

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodHandler = MethodHandler()
        methodHandler.initialize(binding.binaryMessenger, binding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodHandler.dispose()
    }
}
