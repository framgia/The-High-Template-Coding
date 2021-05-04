package com.sun.utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.Network
import android.os.Build
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Class check connection for application
 */

enum class ConnectionType {
    CONNECTED, DISCONNECTED
}

@Singleton
class NetworkConnectionUtil @Inject constructor(@ApplicationContext private val context: Context) {

    var connectionResult: ((type: ConnectionType) -> Unit)? = null

    private var _isConnected = false
    val isConnected: Boolean
        get() = _isConnected

    private val networkCallBack: ConnectivityManager.NetworkCallback by lazy {
        object : ConnectivityManager.NetworkCallback() {
            override fun onLost(network: Network) {
                super.onLost(network)
                _isConnected = false
                connectionResult?.invoke(ConnectionType.DISCONNECTED)
            }

            override fun onAvailable(network: Network) {
                super.onAvailable(network)
                _isConnected = true
                connectionResult?.invoke(ConnectionType.CONNECTED)
            }
        }
    }

    /**
     * Register for the first activity when launching the app (in onCreate method)
     * Example: SplashActivity
     */
    fun registerNetworkCallListener() {
        //Android 9 and above
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            val connectivityManager =
                context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            if (connectivityManager.activeNetwork == null) {
                _isConnected = false
                connectionResult?.invoke(ConnectionType.DISCONNECTED)
            }
            connectivityManager.registerDefaultNetworkCallback(networkCallBack)
            return
        }
        //Android 8 and below
        val intentFilter = IntentFilter()
        intentFilter.addAction("android.net.conn.CONNECTIVITY_CHANGE")
        context.registerReceiver(networkChangeReceiver, intentFilter)
    }

    /**
     * Unregister from the last activity (in onDestroy method)
     * Example: SampleActivity
     */
    fun unregisterNetworkCallListener() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            connectivityManager.unregisterNetworkCallback(networkCallBack)
            return
        }
        context.unregisterReceiver(networkChangeReceiver)
    }

    @Suppress("DEPRECATION")
    private val networkChangeReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            val connectivityManager =
                context?.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetworkInfo = connectivityManager.activeNetworkInfo
            if (activeNetworkInfo == null) {
                _isConnected = false
                connectionResult?.invoke(ConnectionType.DISCONNECTED)
                return
            }
            if (activeNetworkInfo.type == ConnectivityManager.TYPE_WIFI
                || activeNetworkInfo.type == ConnectivityManager.TYPE_MOBILE) {
                _isConnected = true
                connectionResult?.invoke(ConnectionType.CONNECTED)
            }
        }
    }
}
