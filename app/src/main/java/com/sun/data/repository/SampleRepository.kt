package com.sun.data.repository

import com.sun.data.model.Post
import com.sun.data.remote.wrapper.Result

/**
 * Main entry point for accessing data.
 */
interface SampleRepository {
    suspend fun getPosts(): Result<List<Post>>
}
