package com.sun.ui.sample.activity

import com.sun.data.model.Repo

interface RepoListener {
    fun onRepoItemClicked(item: Repo, position: Int)
}
