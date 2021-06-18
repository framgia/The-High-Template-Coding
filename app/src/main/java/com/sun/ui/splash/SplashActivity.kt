package com.sun.ui.splash

import android.os.Bundle
import androidx.activity.viewModels
import com.sun.R
import com.sun.databinding.ActivitySplashBinding
import com.sun.ui.base.BaseActivity
import androidx.navigation.findNavController
import androidx.navigation.fragment.NavHostFragment
import com.sun.extensions.navigateWithAnim
import com.sun.utils.ConnectionType
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class SplashActivity: BaseActivity<ActivitySplashBinding, SplashViewModel>() {

    override val viewModel: SplashViewModel by viewModels()
    override val layoutId: Int = R.layout.activity_splash

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        networkConnectionUtil.registerNetworkCallListener()
        networkConnectionUtil.connectionResult = { connectionType ->
            when (connectionType) {
                ConnectionType.CONNECTED -> startApplication()
                ConnectionType.DISCONNECTED -> Unit
            }
        }
    }

    private fun startApplication() {
        val navHostFragment = supportFragmentManager.findFragmentById(R.id.nav_host_splash_fragment) as NavHostFragment
        val navController = navHostFragment.navController
        navController.navigateWithAnim(R.id.openSample)
        finish()
    }

    override fun onSupportNavigateUp(): Boolean = findNavController(R.id.nav_host_splash_fragment).navigateUp()
}
