package com.sun.ui.base

import android.os.Bundle
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import com.sun.utils.NetworkConnectionUtil
import javax.inject.Inject

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

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (::viewBinding.isInitialized.not()) {
            viewBinding = DataBindingUtil.setContentView(this, layoutId)
        }
    }
}
