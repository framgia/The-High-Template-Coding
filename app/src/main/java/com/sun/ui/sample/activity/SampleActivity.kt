package com.sun.ui.sample.activity

import android.os.Bundle
import androidx.activity.viewModels
import com.sun.R
import com.sun.databinding.ActivitySampleBinding
import com.sun.ui.base.BaseActivity
import dagger.hilt.android.AndroidEntryPoint

/**
 * Sample activity
 */
@AndroidEntryPoint
class SampleActivity : BaseActivity<ActivitySampleBinding, SampleViewModel>() {

    override val viewModel: SampleViewModel by viewModels()
    override val layoutId = R.layout.activity_sample

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onDestroy() {
        networkConnectionUtil.unregisterNetworkCallListener()
        super.onDestroy()
    }
}
