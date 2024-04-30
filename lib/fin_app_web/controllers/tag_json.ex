defmodule FinAppWeb.TagJSON do
  alias FinApp.Tags.Tag

  @doc """
  Renders a list of tags.
  """
  def index(%{tags: tags}) do
    %{data: for(tag <- tags, do: data(tag))}
  end

  @doc """
  Renders a single tag.
  """
  def show(%{tag: tag}) do
    %{data: data(tag)}
  end

  defp data(%Tag{} = tag) do
    %{
      id: tag.id,
      color: tag.color,
      name: tag.name
    }
  end
end
