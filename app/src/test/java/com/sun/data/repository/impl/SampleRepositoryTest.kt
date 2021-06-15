package com.sun.data.repository.impl

import com.sun.data.model.Post
import com.sun.data.remote.ApiServiceInterface
import com.sun.data.remote.BaseApiTest
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.assertj.core.api.Assertions.assertThat
import org.junit.Test

class SampleRepositoryTest : BaseApiTest() {

    private val api = mockk<ApiServiceInterface>()
    private val repository = SampleRepositoryImpl(api)

    @ExperimentalCoroutinesApi
    @Test
    fun `getPosts - when api call success - should get response`() {
        val posts = listOf(
            Post(
                1,
                1,
                "sunt aut facere",
                "quia et suscipit\nsuscipit recusandae consequuntur expedita et"
            )
        )
        coEvery { api.getPosts() } returns posts

        runBlockingTest {
            assertThat(repository.getPosts()).isEqualTo(posts)
        }
    }
}
