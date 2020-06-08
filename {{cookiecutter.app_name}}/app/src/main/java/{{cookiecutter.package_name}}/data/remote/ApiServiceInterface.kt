package {{cookiecutter.package_name}}.data.remote

import {{cookiecutter.package_name}}.data.model.Post
import retrofit2.http.GET

/**
 * Interface apiService for declare api endpoint
 */
interface ApiServiceInterface {
    @GET("posts")
    suspend fun getPosts(): List<Post>
}
