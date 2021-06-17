package com.sun.extensions

import android.animation.AnimatorInflater
import android.animation.AnimatorSet
import android.animation.ObjectAnimator
import android.content.res.Resources
import android.view.View
import android.view.animation.Animation
import android.view.animation.AnimationUtils
import androidx.annotation.AnimRes
import androidx.annotation.AnimatorRes

fun View.startObjectAnimator(
    @AnimatorRes objectAnimatorId: Int,
    duration: Long? = null
): ObjectAnimator? {
    val animator = try {
        AnimatorInflater.loadAnimator(context, objectAnimatorId)
    } catch (e: Resources.NotFoundException) {
        null
    }
    return (animator as? ObjectAnimator)?.apply {
        duration?.let(::setDuration)
        target = this@startObjectAnimator
        start()
    }
}

fun View.startAnimatorSet(@AnimatorRes animatorSetId: Int, duration: Long? = null): AnimatorSet? {
    val animator = try {
        AnimatorInflater.loadAnimator(context, animatorSetId)
    } catch (e: Resources.NotFoundException) {
        null
    }
    return (animator as? AnimatorSet)?.apply {
        duration?.let(::setDuration)
        setTarget(this)
        start()
    }
}

fun View.setAnimationResource(
    @AnimRes resId: Int,
    duration: Long? = null,
    onEnd: () -> Unit = {}
) {
    try {
        val animation = AnimationUtils.loadAnimation(context, resId).apply {
            duration?.let(::setDuration)
            setAnimationListener(object : Animation.AnimationListener {
                override fun onAnimationStart(animation: Animation?) {
                }

                override fun onAnimationEnd(animation: Animation?) {
                    onEnd()
                }

                override fun onAnimationRepeat(animation: Animation?) {
                }
            })
        }
        startAnimation(animation)
    } catch (e: Resources.NotFoundException) {
        e.printStackTrace()
    }
}
