package com.sun.data.model

import com.google.gson.annotations.SerializedName

data class Repo(
    @SerializedName("name")
    var name: String
): BaseModelPaging()
