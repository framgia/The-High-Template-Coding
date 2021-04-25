package com.sun.ui.sample.activity

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.sun.data.model.Post
import com.sun.data.repository.SampleRepository
import com.sun.ui.base.BaseViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import android.util.Log
import androidx.lifecycle.LiveData
import androidx.paging.PagingData
import com.sun.data.model.Repo
import com.sun.ui.base.BasePagingAdapter
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
                posts.postValue(repository.getPosts())
            }
        }
    }

    /**
     * Get list post from api, using Paging 3 to get paginated data flow page number
     * @param adapter: passing reference of adapter to this paging source to update data local
     */
    fun getPostsPaging(adapter: BasePagingAdapter<Repo>): LiveData<PagingData<Repo>> {
        return getPagingResult(adapter) {
            repository.getPostsPaging(adapter, it)
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
