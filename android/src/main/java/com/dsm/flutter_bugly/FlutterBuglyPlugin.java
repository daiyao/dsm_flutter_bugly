package com.dsm.flutter_bugly;

import android.content.Context;

import androidx.annotation.NonNull;

import com.tencent.bugly.crashreport.CrashReport;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterBuglyPlugin
 */
public class FlutterBuglyPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context _context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        _context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_bugly");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "initBugly":
                String key = (String) call.arguments;
                initBugly(key);
                result.success("");
                break;
            case "bugReport":
                String content = (String) call.arguments;
                bugReport(content);
                result.success("");
                break;
            case "putUserData":
                HashMap<String, String> userData = (HashMap) call.arguments;
                putUserData(userData);
                break;
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * 初始化Bugly
     */
    private void initBugly(String key) {
        CrashReport.initCrashReport(_context, key, true);
    }

    private void bugReport(String content) {
        Throwable throwable = new Throwable(content);
        CrashReport.postCatchedException(throwable);
    }

    private void putUserData(HashMap<String, String> userData) {
        for (String itemKey : userData.keySet()) {
            CrashReport.putUserData(_context, itemKey, userData.get(itemKey));
            System.out.println("反馈用户自己的数据");
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        _context = null;
    }
}
