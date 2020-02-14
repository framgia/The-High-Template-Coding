package {{cookiecutter.package_name}}.di

import {{cookiecutter.package_name}}.data.remote.ApiService
import org.koin.core.qualifier.named
import org.koin.dsl.module
import retrofit2.Retrofit

val networkModule = module {
//    single { createOkHttpCache(get()) }
    single(named("header")) { ApiService.createHeaderInterceptor() } //Naming to identity element
    single(named("logging")) { ApiService.createLoggingInterceptor() }
    single { ApiService.createOkHttpClient(get(named("header")), get(named("logging"))) }
    single { ApiService.createRetrofit(get()) }
//    single { createApiService<ApiServiceInterface>(get()) }
}

inline fun <reified T> createApiService(retrofit: Retrofit): T =
    retrofit.create(T::class.java)
