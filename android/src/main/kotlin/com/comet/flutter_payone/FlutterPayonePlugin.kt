package com.comet.flutter_payone

import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull;
import com.google.gson.JsonObject
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import payone.POManager
import payone.callback.POMCallback

/** FlutterPayonePlugin */
public class FlutterPayonePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_payone")
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_payone")
      channel.setMethodCallHandler(FlutterPayonePlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "initStore" -> {
        Log.d("TAG", "status: ")
        var storeData = call.arguments as HashMap<String, String>

        result.success(initStore(storeData))
        // POManager.share()!!.initStore(call.arguments)
      }
      "buildqrcode"->{
        var qrData = call.arguments as HashMap<String, String>

        result.success(buildQrcode(qrData))
      }
      "observe"->{
        POManager.share()!!.Start( object : POMCallback() {
          override fun status(poStatus: String?) {
            Log.d("TAG", "status: "+poStatus)
          }

          override fun message(poMessageResult: JsonObject?) {
            val backgroundThread = object: Thread("background") {
              override fun run() {
                Handler(Looper.getMainLooper()).post {
                  result.success(poMessageResult.toString())
                };
              }
            }
            backgroundThread.start()

          }
        })
      }
    }

//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }

  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  private fun initStore(storeData: HashMap<String, String>): String {
    try {
      POManager.share()!!.initStore(storeData["mcid"]!!, storeData["country"]!!, storeData["province"]!!, storeData["subscribeKey"]!!, storeData["terminalid"]!!,storeData["iin"]!!,storeData["applicationid"]!!)
      return "initialized store";
    } catch (e: Exception) {
      return e.toString();
    }
  }
  private fun buildQrcode(qrData: HashMap<String, String>):String{
    try {
      return POManager.share()!!.buildQrcode(qrData["amount"]!!,qrData["currency"]!!,qrData["invoiceid"]!!,qrData["description"]!!) ;
    } catch (e: Exception) {
      return "Store is not init yet"
    }
  }
}
