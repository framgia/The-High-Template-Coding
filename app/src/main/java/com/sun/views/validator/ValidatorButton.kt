package com.sun.views.validator

import android.content.Context
import android.util.AttributeSet
import androidx.appcompat.widget.AppCompatButton
import kotlin.reflect.KFunction0

class ValidatorButton @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int
) : AppCompatButton(context, attrs, defStyleAttr) {

    var validator: KFunction0<Boolean>? = null

    override fun setOnClickListener(l: OnClickListener?) {
        super.setOnClickListener {
            val valid = validator?.invoke()
            if (validator == null || valid == true) {
                l?.onClick(it)
            }
        }
    }
}
