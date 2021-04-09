package com.sun.ui.base

import javax.inject.Qualifier

/**
 * Used to name a component when declare, can get component by name declared
 */
@Qualifier
@Retention(AnnotationRetention.RUNTIME)
annotation class BaseSourceApi(val name: String)
