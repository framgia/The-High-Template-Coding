package com.sun.ui.sample.fragment.sample

import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.sun.databinding.FragmentMainNavBinding
import com.sun.ui.base.BaseFragment
import com.sun.R
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.fragment_main_nav.*

/**
 * Sample Fragment
 * Show list post got from URL_END_POINT = https://jsonplaceholder.typicode.com/
 */
@AndroidEntryPoint
class SampleFragment : BaseFragment<FragmentMainNavBinding, SampleViewModel>() {

    override val viewModel: SampleViewModel by viewModels()
    override val layoutId: Int = R.layout.fragment_main_nav

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setUpAdapter()
    }

    private fun setUpAdapter() {
        val adapter = SampleAdapter {
            Toast.makeText(requireContext(), "${it.title}", Toast.LENGTH_SHORT).show()
        }
        rvPosts?.apply{
            this.adapter = adapter
            addItemDecoration(DividerItemDecoration(this.context, LinearLayoutManager.VERTICAL))
        }

        viewModel.posts.observe(viewLifecycleOwner) {
            it?.let {
                adapter.submitList(it)
            }
        }
    }
}
