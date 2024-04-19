defmodule FinApp.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinApp.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        last_name: "some last_name",
        name: "some name",
        nickname: "some nickname"
      })
      |> FinApp.Users.create_user()

    user
  end
end
