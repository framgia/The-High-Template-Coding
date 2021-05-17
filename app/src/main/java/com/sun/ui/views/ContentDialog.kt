package com.sun.ui.views

import android.os.Bundle
import androidx.annotation.LayoutRes
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.viewModels
import com.sun.R
import com.sun.databinding.UiContentDialogBinding
import com.sun.ui.base.BaseDialogFragment
import com.sun.ui.base.BaseViewModel

class ContentDialog<BD: ViewDataBinding>(
    @LayoutRes private val layoutRes: Int
): BaseDialogFragment<UiContentDialogBinding, BaseViewModel>() {
    override val layoutId: Int
        get() = R.layout.ui_content_dialog

    override val viewModel: BaseViewModel by viewModels()

    private var onReady: ((binding: BD) -> Unit)? = null

    private var onDismiss: (() -> Unit)? = null

    /**
     * Create binding layout to inflate to specific view create in ui_content_dialog.xml
     * @sample R.id.frame_content
     */
    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewBinding.apply {
            val contentBinding: BD = DataBindingUtil.inflate(
                layoutInflater,
                layoutRes,
                frameContent,
                true
            )
            onReady?.invoke(contentBinding)
        }
    }

    /**
     * @param onReady: Execute your behaviors after created dialog
     */
    fun show(fm: FragmentManager?, onReady: ((binding: BD) -> Unit)? = null) {
        fm?.apply {
            show(fm, this@ContentDialog.javaClass.name)
        }
        this.onReady = onReady
    }

    /**
     * onDismiss: Execute your behaviors after created dialog
     */
    override fun onDestroy() {
        super.onDestroy()
        onDismiss?.invoke()
    }
}
