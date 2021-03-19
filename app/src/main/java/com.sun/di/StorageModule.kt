package com.sun.di

import com.sun.data.local.prefs.AppPrefs
import com.sun.data.local.prefs.PrefsHelper
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent

/**
 * Declare storage component
 */
@Module
@InstallIn(SingletonComponent::class)
abstract class StorageModule {

    @Binds
    abstract fun providePrefsHelper(appPrefs: AppPrefs): PrefsHelper
}
