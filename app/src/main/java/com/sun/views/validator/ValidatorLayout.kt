package com.sun.views.validator

import android.content.Context
import android.os.Handler
import android.util.AttributeSet
import android.view.ViewGroup
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.view.children

class ValidatorLayout: ConstraintLayout {

    private val validatorView = mutableListOf<ValidatorView>()
    constructor(context: Context): super(context)
    constructor(context: Context, attrs: AttributeSet?): super(context, attrs)
    constructor(
        context: Context,
        attrs: AttributeSet?,
        defStyleAttr: Int
    ): super(context, attrs, defStyleAttr)

    init {
        Handler().postDelayed(
            { getValidator(this) },
            1000
        )
    }

    private fun getValidator(container: ViewGroup) {
        container.children.forEach {
            when (it) {
                is ValidatorView -> {
                    validatorView.add(it)
                }
                is ValidatorButton -> {
                    it.validator = ::validate
                }
                is ViewGroup -> {
                    getValidator(it)
                }
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