defmodule Issues.GithubIssues do
  @user_agent [ { "User-agent", "Eli eli@elijah.kim" } ]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, body }), do: { :ok, body }
  def handle_response({ ___, body }), do: { :error, body }
end