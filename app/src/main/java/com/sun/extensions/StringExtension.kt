package com.sun.extensions

import android.util.Patterns
import java.util.regex.Pattern

/**
 * Return 'true' if email input is correct email format
 * Return 'false' else
 * */
fun String.isEmail() : Boolean {
    return !isNullOrEmpty() && Patterns.EMAIL_ADDRESS.matcher(this).matches()
}

/**
 * Return 'true' if @password is valid your format
 * Return 'false' else
 * */
fun String.isValidPassword() : Boolean {
    // Change your format here
    val regex = "^[!-~¥]*\$"
    val pattern = Pattern.compile(regex)
    return !isNullOrEmpty() && length >= 8 && length <= 45 && pattern.matcher(this).matches()
}
