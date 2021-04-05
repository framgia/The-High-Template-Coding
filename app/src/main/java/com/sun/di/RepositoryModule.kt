package com.sun.di

import com.sun.data.repository.SampleRepository
import com.sun.data.repository.impl.SampleRepositoryImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent

/**
 * Declare repository component
 */
@Module
@InstallIn(SingletonComponent::class)
abstract class RepositoryModule {

    @Binds
    abstract fun provideSampleRepository(sampleRepositoryImpl: SampleRepositoryImpl): SampleRepository
}
