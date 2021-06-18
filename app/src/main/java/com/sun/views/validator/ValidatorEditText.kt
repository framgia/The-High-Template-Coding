package com.sun.views.validator

import android.content.Context
import android.text.InputType
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.FrameLayout
import com.sun.R
import com.sun.common.Constant
import com.sun.databinding.UiValidatorEditTextBinding
import com.sun.extensions.isEmail
import com.sun.extensions.isValidPassword

class ValidatorEditText @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int
) : FrameLayout(context, attrs, defStyleAttr), ValidatorView {

    private val contentView =
        UiValidatorEditTextBinding.inflate(LayoutInflater.from(context), this, true)

    var validator = Constant.VALUE_DEFAULT_INVALID
    var text: String
        set(value) = contentView.textContent.setText(value)
        get() = contentView.textContent.text.toString().trim()
    var textPassword: ValidatorEditText? = null

    init {
        readAttrs(attrs)
    }

    /**
     * Read attributes declared in attrs.xml file
     * */
    private fun readAttrs(attrs: AttributeSet?) {
        contentView.isVisible = false
        attrs?.let {
            val arr = context.resources.obtainAttributes(attrs, R.styleable.ValidatorEditText)
            validator =
                arr.getInt(R.styleable.ValidatorEditText_validator, Constant.VALUE_DEFAULT_INVALID)
            contentView.textContent.apply {
                inputType = if (validator == Type.EMAIL.value) {
                    EditorInfo.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
                } else {
                    arr.getInt(
                        R.styleable.ValidatorEditText_android_inputType,
                        InputType.TYPE_CLASS_TEXT
                    )
                }
            }
            arr.recycle()
        }
    }

    /**
     * Handle logic validate form
     * */
    override fun validator(): Boolean {
        contentView.isVisible = false
        if (visibility == View.INVISIBLE || visibility == View.GONE) {
            return true
        }
        contentView.textContent.text.toString().apply {
            if (validator != Constant.VALUE_DEFAULT_INVALID && (isNullOrEmpty() || isNullOrBlank())) {
                contentView.textError.text = "Error empty!"
                contentView.isVisible = true
                return false
            }
        }
        text.apply {
            val isCorrect: Boolean // Check your condition
            return when (validator) {
                Type.EMAIL.value -> {
                    isCorrect = isEmail() // Change your condition here
                    if (isCorrect.not()) {
                        contentView.textError.text = "Error: Email wrong!" // Your message error
                        contentView.isVisible = true
                    }
                    isCorrect
                }
                Type.PASSWORD.value -> {
                    isCorrect = isValidPassword()
                    if (isCorrect.not()) {
                        contentView.textError.text = "Error: Password invalid!"
                        contentView.isVisible = true
                    }
                    isCorrect
                }
                Type.CONFIRM_PASSWORD.value -> {
                    val textPassword = textPassword?.text
                    isCorrect = isValidPassword()
                    if (isCorrect.not()) {
                        contentView.textError.text = "Error: Password invalid!"
                        contentView.isVisible = true
                    }
                    if (text != textPassword) {
                        contentView.textError.text = "Error: Not same password!"
                        contentView.isVisible = true
                    }
                    isCorrect && text == textPassword
                }
                else -> true
            }
        }
    }

    enum class Type(val value: Int) {
        EMPTY(0), EMAIL(1), PASSWORD(2), CONFIRM_PASSWORD(3)
    }
}
