package com.sun.ui.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import com.sun.utils.ConnectionType
import com.sun.utils.NetworkConnectionUtil
import javax.inject.Inject

/**
 * Base Fragment
 */
abstract class BaseFragment<ViewBinding : ViewDataBinding, ViewModel : BaseViewModel> :
    Fragment() {

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
        if (::networkConnectionUtil.isInitialized) {
            networkConnectionUtil.connectionResult = { connectionType ->
                when (connectionType) {
                    ConnectionType.CONNECTED -> haveInternetConnectionBack()
                    ConnectionType.DISCONNECTED -> lostInternetConnection()
                }
            }
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        if (::viewBinding.isInitialized.not()) {
            viewBinding = DataBindingUtil.inflate(inflater, layoutId, container, false)
            viewBinding.apply {
                root.isClickable = true
                lifecycleOwner = viewLifecycleOwner
                executePendingBindings()
            }
        }
        return viewBinding.root
    }

    //Do something if internet connection is back
    open fun haveInternetConnectionBack() {
    }

    //Do something if internet connection is lost
    open fun lostInternetConnection() {
    }
}
