package com.sun.ui.base

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.sun.data.remote.wrapper.Result
import com.sun.utils.ResultStatus.SUCCESS
import com.sun.utils.ResultStatus.ERROR
import kotlinx.coroutines.*

/**
 * Base ViewModel
 */
abstract class BaseViewModel : ViewModel() {
    // loading flag
    val isLoading = MutableLiveData<Boolean>().apply { value = false }

    // error message
    val errorMessage = MutableLiveData<String>()

    // exception handler for coroutine
    private val exceptionHandler = CoroutineExceptionHandler { _, throwable ->
        viewModelScope.launch {
            onLoadFail(throwable)
        }
    }

    // viewModelScope with exception handler
    protected val viewModelScopeExceptionHandler = viewModelScope + exceptionHandler

    /**
     * @param needBlock need loading flag
     * @param action the suspend action
     * @param callback result of #block, is a CoroutinesScope
     * */
    protected fun <T> executeTask(
        needBlock: Boolean = false,
        action: suspend () -> T,
        callback: CoroutineScope.(T) -> Unit = {}
    ) {
        viewModelScopeExceptionHandler.launch {
            if (needBlock) showLoading()
            withContext(Dispatchers.IO) {
                callback(action())
                if (needBlock) isLoading.postValue(false)
            }
        }
    }

    /**
     * @param needBlock need loading flag
     * @param action the suspend action
     * @param onSuccess result of #block when success, is a CoroutinesScope
     * @param onError result of #block when fail
     * */
    protected fun <T> executeNetWorkTask(
        needBlock: Boolean = false,
        action: suspend () -> Result<T>,
        onSuccess: CoroutineScope.(T) -> Unit,
        onError: (message: String?) -> Unit
    ) {
        executeTask(needBlock, {
            action()
        }, { result ->
            when (result.status) {
                SUCCESS -> result.data?.let { onSuccess(this, it) }
                ERROR -> onError(result.message)
            }
        })
    }

    /**
     * handle throwable when load fail
     */
    open suspend fun onLoadFail(throwable: Throwable) {
        withContext(Dispatchers.Main) {
            errorMessage.value = throwable.message
        }
    }

    fun showLoading() {
        isLoading.value = true
    }

    fun hideLoading() {
        isLoading.value = false
    }
}
