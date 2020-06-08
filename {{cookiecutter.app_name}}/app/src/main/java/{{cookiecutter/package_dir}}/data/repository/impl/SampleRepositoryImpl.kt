package {{cookiecutter.package_name}}.data.repository.impl

import {{cookiecutter.package_name}}.data.model.Post
import {{cookiecutter.package_name}}.remote.ApiServiceInterface
import {{cookiecutter.package_name}}.repository.SampleRepository

class SampleRepositoryImpl(private val api: ApiServiceInterface) : SampleRepository {
    override suspend fun getPosts(): List<Post> = api.getPosts()
}