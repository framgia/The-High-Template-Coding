package com.sun.ui.base

import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.sun.data.model.BaseModelPaging

private const val INITIALIZE_PREV_KEY = 1

class BasePagingSource<T: BaseModelPaging>(
    private val adapter: BasePagingAdapter<T>,
    private val query: suspend (page: Int?) -> List<T>
): PagingSource<Int, T>() {

    override fun getRefreshKey(state: PagingState<Int, T>): Int? {
        // Try to find the page key of the closest page to anchorPosition, from
        // either the prevKey or the nextKey, but you need to handle nullability
        // here:
        //  * prevKey == null -> anchorPage is the first page.
        //  * nextKey == null -> anchorPage is the last page.
        //  * both prevKey and nextKey null -> anchorPage is the initial page, so
        //    just return null.
        return state.anchorPosition?.let { anchorPosition ->
            val anchorPage = state.closestPageToPosition(anchorPosition)
            anchorPage?.prevKey?.plus(1) ?: anchorPage?.nextKey?.minus(1)
        }
    }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, T> {
        // Start refresh at page 1 if undefined.
        val nextPageNumber = params.key ?: INITIALIZE_PREV_KEY

        // Load data from caching
        if (adapter.cachingData.isNotEmpty()) {
            val data = adapter.cachingData.toList()
            return LoadResult.Page(
                data = data,
                prevKey = if (nextPageNumber == INITIALIZE_PREV_KEY) null else nextPageNumber.minus(1),
                nextKey = if (data.isNullOrEmpty()) null else nextPageNumber.plus(1)
            )
        }

        // Load data from source
        return try {
            val response = query(nextPageNumber)
            LoadResult.Page(
                data = response,
                prevKey = if (nextPageNumber == INITIALIZE_PREV_KEY) null else nextPageNumber.minus(1),
                nextKey = if (response.isNullOrEmpty()) null else nextPageNumber.plus(1)
            )
        } catch (e: Exception) {
            LoadResult.Error(e)
        }
    }

    override val keyReuseSupported: Boolean = true
}
