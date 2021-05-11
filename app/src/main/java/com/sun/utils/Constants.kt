package com.sun.utils

import androidx.paging.LoadState

object Constants {

    const val EXTRA_EXAMPLE = "com.sun.utils.EXTRA_EXAMPLE"
    const val VALUE_DEFAULT_INVALID = -1

    fun mappingLoadStatus(value: LoadState) = when(value) {
        LoadStates.LOADING.value -> LoadStates.LOADING
        LoadStates.ERROR.value -> LoadStates.ERROR
        else -> LoadStates.NOT_LOADING
    }

    enum class LoadStates(val value: LoadState) {
        LOADING(LoadState.Loading),
        ERROR(LoadState.Error(Throwable())),
        NOT_LOADING(LoadState.NotLoading(true))
    }
}
