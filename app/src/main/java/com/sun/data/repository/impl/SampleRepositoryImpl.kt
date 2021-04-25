package com.sun.data.repository.impl

import com.sun.data.model.Post
import com.sun.data.model.Repo
import com.sun.data.remote.ApiServiceInterface
import com.sun.data.repository.SampleRepository
import com.sun.ui.base.BasePagingAdapter
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Implementation of repository
 */
@Singleton
class SampleRepositoryImpl @Inject constructor(
    private val api: ApiServiceInterface
) : SampleRepository {
    override suspend fun getPosts(): List<Post> = api.getPosts()

    override suspend fun getPostsPaging(adapter: BasePagingAdapter<Repo>, page: Int?): List<Repo> =
        api.getPostsPaging(page)
}
