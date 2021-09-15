package map.app.low_calories_google_map_example


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import map.app.low_calories_google_map.LowCaloriesGoogleMapPlugin



class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(LowCaloriesGoogleMapPlugin())
    }
}
