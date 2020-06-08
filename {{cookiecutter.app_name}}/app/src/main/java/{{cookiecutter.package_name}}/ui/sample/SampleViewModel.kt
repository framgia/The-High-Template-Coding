package {{cookiecutter.package_name}}.ui.sample

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import {{cookiecutter.package_name}}.data.model.Post
import {{cookiecutter.package_name}}.data.repository.SampleRepository
import {{cookiecutter.package_name}}.ui.base.BaseViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import android.util.Log

class SampleViewModel(private val repository: SampleRepository) : BaseViewModel() {
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
     * Handle exception
     */
    override suspend fun onLoadFail(throwable: Throwable) {
        super.onLoadFail(throwable)
        Log.d("SampleViewModel","$throwable")
    }

}