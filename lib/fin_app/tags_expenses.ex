defmodule FinApp.TagsExpenses do
  @moduledoc """
  The TagsExpenses context.
  """

  import Ecto.Query, warn: false
  alias FinApp.Repo

  alias FinApp.TagsExpenses.TagExpense

  @doc """
  Returns the list of tags_expenses.

  ## Examples

      iex> list_tags_expenses()
      [%TagExpense{}, ...]

  """
  def list_tags_expenses do
    Repo.all(TagExpense)
  end

  @doc """
  Gets a single tag_expense.

  Raises `Ecto.NoResultsError` if the Tag expense does not exist.

  ## Examples

      iex> get_tag_expense!(123)
      %TagExpense{}

      iex> get_tag_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag_expense!(id), do: Repo.get!(TagExpense, id)

  @doc """
  Creates a tag_expense.

  ## Examples

      iex> create_tag_expense(%{field: value})
      {:ok, %TagExpense{}}

      iex> create_tag_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag_expense(attrs \\ %{}) do
    %TagExpense{}
    |> TagExpense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag_expense.

  ## Examples

      iex> update_tag_expense(tag_expense, %{field: new_value})
      {:ok, %TagExpense{}}

      iex> update_tag_expense(tag_expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag_expense(%TagExpense{} = tag_expense, attrs) do
    tag_expense
    |> TagExpense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag_expense.

  ## Examples

      iex> delete_tag_expense(tag_expense)
      {:ok, %TagExpense{}}

      iex> delete_tag_expense(tag_expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag_expense(%TagExpense{} = tag_expense) do
    Repo.delete(tag_expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag_expense changes.

  ## Examples

      iex> change_tag_expense(tag_expense)
      %Ecto.Changeset{data: %TagExpense{}}

  """
  def change_tag_expense(%TagExpense{} = tag_expense, attrs \\ %{}) do
    TagExpense.changeset(tag_expense, attrs)
  end
end
