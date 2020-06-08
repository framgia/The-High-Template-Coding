package {{cookiecutter.package_name}}.data.model

import com.google.gson.annotations.SerializedName

/**
 * Sample object
 */
data class Post(
    @SerializedName("userId")
    val userId: Int,
    @SerializedName("id")
    val id: Int,
    @SerializedName("title")
    val title: String,
    @SerializedName("body")
    val body: String
) : BaseModel()