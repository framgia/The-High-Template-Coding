package com.sun.extensions

import com.sun.R
import android.os.Bundle
import androidx.annotation.IdRes
import androidx.navigation.NavController
import androidx.navigation.NavDirections
import androidx.navigation.NavOptions

/**
 * Set animations for navigate action when user navigate between destinations
 * @param directions: indicated the action determined by <action></action> in root nav graph
 * */
fun NavController.navigateWithAnim(directions: NavDirections) {
    val option = NavOptions.Builder()
        .setEnterAnim(R.anim.slide_in_right)
        .setExitAnim(R.anim.slide_out_left)
        .setPopEnterAnim(R.anim.slide_in_left)
        .setPopExitAnim(R.anim.slide_out_right)
        .build()
    navigate(directions, option)
}

/**
 * Set animations for navigate action when user navigate between destinations
 * @param resId: indicated the id of destinations determined by <fragment></fragment> in root nav graph
 * @param bundle: contain data need passing to @{resId} destinations
 * */
fun NavController.navigateWithAnim(@IdRes resId: Int, bundle: Bundle? = null) {
    val option = NavOptions.Builder()
        .setEnterAnim(R.anim.slide_in_right)
        .setExitAnim(R.anim.slide_out_left)
        .setPopEnterAnim(R.anim.slide_in_left)
        .setPopExitAnim(R.anim.slide_out_right)
        .build()
    navigate(resId, bundle, option)
}
