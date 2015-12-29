defmodule Issues.GithubIssues do
  @user_agent [ { "User-agent", "Eli eli@elijah.kim" } ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, body }), do: { :ok, :jsx.decode(body.body) }
  def handle_response({ ___, body }), do: { :error, :jsx.decode(body.body) }
end
