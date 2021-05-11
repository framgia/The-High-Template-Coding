package com.sun.ui.base

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import androidx.paging.liveData
import com.sun.data.model.BaseModel
import com.sun.data.model.BaseModelPaging
import com.sun.data.model.Post
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

    fun executeTask(action: suspend () -> Unit) {
        viewModelScopeExceptionHandler.launch {
            action()
        }
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

    protected fun <T: BaseModelPaging> getPagingResult(
        adapter: BasePagingAdapter<T>,
        query: suspend (page: Int?) -> List<T>
    ): LiveData<PagingData<T>> {
        return Pager(
            config = PagingConfig(
                pageSize = 1
            ),
            pagingSourceFactory = { BasePagingSource(adapter, query) }
        ).liveData
    }
}
