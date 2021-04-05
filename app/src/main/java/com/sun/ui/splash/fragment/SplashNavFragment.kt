package com.sun.ui.splash.fragment

import androidx.fragment.app.viewModels
import com.sun.R
import com.sun.databinding.FragmentSplashNavBinding
import com.sun.ui.base.BaseFragment
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class SplashNavFragment: BaseFragment<FragmentSplashNavBinding, SplashNavViewModel>() {
    override val viewModel: SplashNavViewModel by viewModels()

    override val layoutId: Int
        get() = R.layout.fragment_splash_nav
}