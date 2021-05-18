package com.sun.ui.base

import android.content.Intent
import android.os.Bundle
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import com.sun.utils.NetworkConnectionUtil
import javax.inject.Inject
import androidx.navigation.NavController
import com.sun.utils.Constance

/**
 * Base Activity
 */
abstract class BaseActivity<ViewBinding : ViewDataBinding, ViewModel : BaseViewModel> :
    AppCompatActivity() {

    @Inject
    lateinit var networkConnectionUtil: NetworkConnectionUtil

    //Binding view
    protected lateinit var viewBinding: ViewBinding

    //ViewModel using in screen
    protected abstract val viewModel: ViewModel

    //LayoutId of screen, example R.layout.screen
    @get:LayoutRes
    protected abstract val layoutId: Int

    // NavController of NavGraph in Activity
    protected var navController: NavController? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (::viewBinding.isInitialized.not()) {
            viewBinding = DataBindingUtil.setContentView(this, layoutId)
        }
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        intent?.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        navController?.handleDeepLink(intent)
        handleNavigateScreen(intent)
    }

    protected fun handleNavigateScreen(intent: Intent?) {
        intent?.let {
            if (it.hasExtra(Constance.EXTRA_EXAMPLE)) {
                // if intent has explicit extra
                // do something
            } else {
                // if intent hasn't explicit extra
                // do something
            }
        }
    }
}
