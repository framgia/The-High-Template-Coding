package com.sun.data.remote.respone

import com.google.gson.annotations.SerializedName

/**
 * Class represents the error content from the API call
 */
data class ApiErrorResponse(
    @SerializedName("code")
    val code: Int?,

    @SerializedName("message")
    val message: String?
)
