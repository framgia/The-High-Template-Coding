package {{cookiecutter.package_name}}.ui.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import {{cookiecutter.package_name}}.BR

abstract class BaseFragment<ViewBinding : ViewDataBinding, ViewModel : BaseViewModel> :
    Fragment() {

    protected lateinit var viewBinding: ViewBinding

    protected abstract val viewModel: ViewModel

    @get:LayoutRes
    protected abstract val layoutId: Int

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        if (::viewBinding.isInitialized.not()) {
            viewBinding = DataBindingUtil.inflate(inflater, layoutId, container, false)
            viewBinding.apply {
                setVariable(BR.viewModel, viewModel)
                root.isClickable = true
                lifecycleOwner = viewLifecycleOwner
                executePendingBindings()
            }
        }
        return viewBinding.root
    }
}
