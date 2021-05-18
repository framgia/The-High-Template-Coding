package com.sun.extensions

import kotlinx.coroutines.CoroutineScope

/**
 * [tryCatch] is CoroutineScope extension help handle exception manually
 * but don't get result from coroutines
 */
suspend fun CoroutineScope.tryCatch(
        tryBlock: suspend CoroutineScope.() -> Unit,
        catchBlock: suspend CoroutineScope.(Throwable) -> Unit,
        finallyBlock: suspend CoroutineScope.() -> Unit = {}
) {
    try {
        tryBlock(this)
    } catch (e: Throwable) {
        catchBlock(this, e)
    } finally {
        finallyBlock(this)
    }
}

/**
 * [tryCatchWithResult] is CoroutineScope extension help handle exception manually
 * can get result from coroutines
 * If an exception occurs, you need to set a default value returned to coroutine
 */
suspend fun <T> CoroutineScope.tryCatchWithResult(
        tryBlock: suspend CoroutineScope.() -> T,
        catchBlock: suspend CoroutineScope.(Throwable) -> T
): T {
    return try {
        tryBlock(this)
    } catch (e: Throwable) {
        catchBlock(this, e)
    }
}
