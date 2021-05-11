package com.sun.data.model

import com.google.gson.annotations.SerializedName
import java.io.Serializable

/**
 * Base model paging implement common [com.google.gson.annotations.SerializedName] for retrofit request
 **/
open class BaseModelPaging(
    @SerializedName("id")
    val id: Int? = null
): Serializable
