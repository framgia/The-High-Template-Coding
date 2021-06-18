package com.sun.views.validator

import android.content.Context
import android.os.Handler
import android.util.AttributeSet
import android.view.ViewGroup
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.view.children

class ValidatorLayout @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int
) : ConstraintLayout(context, attrs, defStyleAttr) {

    private val validatorView = mutableListOf<ValidatorView>()

    init {
        Handler().postDelayed(
            { getValidator(this) },
            1000
        )
    }

    private fun getValidator(container: ViewGroup) {
        var password: ValidatorEditText? = null
        container.children.forEach {
            when (it) {
                is ValidatorView -> {
                    if (it is ValidatorEditText) {
                        if (it.validator == ValidatorEditText.Type.PASSWORD.value) password = it
                        if (it.validator == ValidatorEditText.Type.CONFIRM_PASSWORD.value) {
                            it.textPassword = password
                        }
                    }
                    validatorView.add(it)
                }
                is ValidatorButton -> {
                    it.validator = ::validate
                }
                is ViewGroup -> getValidator(it)
            }
        }
    }

    private fun validate(): Boolean {
        var isValid = true
        validatorView.forEach {
            if (!it.validator()) {
                isValid = false
                return@forEach
            }
        }
        return isValid
    }
}
