package {{cookiecutter.package_name}}

import android.app.Application
import {{cookiecutter.package_name}}.di.appModules
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin

/**
 * Declare application context of app
 * start Koin injection by startKoin {} DSL
 */
class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidLogger() //Koin log
            androidContext(this@MainApplication) //declare used Android context
            modules(appModules) //declare modules
        }
    }
}
