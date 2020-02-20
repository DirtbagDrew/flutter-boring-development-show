package dev.andrewmyer.barometer;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

import static android.content.Context.SENSOR_SERVICE;

/** BarometerPlugin */
public class BarometerPlugin implements MethodCallHandler, SensorEventListener {
  private SensorManager mSensorManager;
  private Sensor mBarometer;
  private Registrar mRegistrar;
  private float mLatestReading = 0;

  double getBarometer(){

    return 79.0;
  }

  BarometerPlugin(Registrar registrar){
    mRegistrar=registrar;
  }
  
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "barometer");
    channel.setMethodCallHandler(new BarometerPlugin(registrar));
    
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    return;
    }  if(call.method.equals("getBarometer")) {
      double reading =getBarometer();
      result.success(reading);
      return;    
    } if(call.method.equals("intitializeBarometer")){
      result.success(initializeBarometer());
      return;
    }
    result.notImplemented();
  }

  @Override
  public void onAccuracyChanged(Sensor sensor, int accuracy){

  }

  @Override
  public void onSensorChange(SensorEvent event){
    mLatestReading++;
  }
}
