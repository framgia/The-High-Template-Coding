package {{cookiecutter.package_name}}.di

import {{cookiecutter.package_name}}.data.repository.SampleRepository
import {{cookiecutter.package_name}}.data.repository.impl.SampleRepositoryImpl
import org.koin.dsl.module

/**
 * Declare repository component
 * @param get() is a component given
 */
val repositoryModule = module {
    single<SampleRepository> { SampleRepositoryImpl(get()) }
}
