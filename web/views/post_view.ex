defmodule Workshop.PostView do
  use Workshop.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, Workshop.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, Workshop.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      title: post.title,
      body: post.body,
      user_id: post.user_id}
  end
end
