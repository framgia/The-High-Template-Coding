package com.sun.ui.sample.activity

import androidx.lifecycle.MutableLiveData
import com.sun.data.model.Post
import com.sun.data.repository.SampleRepository
import com.sun.ui.base.BaseViewModel
import android.util.Log
import androidx.lifecycle.viewModelScope
import com.sun.extensions.tryCatch
import com.sun.extensions.tryCatchWithResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.*
import javax.inject.Inject

@HiltViewModel
class SampleViewModel @Inject constructor(
    private val repository: SampleRepository
) : BaseViewModel() {
    val posts = MutableLiveData<List<Post>>()

    init {
        getPosts()
    }

    /**
     * Get data from api, using [executeNetWorkTask]
     * if successful callback onSuccess will be called,
     * otherwise onError will be called
     */
    private fun getPosts() {
        executeNetWorkTask(action = {
            repository.getPosts()
        }, onSuccess = {
            //This block is CoroutinesScope using dispatcher as IO,
            //you should use postValue instead of setValue for LiveData,
            posts.postValue(it)
            //because it's a CoroutinesScope, you can do many things like
            //accessing local database, read file,...
        }, onError = {
            errorMessage.postValue(it)
        })
    }

    /**
     * If you want to perform multiple tasks in parallel use [tryCatchWithResult] or [tryCatch]
     * for each task and you must set your [coroutineScope] and handle the exception for each task manually
     * [tryCatchWithResult] or [tryCatch] did it for you
     * [coroutineScope] helps other coroutines run normally if there is a coroutine throw exception
     */
    private fun executeMultiTaskParallel() {
        viewModelScope.launch {
            coroutineScope {
                val firstTaskResult = tryCatchWithResult({
                    //Do task here

                }, {
                    //Handle error here
                    onLoadFail(it)
                    //Default value when error

                })

                //Do something with firstTaskResult value
            }
        }
    }

    /**
     * Handle exception
     */
    override suspend fun onLoadFail(throwable: Throwable) {
        super.onLoadFail(throwable)
        Log.d("SampleViewModel","$throwable")
    }

}