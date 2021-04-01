package com.sun.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.SerializedName

/**
 * Sample object
 */
@Entity(tableName = "post_table")
data class Post(

    @PrimaryKey
    @SerializedName("id")
    val id: Int,

    @SerializedName("userId")
    val userId: Int,

    @SerializedName("title")
    val title: String,

    @SerializedName("body")
    val body: String
) : BaseModel()