package com.sun.data.repository

import com.sun.data.model.Post

/**
 * Main entry point for accessing data.
 */
interface SampleRepository {

    suspend fun getPosts(): List<Post>

    suspend fun addPostsToDatabase(posts: List<Post>)

    suspend fun getListPost(): List<Post>
}
