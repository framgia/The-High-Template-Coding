package com.sun.data.repository.impl

import com.sun.data.local.db.PostDao
import com.sun.data.model.Post
import com.sun.data.remote.ApiServiceInterface
import com.sun.data.repository.SampleRepository
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Implementation of repository
 */
@Singleton
class SampleRepositoryImpl @Inject constructor(
    private val api: ApiServiceInterface,
    private val postDao: PostDao
) : SampleRepository {
    override suspend fun getPosts(): List<Post> = api.getPosts()

    override suspend fun addPostsToDatabase(posts: List<Post>) {
        postDao.insertAll(posts)
    }

    override suspend fun getListPost(): List<Post> = postDao.getListPost()
}