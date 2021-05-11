package com.sun.data.remote

import com.sun.data.model.Post
import com.sun.data.model.Repo
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * Interface apiService for declare api endpoint
 */
interface ApiServiceInterface {
    @GET("orgs/framgia/repos")
    suspend fun getPosts(): List<Post>

    @GET("orgs/framgia/repos")
    suspend fun getPostsPaging(
        @Query("page") page: Int?
    ): List<Repo>
}
