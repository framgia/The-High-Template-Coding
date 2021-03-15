package com.sun.di

import com.sun.data.local.prefs.AppPrefs
import com.sun.data.local.prefs.PrefsHelper
import com.google.gson.Gson
import org.koin.dsl.module

/**
 * Declare storage component
 * @param get() is a component given
 */
val storageModule = module {
    single { Gson() }
    single<PrefsHelper> { AppPrefs(get(), get()) }
}
