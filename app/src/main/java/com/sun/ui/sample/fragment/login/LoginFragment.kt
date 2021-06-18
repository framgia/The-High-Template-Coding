package com.sun.ui.sample.fragment.login

import android.os.Bundle
import android.view.View
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import com.sun.databinding.FragmentLoginBinding
import com.sun.ui.base.BaseFragment
import com.sun.R
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class LoginFragment :
    BaseFragment<FragmentLoginBinding, LoginViewModel>(),
    LoginListener {

    override val viewModel: LoginViewModel by viewModels()
    override val layoutId: Int = R.layout.fragment_login

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.listener = this
    }

    override fun login() {
        findNavController().navigate(R.id.openSample)
    }

    override fun register() {
        findNavController().navigate(R.id.openRegisterFragment)
    }
}
