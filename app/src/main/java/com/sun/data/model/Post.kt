package com.sun.data.model

import com.google.gson.annotations.SerializedName

/**
 * Sample object
 */
data class Post(
    @SerializedName("id")
    val id: Int,
    @SerializedName("name")
    val name: String
) : BaseModel()
