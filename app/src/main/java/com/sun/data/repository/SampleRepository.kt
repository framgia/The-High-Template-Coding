package com.sun.data.repository

import com.sun.data.model.Post
import com.sun.data.model.Repo
import com.sun.ui.base.BasePagingAdapter

/**
 * Main entry point for accessing data.
 */
interface SampleRepository {
    suspend fun getPosts(): List<Post>

    suspend fun getPostsPaging(adapter: BasePagingAdapter<Repo>, page: Int?): List<Repo>
}
