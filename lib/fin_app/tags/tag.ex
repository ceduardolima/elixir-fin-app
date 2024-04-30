defmodule FinApp.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :name, :string
    field :color, :string
    has_many :tag_expense, FinApp.TagsExpenses.TagExpense

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:color, :name])
    |> validate_required([:color, :name])
    |> validate_length(:name, min: 3, max: 30, message: "O nome precisa ter no mínimo 3 caracteres e no máximo 30")
    |> validate_format(:color, ~r/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8}|[A-Fa-f0-9]{3})$/, message: "A cor precisa ter 3, 6 ou 8 caracteres acompanhandos do'#'")
  end
end
