package com.sun.ui.sample

import android.os.Bundle
import android.widget.Toast
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.sun.R
import com.sun.databinding.ActivitySampleBinding
import com.sun.ui.base.BaseActivity
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_sample.*

/**
 * Sample activity
 * Show list post got from URL_END_POINT = https://jsonplaceholder.typicode.com/
 */
@AndroidEntryPoint
class SampleActivity : BaseActivity<ActivitySampleBinding, SampleViewModel>() {
    override val viewModel: SampleViewModel by viewModels()
    override val layoutId = R.layout.activity_sample

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setUpAdapter()
    }

    private fun setUpAdapter() {
        val adapter = SampleAdapter {
            Toast.makeText(this@SampleActivity, "${it.title}", Toast.LENGTH_SHORT).show()
        }
        rvPosts?.apply{
            this.adapter = adapter
            addItemDecoration(DividerItemDecoration(this.context, LinearLayoutManager.VERTICAL))
        }

        viewModel.posts.observe(this, Observer {
            it?.let {
                adapter.submitList(it)
            }
        })
    }
}
