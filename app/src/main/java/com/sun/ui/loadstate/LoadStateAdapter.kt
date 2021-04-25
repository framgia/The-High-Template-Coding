package com.sun.ui.loadstate

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.paging.LoadState
import androidx.paging.LoadStateAdapter
import com.sun.BR
import com.sun.R
import com.sun.ui.base.BaseViewHolder
import com.sun.utils.Constants

class LoadStateAdapter(
    private val listener: LoadStateListener
) : LoadStateAdapter<LoadStateViewHolder<ViewDataBinding>>() {

    override fun onBindViewHolder(
        holder: LoadStateViewHolder<ViewDataBinding>,
        loadState: LoadState
    ) {
        holder.binding.apply {
            setVariable(BR.loadState, Constants.mappingLoadStatus(loadState))
            setVariable(BR.listener, listener)
            executePendingBindings()
        }
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        loadState: LoadState
    ): LoadStateViewHolder<ViewDataBinding> {
        val binding = DataBindingUtil.inflate<ViewDataBinding>(
            LayoutInflater.from(parent.context),
            R.layout.layout_load_state,
            parent,
            false
        )
        return LoadStateViewHolder(binding)
    }
}

class LoadStateViewHolder<out T : ViewDataBinding>(bd: T) : BaseViewHolder<T>(bd)
