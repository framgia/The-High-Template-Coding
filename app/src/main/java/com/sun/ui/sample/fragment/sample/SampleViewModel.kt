package com.sun.ui.sample.fragment.sample

import androidx.lifecycle.MutableLiveData
import com.sun.data.model.Post
import com.sun.data.repository.SampleRepository
import com.sun.ui.base.BaseViewModel
import android.util.Log
import androidx.lifecycle.viewModelScope
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
     * Get data from api, using executeTask function to handle exception
     * Exception is thrown on onLoadFail(throwable: Throwable)
     */
    private fun getPosts() {
        executeTask { posts.postValue(repository.getPosts()) }
    }

    /**
     * If you want to perform multiple tasks in parallel use [tryCatchWithResult] for each task and
     * you must set your [coroutineScope] and handle the exception for each task manually
     * [tryCatchWithResult] did it for you
     * [coroutineScope] helps other coroutines run normally if there is a coroutine throw exception
     */
    private fun executeMultiTaskParallel() {
        viewModelScope.launch {
            coroutineScope {
                val firstTaskResult = tryCatchWithResult({
                    repository.getPosts()
                }, {
                    //Handle error here
                    onLoadFail(it)
                    //Default value when error
                    emptyList()
                })

                //Do something with firstTaskResult variables
                posts.postValue(firstTaskResult)
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