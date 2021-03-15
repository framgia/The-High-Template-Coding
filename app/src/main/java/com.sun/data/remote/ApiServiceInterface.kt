package com.sun.data.remote

import com.sun.data.model.Post
import retrofit2.http.GET

/**
 * Interface apiService for declare api endpoint
 */
interface ApiServiceInterface {
    @GET("posts")
    suspend fun getPosts(): List<Post>
}
