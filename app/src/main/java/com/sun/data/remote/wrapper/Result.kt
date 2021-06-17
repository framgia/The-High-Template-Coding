package com.sun.data.remote.wrapper

import com.sun.data.remote.respone.ApiErrorResponse
import com.sun.utils.ResultStatus

/**
 * Class help to encapsulate the api call response states
 *
 * @param data the value of api call success.
 * @param message the detail message string when api call fail.
 * @param status the status of response: success or fail.
 */
data class Result<out T>(
    val data: T?,
    val message: String?,
    val status: ResultStatus,
) {
    companion object {
        fun <T> success(data: T?): Result<T> = Result(data, null, ResultStatus.SUCCESS)

        fun <T> error(throwable: Throwable?): Result<T> =
                Result(null, throwable?.message, ResultStatus.ERROR)

        fun <T> error(apiErrorResponse: ApiErrorResponse): Result<T> =
                Result(null, apiErrorResponse.message, ResultStatus.ERROR)
    }
}
