package com.sun.data.remote

import com.sun.data.model.Post
import kotlinx.coroutines.runBlocking
import okhttp3.mockwebserver.MockResponse
import org.assertj.core.api.Assertions
import org.assertj.core.api.Assertions.assertThat
import org.junit.Test
import retrofit2.HttpException

class JsonPlaceholderApiTest : BaseApiTest() {

    private val api = getMockedApi(ApiServiceInterface::class.java)

    @Test
    fun `getPosts - should get response include only one post data`() {
        val fakeJson = """
        [
             {
                  "userId": 1,
                  "id": 1,
                  "title": "sunt aut facere",
                   "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et"
             }
        ]
    """.trimIndent()

        val expectedResponse = listOf(
            Post(
                1,
                1,
                "sunt aut facere",
                "quia et suscipit\nsuscipit recusandae consequuntur expedita et"
            )
        )
        runBlocking {
            mockServer.enqueue(MockResponse().setBody(fakeJson).setResponseCode(200))
            val actualResponse = api.getPosts()
            assertThat(actualResponse).isEqualTo(expectedResponse)
        }
    }

    @Test
    fun `getPosts - get http exception when network error`() {
        mockServer.enqueue(MockResponse().setBody("").setResponseCode(500))
        Assertions.assertThatThrownBy {
            runBlocking {
                api.getPosts()
            }
        }.apply {
            isInstanceOf(HttpException::class.java)
            hasMessageContaining("HTTP 500 Server Error")
        }
    }
}
