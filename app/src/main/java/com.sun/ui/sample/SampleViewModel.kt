package com.sun.ui.sample

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.sun.data.model.Post
import com.sun.data.repository.SampleRepository
import com.sun.ui.base.BaseViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import android.util.Log
import dagger.hilt.android.lifecycle.HiltViewModel
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
     * Get data from api, using [viewModelScopeExceptionHandler] to handle exception
     * Exception is thrown on onLoadFail(throwable: Throwable)
     */
    private fun getPosts() {
        viewModelScopeExceptionHandler.launch {
            withContext(Dispatchers.IO){
                val listPost = repository.getPosts()
                posts.postValue(listPost)
                repository.addPostsToDatabase(listPost)
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