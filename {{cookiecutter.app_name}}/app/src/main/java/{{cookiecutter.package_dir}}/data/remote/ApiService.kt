package {{cookiecutter.package_name}}.data.remote

import {{cookiecutter.package_name}}.BuildConfig
import android.content.Context
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

/**
 * This is an example of ApiService,
 * Depend on each API, it will be handled particularly
 */
object ApiService {

    private const val TIMEOUT = 10L

    fun createHeaderInterceptor(): Interceptor =
        Interceptor { chain ->
            val request = chain.request()
            val newUrl = request.url.newBuilder()
                .build()
            val newRequest = request.newBuilder()
                .url(newUrl)
//            .header("Content-Type", "application/json")
                .method(request.method, request.body)
                .build()
            chain.proceed(newRequest)
        }

    fun createLoggingInterceptor(): Interceptor =
        HttpLoggingInterceptor().apply {
            level = if (BuildConfig.DEBUG) HttpLoggingInterceptor.Level.BODY
            else HttpLoggingInterceptor.Level.NONE
        }

    fun createOkHttpCache(context: Context): Cache =
        Cache(context.cacheDir, (10 * 1024 * 1024).toLong())

    fun createOkHttpClient(
        logging: Interceptor,
        header: Interceptor
    ): OkHttpClient =
        OkHttpClient.Builder()
//                .cache(cache)
            .connectTimeout(TIMEOUT, TimeUnit.SECONDS)
            .readTimeout(TIMEOUT, TimeUnit.SECONDS)
            .addInterceptor(header)
            .addInterceptor(logging)
            .build()

    fun createRetrofit(okHttpClient: OkHttpClient): Retrofit =
        Retrofit.Builder()
            .baseUrl(BuildConfig.URL_END_POINT)
            .client(okHttpClient)
            .addConverterFactory(GsonConverterFactory.create())
            .build()

}
