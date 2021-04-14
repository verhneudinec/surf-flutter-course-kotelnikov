package ru.kotelnikov.places

import android.os.Messenger
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("3662c5fb-ce91-47c1-a531-8320b7dbcd2f");
        super.configureFlutterEngine(flutterEngine);
    }
}
