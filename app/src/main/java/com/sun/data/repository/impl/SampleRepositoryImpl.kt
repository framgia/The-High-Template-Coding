package com.sun.data.repository.impl

import com.sun.data.model.Post
import com.sun.data.remote.ApiServiceInterface
import com.sun.data.remote.wrapper.Result
import com.sun.data.repository.SampleRepository
import com.sun.utils.safeApiCall
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Implementation of repository
 */
@Singleton
class SampleRepositoryImpl @Inject constructor(
    private val api: ApiServiceInterface
) : SampleRepository {
    override suspend fun getPosts(): Result<List<Post>> = safeApiCall { api.getPosts() }
}