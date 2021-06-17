package com.sun.data.remote.respone

import java.io.IOException

/**
 * Class that represents the API call response states
 */
sealed class NetworkResponse<out T> {
    /**
     * Success response with value
     */
    data class NetWorkSuccess<T>(val value: T) : NetworkResponse<T>()

    /**
     * Failure response with error status from api
     */
    data class ApiError(val apiErrorResponse: ApiErrorResponse) : NetworkResponse<Nothing>()

    /**
     * Network error, for example: no internet connection
     */
    data class NetWorkError(val error: IOException) : NetworkResponse<Nothing>()

    /**
     * UnKnown error, for example: json parsing error
     */
    data class UnKnownError(val throwable: Throwable) : NetworkResponse<Nothing>()
}
