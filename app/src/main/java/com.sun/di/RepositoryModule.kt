package com.sun.di

import com.sun.data.repository.SampleRepository
import com.sun.data.repository.impl.SampleRepositoryImpl
import org.koin.dsl.module

/**
 * Declare repository component
 * @param get() is a component given
 */
val repositoryModule = module {
    single<SampleRepository> { SampleRepositoryImpl(get()) }
}
