package {{cookiecutter.package_name}}.data.remote

import {{cookiecutter.package_name}}.data.model.Post
import retrofit2.http.GET

/**
 * Sample interface apiService
 */
interface ApiServiceInterface {
    @GET("posts")
    suspend fun getPosts(): List<Post>
}
