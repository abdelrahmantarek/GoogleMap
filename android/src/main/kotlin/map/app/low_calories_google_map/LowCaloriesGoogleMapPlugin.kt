package map.app.low_calories_google_map

import android.content.Context
import android.widget.Toast
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

/** LowCaloriesGoogleMapPlugin */
class LowCaloriesGoogleMapPlugin: FlutterPlugin, MethodCallHandler ,ActivityAware{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  lateinit var helper : Helper




  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "low_calories_google_map")
      channel.setMethodCallHandler(LowCaloriesGoogleMapPlugin())
      // clearing temporary files from previous session
//      with(registrar.context().cacheDir) {
//        list { _, name -> name.matches("sound(.*)pool".toRegex())
//        }.forEach { File(this, it).delete() } }
    }
  }



  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "low_calories_google_map")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      "getLocation" -> helper.getLocation(result)
      "gpsStatusAndroid" -> result.success(helper.gpsIsOk());
      "locationStatusAndroid" -> result.success(helper.locationGranted());
      "requestOpenGpsAndroid" -> helper.requestOpenGps(result);
      "requestLocationPermissionAndroid" -> helper.requestLocationPermission(result);
      else -> {
        result.notImplemented()
      }
    }
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    helper = Helper(binding.activity,binding)
    Toast.makeText(binding.activity, "onAttachedToActivity", Toast.LENGTH_LONG).show()
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

}
