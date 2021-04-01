package com.sun.data.local.db

import androidx.room.Dao
import androidx.room.Query
import com.sun.data.model.Post

/**
 * Example data access dao (DAO)
 * PostDao provides the methods that the rest of the app uses to interact with data in the post table
 */
@Dao
abstract class PostDao : BaseDao<Post> {
    @Query("SELECT * FROM post_table")
    abstract fun getListPost(): List<Post>
}
