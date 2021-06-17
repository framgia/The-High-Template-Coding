package com.sun.data.remote

import okhttp3.logging.HttpLoggingInterceptor
import okhttp3.mockwebserver.MockWebServer
import org.junit.After
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Base class to make Api calls
 */
abstract class BaseApiTest {

    protected val mockServer = MockWebServer()

    init {
        mockServer.start()
    }

    private fun getMockedRestApiBuilder(): Retrofit {
        val logging = HttpLoggingInterceptor().apply { level = HttpLoggingInterceptor.Level.NONE }
        val header = ApiService.createHeaderInterceptor()
        val client = ApiService.createOkHttpClient(logging, header)
        return Retrofit.Builder()
            .baseUrl(mockServer.url("/").toString())
            .client(client)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    protected fun <T> getMockedApi(apiClass: Class<T>): T =
        getMockedRestApiBuilder().create(apiClass)

    @After
    fun tearDown() {
        mockServer.shutdown()
    }
}
