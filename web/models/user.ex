defmodule Workshop.User do
  use Workshop.Web, :model

  # note at compile time this is generated to a STRUCT; its not duplication; its mandatory
  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps #[:inserted_at :created_at, :updated_at :false]
  end

  # the @ symbol is a module attribute; it is a value compiled into the module; not exposed or exported
  # contains a list of fields (atoms) that are allowed to exist on the model
  @allowed_params ~w(name email password password_confirmation)a

  # note: ~w(name email password password_confirmation) gives a list of strings
  # note: ~w(name email password password_confirmation)a gives a list of atoms

  # cast comes from ecto itself
  # the \\ means defaults to an empty map
  # NOTE: = is not assignment its pattern match and then assignment
  # NOTE: prefix or postfix this with something like "registration_changeset"
  def changeset(struct, params \\ %{}) do
    struct
    # cast transforms the data types
    |> cast(params, @allowed_params)   # NOTE that cast returns a changeset
    |> validate_required(@allowed_params)
    |> update_change(:email, &String.downcase/1) # & means "call anon function"
    # alternative way to line 30 is this:
    #|> update_change(:email, fn email -> String.downcase(email) end)
    |> validate_format(:email, ~r/@/) # don't use this in production; good laugh
    |> unique_constraint(:email)
    |> validate_confirmation(:password, message: "must match password") # expects that there is a matching password_confirmation field
    |> hash_password()
  end


  # takes a changeset as its argument  -- a struct is just a map which a dunder key -- only want this to happen when there is a password in the changes
  defp hash_password(%{changes: %{password: password}, valid?: true} = changeset),
    do: put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
  #
  # do it in 2 separate methods to eliminate conditional logic a source of bugs; pattern matching has fewer bugs
  defp hash_password(changeset), do: changeset

end
