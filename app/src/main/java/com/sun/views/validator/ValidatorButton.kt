package com.sun.views.validator

import android.content.Context
import android.util.AttributeSet
import androidx.appcompat.widget.AppCompatButton
import kotlin.reflect.KFunction0

class ValidatorButton: AppCompatButton {

    var validator: KFunction0<Boolean>? = null

    constructor(context: Context): super(context)

    constructor(context: Context, attrs: AttributeSet?): super(context, attrs)

    constructor(
        context: Context,
        attrs: AttributeSet?,
        defStyleAttr: Int
    ): super(context, attrs, defStyleAttr)

    override fun setOnClickListener(l: OnClickListener?) {
        super.setOnClickListener {
            val valid = validator?.invoke()
            if (validator == null || valid == true) {
                l?.onClick(it)
            }
        }
    }
}
