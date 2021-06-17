package com.sun.utils

import com.google.gson.Gson
import com.sun.data.remote.respone.NetworkResponse
import com.sun.data.remote.respone.NetworkResponse.UnKnownError
import com.sun.data.remote.respone.NetworkResponse.NetWorkSuccess
import com.sun.data.remote.respone.NetworkResponse.ApiError
import com.sun.data.remote.respone.NetworkResponse.NetWorkError
import com.sun.data.remote.respone.ApiErrorResponse
import com.sun.data.remote.wrapper.Result
import okhttp3.ResponseBody
import retrofit2.HttpException
import java.io.IOException
import java.lang.Exception

/**
 * suspend function [safeApiCall] help encapsulate the results when the api call success or fail
 */
suspend fun <T> safeApiCall(block: suspend () -> T): Result<T> =
    when (val response = responseOfNetworkCall(block)) {
        is NetWorkSuccess -> response.value.asResult()
        is ApiError -> response.apiErrorResponse.asErrorResult()
        is NetWorkError -> response.error.asErrorResult()
        is UnKnownError -> response.throwable.asErrorResult()
    }

/**
 * suspend function [responseOfNetworkCall] help check api call response states
 */
private suspend fun <T> responseOfNetworkCall(block: suspend () -> T): NetworkResponse<T> =
    try {
        NetWorkSuccess(block())
    } catch (throwable: Throwable) {
        when (throwable) {
            is IOException -> NetWorkError(throwable)
            is HttpException -> ApiError(parseError(throwable.response()?.errorBody()))
            else -> UnKnownError(throwable)
        }
    }

private fun <T> T.asResult(): Result<T> = Result.success(data = this)

private fun <T> Throwable.asErrorResult(): Result<T> = Result.error(throwable = this)

private fun <T> ApiErrorResponse.asErrorResult(): Result<T> = Result.error(apiErrorResponse = this)

/**
 * Parse the error from the api call response, for example sample error body response
 *  {
 *      "code" : 500,
 *      "message" : "No message available"
 *  }
 */
private fun parseError(errorBody: ResponseBody?): ApiErrorResponse =
    try {
        Gson().fromJson(errorBody?.string(), ApiErrorResponse::class.java)
    } catch (e: Exception) {
        ApiErrorResponse(null, e.message)
    }
