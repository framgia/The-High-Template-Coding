package {{cookiecutter.package_name}}.di

import {{cookiecutter.package_name}}.ui.sample.SampleViewModel
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module

/**
 * Declare viewmodel component
 */
val viewModelModule = module {
    viewModel { SampleViewModel(get()) }

