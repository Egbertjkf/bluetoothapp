package com.example.bluetoothapp

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import android.bluetooth.BluetoothAdapter
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import android.content.Intent

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.example.bluetooth/method"

    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //Setup Channels
        setupChannels(this,flutterEngine.dartExecutor.binaryMessenger)
    }

       override fun onDestroy() {
        teardownChannels()
        super.onDestroy()
    }

    private fun setupChannels(context:Context, messenger:BinaryMessenger){

        var bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();

        methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
        methodChannel!!.setMethodCallHandler{
            call,result ->
            if((call.method == "isBluetoothActive") || (call.method == "ativaBluetooth")){
                if ((call.method == "isBluetoothActive")) {
                    result.success(bluetoothAdapter.isEnabled).toString()//(bluetoothAdapter?.isEnabled)                  

                }
                if ((call.method == "ativaBluetooth") && (bluetoothAdapter.isEnabled == false)) {
                        val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                        startActivityForResult(enableBtIntent, 1)
                        //result.success(enableBtIntent).toString();
                }
            }else{
                result.notImplemented().toString()
            }
        }
        
    }

    private fun teardownChannels(){
        methodChannel!!.setMethodCallHandler(null)
        // pressureChannel!!.setStreamHandler(null)
    }



}
