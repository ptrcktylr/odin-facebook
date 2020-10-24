module PostsHelper
  def likes(post)
    pluralize(post.likes_count, 'Like')
  end
end
