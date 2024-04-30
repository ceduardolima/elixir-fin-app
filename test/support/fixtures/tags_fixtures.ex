defmodule FinApp.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinApp.Tags` context.
  """

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        color: "some color",
        name: "some name"
      })
      |> FinApp.Tags.create_tag()

    tag
  end
end
