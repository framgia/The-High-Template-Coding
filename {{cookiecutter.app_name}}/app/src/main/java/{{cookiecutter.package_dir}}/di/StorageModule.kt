package {{cookiecutter.package_name}}.di

import {{cookiecutter.package_name}}.data.local.prefs.AppPrefs
import com.google.gson.Gson
import org.koin.dsl.module

val storageModule = module {
    single { Gson() }
    single { AppPrefs(get(), get()) }
}
