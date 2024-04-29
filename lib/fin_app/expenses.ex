defmodule FinApp.Expenses do
  @moduledoc """
  The Expenses context.
  """

  import Ecto.Query, warn: false
  alias FinApp.Repo

  alias FinApp.Expenses.Expense

  @doc """
  Returns the list of expenses.

  ## Examples

      iex> list_expenses()
      [%Expense{}, ...]

  """
  def list_expenses do
    Repo.all(Expense)
  end

  @doc """
  Gets a single expense.

  Raises `Ecto.NoResultsError` if the Expense does not exist.

  ## Examples

      iex> get_expense!(123)
      %Expense{}

      iex> get_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense!(id), do: Repo.get!(Expense, id)

  @doc """
  Creates a expense.

  ## Examples

      iex> create_expense(%{field: value})
      {:ok, %Expense{}}

      iex> create_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense(attrs \\ %{}) do
    %Expense{}
    |> Expense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expense.

  ## Examples

      iex> update_expense(expense, %{field: new_value})
      {:ok, %Expense{}}

      iex> update_expense(expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense(%Expense{} = expense, attrs) do
    expense
    |> Expense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expense.

  ## Examples

      iex> delete_expense(expense)
      {:ok, %Expense{}}

      iex> delete_expense(expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense changes.

  ## Examples

      iex> change_expense(expense)
      %Ecto.Changeset{data: %Expense{}}

  """
  def change_expense(%Expense{} = expense, attrs \\ %{}) do
    Expense.changeset(expense, attrs)
  end

  alias FinApp.Expenses.UserExpense

  @doc """
  Returns the list of users_expenses.

  ## Examples

      iex> list_users_expenses()
      [%UserExpense{}, ...]

  """
  def list_users_expenses do
    Repo.all(UserExpense)
  end

  @doc """
  Gets a single user_expense.

  Raises `Ecto.NoResultsError` if the User expense does not exist.

  ## Examples

      iex> get_user_expense!(123)
      %UserExpense{}

      iex> get_user_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_expense!(id), do: Repo.get!(UserExpense, id)

  @doc """
  Creates a user_expense.

  ## Examples

      iex> create_user_expense(%{field: value})
      {:ok, %UserExpense{}}

      iex> create_user_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_expense(attrs \\ %{}) do
    %UserExpense{}
    |> UserExpense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_expense.

  ## Examples

      iex> update_user_expense(user_expense, %{field: new_value})
      {:ok, %UserExpense{}}

      iex> update_user_expense(user_expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_expense(%UserExpense{} = user_expense, attrs) do
    user_expense
    |> UserExpense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_expense.

  ## Examples

      iex> delete_user_expense(user_expense)
      {:ok, %UserExpense{}}

      iex> delete_user_expense(user_expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_expense(%UserExpense{} = user_expense) do
    Repo.delete(user_expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_expense changes.

  ## Examples

      iex> change_user_expense(user_expense)
      %Ecto.Changeset{data: %UserExpense{}}

  """
  def change_user_expense(%UserExpense{} = user_expense, attrs \\ %{}) do
    UserExpense.changeset(user_expense, attrs)
  end
end
