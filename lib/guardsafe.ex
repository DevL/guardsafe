defmodule Guardsafe do
  @moduledoc """
  Provides readability-enhancing macros that can safely be used in guard clauses.
  """

  @doc """
  Expands `divisible_by?(number, divisor)` into `rem(number, divisor) == 0`

  ## Examples

      iex> 25 |> divisible_by? 5
      true
  """
  defmacro divisible_by?(number, divisor) do
    quote do
      rem(unquote(number), unquote(divisor)) == 0
    end
  end

  ~w(atom binary bitstring boolean float function integer list map nil number pid port reference tuple)
  |> Enum.each fn(type) ->
    @predicate String.to_atom("#{type}?")
    @function String.to_atom("is_#{type}")
    @doc """
    Expands `#{@predicate}(term)` into `#{@function}(term)`

    ## Examples

        iex> some_#{type}_variable |> #{@predicate}
        true
    """
    defmacro unquote(@predicate)(term) do
      quote do
        unquote(@function)(unquote(term))
      end
    end
  end
end

