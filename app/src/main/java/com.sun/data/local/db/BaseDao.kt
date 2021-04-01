package com.sun.data.local.db

import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Update

/**
 * Base data access dao (DAO)
 */
interface BaseDao<T> {

    /**
     * Insert an object in the database
     */
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    fun insert(obj: T)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAndReplace(obj: T)

    /**
     * Insert an list of objects in the database.
     * Update if exists, otherwise will insert
     */
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(obj: List<T>)

    /**
     * Update an object from the database.
     */
    @Update
    fun update(obj: T)

    /**
     * Delete an object from the database.
     */
    @Delete
    fun delete(obj: T)
}
