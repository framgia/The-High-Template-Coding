package com.sun.data.repository.impl

import com.sun.data.model.Post
import com.sun.data.remote.ApiServiceInterface
import com.sun.data.repository.SampleRepository

/**
 * Implementation of repository
 */
class SampleRepositoryImpl(private val api: ApiServiceInterface) : SampleRepository {
    override suspend fun getPosts(): List<Post> = api.getPosts()
}