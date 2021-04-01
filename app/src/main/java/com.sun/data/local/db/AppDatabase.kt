package com.sun.data.local.db

import androidx.room.Database
import androidx.room.RoomDatabase
import com.sun.data.model.Post

/**
 * Create database for app
 */
@Database(entities = [Post::class], version = 1, exportSchema = false)
abstract class AppDatabase : RoomDatabase() {

    abstract fun postDao(): PostDao
}
