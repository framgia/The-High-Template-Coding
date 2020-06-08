package {{cookiecutter.package_name}}.di

import {{cookiecutter.package_name}}.data.repository.SampleRepository
import {{cookiecutter.package_name}}.data.repository.impl.SampleRepositoryImpl
import org.koin.dsl.module

val repositoryModule = module {
    single<SampleRepository> { SampleRepositoryImpl(get()) }
}
