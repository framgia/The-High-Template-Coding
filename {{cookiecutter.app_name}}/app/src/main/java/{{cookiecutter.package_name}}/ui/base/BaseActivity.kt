package {{cookiecutter.package_name}}.ui.base

import android.os.Bundle
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding

abstract class BaseActivity<ViewBinding : ViewDataBinding, ViewModel : BaseViewModel> :
    AppCompatActivity() {
    protected lateinit var viewBinding: ViewBinding

    protected abstract val viewModel: ViewModel

    protected abstract val bindingVariable: Int

    @get:LayoutRes
    protected abstract val layoutId: Int

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (::viewBinding.isInitialized.not()) {
            viewBinding = DataBindingUtil.setContentView(this, layoutId)
            viewBinding.setVariable(bindingVariable, viewModel)
        }
    }
}
