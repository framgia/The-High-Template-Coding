package com.sun.ui.base

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.DiffUtil
import com.sun.BR
import com.sun.data.model.BaseModelPaging
import com.sun.ui.sample.activity.RepoListener

class BasePagingAdapter<T: Any>(
    @LayoutRes private val layoutRes: Int,
    private val listener: RepoListener,
    comparator: DiffUtil.ItemCallback<T>
) : PagingDataAdapter<T, BaseViewHolder<ViewDataBinding>>(comparator) {

    val cachingData = mutableListOf<T>()

    override fun onBindViewHolder(holder: BaseViewHolder<ViewDataBinding>, position: Int) {
        // Note that item may be null.
        // ViewHolder must support binding a null item as a placeholder.
        val item = getItem(position)
        holder.binding.apply {
            setVariable(BR.item, item)
            setVariable(BR.position, position)
            setVariable(BR.listener, listener)
        }
        holder.binding.executePendingBindings()
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): BaseViewHolder<ViewDataBinding> {
        val binding = DataBindingUtil.inflate<ViewDataBinding>(
            LayoutInflater.from(parent.context),
            layoutRes,
            parent,
            false
        )
        return BaseViewHolder(binding)
    }

    fun updateItem(item: T, position: Int) {
        cachingData.apply {
            clear()
            addAll(snapshot().items)
            this[position] = item
        }
        notifyItemChanged(position)
        refresh()
    }

    fun deleteItem(item: T, position: Int) {
        cachingData.apply {
            clear()
            addAll(snapshot().items)
            this.removeAt(position)
        }
        notifyItemRemoved(position)
        refresh()
    }
}

class BaseComparator<T: BaseModelPaging>: DiffUtil.ItemCallback<T>() {
    override fun areItemsTheSame(oldItem: T, newItem: T): Boolean {
        // Id is unique.
        return oldItem.id == newItem.id
    }

    @SuppressLint("DiffUtilEquals")
    override fun areContentsTheSame(oldItem: T, newItem: T): Boolean {
        return oldItem == newItem
    }
}
