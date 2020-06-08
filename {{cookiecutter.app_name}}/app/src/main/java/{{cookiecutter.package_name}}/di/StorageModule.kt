package {{cookiecutter.package_name}}.di

import {{cookiecutter.package_name}}.data.local.prefs.AppPrefs
import {{cookiecutter.package_name}}.data.local.prefs.PrefsHelper
import com.google.gson.Gson
import org.koin.dsl.module

val storageModule = module {
    single { Gson() }
    single<PrefsHelper> { AppPrefs(get(), get()) }
}
