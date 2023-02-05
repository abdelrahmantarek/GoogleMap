// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package map.app.low_calories_google_map

import android.app.Activity
import android.app.Application
import android.os.Bundle
import android.util.Log
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LifecycleRegistry
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry.Registrar

/**
 * Plugin for controlling a set of GoogleMap views to be shown as overlays on top of the Flutter
 * view. The overlay should be hidden during transformations or while Flutter is rendering on top of
 * the map. A Texture drawn using GoogleMap bitmap snapshots can then be shown instead of the
 * overlay.
 */
class LowCaloriesGoogleMapPlugin : FlutterPlugin, ActivityAware {
    private var lifecycle: Lifecycle? = null

    // FlutterPlugin
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        binding
            .platformViewRegistry
            .registerViewFactory(
                VIEW_TYPE,
                GoogleMapFactory(
                    binding.binaryMessenger,
                    binding.applicationContext,
                    object : LifecycleProvider {
                        override fun getLifecycle(): Lifecycle? {
                            return lifecycle
                        }
                    })
            )
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}

    // ActivityAware
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding)
        Log.d("onAttachedToActivity", lifecycle.toString())
    }

    override fun onDetachedFromActivity() {
        lifecycle = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    /**
     * This class provides a [LifecycleOwner] for the activity driven by [ ].
     *
     *
     * This is used in the case where a direct Lifecycle/Owner is not available.
     */


    companion object {
        private const val VIEW_TYPE = "plugins.flutter.io/google_maps"
        fun registerWith(
            registrar: Registrar
        ) {
            val activity = registrar.activity()
                ?: // When a background flutter view tries to register the plugin, the registrar has no activity.
                // We stop the registration process as this plugin is foreground only.
                return
            if (activity is LifecycleOwner) {
                registrar
                    .platformViewRegistry()
                    .registerViewFactory(
                        VIEW_TYPE,
                        GoogleMapFactory(
                            registrar.messenger(),
                            registrar.context()
                        ) { (activity as LifecycleOwner).lifecycle })
            } else {
                registrar
                    .platformViewRegistry()
                    .registerViewFactory(
                        VIEW_TYPE,
                        GoogleMapFactory(
                            registrar.messenger(),
                            registrar.context(),
                            ProxyLifecycleProvider(activity)
                        )
                    )
            }
        }
    }

    private class ProxyLifecycleProvider(activity: Activity) :
        Application.ActivityLifecycleCallbacks, LifecycleOwner, LifecycleProvider {
        private val lifecycle = LifecycleRegistry(this)
        private val registrarActivityHashCode: Int

        override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_CREATE)
        }

        override fun onActivityStarted(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_START)
        }

        override fun onActivityResumed(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_RESUME)
        }

        override fun onActivityPaused(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_PAUSE)
        }

        override fun onActivityStopped(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_STOP)
        }

        override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {}
        override fun onActivityDestroyed(activity: Activity) {
            if (activity.hashCode() != registrarActivityHashCode) {
                return
            }
            activity.application.unregisterActivityLifecycleCallbacks(this)
            lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_DESTROY)
        }

        override fun getLifecycle(): Lifecycle {
            return lifecycle
        }

        init {
            registrarActivityHashCode = activity.hashCode()
            activity.application.registerActivityLifecycleCallbacks(this)
        }
    }


}