package com.sun.ui.sample.activity

import android.os.Bundle
import android.widget.Toast
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.sun.R
import com.sun.data.model.Repo
import com.sun.databinding.ActivitySampleBinding
import com.sun.ui.base.BaseActivity
import com.sun.ui.base.BaseComparator
import com.sun.ui.base.BasePagingAdapter
import com.sun.ui.loadstate.LoadStateAdapter
import com.sun.ui.loadstate.LoadStateListener
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_sample.*

/**
 * Sample activity
 * Show list post got from URL_END_POINT = https://jsonplaceholder.typicode.com/
 */
@AndroidEntryPoint
class SampleActivity :
    BaseActivity<ActivitySampleBinding, SampleViewModel>(),
    LoadStateListener,
    RepoListener {
    override val viewModel: SampleViewModel by viewModels()
    override val layoutId = R.layout.activity_sample

    private val pagingAdapter by lazy {
        BasePagingAdapter<Repo>(
            layoutRes = R.layout.item_post,
            listener = this@SampleActivity,
            comparator = BaseComparator()
        )
    }

    private val adapter by lazy {
        pagingAdapter.withLoadStateFooter(LoadStateAdapter(this@SampleActivity))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setUpAdapter()
        setUpRefreshData()
    }

    private fun setUpRefreshData() {
        viewBinding.layoutSwipeRefresh.apply {
            setOnRefreshListener {
                context?.let {
                    pagingAdapter.refresh()
                    adapter.notifyDataSetChanged()
                }
            }
        }
    }

    private fun setUpAdapter() {
        val sampleAdapter = SampleAdapter {
            Toast.makeText(this@SampleActivity, "${it.name}", Toast.LENGTH_SHORT).show()
        }
        viewBinding.adapter = adapter
        viewBinding.rvPosts.apply{
            addItemDecoration(DividerItemDecoration(this.context, LinearLayoutManager.VERTICAL))
        }

        viewModel.posts.observe(this, Observer {
            it?.let {
                sampleAdapter.submitList(it)
            }
        })

        viewModel.getPostsPaging(pagingAdapter).observe(this) {
            viewModel.executeTask {
                pagingAdapter.submitData(it)
                viewBinding.layoutSwipeRefresh.isRefreshing = false
            }
        }
    }

    override fun onRetryLoadData() {
        pagingAdapter.retry()
    }

    override fun onRepoItemClicked(item: Repo, position: Int) {
        item.name += " ------ Clicked"
        pagingAdapter.updateItem(item, position)
    }
}
