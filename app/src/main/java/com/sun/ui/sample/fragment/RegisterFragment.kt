package com.sun.ui.sample.fragment

import android.os.Bundle
import android.view.View
import androidx.fragment.app.viewModels
import com.sun.R
import com.sun.databinding.FragmentRegisterBinding
import com.sun.ui.base.BaseFragment

class RegisterFragment:
    BaseFragment<FragmentRegisterBinding, RegisterViewModel>(),
    RegisterListener {

    override val viewModel: RegisterViewModel by viewModels()
    override val layoutId: Int
        get() = R.layout.fragment_register

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.listener = this@RegisterFragment
    }

    /**
     * Execute if client validate successfully
     * */
    override fun register() {

    }
}
